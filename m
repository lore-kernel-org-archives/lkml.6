Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5170C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A166F2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nduG4CPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBGXzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:55:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36492 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:55:50 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so4709147itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QMradZ8y8bj4nP1jg/AeFwYhEQ1GVuc8QuX5QQgsHpc=;
        b=nduG4CPS5kfR2KxTCsaUmPZ8azuN/6/pOvCpH5S96naFwJed4RZa6P7N4ns9Q93SRe
         sqFDMqp54k3wdIe3n47Z1awOej9wyUGobIqgrAOtorM8onUXpHaEnDiuEQ3GAInVPXsG
         xE2wnuyw6xYZKc9YfBzizRTfwjbvoBZX2ay3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QMradZ8y8bj4nP1jg/AeFwYhEQ1GVuc8QuX5QQgsHpc=;
        b=SWycnCNm+u3YOoVUthCe3498vqzWneh4bijSkuw39d9BoYh2Rk0AYZfni9xwKJeqpw
         tr3FePE4ovJW+b9o3kZO1xgBsDbpUBWeYT8TDhXW3bDCAnjfJUZg4i5L19eCENt7vwOZ
         OZ07ijxvldUiy0NUZjJ5gXw17A0y8l246Xj4nttTyIM4Ig092AX3TRPMrC+uA6g88JQo
         5pvcN4y8tUsFgizkFlWiLnTKeClBe/rovxfgl/xTxaRJPKwyipJ8hTIc+WjOyAWzMqIT
         8mVD816rTKZc0Qa5aZXJb2pnVJ9jldlvJ52Lj6veD+5LmNM+1qNXz0YRfoy6UgFsvzb6
         0c9Q==
X-Gm-Message-State: AHQUAuaxKqXDMiZ3ok9CQOIv1CXZQxz//tAP1Q+GqWsZqlZM6TdhixVw
        I01afC+yY8hi/sejmZ7KTYb0cuXXrb0=
X-Google-Smtp-Source: AHgI3IaZ/WAAZDxVFizR+qg/NQT8eXhH/ugYuFF5lweAARELF/3/LScV5gx/KKckm8T0xLng/TiKsw==
X-Received: by 2002:a05:660c:4c5:: with SMTP id v5mr2823860itk.104.1549583749019;
        Thu, 07 Feb 2019 15:55:49 -0800 (PST)
Received: from mail-it1-f181.google.com (mail-it1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id q5sm218921ioh.22.2019.02.07.15.55.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 15:55:47 -0800 (PST)
Received: by mail-it1-f181.google.com with SMTP id c9so4708982itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:55:47 -0800 (PST)
X-Received: by 2002:a5e:a60f:: with SMTP id q15mr5385992ioi.140.1549583746746;
 Thu, 07 Feb 2019 15:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-3-thgarnie@chromium.org>
 <20190207121729.GE2414@zn.tnic> <CAJcbSZFe+Cn9+gEa4iv56sZE+WXXiHjeR8Mcte9s_HYr8QBrsw@mail.gmail.com>
 <20190207171145.GH2414@zn.tnic>
In-Reply-To: <20190207171145.GH2414@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Thu, 7 Feb 2019 15:55:35 -0800
X-Gmail-Original-Message-ID: <CAJcbSZFTiHcRM8gy8LbVMQYM2b7H=Gngbsf6bMGKmkDo7mKbjg@mail.gmail.com>
Message-ID: <CAJcbSZFTiHcRM8gy8LbVMQYM2b7H=Gngbsf6bMGKmkDo7mKbjg@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] x86: Use symbol name in jump table for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:11 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Feb 07, 2019 at 09:04:45AM -0800, Thomas Garnier wrote:
> > I assume that's an optimisation done by gcc later.
>
> So why is that change even needed? Where does it break?
>
> > The P modifier in the documentation does state that it is used to
> > generate PIC code.
>
> The documentation says:
>
> "If used for a function, print the PLT suffix and generate PIC code. For
> example, emit foo@PLT instead of =E2=80=99foo=E2=80=99 for the function f=
oo()."
>
> when you use %P for a function. Which is not how it is used here.

I did more checks about that. I think Ard's patch to make jump label
relative actually fixed the issue I had with them.

Thanks for spotting this, I will do additional checks and look at
removing this change.

>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
