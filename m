Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C71BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95852075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m56tjqQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95852075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeGRSm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:42:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39525 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbeGRSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:42:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so10479411oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XqE/GkBOO5tMh416y9sQ8QJef5kVVvRJiE3AHzbQi+8=;
        b=m56tjqQIeMUCr2VI0D4zOTwRaUidffw0/UXPxUBvSpZ7Lwt8m+o253iCSAERkPS07g
         c9tSDGAtKiJAE3bzcR4kHNuXo8/Vm/yBV6hCQyaIRydQXK1FcbPDi/LW5vU3cqCVI11C
         CzC+N0OZYhQJIwHVLA69iDb1USoAA7duSTpByiAZxS9Hg4ze+23c95uTOAxBmy1I1igj
         X+sgJvs26pWx6AjUcAbsvXFjwc4imO1EDjaO9CqCyV60wIPzC9ukjQgnLikYJ64RY5t5
         4mzIw0dmxRpEiiOjhtzf7Cqyw2nZX7KyL+Ljjui6rF0mX8snJSGsMaLAB7THRIs/SZi4
         T9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XqE/GkBOO5tMh416y9sQ8QJef5kVVvRJiE3AHzbQi+8=;
        b=evceMSsnf+m21muL9WHZLw/87HLTmcDsun9EcxQ4xo9kKLtu36I0UQkLdDb5kcpQki
         w+LWE9nwo+OmkO7Bl7+yFQIAiIYftrSLD6tmaJ968EQxNeDt0hYjrgbzdSeR3WbctJKu
         S0JURRNnrNaUt2kcFssdIYORt5QQ6ptWlF4pVsClOhjNBMvRqMWeQAlGL641qu6eNULq
         gpQHLC6Ax0r3WeFCOezXrvoh7faRfLF02eqzkgNiDUIndDAzKeqjeixdBh7iRy4nHDp7
         QiFq8oYDT6JfIv/tQyB37CjSelJM2U1Nsy1NdLPfbpbV31u+pCL6HtzCYx++qd5xOcbI
         ebTg==
X-Gm-Message-State: AOUpUlGWr12l/j6++7of+9g84dpSw50wL838KO7Asy0XXtWP+XS05Hzq
        gODsEEJUe18Y1qKJeL6xe+uIrsUaDqS0PUpaAf0q8pan
X-Google-Smtp-Source: AAOMgpcYwp9itsUMO2o8kL/j10F89i5p14f3adBEXP3wxZ2ViIHbJaAGnavZv/f0Q6evBi9dYDbYy4W6VYUo45l20cQ=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr8256199oif.348.1531937035722;
 Wed, 18 Jul 2018 11:03:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 11:03:55
 -0700 (PDT)
In-Reply-To: <20180718175545.GA11749@flask>
References: <1531214840-24686-1-git-send-email-karahmed@amazon.de>
 <1531214840-24686-2-git-send-email-karahmed@amazon.de> <20180718175545.GA11749@flask>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 18 Jul 2018 11:03:55 -0700
Message-ID: <CALMp9eSv0ax6owRV78Xo9gw1T=_29_wg4LqbhNJP6+Hd_EU1Og@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] kvm: nVMX: Introduce KVM_CAP_NESTED_STATE
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:55 AM, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redh=
at.com> wrote:

>> +     vmx->nested.nested_run_pending =3D 1;
>
> This is not necessary.  We're only copying state and do not add anything
> that would be lost on a nested VM exit without prior VM entry.

If nested_run_pending is blindly set on restore, then prepare_vmcs02
will do the wrong thing. For example, if there was an injected event
in the vmcs12, it will get injected again, even if the vCPU has been
in L2 for some time.

The value of nested_run_pending should always come from the saved VMX
state (a few lines above).
