Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE59C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DF321741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuoOeJWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfA1RBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:01:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34023 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733110AbfA1RBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:01:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so12448520lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i33QfJaRit2vgeTjMBY2pqu2PrmKDmynFKckyg4kLIM=;
        b=DuoOeJWG5eTJ66dsUj7rOtr/RgXvgYFqAO6QRBRaJveLvSNPM4rZQ/PQQ1IsFx3cOL
         9gZt8CLACZW/onBJf1FCVcN+5LzMm6h1tvfIAJGEvmsL4uCq/juF23yaBu7jtujPq0Tl
         IDEO4I8t58pooIbWhR7/DAzGPgqhvJvFn0fzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i33QfJaRit2vgeTjMBY2pqu2PrmKDmynFKckyg4kLIM=;
        b=RapUo2RJvz5q3D00qGPTAJUGlsNE2XyepKBWzhxp5RB8qKLl/bgRE8krqg8+L9spM3
         0g+5piPLGjghkPmcP1HkSlu8Gd1fa5IAZaapyo007lX62nHFvl8BRJMY+udkcRVfwKkZ
         MY+rfktiTjx4L20ySyKfALKhnEab2YCtD1uwi3iQobmDlVCqpwOqfebYgWeTmUzj64xu
         4dfEuyuWXXUUXPypI4jDct6Tb8D16yHbYU1x4G16ZmkDd+bRCL8pz7O6umaPAHLxvCtf
         X6xTnUT2iFwY/Pa/wWxYeDVQvgUgrxKhmOzD501iIMVBiF6red0loXET8m/uFAvSvA3u
         XS+g==
X-Gm-Message-State: AJcUukenYuOSWKrdnif5uHEQnaH1XSnpMwoNIEPsqKCiCZEI5G8FvRml
        Hz9CMraMNrrXvMEFvs/DRtesG/tiNMMRd91n6DIlwQELe50=
X-Google-Smtp-Source: ALg8bN4eH4G1zxvrkThKHCblzIibsiavzXsLBGZfxcUn2/oEPPSc7Cozhc7ZDXPHQOOKr/IcYluUt0vGRE9vzEenmyc=
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr18562650lff.123.1548694906430;
 Mon, 28 Jan 2019 09:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
 <7d75f420-d624-d53d-4fa1-3827c90fa608@kernel.org> <CAEUSe7_eYmMSovO4JAabh+83CtY2L8eeMoCVKKS5P-fs7zVhjg@mail.gmail.com>
 <a68c3fdd-081a-74ea-8d98-30eaf3d70446@kernel.org> <20190128154242.GB15002@beryl>
 <4a5fc384-ee96-54ba-02f5-fc5ab7c79c47@kernel.org>
In-Reply-To: <4a5fc384-ee96-54ba-02f5-fc5ab7c79c47@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 28 Jan 2019 11:01:33 -0600
Message-ID: <CAEUSe799jd1vpUUfzpMMs9HXNUPpB1Jy5w1hZBd7f5CRMqLygw@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests: lib: allow to override CC in the top-level Makefile
To:     Denys Dmytriyenko <denys@ti.com>
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 28 Jan 2019 at 10:28, shuah <shuah@kernel.org> wrote:
> On 1/28/19 8:42 AM, Denys Dmytriyenko wrote:
> > On Mon, Jan 28, 2019 at 08:01:15AM -0700, shuah wrote:
> >> Hi Daniel,
> >>
> >> On 1/18/19 10:54 AM, Daniel D=C3=ADaz wrote:
> >>> Hello!
> >>>
> >>> On Wed, 16 Jan 2019 at 15:56, shuah <shuah@kernel.org> wrote:
> >>>>
> >>>> On 1/16/19 10:43 AM, Daniel D=C3=ADaz wrote:
> >>>>> From: Fathi Boudra <fathi.boudra@linaro.org>
>
> This is the problem. It says, it came from Fathi Boudra
> <fathi.boudra@linaro.org>

Denys, apologies for sending this patch as Fathi's. In our Git
repository [1] he's marked as author, probably as it got copied from
repo to repo.

Would you mind sending this patch yourself?

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

[1] https://github.com/96boards/meta-rpb/blob/master/recipes-overlayed/ksel=
ftests/files/0001-selftests-lib-allow-to-override-CC-in-the-top-level-Makef=
ile.patch


> >>>>> Relax CC assignment to allow to override CC in the top-level Makefi=
le.
> >>>>>
> >>>>> Signed-off-by: Denys Dmytriyenko <denys@ti.com>
> >
> > ^^^ I am the original author of the patch and this is my signed-off lin=
e.
> >
>
> thanks,
> -- Shuah
