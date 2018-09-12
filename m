Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B413C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD7520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD7520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeILLAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:00:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37578 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeILLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:00:33 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fzy9h-0005NZ-Kv
        for linux-kernel@vger.kernel.org; Wed, 12 Sep 2018 05:57:37 +0000
Received: by mail-pg1-f198.google.com with SMTP id r2-v6so513097pgp.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 22:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hofmYPnagGxbSk4AGDnQMO1wAt18wp8aVdoeIclojjk=;
        b=krqx8yFyVTX/dHqw1YwyWQlwVVtCZ6bHFGFiwh7kVr3rZDnMDcbhI0+u9rR3f539lD
         zFFrDhAYKo5NmJULm+M4xoWMw65J041+kw6WB22xwttoFRv1zX2EyCtOloV8atOw/5Ki
         ojJqIvGbMS0stDJeJT2WoBNtcogKqXZ5WF5yRQwijKgmThLiJKHcEZXx2HSdezR5Bbzb
         sPHNPlci1SsH/UmOmS/Vl0dnaFsezNtGTa4zARvJHL3SHOPH0PT7H2oU3jVogEMkBQpo
         RlLYwA57l8OSMZY4b6eUVuGf5AI30qnLMptB1EIuVQOFliTZsNCfvApt/bSkkLDQOjgZ
         Dutw==
X-Gm-Message-State: APzg51BmUZkFiXigjKI7mUq8rhYJM4GTX2+7kRp0I9yrY3CeIhLTnuZv
        hua7UnpLt1Rl+ZyZcmCMWQPJ1n81Jk4VeG0wcTKXWGYJtBIpN9FkfjbGTZPDHkp6+partS0u21p
        5sC7/Cbab4ELO3jHWT0ye0Y7iI5FMntVAdhLEZN6MFA==
X-Received: by 2002:a62:5a01:: with SMTP id o1-v6mr328495pfb.0.1536731856239;
        Tue, 11 Sep 2018 22:57:36 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdYTmrpDEYirj1R4grhEdWqMKAJ4X1RDktjySJ+dq5nECrrSpCPaXmopOz1kJsPrtKRxf23p1Q==
X-Received: by 2002:a62:5a01:: with SMTP id o1-v6mr328471pfb.0.1536731855873;
        Tue, 11 Sep 2018 22:57:35 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b3-v6sm25612pgm.74.2018.09.11.22.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 22:57:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Regression caused by commit 7bb05b85bc2d ("r8169: don't use MSI-X
 on RTL8106e")
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAPpJ_ecuPysq2SE7=X7ip-3M=4yOcwuu6m_2292WgYA8j6gqjw@mail.gmail.com>
Date:   Wed, 12 Sep 2018 13:57:31 +0800
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>
Content-Transfer-Encoding: 7bit
Message-Id: <AC238433-78C1-4FA7-894E-82CC123A7F89@canonical.com>
References: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
 <CAPpJ_ecuPysq2SE7=X7ip-3M=4yOcwuu6m_2292WgYA8j6gqjw@mail.gmail.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:56, Jian-Hong Pan <jian-hong@endlessm.com> wrote:

> 2018-09-12 11:42 GMT+08:00 Kai-Heng Feng <kai.heng.feng@canonical.com>:
>> Hi Jian-Hong,
>>
>> There's a Dell machine with RTL8106e stops to work after S3 since the  
>> commit
>> introduced.
>> So I am wondering if it's possible to revert the commit and use
>> DMI/subsystem id based quirk table?
>>
>> It's because of commit bc976233a872 ("genirq/msi, x86/vector: Prevent
>> reservation mode for non maskable MSI") cleared the reservation mode,  
>> and I
>> can see this after S3:
>>
>> [   94.872838] do_IRQ: 3.33 No irq handler for vector
>>
>> If the device uses MSI-X instead of MSI, the issue doesn't happen  
>> because of
>> reservation mode.
>
> Interesting!  Opposite symptom!
> Could you help try the patch
> https://marc.info/?l=linux-pci&m=153629858601668&w=4 with and without
> reverting the commit?

Same issue after applying this patch. MSI-X works, MSI doesn't work.

>
> If the patch does not work, another suggestion: You can try falling
> back to only PCI_IRQ_LEGACY.

This device is capable of using MSI-X, I don't think falls back to use  
legacy is a good idea.
Instead, using a quirk table should be more appropriate.

Kai-Heng

>
> Regards,
> Jian-Hong Pan
>
>> Hi Thomas,
>>
>> Is it something should be handled by x86 BIOS? Because I don't see this
>> issue when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.
>>
>> Kai-Heng


