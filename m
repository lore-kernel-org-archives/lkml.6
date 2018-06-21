Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F05FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5245420837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPm1699j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5245420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFUHGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:06:25 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36462 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeFUHGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:06:24 -0400
Received: by mail-it0-f67.google.com with SMTP id j135-v6so3328471itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+o0a8qJY2/Pt0SHKMnMfm3AlumEW1LhlaH66K/cCqk0=;
        b=PPm1699jRAP8WyFEDs4GtDX3JqwX8Hy4Use+oVBr8ZrvvDkXwd8aCI/THl1+QKIkKh
         aAAdnm++BG37Kfa5C1plcagbImEAqvYwU+xnnsyvj0G1ZBT11zL9xYPji+oy31Orh0W2
         RZLmhXNjVHj10O3p+JTghzKq1LRiD3jIinwNswrc/6rMaYxgw/52fb6rZDlvd6JW5Mc/
         V4jyUmMS3ZSaOrBdvq5l2KtoWAMB+Vcb6C+7dJQ4h/kgG/gIGJTqkG5VOqrwlCiQrECK
         EkhhNQ9E2F3r5Zf+yoni7GAr7xLGz1gi1wcgDobpO3v04LpmJ2I1yemVXNYzgC0ysQjh
         OzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+o0a8qJY2/Pt0SHKMnMfm3AlumEW1LhlaH66K/cCqk0=;
        b=MIO8a+YbBH6dmBXcG28sC4P07XMVdmv3hbEbt9Nqa87s7q5hwH7kqFkt0H2l4WaFB2
         wXShHfHpLROKwtQlzniUH5YaHReQmyj53doeORsiepr/Q1sc1YqeP+k2GxqsG2CQbnTV
         8Vs1vxWIoQBpPc8KbmMTKAPAHnTr1KtX11+P4PeeqMcVz8TySh0O3D2ok0P41Ut32lwn
         mI7CE/YIb+WkQWAv79L464GQzuHrvqCjZXuc408sj00MQifgaRNfY0srbJaIqkOngpRY
         aQS96A8zvezrh0EHXI5w+ZjTAJY1gpoJIBy/QwlN4gwSZp0zdTwRteaPgl/Yr+1YaCnb
         74aA==
X-Gm-Message-State: APt69E3YzycLhhaJm57iadNJCiF3RKkg2BEPGpk+l72CHpEK1MoX2EJA
        rhPtxIyvftLEgZJaEQ+e/Mp7Y1dv/JX4EDCtRM0=
X-Google-Smtp-Source: ADUXVKI2GaC+hhmnWYywZFct+YGntB7ZqFVPW99I8Nr/jieFlZPGcBOz7hKa2izDGKbqYRvUwnXxQZsDTQSWIOJXgbE=
X-Received: by 2002:a02:94e7:: with SMTP id x94-v6mr20211182jah.49.1529564783409;
 Thu, 21 Jun 2018 00:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529506497.git.zong@andestech.com> <79dba59ab02752b260cb31f557a09df786fd80d7.1529506497.git.zong@andestech.com>
 <20180621064043.GC19319@infradead.org>
In-Reply-To: <20180621064043.GC19319@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 21 Jun 2018 15:06:12 +0800
Message-ID: <CA+ZOyahrur6+9xw6mTpMGEe2Y6S=V0f_63kzqOgAdbdTpOvqCA@mail.gmail.com>
Subject: Re: [PATCH 1/5] RISC-V: Add conditional macro for zone of DMA32
To:     hch@infradead.org
Cc:     Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aou@eecs.berkeley.edu, greentime@adnestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B46=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:40=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, Jun 21, 2018 at 09:41:41AM +0800, Zong Li wrote:
> > The DMA32 is for 64-bit usage.
> >
> > Signed-off-by: Zong Li <zong@andestech.com>
> > ---
> >  arch/riscv/mm/init.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index c77df8142be2..91a5852e28fd 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -28,8 +28,11 @@ static void __init zone_sizes_init(void)
> >  {
> >       unsigned long max_zone_pfns[MAX_NR_ZONES] =3D { 0, };
> >
> > +#ifdef CONFIG_ZONE_DMA32
> >       max_zone_pfns[ZONE_DMA32] =3D PFN_DOWN(min(4UL * SZ_1G, max_low_p=
fn));
> > +#else
> >       max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;
> > +#endif
>
> This breaks the 64-bit setup.  The second line needs to be kept for
> the CONFIG_ZONE_DMA32 case.


Yes, it should be

#ifdef CONFIG_ZONE_DMA32
    max_zone_pfns[ZONE_DMA32] =3D PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
#endif
    max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;

Thanks!
