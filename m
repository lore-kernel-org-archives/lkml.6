Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE01C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0409721773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547129621;
	bh=1sldYsptnm2ML4CrM5FD5fCzPXm6p0Jel6+1UqpnmAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NsshADjK4bT+1tlh/Hfax8LRWch95ZuCatsFyDmjpvO6AzBeYxDBn/N83wFgVdJ13
	 KdI5E5aUoGNgVvn1Qjf//Eq7GRGxbdercktnBHFZ8qIITBhf3d75kREqpTsi6X14v7
	 Q7C8D6lew2BGz8hZWUqc6s+jeVemAzpaFnhht1VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfAJONj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbfAJONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:13:39 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941C721773
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547129618;
        bh=1sldYsptnm2ML4CrM5FD5fCzPXm6p0Jel6+1UqpnmAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xfFc9Ga5XgGR6K6QFSmj7hxdov7LlAKhKJK3hg0uyhd9yHINj87YEPlkUt9CM4ZPb
         EtFMzd4ua/VszMSIhjybE2qHrTRqxw3eNvGcLqrhb9MX1whfiwLdICAIbg9O49c3E2
         Z/l8BZ/ksdfJvOAz2cKh5vmtDT8eP/DJWcfG1yHU=
Received: by mail-qt1-f179.google.com with SMTP id p17so12904467qtl.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:13:38 -0800 (PST)
X-Gm-Message-State: AJcUukd/QKBOytpJzPcouwohB/zy8UI3NEYMif/TIzp9d4pvYUmEMmca
        Mm0veDD+JOKwPFVY31aL+0Vmaw/3oSiK3cXbeg==
X-Google-Smtp-Source: ALg8bN5VfTGq/y4LEy5Z+7xjKRE1uUlO7J6hshnGDv9lQNQnvc2SGfDfNe1jWVZvR2+yGjXZVWcC/cjA5d3N50SC7kA=
X-Received: by 2002:a37:7682:: with SMTP id r124mr9420446qkc.79.1547129617823;
 Thu, 10 Jan 2019 06:13:37 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190110082256eucas1p1bb0685cb83aa0a865f2391e43512b417@eucas1p1.samsung.com>
 <f936ab2a7c34974c67ade29e97fe15bb5781ac39.camel@perches.com> <87d0p47wh9.fsf%l.stelmach@samsung.com>
In-Reply-To: <87d0p47wh9.fsf%l.stelmach@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Jan 2019 08:13:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKt-ujsB-t9A=4dEAjqrvcquUG+qF3tFg1YCqmup_5wcw@mail.gmail.com>
Message-ID: <CAL_JsqKt-ujsB-t9A=4dEAjqrvcquUG+qF3tFg1YCqmup_5wcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: fix bad file reference into Documentation
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     Otto Sabart <ottosabart@seberm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 2:23 AM =C5=81ukasz Stelmach <l.stelmach@samsung.co=
m> wrote:
>
> It was <2019-01-09 =C5=9Bro 20:35>, when Joe Perches wrote:
> > On Wed, 2019-01-09 at 20:09 +0100, Otto Sabart wrote:
> >> There is no `samsung,exynos5250-trng.txt` file in the documentation an=
d
> >> I do not think it ever existed.
> >
> > There was a patch for this
> >
> > https://patchwork.kernel.org/patch/10623153/
> >
> > But is is still unapplied...
> >
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> >> @@ -13309,7 +13309,6 @@ M:   =C5=81ukasz Stelmach <l.stelmach@samsung.=
com>
> >>  L:  linux-samsung-soc@vger.kernel.org
> >>  S:  Maintained
> >>  F:  drivers/char/hw_random/exynos-trng.c
> >> -F:  Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>
> + Rob Herring

Please resend the above patch. If I've acked it, then I'm assuming
it's going in via the driver tree. But I'll apply it if you tell me to
instead.

Rob
