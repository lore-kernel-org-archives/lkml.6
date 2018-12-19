Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB8BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5778217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="iHjlnvH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeLSJYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:24:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38426 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeLSJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:24:50 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so8422545ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kOYJwKxQ0pGsj3DpVVNDVwNG3VaOkHgQH3xL3tx3odE=;
        b=iHjlnvH5p8to2RGQWe+2S61K2RyFxMveoU/sAAxWBmx3RefbM2gk+0ZphN2rypGfoI
         rXZqyp2CQy5qsaOHsmI3YxrskF3IZRwdWCmpuZmt7Bmuk3FB/vwXVl8ruYZRZQ4emsdo
         AmSTy4gMKZZVO/MQVKTf2fcd5peFim2EMxmQJOpY7qaMsmUXtoKEq7wEWr9sYMTxAfLp
         okVJBvgJBC6yWu9vkPAMjQfqCIeVTekcGZFMk4aMrXAM3Y0I9REuPjV8E5NV5hpVdoTZ
         B05CdV7kbowl9eJDe2fp/tLbshm56PZKvfjsvwWf6vYEg4XYnQ6nqZionUR8VhTgdKzs
         2oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kOYJwKxQ0pGsj3DpVVNDVwNG3VaOkHgQH3xL3tx3odE=;
        b=Z8uf0M5QfYX9oZMtKRyWSCTjZawxbkJIG7pveGQ29Lsca2BcmDpAeWwaHznXWUeow/
         nc/9WsEVymdBHYCtekfedZ9XZ/A8MGMJMLuxQILdix8o8xuYlyKnNXef69rvHBs5h3ev
         y9HJdf+fsao1GWjXyS2ZbkscjRBRiLw1BEqq7LE+T4s+ApiJsjKr78WKj88j7RS/rwiZ
         jxCMYfgzkMUwgQBGBF+uycAysYb/GBflsTR1o0LIyIVq3cpJepZQkAzBZPWMYIW0YUcY
         rAntx+FnLYw50iMeF/Urb/NPyzxKFcz5naVyuK8vmDv/SLe9DuJZlFwiPYCMa82QLKBv
         Fuvw==
X-Gm-Message-State: AA+aEWYlWH0KccjdrD8teh+ltbmOAhDlHU9g+90wuL/FKnT+Z6HXotV0
        e61++NN+oXxSz18vxHPfGixNGJrQClHBGj084Uyh9Q==
X-Google-Smtp-Source: AFSGD/XrOGYvEw8xJTZUxRdfvI7yAZzRcezzJ/Vj9WZ6mxlDp0h67kSBHC1jDAtQKFsc9SIWGdlCSKjbUMwJee0+BL4=
X-Received: by 2002:a02:7696:: with SMTP id z144mr18385618jab.102.1545211489228;
 Wed, 19 Dec 2018 01:24:49 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181216.124120.731491122771817496.davem@davemloft.net> <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
 <20181217083735.4c6599b3@windsurf> <20181219110546.63f68f4b@xhacker.debian>
In-Reply-To: <20181219110546.63f68f4b@xhacker.debian>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 19 Dec 2018 10:24:37 +0100
Message-ID: <CAPv3WKctKtFVbb8Ltyj9gaB8bJEaTG4pxMeMFJbZKGYeo2_n+w@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        David Miller <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

=C5=9Br., 19 gru 2018 o 04:11 Jisheng Zhang <Jisheng.Zhang@synaptics.com> n=
apisa=C5=82(a):
>
>
> On Mon, 17 Dec 2018 08:37:35 +0100 Thomas Petazzoni wrote:
>
> > Hello Marcin,
> >
> > On Mon, 17 Dec 2018 00:25:58 +0100, Marcin Wojtas wrote:
> >
> > > Thanks. Indeed, the patch is valid as a fix for current version of SW
> > > BM. However, because this concept is broken, I will rework it and
> > > submit patch/patches some time early 2019.
> >
> > I know some people are working on XDP support in mvneta, and this work
> > also needs to change parts of the memory allocation strategy in this
> > driver. I'd suggest to get in touch with those folks. Antoine can give
> > you the contact details, I don't have them off-hand. Or perhaps they
> > will see this e-mail :-)
>
> Great. So the problem of current memory allocation is seen, glad to
> know reworking is going on.
>
> Besides the memory waste, there's another issue with commit 7e47fd84b56b
> it always allocates page, so the rx is mapped with dmap_map_page(), but
> the unmap routine isn't updated, there's mismatch here.
>

Indeed, despite the upcoming rework, which will be more complex, how
about I submit a quick patch for this?

Best regards,
Marcin
