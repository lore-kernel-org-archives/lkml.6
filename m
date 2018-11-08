Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5ECECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6DC20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glXkCfej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6DC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeKIGb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:31:28 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35176 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:31:28 -0500
Received: by mail-io1-f67.google.com with SMTP id 79-v6so15704781iou.2;
        Thu, 08 Nov 2018 12:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQdS+FHmR8qURlp+S44E114Dtf5AHtGCvkRmM+6aZp0=;
        b=glXkCfejZTP2G7pzZI7SfSd9G0l4SlyIueLj8kKTpHMp0neogHpEtTbwczorZA+/fT
         KpE1epQdZQDOIsii9Q3MqXQmv7kikvSk2pHGRjVAzcPG3s4xqPvJyMLQ099wI99uBKJT
         HEbR2k16WzogJhXEi2QbbcHiyl7JJXV+AQgqFqiB4BIrv4MAJG0a9WuMdG7CLu2VyJAG
         qteSPI84fYxUpjNfhGn1Bb1KBaPHLe76nbS/0u7rsAu1w3fjf0gWrRArAPw4kP0Mqudu
         OvqrD1nq5i5Pfbclifbr5beFogbdqH4JnzNC6b7pTnc69pGQH2j5BbDH3uiidm/s3w8J
         dMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQdS+FHmR8qURlp+S44E114Dtf5AHtGCvkRmM+6aZp0=;
        b=awPsI5UPnN9k6UdDEtIexkBlutusOVkU3ax5fx4rXl0qSWCwSbeO1JGg0yk1Y4VKcI
         R1wQRWdCm/XaVMJtcyU1a75h6UblqSqczNTGM2H3CN+VvUx0S4D/mG6ePY2Su2xPRHa0
         JiILZw3/A6UnaxLvwP1nfe3c+okDgf51N63Wu4Axm+4wHGaF/cPUTZm3o/4KYHMmYP7h
         vShggi0/qxMEE+gclRqpT55cW1YOS8D9r3yYSS1Hbbdm9vvsySTMK9FotyJGjmpxHwSd
         KNYnMx3OKboxrF/KZZECPz52RCAPCOkFA+dfueTU14lUuVztOjpt/37DkfTbta8w75CI
         29Xg==
X-Gm-Message-State: AGRZ1gL11Q+X1clAL0xWxYIWSa3n1whvC0l2/eKxzmpK0ZEw7mmJ4mhF
        0KwGc2FRVgAG58+X38Nb6lj8LMsjuqa3Zp7zGhs=
X-Google-Smtp-Source: AJdET5dyqzhj6hBHrJShZhI3EL/MoTuStP/v7rmujm4nuXI7DbnCtONKL2bmT28k2c9qynvYiX+KOaSLXVsfITP/d3c=
X-Received: by 2002:a6b:ca03:: with SMTP id a3-v6mr5052194iog.208.1541710453179;
 Thu, 08 Nov 2018 12:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com> <24f900ba-6459-c6aa-4e97-92f0ec744896@redhat.com>
In-Reply-To: <24f900ba-6459-c6aa-4e97-92f0ec744896@redhat.com>
From:   Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Date:   Thu, 8 Nov 2018 22:54:00 +0200
Message-ID: <CAAGnT3Y8SwD-jm2x2k7y2EZMsHdfua4-tnfu8o_ajyV+n4imcA@mail.gmail.com>
Subject: Re: [PATCH V6 0/8] KVM: X86: Introducing ROE Protection Kernel Hardening
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        nathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?6rmA7J246rK4?= <ovich00@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        nigel.edwards@hpe.com, Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Do you have patches that enable usage of ROE in the kernel?
> Alternatively you can write testcases in tools/testing/selftests/kvm to
> test how guests should use it.

As for now ROE isn't integrated yet into the kernel, I did have some
tests I will
have them in  selftests/kvm in the next patch set

> I would remove CONFIG_KVM_ROE altogether.  You can enable it
> unconditionally.

Noted, I will have it enabled unconditionally in the next patch set.

> I will continue reviewing the patches soon.
>
> Paolo
