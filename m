Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7257320874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5hzuHLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7257320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeKYHpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeKYHpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:45:42 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B6120874;
        Sat, 24 Nov 2018 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543092985;
        bh=hlBsiUEH+ZWka5a8iz5DaWCEzuHRprj8sINmx8c6ZzU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R5hzuHLWEu28G+/iDcUyeLMIPJhd/JrF3lgl1DJ0VqCt/lBaW6szGY7Aa9hQvo6/x
         VZm+Kk/7b2XfgKpvcBPGXYkYOH3nmFoGUHZ9EkDirmtha5WYAv3ZrXXlDgiHwqluvU
         8spO1p47metAK/v5jZXfDHcd+cicMdTb0u5b0Hoo=
Received: by mail-qt1-f172.google.com with SMTP id n32so13673765qte.11;
        Sat, 24 Nov 2018 12:56:24 -0800 (PST)
X-Gm-Message-State: AA+aEWb0HiYas5TSBVhX2Vo4FGyB/q/GG2nT7D1zYRqzgFYNA1B6xeC6
        KlXHxp+iWWZZcL8jBZpOWejIaz0wcGUDMl1J3Q==
X-Google-Smtp-Source: AFSGD/WxptSR36uFCD4EPBdkOCOg65I1mjd29oA74fGxOzpWpPzkr5PmnXa/FAZ3gSMKnpVrrdnktNDAaa1NU74cW3I=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr20410240qvk.106.1543092984189;
 Sat, 24 Nov 2018 12:56:24 -0800 (PST)
MIME-Version: 1.0
References: <1542787873-8429-1-git-send-email-miles.chen@mediatek.com>
 <CAL_JsqLGvUYQmCGXLgSO+6kFj2i87dpaTbMGbyu5oMt=eeu35A@mail.gmail.com> <1542855088.15789.6.camel@mtkswgap22>
In-Reply-To: <1542855088.15789.6.camel@mtkswgap22>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 24 Nov 2018 14:56:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+O1YDP1yiHZpcxUaFG1LYDqi74D_kEnErP+cwGDppVWQ@mail.gmail.com>
Message-ID: <CAL_Jsq+O1YDP1yiHZpcxUaFG1LYDqi74D_kEnErP+cwGDppVWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] of: make MAX_RESERVED_REGIONS configurable
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:51 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> On Wed, 2018-11-21 at 10:39 -0600, Rob Herring wrote:
> > On Wed, Nov 21, 2018 at 2:11 AM <miles.chen@mediatek.com> wrote:
> > >
> > > From: Miles Chen <miles.chen@mediatek.com>
> > >
> > > When we use more than 32 entries in /resered-memory,
> > > there will be an error message: "not enough space all defined regions.".
> > > We can increase MAX_RESERVED_REGIONS to fix this.
> > >
> > > commit 22f8cc6e3373 ("drivers: of: increase MAX_RESERVED_REGIONS to 32")
> > > increased MAX_RESERVED_REGIONS to 32 but I'm not sure if increasing
> > > MAX_RESERVED_REGIONS to 64 is suitable for everyone.
> > >
> > > In this RFC patch, CONFIG_MAX_OF_RESERVED_REGIONS is added and used as
> > > MAX_RESERVED_REGIONS. Add a sanity test to make sure that
> > > MAX_RESERVED_REGIONS is less than INIT_MEMBLOCK_REGIONS.
> > > Users can configure CONFIG_MAX_OF_RESERVED_REGIONS according to their
> > > need.
> >
> > I don't want a kconfig option for this. I think it should be dynamic instead.
> >
> > The current flow is like this:
> >
> > for each reserved node:
> >   - call memblock_reserve
> >   - Add info to reserved_mem array
> >
> > I think we should change it to:
> >
> > for each reserved node:
> >   - call memblock_reserve
> >   - count number of nodes
> >
> > Alloc array using memblock_alloc
> >
> > for each reserved node:
> >    - Add info to reserved_mem array
> >
>
> thanks for your comment.
>
> I reviewed the flow and it might be easier to count the
> nodes and setup array first:
>
> for each reserved node:
>     - count number of nodes
>
> Alloc array using memblock_alloc
>
>
> for each reserved node:
>    - call memblock_reserve

The order here is wrong. It is important that you reserve the memory
blocks before doing any allocations.

>    - Add info to reserved_mem array
>
> What do you think?
>
> > Rob
>
>
