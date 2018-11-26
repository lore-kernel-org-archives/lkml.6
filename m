Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2EEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DE720817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pun.org header.i=@pun.org header.b="TFo1Ji19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DE720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pun.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeK0HRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:17:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43948 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeK0HRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:17:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so19186860qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pun.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esRgVhR4q+iCatyFdF7NaPYFbeNv4OAQbPSBDZQYFWY=;
        b=TFo1Ji19l3q2seqNDb0MAY3tATK4PmTF6W/bruLpcWyqedQuzqnAZtj5O5DD6RzZdZ
         nIyVPtfSh9FuFsxRtz3u8yFvAdJlTQwg+l7We2GaM6R/Fx0ZR5OP9HTcSEI+4EZ/THQB
         XL4kIvRc91hAZspxMoIaXUSVNfwGLUoHUlWJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esRgVhR4q+iCatyFdF7NaPYFbeNv4OAQbPSBDZQYFWY=;
        b=PoMqDm3o2isRw3ocO8pSFADaUB4E1QeLHT+nrQr+SV0bO6dNAEQNInQLBm3ifBw/0R
         2GWkTiYCz3493CgYB66LA0at090GkAEWeDmpTnCqpo4pSrRjRewGlF28QM3SapPoUmEG
         39QYJSWCbTlO9BGMMDwh1TNFlEMDMnifVCud7y8lxUS2nuHTxyG56GazKwP8p3h1s05o
         RGLuw8dIjVBeByGM3e2RF8rE+VNQZ0LU4C4Yzj7Eh8OyqAQxcZOkwDTdDwyuHglmLiPj
         OTdIALf2zNcBcQ2unynmvO6bn1vFsKHjJz/zU34Oul/Y62WbRmx0cvGBk4awOuP5ZZl9
         WseQ==
X-Gm-Message-State: AA+aEWad1o4O6MN6VFTUFRV55jvGOBmTV05wHP26+feIBWg/ypuYde/w
        WHH5MkndtT4veNKFDQaEJhkngrS0AawgGn56iDmdXA==
X-Google-Smtp-Source: AFSGD/UQ1kbpkw08TOw0E20yJUTFpGb5zVprtUEBP66nEG9nunwIre7ls6r+G4rNE2XJGfBquQZrwm2pDzAP4vukhts=
X-Received: by 2002:a0c:8286:: with SMTP id i6mr27697596qva.65.1543263704714;
 Mon, 26 Nov 2018 12:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20181122030914.16274-1-kys@linuxonhyperv.com> <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181126191812.GA32208@kroah.com>
In-Reply-To: <20181126191812.GA32208@kroah.com>
From:   "Joshua R. Poulson" <jrp@pun.org>
Date:   Mon, 26 Nov 2018 12:21:33 -0800
Message-ID: <CABHrTiLtn6BjWoqUoSxwUjEAJAcrRvMkpPLsFnNGCCXWdFoRXQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
To:     gregkh@linuxfoundation.org
Cc:     KY Srinivasan <kys@microsoft.com>, will.deacon@arm.com,
        catalin.marinas@armm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, Andy Whitcroft <apw@canonical.com>,
        jasowang@redhat.com, Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (SYSTEM CENTER)" <Michael.H.Kelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, mikelley@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/r=
eference/tlfs

Thanks, --jrp
On Mon, Nov 26, 2018 at 11:18 AM Greg KH <gregkh@linuxfoundation.org> wrote=
:
>
> On Thu, Nov 22, 2018 at 03:10:56AM +0000, kys@linuxonhyperv.com wrote:
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> > @@ -0,0 +1,338 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This file contains definitions from the Hyper-V Hypervisor Top-Leve=
l
> > + * Functional Specification (TLFS):
> > + * https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
docs.microsoft.com%2Fen-us%2Fvirtualization%2Fhyper-v-on-windows%2Freferenc=
e%2Ftlfs&amp;data=3D02%7C01%7Ckys%40microsoft.com%7Cc831a45fd63e4a4b083908d=
641216aa8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636768009113747528&a=
mp;sdata=3DjRSrs9ZWXdmeS7LQUEpoSyUfBS7a5KLYy%2FolFdE2tI0%3D&amp;reserved=3D=
0
>
> "interesting" url :(
>
> Care to use a real one?
>
> thanks,
>
> greg k-h
