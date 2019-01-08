Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D63C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA8820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546959423;
	bh=ermArLtvls1wgNieOXTgJ3O6kO3RHBy5b15Gt5oH92U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zIUl1sBO4w+0MWaZHAsg8vjyJEmUbQUA8MR5TdWZSBnuNv6MAwmnjO1pzLEjPPoJP
	 hNqndyOtkwfD83+BOughBh8lw8+zh3VYL35U5oDryHylfXidss2Xoe7I1txnkaWmi5
	 DRaNimzLoo6LWhDb543opxPEcfGze/8ikG4syZsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfAHO5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:57:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfAHO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:57:02 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DC621019;
        Tue,  8 Jan 2019 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546959421;
        bh=ermArLtvls1wgNieOXTgJ3O6kO3RHBy5b15Gt5oH92U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GpUQ6y2ek6S+NtAqULX25wso+Zx9r5VH60GM1xJvBV8IY1YsNv3HA2T364NsHU4QF
         tFBGvFCuhfp8K1jXv8hHujG+C4Un9VOLmz2puBM3s9oZ7xKAc/AdZj6HQ+E8n1njIO
         n0WNGeRKdxx3H1uziedWt+1L75JEF5jUAjqFEhD4=
Received: by mail-qt1-f174.google.com with SMTP id n32so4585279qte.11;
        Tue, 08 Jan 2019 06:57:01 -0800 (PST)
X-Gm-Message-State: AJcUukc6XwWct9b4SCTTnAJ9b4MU3yegZnHJPwQ6AOA5rqWSO+tG07oc
        syaK/6ro9B9/4i4wcrszJh3KwhVnY8wERCLQ2w==
X-Google-Smtp-Source: ALg8bN4DTMPwuqi6GrKoOjHsoXa/AUhAr7ZBhJzYYrOtIh6+jPTcCnmr+EZ6HYQtZevVA99ege7oDhlPWDFgZ6rKDiE=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr1882981qtd.257.1546959420549;
 Tue, 08 Jan 2019 06:57:00 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus> <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
In-Reply-To: <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Jan 2019 08:56:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
Message-ID: <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa boards
To:     =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 5:43 AM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft.c=
om> wrote:
>
> On 29.12.2018 00:25, Rob Herring wrote:
> > On Tue, Dec 18, 2018 at 02:42:11PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> >> These are i.MX6S/DL based SBCs embedded in various Y Soft products.
> >> All share the same board design but have slightly different HW
> >> configuration.

[...]

> >> +/ {
> >> +    model =3D "Y Soft IOTA Draco i.MX6Solo board";
> >> +    compatible =3D "ysoft,imx6dl-yapp4-draco", "fsl,imx6dl";
> >
> > All compatible strings should be documented, not just SoC vendor boards=
.
>
> OK, I will add a Documentation/devicetree/bindings/arm/ysoft.yaml file fo=
r that.

Actually, it should go in fsl.yaml. The file for every board vendor is
gone. i.MX was pretty much the only platform doing that.

Rob
