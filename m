Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86636C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEFA21B18
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzsOeNar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfBLKXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:23:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43041 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:23:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so1076102pfh.10;
        Tue, 12 Feb 2019 02:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTTJdqf/ZWLOUT+uK18iY5fQAanEzmeGSK8RyC8mzgo=;
        b=fzsOeNarDEfKHlAntINZHVZGIhmhjydkfu2/SuhWPNq6Jv/cjgPERGaSPnnjiLNBmp
         3p+jjD/8ZhnkHPSlrqlE4c+LKREjP985LoD3qsy05XoeHD1oo0PWbW80rJB9iAoh0C/+
         oQbTnu0lEw/zZvnrULDHXSu7f4vcNFfKjUpkCDyLNQ0YCxCq9tn9Wmf+DUbKBGwVtbkA
         pRzZyEyfmabYXcefe750yMup2FhKXIlxFn5bCRUuFiBza5BuNqmeak9AXlfgRUgVhHrM
         FCj7AJ5mJxTm99yj42GmrymH1PhTBi/HVHbFVNA3AuBAqDfbNzO9shxxbFts7LvQRwm+
         I4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTTJdqf/ZWLOUT+uK18iY5fQAanEzmeGSK8RyC8mzgo=;
        b=bEqfWy/cbFXEg2PRZGSyQdcy5lhgoiWoa0bjetL7pX6Ti2dXMHBV8LS5+3CVKL+xjS
         Yons0cE1sVn7aj6rNMV5MCw7/Bjp8MfybTqkoBr9F/Q1M1q6mHVn69Tt6UfcNyPsiDXr
         OdUzxUEQ4Bze6rxXatj0LgadiKBO42YhOcGE94ojZHwFqjX86WyUOWPyixeWoFDlSHQW
         viMZAYetor4tu/WkvacNzbCBz3rGRle1u7iZIbPmvDBypTQ8CD79rdg/rRpSdZoDbpqR
         9kbg4L5bBP9M8vohd2/fralNe8q4n7UpfNvvzXEjmEc0spG4/3y4xcxfj52dnYUMWYkE
         t1Fg==
X-Gm-Message-State: AHQUAuZpWXpPXxRfVa5BZAsk5nM3TKlc+o5sT/sfXobIfte2n5gKLpP2
        yg0xTpZQ7Eo5QCCcSHpAH/Hzy9KAUVIVAdmJ0hY=
X-Google-Smtp-Source: AHgI3IY2kmVlUdKv8f9Sk+glks2rXPkq7jQagqImqXSs1fMz/TOg7fuP1h2Iql1nmVyW9H/AsHpoBxNwNsrqnbixArc=
X-Received: by 2002:a63:4a21:: with SMTP id x33mr3033356pga.428.1549967015050;
 Tue, 12 Feb 2019 02:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20190212100825.9113-1-anders.roxell@linaro.org> <CAHp75Vd8yi0u7S6oA=Vr7E9ptYdvBvXBJn=fG2kM-=vS-7oOQg@mail.gmail.com>
In-Reply-To: <CAHp75Vd8yi0u7S6oA=Vr7E9ptYdvBvXBJn=fG2kM-=vS-7oOQg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:23:24 +0200
Message-ID: <CAHp75VcPeKDLOB7vKeSG9+UfsYnPfTPy_omuTgJSUgKzC0caNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ima: fix build error redeclaration of enumerator
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Feb 12, 2019 at 12:15 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Commit a893ea15d764 ("tpm: move tpm_chip definition to
> > include/linux/tpm.h") introduced a build error when both ima and efi is
> > enabled. What happens is that both headers (ima.h and efi.h) defines the
> > same 'NONE' constant, and it broke when they started getting included
> > from the same file.
>
> > We only need one of the two patches applied.
>
> I would argue that we need two patches applied. Namespace is a hidden
> issue in the code.
>
> This patch looks good to me, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Oh, did you change ABI? So, I have to say that enum changes are okay,
but ABI, if any, are not.

-- 
With Best Regards,
Andy Shevchenko
