Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BAFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3389E2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="bZ88MBi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3389E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeH2Sso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:48:44 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44024 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeH2Sso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:48:44 -0400
Received: by mail-ua1-f67.google.com with SMTP id f4-v6so3398099uao.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BFzgmMVnFSuFK0YDmdjIdXGCXD5JlHI9DcS2nQTLEo0=;
        b=bZ88MBi7yikaJKOhLcQYZ07Z19Ccxc7EyMlVWIH3XztAfs4qET3fhY/yaLn673jK8K
         rwVuFhsVunzSIQl2mvp6PLOm4sjrlhpPhPBYTCHEGEyUrRpX+x1OGxH82RaQJN2Xn+bU
         bBv9tLqlJelDFuvEWkdDTOKJ1pCX+/mG+++FbJRzl2HV5gFud/G4N5nUKfGqYTdp1Mlc
         2aXc2jJzAMXGdfjQ4Db3Qf8ddY95aMUyj1mdPL6CdvQHK38CYzDgM99vo/S15cs7+WbV
         v3egYraZEzTV8tB088dVjQQpSWLXqa4cSS5MrFaVtG94YkWugksS4/vvh0CCLsprcQzJ
         JfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BFzgmMVnFSuFK0YDmdjIdXGCXD5JlHI9DcS2nQTLEo0=;
        b=HdKhS+FdhgK9Zu9o8JyFqOVTbb3McNJR9NV8Qel5MwgEv/4luimKrpimdiZ0Zst7JB
         OWx62Bbp1C9qOdrux0yaeLCNJJu+cOb06InEpMPOhSiS/b5QRRPYTb2dFDmweb3uNV1S
         A2oveojRTzgs9dZJZZF4wRUagVfXOBDapPHKMASKat69wJ2E/RmOqijoMgUBpCmij+R9
         wF/QMeFXLRqK6QPAzVY+7rJNmQOt8XdSjThXNaECFsyJI3ltEvgx+Bqpj4yLxx012VgB
         rIVa8qEg9qnPoDgnzVyo/mvSijDQmh8KGtUVnor4ZCr1IjFq6UsIkWCkQFlbz1RkvgoX
         E+BQ==
X-Gm-Message-State: APzg51AeKamA3JJuS3m3b5LbQqCsEbKXnO//JrGUYEKdxu153FFvk/BS
        7DCN2b9zpHHSvbcw5+F0bIbU08hhXaUhCFiKhuUCOA==
X-Google-Smtp-Source: ANB0VdbUAtx18E8LI1p009ddLXL5zWOONt/s2lmOE1Qf6mGwZim9rg6I7hADGDhuqKNADBSlHwF6NdJotG1fPeBxRVk=
X-Received: by 2002:a9f:3acc:: with SMTP id q12-v6mr4350635uag.178.1535554285064;
 Wed, 29 Aug 2018 07:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545414-550-3-git-send-email-hans.ml.holmberg@owltronix.com> <eb5ca95c-6c4a-71a0-4cf1-634b211b52ce@lightnvm.io>
In-Reply-To: <eb5ca95c-6c4a-71a0-4cf1-634b211b52ce@lightnvm.io>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Wed, 29 Aug 2018 16:51:13 +0200
Message-ID: <CANr-nt2hZku+CwO2eQ4hbu0bCP-=14jRHp2GkR-4N6-Tx_CiLg@mail.gmail.com>
Subject: Re: [PATCH 2/7] lightnvm: pblk: fix mapping issue on failed writes
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 3:23 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > On 1.2-devices, the mapping-out of remaning sectors in the
> > failed-write's block can result in an infinite loop,
> > stalling the write pipeline, fix this.
> >
> > Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path"=
)
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >   drivers/lightnvm/pblk-write.c | 45 ++++++++++++++++++++++++++++++++++=
---------
> >   1 file changed, 36 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-writ=
e.c
> > index 1bc879ab679d..fd67325f6e54 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -103,6 +103,41 @@ static void pblk_complete_write(struct pblk *pblk,=
 struct nvm_rq *rqd,
> >       pblk_rb_sync_end(&pblk->rwb, &flags);
> >   }
> >
> > +static int pblk_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *=
ppa)
> > +{
> > +     int done =3D 0;
>
> Could this please be renamed to last to signify it is the last ppa in
> the ppa.

Yes, that would be better.

>
> > +
> > +     if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
> > +             int sec =3D ppa->g.sec;
> > +
> > +             sec++;
> > +             if (sec =3D=3D geo->ws_min) {
> > +                     int pg =3D ppa->g.pg;
> > +
> > +                     sec =3D 0;
> > +                     pg++;
> > +                     if (pg =3D=3D geo->num_pg) {
> > +                             int pl =3D ppa->g.pl;
> > +
> > +                             pg =3D 0;
> > +                             pl++;
> > +                             if (pl =3D=3D geo->num_pln)
> > +                                     done =3D 1;
> > +
> > +                             ppa->g.pl =3D pl;
> > +                     }
> > +                     ppa->g.pg =3D pg;
> > +             }
> > +             ppa->g.sec =3D sec;
> > +     } else {
> > +             ppa->m.sec++;
> > +             if (ppa->m.sec =3D=3D geo->clba)
> > +                     done =3D 1;
> > +     }
> > +
> > +     return done;
> > +}
> > +
>
> Can you please move this function to core? I want to avoid introducing
> more if's around 1.2/2.0 in targets.

That makes sense, i'll post a V2. Thanks for the review.

>
> >   /* Map remaining sectors in chunk, starting from ppa */
> >   static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *pp=
a)
> >   {
> > @@ -125,15 +160,7 @@ static void pblk_map_remaining(struct pblk *pblk, =
struct ppa_addr *ppa)
> >               if (!test_and_set_bit(paddr, line->invalid_bitmap))
> >                       le32_add_cpu(line->vsc, -1);
> >
> > -             if (geo->version =3D=3D NVM_OCSSD_SPEC_12) {
> > -                     map_ppa.ppa++;
> > -                     if (map_ppa.g.pg =3D=3D geo->num_pg)
> > -                             done =3D 1;
> > -             } else {
> > -                     map_ppa.m.sec++;
> > -                     if (map_ppa.m.sec =3D=3D geo->clba)
> > -                             done =3D 1;
> > -             }
> > +             done =3D pblk_next_ppa_in_blk(geo, &map_ppa);
> >       }
> >
> >       line->w_err_gc->has_write_err =3D 1;
> >
>
