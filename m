Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E172C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D021E2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="OJlz6rto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021E2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeICMQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:16:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44213 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:16:01 -0400
Received: by mail-ua1-f65.google.com with SMTP id m11-v6so12484161uao.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0DbDQ8diAdf5m14wtXI6ouf+Nu0hhGcTfRfaAxBUjAE=;
        b=OJlz6rtol+He5Klu6x1odKIPlD60az22a8vqGsvqpNPArL3Jr0IOeSHpsvlV92hCIb
         nqexNLTb+8O82PXEoIpxN3hGISmA0jPnoXZ9tXk4r4izeQh9c48hQbGjpEhBQsUQd3Wo
         hiOth03RcZp4AkIzh8d4lWJHMVjQyzBBFtqN/A3m9jKnATQUV7lPMltvXpz/eB24hXf1
         E6VsangSsh1ehw6pwWg1A56KCuWXbQJNr8ASHrH0YPqiBY05uygSUErvz0g9RfILJaew
         s04SsqION6iTZAzYLC4qyIf6QIPgldklUzlKxBu1prAzIRanDT/7M8iqu2r/25LxlvwA
         wnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0DbDQ8diAdf5m14wtXI6ouf+Nu0hhGcTfRfaAxBUjAE=;
        b=DiuObwB7YXN3aSpYkue0D9CYJDEgdUdkxaqT2M1ELsKfj+nVKeF6soE160AgwqDuAo
         j2X2ZWOWExb2SnQW08cAa5HL37yHY5QBLCHZp4A6ZZ87BK4X+JRFkGGwghkTd1imYtBN
         v71PoNAvwndsNuvaRkeaOETwJkJYcqGx55T1Ik4NtHlnz6U5HNCidCLjFnMQzf01ai+l
         CPX9m8TUoe3lTLaFZfZQMCYZ4biDK3bbtT2YXRXAZwTHKFifthESEUKfi+it0L6j5437
         BlZ9r147QzZ7q2tJE7rg0hH0S77/VSH/APZgFuS4W0beMFjGIjBUiZRbyvhrvQrbR6fT
         sTWw==
X-Gm-Message-State: APzg51ABW+cu3EtAwjupWVTddcOfkpYyWh9xWbSuEa2mcDReT8vIsRVn
        NCOLAiXfxg55uiiRnUbzN4NJrBVr+HUYW9RONyPw0M3Pzpg=
X-Google-Smtp-Source: ANB0Vdal3RQkGtJICPSk1NtHCp1j0em9/+JikTJ0q07caOEAmQbb2LAVd3sd9+mbShLWqpDxVoCW6nA15SA3CkeudMk=
X-Received: by 2002:a67:8dc6:: with SMTP id p189-v6mr8043334vsd.15.1535961422486;
 Mon, 03 Sep 2018 00:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com> <70ce6061-61f0-9a14-7b70-59d0ad2bfa43@lightnvm.io>
In-Reply-To: <70ce6061-61f0-9a14-7b70-59d0ad2bfa43@lightnvm.io>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 3 Sep 2018 09:56:51 +0200
Message-ID: <CANr-nt2cv7Ja=4zwp_kwyYsgeLWy=mR8gMEYz=FNOJ0pffQ-Gw@mail.gmail.com>
Subject: Re: [PATCH V2] lightnvm: pblk: fix mapping issue on failed writes
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

On Fri, Aug 31, 2018 at 4:18 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 08/31/2018 11:59 AM, Hans Holmberg wrote:
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
> >
> > Changes in V2:
> >       Moved the helper function pblk_next_ppa_in_blk to lightnvm core
> >       Renamed variable done->last in the helper function
> >
> >
> >   drivers/lightnvm/pblk-write.c | 10 +---------
> >   include/linux/lightnvm.h      | 34 ++++++++++++++++++++++++++++++++++
> >   2 files changed, 35 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-writ=
e.c
> > index 5e6df65d392c..922506d2d0a6 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -125,15 +125,7 @@ static void pblk_map_remaining(struct pblk *pblk, =
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
> > +             done =3D nvm_next_ppa_in_blk(geo, &map_ppa);
> >       }
> >
> >       line->w_err_gc->has_write_err =3D 1;
> > diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> > index 09f65c6c6676..2a6cbfe1d1b4 100644
> > --- a/include/linux/lightnvm.h
> > +++ b/include/linux/lightnvm.h
> > @@ -593,6 +593,40 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_de=
v *dev,
> >       return ppa32;
> >   }
> >
> > +static inline int nvm_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_=
addr *ppa)
>
> You can pass nvm_tgt_dev here. Then the two unfoldings in
> pblk_map_remaining are not needed.

Yeah. thats better. fixed.

>
> The naming sounds very 1.2ish, how about nvm_get_next_lba_in_chk?

I used blk because in the generic ppa format (ppa_addr.a), the name is blk.
Chunk is more abstract concept so i think it's better using that going forw=
ard.
Fixed.

>
> > +{
> > +     int last =3D 0;
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
> > +                                     last =3D 1;
> > +
> > +                             ppa->g.pl =3D pl;
> > +                     }
> > +                     ppa->g.pg =3D pg;
> > +             }
> > +             ppa->g.sec =3D sec;
> > +     } else {
> > +             ppa->m.sec++;
> > +             if (ppa->m.sec =3D=3D geo->clba)
> > +                     last =3D 1;
> > +     }
> > +
> > +     return last;
> > +}
> >
> >   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct =
bio *);
> >   typedef sector_t (nvm_tgt_capacity_fn)(void *);
> >
>
