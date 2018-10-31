Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D96CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ED62084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnsFKMZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ED62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbeKAIWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:22:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54761 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbeKAIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:22:49 -0400
Received: by mail-it1-f194.google.com with SMTP id d6so15257143itl.4;
        Wed, 31 Oct 2018 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSzvgMVc55+sIXPtttI9yd+ASVRS/m3e1H7wnXhXWFs=;
        b=lnsFKMZ7KfCvSl+6w9MNSBUB3EqSfJbQClloE/Lrmqvao1NmPNkyS4bXZI55nlp2pN
         C4yJvtxgFRRkPIAtwiZp7mFUwbf238rnDWjrYH20Zdq0XDaoByr3uz3NRk0ytOaEfNhG
         O0rnD34tpYMETKU+nntqBnyw23znVFXCkaZy5g4v6lwu27IB/ZPZg1brT6Tb7MqetPf6
         CVjgZoDMrJTo86j4Mm8xgCXNCkIBgyrugF5mYnn3nHMN4wWD2DotNU1LXKZtzMkwVTVb
         oMSv4y3LObyHLS9N3D7DM06gYVXII47zoUFfZBYqt+ujnIzKDkJoEbD5ai5zvsrRETrQ
         KIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSzvgMVc55+sIXPtttI9yd+ASVRS/m3e1H7wnXhXWFs=;
        b=QppCIUE3dD4RGpfdoZ+7HjrpVZ2b0CwjcWmu7zQOzhTqL0Jt5Pl+mb4fooZJ7y9UhQ
         bUJojPwmc2sc3uuKv0Ib8Ci7izlaJO1LrudijFpU7buslJYgqwh8t8iUqgrD3TU7H7H4
         2d0oWy9aIsu+6xzeDO7Io+fKdcQ/r8wLUThNlIFQYFb3QGSy63zwljqtIfZhD/G7fLar
         uY+wHOZguLIMCgzy3EseZ3xFuLE5TdVn9tv5apFPY97EHQZYQXtlsOLnvyHmYryGoGLF
         jeZLmtW6ATnYrZ8ETp1lZMBuNfXsDIPD0BE6qGG58W1AQ8izriPExlX81YqnpAppIXm8
         mpCA==
X-Gm-Message-State: AGRZ1gLj9jF/aC+LMKPxbPY/kV+yqmb8uMAhffGuwMiKNflOOZNbm5xi
        qYw3jW/Qhm8fuH5T50O3pGijBpOtW2DNeqZVs+k=
X-Google-Smtp-Source: AJdET5fU2O8CGxXAiZ7pQXWCD1l/B4kVravvWZfUMfADqiZUkR6Ruaz0bGl2WMrMO8v0teaSRSWl76Tdm+FhrRZ6AIs=
X-Received: by 2002:a02:3849:: with SMTP id v9-v6mr3841121jae.15.1541028152334;
 Wed, 31 Oct 2018 16:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com> <1b3eb10e-c492-dc77-cbe6-3a3e692326d7@gmail.com>
In-Reply-To: <1b3eb10e-c492-dc77-cbe6-3a3e692326d7@gmail.com>
From:   Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Date:   Thu, 1 Nov 2018 01:21:00 +0200
Message-ID: <CAAGnT3ao2YugWW_1TuZw4+OiLQsBYLXtcYjARagZ3pGwFhvGZg@mail.gmail.com>
Subject: Re: [PATCH V5 0/5] KVM: X86: Introducing ROE Protection Kernel Hardening
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
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
        Ahmed Lotfy <A7med.lotfey@gmail.com>,
        Mohamed Azab <mazab@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Igor,
> This is very interesting, because it seems a very good match to the work
> I'm doing, for supporting the creation of more targets for protection:
>
> https://www.openwall.com/lists/kernel-hardening/2018/10/23/3
>
> In my case the protection would extend also to write-rate type of data.
> There is an open problem of identifying legitimate write-rare
> operations, however it should be possible to provide at least a certain
> degree of confidence.

I have checked your patch set. In our work we were originally planning to do
something similar to write_rare just so we can differentiate between memory
chunks that may be modified and those that will be set once and never modify.
I see you are planning to do a white paper too, actually we are doing
an academic
paper based on our work. If you would like to collaborate, so that ROE
and write_rare
would integrate well from the beginning, we will be glad to do so.

Thanks,
--
Ahmed
Junior Researcher , IoT and Cyber Security lab, SmartCI , Alexandria
University, & CIS @  VMI
