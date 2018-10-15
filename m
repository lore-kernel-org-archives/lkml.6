Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F52C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EFB2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="BgdCLoly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EFB2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeJOW2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:28:18 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:39921 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeJOW2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:28:17 -0400
Received: by mail-qk1-f169.google.com with SMTP id q5-v6so11954885qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yt7zleFkKQTj8GCzRUSXwF46MXH3U96O+8q3+ISfAaM=;
        b=BgdCLolyw0VNn9+3a5VSBR/4yYst1BJ/Ma8H1ZBvxJXMTY2xnbajGHz/eC5gdcphMM
         DKvBcQdnVfliEF3En17ZmZ95a1f93qj+PC+c//59T78xBRKn19ckA3/LqB8mQeL1MgY3
         bAlzw9aiKHgxE4//PAeNPGOalEKdgZ/Sh681GZS6tySUdLkbrIhjsHYKnFgN61TgZegi
         ok5cDTZdtz4SndB3efAuwtRPdHrgMaJkILyAhUJN9ydDBuCvA15/YGnLh1DOkzUrW96L
         QoahCcn28Qy2lcGCL5ZF9FaW9fKP32ivnhvN26AyegDOfWTe9SSXufG2vhOqWSJ+JvAh
         DoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yt7zleFkKQTj8GCzRUSXwF46MXH3U96O+8q3+ISfAaM=;
        b=TR5xagumQk2U5ZjN1gAMTTg1bPPWwRkYw/BKd9EO8kGAyb4hYv5Mw+bQBYVQd5gL9/
         9OGDhOvF1nzDygpLPyMfaSGw48SPpnsyCH+4BoO1u1VTsbKfbPCPdCEwAlomZMLEinBI
         LYmZz3yd5DCfOQrkHMyxTHHXn8Yvaa4RE6CBh+w9iHimJjYu8STTVO0j7QTIKKIjGi/Q
         8i7y+gp/SRHYRqA6K0JGIBLibLAbkp7A6T3+r/huMhozetNnbSHso1AZzFo5jjf87JFE
         Zo0abc5Yere4Z7usUPEuHLtTUcEkZbZP2e86m6MnrFsONIa7WhaneTN0aVygxoutdh0l
         PPTA==
X-Gm-Message-State: ABuFfojDFcWHxfLmAAOPz58ZBGwP/tdW37BUWYqSyftvefoqp6Ee3/Hj
        +KQxe2+cmUQXqo/pbgp3rXBSHA==
X-Google-Smtp-Source: ACcGV62c8NtpqgyHN0IWK4+POOr5fECI5P40WNf3IqydpzP1+2BfFvfnDCyvUVdOn4a89qIu0DxZZg==
X-Received: by 2002:a37:6681:: with SMTP id a123-v6mr15688824qkc.149.1539614562925;
        Mon, 15 Oct 2018 07:42:42 -0700 (PDT)
Received: from [192.168.43.100] ([172.56.20.167])
        by smtp.googlemail.com with ESMTPSA id n25-v6sm9290081qkl.8.2018.10.15.07.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 07:42:42 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Rob Landley <rob@landley.net>
Subject: devinet.c inet_abc_len() breaking ifconfig?
Message-ID: <c2cbddb5-da35-c522-b181-30cd4f327e96@landley.net>
Date:   Mon, 15 Oct 2018 09:42:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Taht pointed out to me that this doesn't work in toybox:

  $ ifconfig eth0 242.2.0.1 netmask 255.255.255.0 broadcast 242.2.0.255
  ifconfig: ioctl 8916: Invalid argument

Because of this in the kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/devinet.c#n940

What is the inet_abc_len() function _for_? When's the last time "class A, Class
B, and Class C" IPv4 addresses actually _existed_ as a thing? (Somewhere around
1995?)

He suggested I switch to the netlink API, which doesn't enforce this, but... why
is the kernel enforcing it for one api but not the other?

Rob
