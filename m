Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32398C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71383206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAw88Nyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbeLNWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:24:40 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:53202 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:24:40 -0500
Received: by mail-it1-f182.google.com with SMTP id g76so11157090itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZm7mIqXmxDhhOXV2B3OHiUeStfdXmeatOA54zN8HZ0=;
        b=wAw88NyqkyYpJ4XT9jKoIWVRDiZD3387GvATOiLi9rnbGJ1RFNh2vHYVMUodQHbxNe
         V1F119+y0nbWtLn4bOB6UOvKd7123tTOFj2BsQ57kA2hjB8tNEZhtIFXKpKFFfOobX1y
         CK5qiTKcsqJdPLA8pNYDlaiwBfZbl1MOo1U51Da+W2LPuVPs85DBd1GlnuX38jVtaAMP
         EdHDU+tCSW1BCrdE7NfCmyRnZOb5pHu7e2W/zVmYY4rpr5uQFQhH3p/MIbvNcATGj+At
         Y77SeoiG7ga8Y0zpKBlCdrZRhpJr20qCUzL/3KtsjrLQJ7n26X39ZZyE4fT+mRMQC7bd
         tTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZm7mIqXmxDhhOXV2B3OHiUeStfdXmeatOA54zN8HZ0=;
        b=MUEyX3v1ovBC+ps97sCe3yeV0GAOAm0J+ACvbDO1VqeDx76929NZSisJm21+ZuQ3bl
         IHTFVdzsoiyTmDAOs9w8xcnmenyrQvGV3donSMbfE6Xg9AeOgsC2mKtbVJO6H21P9/GJ
         KQ31fmVw1neMIGD7dKKvPBHKaUtAZfLTnXW/G67g/H20p3mi6DcY1n3TbmAbMwY4wkvw
         Q2EbaGyNt/6fG7LDpDFNSaEf/Vwi4gByDuFIK6jniZ/pv5ZxO5dtnsC+/LLA8K+FkUs1
         KaDNPHfA2xxDX3Ql2G596dQ0GawP3nwGCp/qhX3Cj3iJOBtoXbv0rFTdaBhyg4rtNhli
         P++g==
X-Gm-Message-State: AA+aEWazqK3TGx2ANsGC+v+vW87wvq8fiUCWcShAbtt8yCuC6EjWrJdt
        a3gdTp1YejDE1VMvhEa4DMybhPS7avjRUIUVTEonWA==
X-Google-Smtp-Source: AFSGD/XcWgKb8iPvIiYX7jri30Fp9wdaHSyMs+viXj8KzQvGAEFDu7fVLhVoo7SwM4cRv9aJj2yxqSAzzyINkS027to=
X-Received: by 2002:a24:5411:: with SMTP id t17mr3039942ita.32.1544826279317;
 Fri, 14 Dec 2018 14:24:39 -0800 (PST)
MIME-Version: 1.0
References: <9aa7b39c-707e-c87a-ad4c-f54ff08e3172@redhat.com>
In-Reply-To: <9aa7b39c-707e-c87a-ad4c-f54ff08e3172@redhat.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Fri, 14 Dec 2018 14:24:27 -0800
Message-ID: <CANDihLFgOmkumZ-W4i=5oOb1Zu+BHJz8M-WphYYyAdb9jYdL+g@mail.gmail.com>
Subject: Re: Unwinding regression with 379d98ddf413 ("x86: vdso: Use $LD
 instead of $CC to link")
To:     labbott@redhat.com
Cc:     luto@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        kernel-team@android.com, joel@joelfernandes.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, fweimer@redhat.com,
        carlos@redhat.com, hjl.tools@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Fri, Dec 14, 2018 at 1:48 PM Laura Abbott <labbott@redhat.com> wrote:
> Hi,
>
> There are two reports of a regression with unwinding with
> 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
>
> https://bugzilla.kernel.org/show_bug.cgi?id=201741
> https://bugzilla.redhat.com/show_bug.cgi?id=1659295
>
> It looks like the unwinding information has been
> stripped out. Any ideas?

Sorry about this. I missed a critical flag (--eh-frame-hdr) that gcc
specifies implicitly when converting the Makefile to invoke ld
directly. This went unnoticed because the linking of vmlinux (which
also uses ld directly) does not need this information, so it does not
specify the flag. Sending a verified fix now.

> Thanks,
> Laura
