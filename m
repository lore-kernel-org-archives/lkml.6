Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE598C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A2A20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNJQyeD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A2A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeIGSWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:22:13 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35538 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbeIGSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:22:12 -0400
Received: by mail-qk1-f173.google.com with SMTP id f62-v6so7967261qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=vwp9QJtySLAygvHFMUFd+LuMvy8SeODc7QAZGsrYCJo=;
        b=FNJQyeD1eAJrfXMno2Zdm/wc18C53OvUtPuZCY0yCBH6Vavpe/6ck8HCMkHy7Tvtx8
         hhw7N81fbmZJ+xkQr0gPQVdU8VTbCtSgICdscXJW8bPK8E9Z6PYedUf5t0Sbactxw8zS
         C54o/+YSyG9kZ1AS+o+q6WYDtyoMCMCHSpRk9afkw3qE/Wye+9u8chbB+M1LuBaE/Bpr
         wBPKdzrDAL4dHS9h+f5/aPeF+HEnW6mJSv3rR1dHnmRjtnK2tBORBrx6XY9v7yMAJ/9+
         4BJk+80hikbj1N3EPkVWKan9DclOr3I/aj+n5ame3dPQBlZ4+EP9q9GEWwaGf6XqGAAw
         VdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vwp9QJtySLAygvHFMUFd+LuMvy8SeODc7QAZGsrYCJo=;
        b=cWpTrAFnl79sH5Ih7yaCYg/6/JE+v34xfeg432v/sA5VL1UwbCg5gjG+JB4esTQCUg
         KWcQrt+X0BVDQbDqvlvI7piLEYZKYlKAJ1A5v56h5M6CJkC757z6Imn5ut9fQT8hXmfd
         D/nCiV3BqEmenR1r7hvEsVpjkNlildYNBXH0qP46Tb2secpTeqagph3E66kVKk/K/iiP
         T9AMhaOppxWFeuWj6c2kAe80TeO//ouYSaep9m0y3DetZ/I6IGIUuTnr13Hvk4MbtDDR
         i3BAmzR6WeewJ+LHsiGg/X+DeAFstZVvOnD+n5bfSuJyUho+FS7TCMB3TJUIT+dZMaVP
         uxrQ==
X-Gm-Message-State: APzg51Db0MPaW9v23DAmsQYvTFnOkGPUTbu8sxtMKeFD8mx0CvUAbXgo
        qciCuraMudrScbbEX7gQXl32TP1D
X-Google-Smtp-Source: ANB0VdaVKM1P+krSHZ2WfncksW5o6We1bueHokFbN+UgEHmA9a55/c+hQ0Dm7neUJ8xhobYYDj/yQg==
X-Received: by 2002:a37:7607:: with SMTP id r7-v6mr5962793qkc.133.1536327670519;
        Fri, 07 Sep 2018 06:41:10 -0700 (PDT)
Received: from [10.1.1.147] (pool-96-244-117-231.bltmmd.fios.verizon.net. [96.244.117.231])
        by smtp.gmail.com with ESMTPSA id a187-v6sm4738154qkd.47.2018.09.07.06.41.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 06:41:09 -0700 (PDT)
From:   "hanasaki@gmail.com" <hanasaki@gmail.com>
Subject: Mouse no longer working : works in 4.18 : doesn't work in 4.18.5
To:     LIST - Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <8a77c527-01af-3857-e4ad-30be18f94bd2@gmail.com>
Date:   Fri, 7 Sep 2018 09:41:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mouse worked fine in 4.18 however does not work in 4.18.5  Both kernels 
were built with exactly the same .config file (copied from the 4.18 
build dir to the un-tar'ed 4.18.5 directory to build)

Any input on root cause and fix / workaround is appreciated.

"Doesn't work" means : syslog and kernel show that:
1. the kernel finds the mouse
2. gpm finds the mouse and detects its protocol
3. mouse cursor does not move and buttons do not work
	: not in gpm
	: not in X
4. syslog and kernel .config are the same for both versions

Below is the output from syslog and dmesg.

Update : same issue in 4.18.6 @ 20180906

========= dmesg
     6.925981] usbcore: registered new interface driver usbhid
[    6.925982] usbhid: USB HID core driver
[    6.927425] usbcore: registered new interface driver usbmouse
[    6.942113] input: PixArt USB Optical Mouse as 
/devices/pci0000:00/0000:00:14.0/usb2/2-10/2-10:1.0/0003:093A:2510.0001/input/input17
[    6.942207] hid-generic 0003:093A:2510.0001: input,hidraw0: USB HID 
v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:00:14.0-10/input0

========= Syslog
Sep  6 23:26:22 russia /usr/sbin/gpm[2699]: *** info 
[daemon/startup.c(131)]:
Sep  6 23:26:22 russia /usr/sbin/gpm[2699]: Started gpm successfully. 
Entered daemon mode.
Sep  6 23:26:23 russia /usr/sbin/gpm[2699]: *** info [mice.c(2059)]:
Sep  6 23:26:23 russia /usr/sbin/gpm[2699]: Detected EXPS/2 protocol mouse.

TIA / Thanks.
