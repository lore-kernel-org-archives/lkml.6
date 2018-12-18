Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED6A218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="0JUT7KTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLRMSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:18:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45200 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:18:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so15498656wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MoT/FUV/sLikcgl6YNjLcqACd1Fc/igbWdW4TaPEwEo=;
        b=0JUT7KTRdhIIRyC5BAkFfDVBMkIRNwd9KBDyV7NJFT+pgW93IFJwqsJbGRqwO1z4KA
         B82yNMijNIjE4cW4u9RmTfgoar878F3ah1xqMuVyUTfNXMufwzA+0TqZFRxl/mrgb8Hu
         Jg0GkX3yEtr/+9xGtOd3VpIzeIJDGvf1IgCMPKbchZMGT9VfGs3KOV0hce++PawrbdH2
         uVnUIvZkV4g66kD6h2Eb+qKEmj+2vBOtpK7X4jCoS2WnEWGCv4c4m+kSKo02hpYeroNA
         9L6E914HIlFbii9/XgREALFOQBVVsxkDMVIKZLH9G7E/TiNYRfAz2dzlWW2kJDKECxHi
         vdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MoT/FUV/sLikcgl6YNjLcqACd1Fc/igbWdW4TaPEwEo=;
        b=osvK7Q+0ugqcPuxNThY/tYGSXMTd8rhnz4qTPbjDz+vEH2VPKkjdXg4jfy+tAfWhao
         YkxQP6AxjaLk7fB/F39JnMkxdkYywogLLCdnknnE8UXujBtHHMfS0QTGVBsJF3SvjdS9
         YIK2wUoyvGpcpVvFIkz0GJGukZ5hnY6S0uUqPsVqwqPsenp6BOBuRNxDTHKuQCFDifON
         6DTjweiXh0cabiFn1TqvmrDpBE81kHdtX3fZ8Tr6WZOMIbz0fWSCae/+OubhBDL2FLd3
         HQzvTjXqaincWFSC2Ic5+QHVohHiinmL9BV4NOjIWhxAoNang2CqlP5zJjU7MaXneY3C
         IBrQ==
X-Gm-Message-State: AA+aEWb9aTTYRw4qHwBJvszQvIyeBeKGFPTA/lslgW+HeVhUMRfgKu22
        B1u5cJW++tg4OiZd5X9Lw18kczElhh21og==
X-Google-Smtp-Source: AFSGD/WzJIx/F5ImXjanNDKC1/agaTba7zOlC1+HRxpqHscnSoR5q2uk4WK2jLl/+5ymVn4UGTO8oQ==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr13409725wrv.4.1545135527368;
        Tue, 18 Dec 2018 04:18:47 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w18sm1945541wru.54.2018.12.18.04.18.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 04:18:46 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] serial: uartps: Driver updates
Date:   Tue, 18 Dec 2018 13:18:38 +0100
Message-Id: <cover.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sending 4 patches in series to fix some issues we found.
Patches were sent separately but I have been asked to send them in
serial that's why I am also adding cover letter to explain this v2
version.

Thanks,
Michal

Changes in v2:
- Change description based on request from Greg
- Fix Nava's email address to align with patch email address

Michal Simek (1):
  serial: uartps: Fix error path when alloc failed

Nava kishore Manne (1):
  serial: uartps: Fix interrupt mask issue to handle the RX interrupts
    properly

Shubhrajyoti Datta (2):
  serial: uartps: Add the device_init_wakeup
  serial: uartps: Check if the device is a console

 drivers/tty/serial/xilinx_uartps.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
1.9.1

