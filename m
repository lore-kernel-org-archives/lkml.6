Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB47C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909A42098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImnQa9Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909A42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJRUAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:00:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37098 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbeJRUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:00:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so23748926oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9fEzlNMOYKFf9+xRuK6JcthANZlOoiUBvMjjuQoFuY=;
        b=ImnQa9Grciveb4nkFjpMa1WVoNw13UEdZntIghUBeg5xwHC8cKgoCTLT7O2U71HFY1
         1f25sH7+V74QzyfFVpUwUlvueoriPYiFdJIrDxj9KCsFAS4yQKlVjmXuHyjstuuKgiOr
         0X0tccKTwxiAcPEYtvcKEL2L7R388y4KCbDXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9fEzlNMOYKFf9+xRuK6JcthANZlOoiUBvMjjuQoFuY=;
        b=bKeU+gLRWku6jFcx7mKlqbgN3b1xz47x5dbcnOPI18JqpxsRTKwsmYtdgE+mmtjSet
         DZIPVd/zJlFHXg7rsMbB4bHR4Yd0gyt+PTLsi0apCgzQxzqIbFkrmGSGMU2h5IMDkgju
         FNf5jaLQ5oD2/sEAKBUejfQq8sbQYRqsW0hzlQHtEIWbjN4WJtTCyyEFQWriF5jrICDV
         Y/7cmeLeajmFoeFZQeadIUPnn6GXiuxE462+xmE1vwzKetCMh0N7XxlANDAoXR4rWD9P
         Aj/K2SgnQ30XJSxlG1ICzvxNVqTeARvN9OxYapgnaDoyfWH5rqpPxMCFllueoanJPxAw
         5yBA==
X-Gm-Message-State: ABuFfoh4Gw85ho/jsxAxo8YeShlBvh2JFZmZLmPAaHSANYBBLdjEwGak
        7b3z2/LeXucPvRJHnWIVHKuJPLyRIpBO713vUdeEYA==
X-Google-Smtp-Source: ACcGV61p0Acmd3cuxaGXdogUQUT4yUQtNbddyEBElqhTSXy7mrV9+V62kUgvUuqsppdZbVp2sjA9HXSI/xWLsG9hvFE=
X-Received: by 2002:aca:dd08:: with SMTP id u8-v6mr15215781oig.94.1539863978239;
 Thu, 18 Oct 2018 04:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-7-hch@lst.de>
 <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
 <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com> <20181017071958.GC23407@lst.de>
In-Reply-To: <20181017071958.GC23407@lst.de>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 18 Oct 2018 13:59:27 +0200
Message-ID: <CA+M3ks5WW9WviTNr3VLHc-ijYLu-fp8XMtAbr3p9cFe3J+n39Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 17 oct. 2018 =C3=A0 09:19, Christoph Hellwig <hch@lst.de> a =C3=A9c=
rit :
>
> On Tue, Oct 16, 2018 at 02:41:23PM +0200, Benjamin Gaignard wrote:
> > Le lun. 15 oct. 2018 =C3=A0 11:12, Benjamin Gaignard
> > <benjamin.gaignard@linaro.org> a =C3=A9crit :
> > >
> > > Le sam. 13 oct. 2018 =C3=A0 17:17, Christoph Hellwig <hch@lst.de> a =
=C3=A9crit :
> > > >
> > > > The DMA API does its own zone decisions based on the coherent_dma_m=
ask.
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >
> > > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >
> > Christoph do you plan to merge this patch on your own tree ? or would
> > like I put it directly in drm-misc-next branch ?
>
> Please pull it in through drm-misc-next, thanks!

Applied on drm-misc-next,
Thanks,
Benjamin
