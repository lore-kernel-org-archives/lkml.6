Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6906C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805B7218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546933359;
	bh=U8LTxlLkvrlvXtFk9537u+7EhPu/K5r0M0XVwpMvKT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DuYNPsR9H0mvTmGlcZFmwdAMOm8KHG7uxzW95/6SjxGJQ5uBNEZzcOijlterS0ahg
	 j2p29I5Y3gpeHkoZplh++h/V6DLfNQYWpDhsKB7hdYqUTmQ9Aijg0ydPguWC8fzCTt
	 BWriXeiZ0b9cXWYTLea2tYKgppjYHa64LgMluA44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfAHHmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:42:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfAHHmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:42:38 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A4B218A1;
        Tue,  8 Jan 2019 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546933357;
        bh=U8LTxlLkvrlvXtFk9537u+7EhPu/K5r0M0XVwpMvKT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XOhdmRkja7MF7K0aVcRp+AXSyViDqYmhsEiYYLqSi1/DbuJ+C6OLgrAjc4SHlgBem
         RnlIEPSfrrPrdMluukpWQZGfSeJmixYNf0/USVmEAGkN/qTnur4QoeB0Ufmjvpxu9U
         6j6D9XfWLysYybFAsNSwivCLZktXH7WZX1mMQdY4=
Received: by mail-lj1-f179.google.com with SMTP id k19-v6so2528244lji.11;
        Mon, 07 Jan 2019 23:42:37 -0800 (PST)
X-Gm-Message-State: AJcUukdc9Fp/5zgXtAIiEx1jPFAj6Y0I5XaaPpnxNaa+uSl0meijfzr8
        pML716XS/SNh8Uar5HBpi88FtewtbFLMUp7/BIw=
X-Google-Smtp-Source: ALg8bN7OBqxzlKH0KZu5F41cdSrGrbch8RvAS82mdlGAKtoAdE5QvwGvZFMbbmylzd0260PvadqwnrWCkHPHu7dqXXk=
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr463850ljb.89.1546933355582;
 Mon, 07 Jan 2019 23:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20190103201408.GA27754@embeddedor> <20190107194324.GC3313@kozik-lap>
 <1abcd26c-aa10-9481-ed53-3c3654842757@embeddedor.com>
In-Reply-To: <1abcd26c-aa10-9481-ed53-3c3654842757@embeddedor.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 8 Jan 2019 08:42:24 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcKgFpRbFufxw5LVv-boWwdvSq-zG9gw1u7P9-f+5BJMQ@mail.gmail.com>
Message-ID: <CAJKOXPcKgFpRbFufxw5LVv-boWwdvSq-zG9gw1u7P9-f+5BJMQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in osiris_dvs_notify
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ben Dooks <ben@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 at 21:33, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>
> Hi Krzysztof,
>
> On 1/7/19 1:43 PM, Krzysztof Kozlowski wrote:
> > On Thu, Jan 03, 2019 at 02:14:08PM -0600, Gustavo A. R. Silva wrote:
> >> Fix boolean expressions by using logical AND operator '&&'
> >> instead of bitwise operator '&'.
> >>
> >> This issue was detected with the help of Coccinelle.
> >>
> >> Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>   arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
> >
> > Thanks, applied with fixing up -Wparentheses warning. I think you should
> > update your GCC.
> >
>
> Thanks for that.
>
> I wonder if you could take these too:
>
> https://lore.kernel.org/lkml/418252fcd77472413ce15ac3df167e448a4defe9.1546667177.git.gustavo@embeddedor.com/
> https://lore.kernel.org/lkml/2795c5ba939fe23dda6c86135d56e68433f7d68a.1546667177.git.gustavo@embeddedor.com/

Can't do. I am maintainer only for ARM/Samsung platform and these are
for Integrator.

Best regards,
Krzysztof
