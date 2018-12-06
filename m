Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6AFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BEE20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="SAWxsPXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BEE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeLFIok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:44:40 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39621 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:44:40 -0500
Received: by mail-vk1-f193.google.com with SMTP id q80so5312129vka.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6pFJ3VI5G4p8DpfIC9/fgRuZm55TzzFm6pvGBFskL2o=;
        b=SAWxsPXn7cNX4AX/DiYNk9SAcNu5+QpR/HmrgEk6Fk+x1ia2BvqqO9by4O6VVIKRwt
         AuK9tj/FPJ7EWiZD93uAktdstrxhogWqzJ8Qy6V4tiHz2lX1WuNDacEEOCrF3uzfroZ/
         vdChAfdt22Ndukx1I+JVSeePRgY6gws401lwPpzZjtRpnknaaGDrOaOuMN5CFN8qDfmP
         01Q3tRE5/E34SZO8ZE0daXV4FQ7pBEai0NWOv5KLceFb1RxNV/ItwjjDWls6puMI6eMl
         aEDh2QYj9RZdyoVsFMFQFA4v3Qoxrkh9PI6UuYmdEaF9BNl1pyY6vcYQoBUAyJU5fLH1
         qoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6pFJ3VI5G4p8DpfIC9/fgRuZm55TzzFm6pvGBFskL2o=;
        b=eGegVsM26pmt29raBkBIYiro++21md16DJ+WhehTbVtAyEb/9Ek475ptU/ZWMmRupZ
         Kr9v0a1EJ4+sG9WiiFhcJhvDCODiTqmXFNsY5Q2IrXL5IhQ3GZrDJXl9LY2cyqd1nQqW
         tEw8ig1FPuK2BOiLkoiE7XwPU9JgRGrDioob80y+TO5A/a49CQflKGekcHT2V+ybKs6q
         FYzpZ2xG4wAM+6wv2XoSJSZZ7fKmY4tZhCzzo/foCwkEQKiYOWMnOc4Bv2Ds8vwRkvIj
         OZNnGjeD7wYbkJct2MhstYLTafsqUEJYCjbeLDQauoSVlhJmeockt15p1Plsztf+cQru
         hZlw==
X-Gm-Message-State: AA+aEWaRS4+dzf3nI7ZeDaupwGDYYvr7/Uamj6+z24kx66aAnbH3ISnT
        nRAK8KXEHRQ7GUuk7qcAiRysQGQ0zEIatvxd6qIu6g==
X-Google-Smtp-Source: AFSGD/W1ggVz0s5TvMN7W00CkESwsuq4oam3BqvWxBMuc3dxxLFq51hsn72J0Xe5/Vq8ZThQFhiQ9hxH0t1NMt8aNqo=
X-Received: by 2002:a1f:8d94:: with SMTP id p142mr11965304vkd.58.1544085878550;
 Thu, 06 Dec 2018 00:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20181205074212.31104-1-jian-hong@endlessm.com>
 <20181205074212.31104-2-jian-hong@endlessm.com> <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>
 <CAPpJ_ed5qbhxUONdoACcQhH8jv1J_vvw4M-Vp4QwDsgQ1w8Vdw@mail.gmail.com> <6FAB7C47BCF00940BB0999A99BE3547A184200EB@RTITMBSV02.realtek.com.tw>
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A184200EB@RTITMBSV02.realtek.com.tw>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 6 Dec 2018 16:44:02 +0800
Message-ID: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups
 for ASUS X542UN
To:     Kailang Yang <kailang@realtek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Kailang <kailang@realtek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi Jian-Hong,
> >
> > Could you test to change the model to ALC269_FIXUP_HEADSET_MODE_NO_HP_M=
IC?
> >
> > .chain_id =3D ALC256_FIXUP_ASUS_HEADSET_MODE  =3D=3D> change to ALC269_=
FIXUP_HEADSET_MODE_NO_HP_MIC

We do not have ASUS X542UN in hand right now, but we have ASUS X542UQ
which goes with the same quirk as X542UN.
I tested with ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC, and it also works.
So, I am going to send new patch set using
ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC for ALC294.

Thanks,
Jian-Hong Pan
