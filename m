Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A721CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799AC2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbfBNQol convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:44:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38475 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfBNQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:44:40 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1guK7q-0005RB-Ty
        for linux-kernel@vger.kernel.org; Thu, 14 Feb 2019 16:44:39 +0000
Received: by mail-pf1-f198.google.com with SMTP id k10so5219550pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4JVQ4Ym7cPvVnoypNzsvLkoQ+Ld8CW76g5Ltvz0ByQE=;
        b=EEfiaFkdQB05DyThrmnwk8Oi5P9v8FINDLrTKIgXGLQff2JJUmFiFUwxCrpvpL1DQU
         jCNUrkPlQ1GSdQRYcIya24FjbUK8k4lPR1Q3A54HKYZ9N8GZtRQi58xupdCmp+x35kIy
         uFUbCg9sIpJUrG5gAHCmZ52ON9GXY0IbMNgR06OEyQCJeW8UvbO6lea4WDRFYd2dyVGd
         cKhoDsGSTgXeeJkZ6ZiK3UZ+1BfoVbWutXJUALRwFStyz+0RwbC4oT9MDmzgWqryuxx6
         AuXdd9q38iRVjuoj/XGxtPvPbXZc7ArmDcq9EMFXsn8xIBt1h/kTmWMpQbGOv8ZhQiaz
         02cQ==
X-Gm-Message-State: AHQUAubKTjf8JIAE/t3IRnYEgD1QDu41DZq5EfpyrA6UgaWorv2wY1pT
        kyLom9RsNkpVkMo9Cw9GmTg+IS0kSTbKIRjcFANb77rJaQYWKAETBEvha3EJe0VfPqNT6rVDQQr
        YGiPzeZQMVgdjL0nL8kGqjY8RbyDOkFIAZC7SxeksPQ==
X-Received: by 2002:a65:62d4:: with SMTP id m20mr713080pgv.215.1550162677416;
        Thu, 14 Feb 2019 08:44:37 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZDSdxIfaYCn8vBxee2FOhBS93CmDAjdxIkeyqIF4SI49kLuFb1sWoS1P1zrqMkykIhNvfT7w==
X-Received: by 2002:a65:62d4:: with SMTP id m20mr713052pgv.215.1550162677052;
        Thu, 14 Feb 2019 08:44:37 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id y9sm4053709pfi.74.2019.02.14.08.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:44:36 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Issue with commit a99790bf5c7f3d68d8b01e015d3212a98ee7bd57
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAE6q+i3E1+2BKTUFYQx0ch-cFNHzw0X805U1DMEy7MDiXXh8Sg@mail.gmail.com>
Date:   Fri, 15 Feb 2019 00:44:33 +0800
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3B9B63A0-E3CA-45EF-B291-5EC21F6F64F4@canonical.com>
References: <CAE6q+i3E1+2BKTUFYQx0ch-cFNHzw0X805U1DMEy7MDiXXh8Sg@mail.gmail.com>
To:     Elias Rydberg <rydberg1995@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> On Feb 15, 2019, at 12:17 AM, Elias Rydberg <rydberg1995@gmail.com> wrote:
> 
> Dear Kai,
> 
> I write to you simply as I do not know exactly who to write, and since you are the author of commit a99790bf5c7f3d68d8b01e015d3212a98ee7bd57. If you are the completely wrong person to contact about this, I do apologize, and ask for you to share a resource guides me in the right direction. As of Dave, I CC you since you signed of the commit as well.
> 
> I will try to describe this with as few words as possible.
> 
> When upgrading to kernel 4.19 I experiened an issue of the screen starting to flicker, and then turn pitch black, whenever I turned on my wifi module. After som guidance, I found a workaround, namely booting with kernel parameter intel_idle.max_state=4. Not having a lot of experience with the Linux kernel, I thought it might have to do with an individual hardware fault in my machine.
> 
> This week I’ve been in contact with another person experiencing the exact same problems, and having the exact same laptop setup. I then investigated further, did my first kernel bisection, and found out that using a kernel with the named commit is causing this behaviour. This is the result from the bisection:
> 
> a99790bf5c7f3d68d8b01e015d3212a98ee7bd57 is the first bad commit
> commit a99790bf5c7f3d68d8b01e015d3212a98ee7bd57
> Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Date:   Thu Jun 21 16:30:39 2018 +0800
> 
> 
> 
>     r8169: Reinstate ASPM Support
> 
> 
> 
>     On Intel platforms (Skylake and newer), ASPM support in r8169 is the
>     last missing puzzle to let CPU's Package C-State reaches PC8.  Without
>     ASPM support, the CPU cannot reach beyond PC3. PC8 can save additional
>     ~3W in comparison with PC3 on a Coffee Lake platform, Dell G3 3779.
> 
> 
> 
>     This is based on the work from Chunhao Lin <hau@realtek.com>.
> 
> 
> 
>     Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> 
> 
> :040000 040000 87d4515c14f8eb8cf99b6f47f97ca4db700931c1 e542595c74609136a7094777afb10b83012f6643 M      drivers
> The spec on my latop is:
> CPU: Intel i7-8550U
> Wifi: Intel AC-9260 1730Mbps
> Memory: 8GB Kingston DDR4 2400MHz
> SSD: Samsung 970 EVO 500gb

From platforms I’ve seen, if ASPM on r8169 is disabled, the deepest Package C-State on Intel CPU will limit to PC3.

If the ASPM on r8169 is enabled, it can reach to PC8 when the display is on, and be able to reach PC10 when display is off.

So the issue seems to be a platform bug - deeper Package C state makes your system unstable.

Please contact the system vendor, the deepest Package C state can be reach should be set by BIOS.

Kai-Heng

> 
> I’m not sure about the motherboard, but the model of the laptop case (and probably the motherboard) is Clevo N750WU.
> 
> Please ask if you need more information and I will provide as much help as I can.
> 
> Kind regards,
> Elias Rydberg

