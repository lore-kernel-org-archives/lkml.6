Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9E42086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpJ2YSvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9E42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbeKPCk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:40:28 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41389 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPCk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:40:27 -0500
Received: by mail-yb1-f194.google.com with SMTP id t13-v6so8589742ybb.8;
        Thu, 15 Nov 2018 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X1mxXzdBiRG48X8HPBucc2eN8sH48Ki9YL+NVw/zJQk=;
        b=XpJ2YSvAtfJhLwjRVmMW313JuFEs20UUANQ2n/dHrDEUFVmsBsVqi3DilNhErLpg3Y
         6wSYDzwO+xqTnyS8L5f+c765/YnTYjNAV/U/ESCdAKCB2+cwic8obvEhnvpsPui3/DfT
         MebxKCchw28cGWPDX4FdcQbCUfFKINmerqjB7+0vPoSXi+WTOaN1QG+iBEfqtAlNs1iX
         t11g1QdoyyaUXROfyAeJH8lHjWDeXHLtoYN/TpSotCmlx9yHlcnPsjzAgBdWmdSx1PnE
         s5GcSrIWy8JBekk8dIDO0JM5J6c8tY/EA6YedeQ0auyP+anOTdSc3ts87/Li04OQJyPp
         BocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X1mxXzdBiRG48X8HPBucc2eN8sH48Ki9YL+NVw/zJQk=;
        b=VCLmsn/uB2yU2EMyl5OVCwitQYLI3MfgTm5RDXc0RKPoyFDtGgX7kD/yxzLSniZ+DN
         euE4aFSibgZI/+usxLFeQ3DYN+cCOcd3bBMSmSrtwuTIkhh5Q360IZjbWnWl4o779sFF
         70zj7cQurRwxbSoDEqRnTdcaRFILwlNTgP9ljQLSkrTtn1QiYQkuvoAOy7QogDJg8/a7
         ytevvzGNQI1QlbMK60AimfDwWePUYMyPCb/sg0VzhLz5B9rE/IGHSKB1k+aQJWNHhMrH
         +NgO0Kz75XbbnmBbGoabZA2J8YPzkPzXrt+RQoasg5mH8V4n57h3JJObK/jsCZJbeMih
         XTUA==
X-Gm-Message-State: AGRZ1gJd0itOEWWAkKwld0KVFAziqzFCvNBDglfglCP8veRO6DAa9kZs
        Bw34IDFjtEIG6g5wxKi4Zrbfk//Nx0O4h+Ki8Gc=
X-Google-Smtp-Source: AJdET5fl/CZGn2rj4DSe7KmDs2QlavT6STyXiaycLmd/CagNPdZVvi4gqO1bNAddqENa9D58C/pIvUgA2nnIaKdgcSs=
X-Received: by 2002:a5b:d06:: with SMTP id y6-v6mr6496619ybp.147.1542299515825;
 Thu, 15 Nov 2018 08:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20181108124934.32381-1-peron.clem@gmail.com> <20181113225135.GQ2089@sirena.org.uk>
 <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com> <20181114173129.GY2089@sirena.org.uk>
In-Reply-To: <20181114173129.GY2089@sirena.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 15 Nov 2018 17:31:44 +0100
Message-ID: <CAJiuCccTwxA4Am=H5vMw9PBJQi_+ErSPEsT5C7PRpv_b6y9EPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118 S/PDIF transceiver
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrien Charruel <adrien.charruel@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, 14 Nov 2018 at 18:31, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 14, 2018 at 11:55:17AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Tue, 13 Nov 2018 at 23:51, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
>
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> > > > + *
>
> > > Please make the entire comment a C++ one so this looks more intention=
al.
>
> > I check from other files and also this article says :
> > "For normal C source files, the string will be a comment using the
> > "//" syntax; header files, instead, use traditional (/* */) comments
> > for reasons related to tooling"
> > https://lwn.net/Articles/739183/
>
> Right, and what I said was that you should make the entire comment a C++
> one which means that the magic line will be C++ as required.

Yes, sorry I was confused between C++ and C99,
Regards,
Clement
