Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14640C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C044721477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XN3b8b7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C044721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeJRUBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:01:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41154 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJRUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:01:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id l197-v6so23744596oib.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8LEYxzNyd12usccmUsiKE+Ec8KzMI7COr+GLPD/jpk=;
        b=XN3b8b7zKy8i4etEdLFPO/xImVsqJGBgjdSFoEUeo7ZG7PxGIq+bhVXfbkXib6lSsM
         IOrsVGl397DSogrAyHCXku/hdgfILUOE3AGx2jKsqCcKEqy67nblrlUJM+Km+Y8fG6UG
         3d1aIUOPr2KK5V/+XoW2KKfNJRi8DH3305oMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8LEYxzNyd12usccmUsiKE+Ec8KzMI7COr+GLPD/jpk=;
        b=kYJ4Ftv3T2VuGXcKWY19WUEfqJKCyxPWakcGxDcIkHQCh1rmHIJuPTUFHFUzl/U0zM
         teBrh2GViut5Wde8x72FaZP8RfgDCOoE6/Qu0+LB5JNAEkLeNm9BZ4FBvEWIk2IWn2vc
         8Jm0RUVxDj0tzPZMfNpZjCvkjG1i4CEIJ0miuadxq/n6zWj5mthuMqyNpxC5HWO/5zNS
         ewG9nhNbGH9sfpPVsgu2+F/jJgPb2eeL/3LyWSbRMtMQbBVPmPEA/FoWBTNDQXzwLizg
         cVC0xp1BUkjvjWUwTmIe+Y+74nt1un3rOkEsBelt69oPXCEYqdp7aRlUe7io12DlH6H5
         rtrg==
X-Gm-Message-State: ABuFfoge+gCbbkJUsBS1pTwp1CfLPlWZmgjIXY4B735mgL1DuIJFxhki
        QLR9dheaZv+z51yxKFI907VjNLZPvb+ETalrD72R3g==
X-Google-Smtp-Source: ACcGV609eMpbYg+tF35u60vjBmlnePURX3T5eIRF+acatXnm5ql/Bp+7V06tlGh8QKAkRduPE18lPXeJSVGpQABSIm8=
X-Received: by 2002:aca:4e09:: with SMTP id c9-v6mr15388432oib.254.1539864051156;
 Thu, 18 Oct 2018 05:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-8-hch@lst.de>
 <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com> <20181017072020.GD23407@lst.de>
In-Reply-To: <20181017072020.GD23407@lst.de>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 18 Oct 2018 14:00:40 +0200
Message-ID: <CA+M3ks5ebGDgFtMS5mSYz38AnyrTMQr8C_JkbFEzp=k+izJjUQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to dma_alloc_attrs
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 17 oct. 2018 =C3=A0 09:20, Christoph Hellwig <hch@lst.de> a =C3=A9c=
rit :
>
> On Mon, Oct 15, 2018 at 11:12:55AM +0200, Benjamin Gaignard wrote:
> > Le sam. 13 oct. 2018 =C3=A0 17:18, Christoph Hellwig <hch@lst.de> a =C3=
=A9crit :
> > >
> > > The DMA API does its own zone decisions based on the coherent_dma_mas=
k.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>
> Can you pick it up through the media tree?

No but Mauros or Hans (in CC) can add it.
