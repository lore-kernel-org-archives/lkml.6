Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02768C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5372086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="l6uwv7js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5372086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeKETzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:55:03 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:37308 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKETzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:55:03 -0500
Received: by mail-lf1-f49.google.com with SMTP id p17so5741336lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=acQBDENSybZLW0LXWk8KiEo3FhTphL8qd/b0WjebiB8=;
        b=l6uwv7jsxVuPeXhBZTx+J0JcrPCTXwENV+1gJ91RmdBtq+sUQ05/vpSmZIQHzOM5Z+
         IU+yBEyA1qdqAr8sgV9L4AZ+Q1c57RbDU2P5hTX2bon6nJlUPfQo94/HrVDDKogkoLXP
         6JPr/oXNnUe1OHjl5Xorfz1tpphvp0lAjEwi4mJVC+by8fCKSUixGO7Vc/8ohmJoyhQs
         0VUEBv7L5DiwN4xrWBuhIDsvXF2kr7YgzNpqzFqL2md4DhE95ksNUxsQe+H5XylBr89D
         CHxNbaNRl6BzXmLWFQoJZq8C+Abcy49dxZHd9mGjsWybkCPsk+9Hp4EX6f3TSOyURe3s
         jKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=acQBDENSybZLW0LXWk8KiEo3FhTphL8qd/b0WjebiB8=;
        b=er2S1UQdubH2gJoEM1WdS7IfSfulUyB8HRp5kFbpf9UmYeQd+jEX5QRb4J2IFlJV8t
         UXcPRYUVw+kwDDEiP1Yribe+c4cW9MJ6Z5dT/7pkGA74J+nou3qmFwuQZ6DJ8Pa23PrY
         LtoHwASShSYBcyHfed9yuvEzCKwhpN4jGn8SzRiPjrTR9aQR4tsfovmR6Seieqi/UuGf
         njvIn84Sz3ODCBg+Pshzg017R2pYQ8Uf379gv4aOa1bNvpRwo9qUbI1hyrF0oMARGcMH
         DWMzc69lncnWYq5NkG5TnsiYXet+CJjyBcB6AUjjpm+G3ZKAvty4tnWZlRQcpBleqsbq
         mx9w==
X-Gm-Message-State: AGRZ1gIjWdgLTvvtD8SrsL2R17VUmS5LXpudI38+ZJvitHuENKVEpS9Z
        lBS7VKGxZFWPFpjQCxsPjbRfKiR1SnAtjQ==
X-Google-Smtp-Source: AJdET5dBuQNFt32kwOqDZXBoqMVHBMWrbfwT1K3oVU/kjp+kkYEceXIyrdfM67qcHLnFPEfqq9NPxw==
X-Received: by 2002:a19:4287:: with SMTP id p129mr12812729lfa.135.1541414159682;
        Mon, 05 Nov 2018 02:35:59 -0800 (PST)
Received: from [192.168.1.169] (h-137-80.A159.priv.bahnhof.se. [81.170.137.80])
        by smtp.gmail.com with ESMTPSA id c5-v6sm3677771lja.62.2018.11.05.02.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:35:58 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
Subject: KOBJ_BIND uevent
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org
Message-ID: <f844342b-14fd-6ce5-55b0-5c224d0c841b@norrbonn.se>
Date:   Mon, 5 Nov 2018 11:35:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about the ordering of uevents, specifically concerning 
complex USB devices that present multiple interfaces/functions.

Before KOBJ_BIND, a USB device would typically present itself as:

add usb_device
add usb_interface-1
add subsystem-device-1.0
add subsystem-device-1.1
add usb_interface-2
add subsystem-device-2.0

I have noted that the recently added "bind" actions, however, present in 
the reverse order.

bind subsystem-device-1.0
bind subsystem-device-1.1
bind usb-interface-1
bind subsystem-device-2.0
bind usb_interface-2
bind usb_device

This secondary ordering could be useful in the sense that the final 
"bind" action on the usb_device is an indication that the kernel has 
finished enumeration of all endpoints and has bound all drivers that it 
could to the available interfaces... i.e. no further events for this 
device are expected.

The question, then, is:  is the above ordering of "bind" events stable, 
or is it just a consequence of the current implementation and may change 
in the future?

/Jonas
