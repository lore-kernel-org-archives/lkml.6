Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F49C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B132087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B132087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeILNXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:23:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39424 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeILNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:23:12 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g00NF-000503-Bk
        for linux-kernel@vger.kernel.org; Wed, 12 Sep 2018 08:19:45 +0000
Received: by mail-pg1-f199.google.com with SMTP id 191-v6so678306pgb.23
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y6HXM1E008RjgkB/6vyZibJoQnFYfYIQREetc0F3kKk=;
        b=HpUElJVc/+7k6AQIXv9sEKSEGCsjIburMSzF/Q/JdV9Z0D+V1OOKp3kvZ3Qd+mhRLK
         z1LyacpBAOVGSaXvZXBsdc03EVJZtko1SsvzpZYL4EyJkbGumKCKmTUSC/myCe4aBDEa
         e2ByqkkjleJs8ad3lEEusOgkFXFESWICCCYWJEvfPirCjKiU1F0ltYewlLg0kWawodmQ
         qrng6SSwh/2ruTXV/dTsxHnjPBVKRJlb1KVC334kh9YTK1m4dM1XwOEEZuCsqjge2rKH
         Nima+Fvp350606NBm/TD6sbCCU3MypIfpKODIWXoXehYJzvXSzm86i8y1x6tNl7R5WK3
         vWaA==
X-Gm-Message-State: APzg51BYArQKy4mo5a3UHLCzIT5EW+9R/E4Gh3onRA/1yJMgDHy/zzNK
        lSEWo20b/V+4lQ8fgy3lmCSIQr06Zt6+s+fMXbb0cwbLJBRaY3x2X5oSDl8M3pxJ3iDcILcZeEu
        2bzYsOMFWk2Fg2ymr44Lw8O7zx/2muXlrmXbvRIaamw==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr831871pln.261.1536740383751;
        Wed, 12 Sep 2018 01:19:43 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdaRjlBobaBWPwD9ZJgStbGCqycbXTbRSPaSfUuCvto2p3LIWxiZmQjbXPf0vk9DA2exDiQ4ug==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr831836pln.261.1536740383372;
        Wed, 12 Sep 2018 01:19:43 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id y85-v6sm669796pfa.170.2018.09.12.01.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:19:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Regression caused by commit 7bb05b85bc2d ("r8169: don't use MSI-X
 on RTL8106e")
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <alpine.DEB.2.21.1809120826310.1427@nanos.tec.linutronix.de>
Date:   Wed, 12 Sep 2018 16:19:39 +0800
Cc:     jian-hong@endlessm.com, Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BF554FD5-17BA-4F16-9FDF-705D1FC76C12@canonical.com>
References: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
 <alpine.DEB.2.21.1809120826310.1427@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 14:32, Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 12 Sep 2018, Kai-Heng Feng wrote:
>
>> There's a Dell machine with RTL8106e stops to work after S3 since the
>> commit introduced. So I am wondering if it's possible to revert the
>> commit and use DMI/subsystem id based quirk table?
>
> Probably.

Hopefully Jian-Hong can cook up a quirk table for the issue.

>
>> It's because of commit bc976233a872 ("genirq/msi, x86/vector: Prevent
>> reservation mode for non maskable MSI") cleared the reservation mode,  
>> and I
>> can see this after S3:
>>
>> [   94.872838] do_IRQ: 3.33 No irq handler for vector
>
> It's not because of that commit, really. There is a interrupt sent after
> resume to the wrong vector for whatever reason. The MSI vector cannot be
> masked it seems in the device, but the driver should quiescen the device to
> a point where it does not send interrupts.

Understood.

>
>> If the device uses MSI-X instead of MSI, the issue doesn't happen  
>> because of
>> reservation mode.
>
> Reservation mode has absolutely nothing to do with that. What prevents the
> issue is the fact that MSI-X can be masked by the IRQ core.

So in this case I think keep the device using MSI-X is a better route, it's  
MSI-X capable anyway.

>
>> Is it something should be handled by x86 BIOS? Because I don't see this  
>> issue
>> when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.
>
> Suspend to idle works completely different and I don't see the BIOS at
> fault here. it's more an issue of MSI not being maskable on that device,
> which can't be fixed in BIOS or it's some half quiescened state which is
> used when suspending and that's a pure driver issue.

Understood.
Thanks for all the info!

Kai-Heng

>
> Thanks,
>
> 	tglx


