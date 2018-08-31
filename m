Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7EC20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="z0mW6cd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7EC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeHaOJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:09:21 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42235 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbeHaOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:09:21 -0400
Received: by mail-ua1-f65.google.com with SMTP id w7-v6so7749798uan.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yufp+J/gkWzIrD6aPTq0H1Qktbr/r593ciWCgd/kEmI=;
        b=z0mW6cd6Wzeg6klTnFBb/Wqj82nYvaOT9kYE3gZ69AVTP/EZD9RjDffj+OW0/c2fl+
         lTQr6hrJ3hLCiKY6tX8OzYL5w3ojHUbycKGBKKmxZGCagScEFEFdehXj4AR0bjZmDTis
         cgKnOCvGw4RcbcO0jfTVwYAq+pfUMjH4OX12azcTpE2qwaPEh9FNk08PMon/aZEbO6X/
         mv4XVZzVPmdtm/yU/ZQEzS1VcN67SXFNdJ5p/ZMPppqh+A7Tni2Fld4HQhiDTHKU8GOP
         UZ+ag2R8GLyb7PZ7WYs2Br4o3d6z8dclyh/355wsXxWi3Wzkym9r/aZlLhgyjWTJJpe4
         ggEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yufp+J/gkWzIrD6aPTq0H1Qktbr/r593ciWCgd/kEmI=;
        b=KtLpSbDUjWpHdJeRyXWlwrcUBov0/+dOEJepjHyGSvFvh3Lx7PJcbunMLYf9WF/cNw
         Vg7Nsj/YF00oShgyiY7sNDFNXo7r1Tk2UDRtf6c2Oqfh28ohmSbk+ba7j0EKlvc8Ru8U
         Yv7nR4v0ZmADyVqcupE8nJbF4vbKRUTF9aU45EWcRpmf+SO31tfAn2u+cz52XJRVSKhS
         HLpZLRg3lWorFXxF0G1q+oe7iCj0VTcUAZie4ktDt8tWF+gR7MG3zShO2QR1jFT/TBIH
         2gQ1a8EeNE8+qFsurbuD0fBa/ZJEbsss0EPlX+BGjka3ubbzfznADt4eA9INM6fDPFB+
         iTLg==
X-Gm-Message-State: APzg51CQr7U0utFFWE9lW986dNklOzC4YC+o2JjFKzPoJUzqeR0xG+4K
        /2RLtLEHJQf4Ie4yXaoob7NvLCCEZ9scZF+q+Uyn/g==
X-Google-Smtp-Source: ANB0Vdb+IqpnKFrstYmRQvi8IztgfL5/7LzJMwXisqnL6Ko/u0hWHbF84z2yBlm3eihZzD6k6eDYq5zVoDJ2iVSEaz0=
X-Received: by 2002:ab0:1532:: with SMTP id o47-v6mr8782437uae.162.1535709756545;
 Fri, 31 Aug 2018 03:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545414-550-5-git-send-email-hans.ml.holmberg@owltronix.com>
 <92a2b562-c485-47ff-7aa9-5aa82b992e40@lightnvm.io> <CANr-nt1yygevsNUELoaN6tC1N+emiuz+QtqmynKha18_AZP2Rg@mail.gmail.com>
In-Reply-To: <CANr-nt1yygevsNUELoaN6tC1N+emiuz+QtqmynKha18_AZP2Rg@mail.gmail.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Fri, 31 Aug 2018 12:02:25 +0200
Message-ID: <CANr-nt17oGKs9WtSQktQ0YTimFCV-4Afsmb7qw4Ynrj2QD6KpA@mail.gmail.com>
Subject: Re: [PATCH 4/7] lightnvm: pblk: move global caches to module init/exit
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

Just sent a new patch ("lightnvm: pblk: stop recreating global
caches") which does reference counting.
On Wed, Aug 29, 2018 at 5:06 PM Hans Holmberg
<hans.ml.holmberg@owltronix.com> wrote:
>
> On Wed, Aug 29, 2018 at 3:29 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wro=
te:
> >
> > On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> > > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > >
> > > Pblk's global caches should not be initialized every time
> > > a pblk instance is created, so move the creation and destruction
> > > of the caches to module init/exit.
> > >
> > > Also remove the global pblk lock as it is no longer needed after
> > > the move.
> > >
> >
> > The original goal was to not allocate memory for the caches unless a
> > pblk instance was initialized. This instead uses up memory without pblk
> > being used, which I don't think is a good idea.
>
> You're right, i'll rework the patch with reference counting of pblk insta=
nces.
> The global caches only need to exist when there is at least one pblk inst=
ance.
>
> Thanks,
> Hans
>
> >
> > > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > > ---
> > >   drivers/lightnvm/pblk-init.c | 42 ++++++++++++++++++++-------------=
---------
> > >   1 file changed, 20 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-ini=
t.c
> > > index 76a4a271b9cf..0be64220b5d8 100644
> > > --- a/drivers/lightnvm/pblk-init.c
> > > +++ b/drivers/lightnvm/pblk-init.c
> > > @@ -27,7 +27,6 @@ MODULE_PARM_DESC(write_buffer_size, "number of entr=
ies in a write buffer");
> > >
> > >   static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_r=
q_cache,
> > >                               *pblk_w_rq_cache;
> > > -static DECLARE_RWSEM(pblk_lock);
> > >   struct bio_set pblk_bio_set;
> > >
> > >   static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> > > @@ -306,21 +305,17 @@ static int pblk_set_addrf(struct pblk *pblk)
> > >       return 0;
> > >   }
> > >
> > > -static int pblk_init_global_caches(struct pblk *pblk)
> > > +static int pblk_init_global_caches(void)
> > >   {
> > > -     down_write(&pblk_lock);
> > >       pblk_ws_cache =3D kmem_cache_create("pblk_blk_ws",
> > >                               sizeof(struct pblk_line_ws), 0, 0, NULL=
);
> > > -     if (!pblk_ws_cache) {
> > > -             up_write(&pblk_lock);
> > > +     if (!pblk_ws_cache)
> > >               return -ENOMEM;
> > > -     }
> > >
> > >       pblk_rec_cache =3D kmem_cache_create("pblk_rec",
> > >                               sizeof(struct pblk_rec_ctx), 0, 0, NULL=
);
> > >       if (!pblk_rec_cache) {
> > >               kmem_cache_destroy(pblk_ws_cache);
> > > -             up_write(&pblk_lock);
> > >               return -ENOMEM;
> > >       }
> > >
> > > @@ -329,7 +324,6 @@ static int pblk_init_global_caches(struct pblk *p=
blk)
> > >       if (!pblk_g_rq_cache) {
> > >               kmem_cache_destroy(pblk_ws_cache);
> > >               kmem_cache_destroy(pblk_rec_cache);
> > > -             up_write(&pblk_lock);
> > >               return -ENOMEM;
> > >       }
> > >
> > > @@ -339,15 +333,13 @@ static int pblk_init_global_caches(struct pblk =
*pblk)
> > >               kmem_cache_destroy(pblk_ws_cache);
> > >               kmem_cache_destroy(pblk_rec_cache);
> > >               kmem_cache_destroy(pblk_g_rq_cache);
> > > -             up_write(&pblk_lock);
> > >               return -ENOMEM;
> > >       }
> > > -     up_write(&pblk_lock);
> > >
> > >       return 0;
> > >   }
> > >
> > > -static void pblk_free_global_caches(struct pblk *pblk)
> > > +static void pblk_free_global_caches(void)
> > >   {
> > >       kmem_cache_destroy(pblk_ws_cache);
> > >       kmem_cache_destroy(pblk_rec_cache);
> > > @@ -381,13 +373,10 @@ static int pblk_core_init(struct pblk *pblk)
> > >       if (!pblk->pad_dist)
> > >               return -ENOMEM;
> > >
> > > -     if (pblk_init_global_caches(pblk))
> > > -             goto fail_free_pad_dist;
> > > -
> > >       /* Internal bios can be at most the sectors signaled by the dev=
ice. */
> > >       ret =3D mempool_init_page_pool(&pblk->page_bio_pool, NVM_MAX_VL=
BA, 0);
> > >       if (ret)
> > > -             goto free_global_caches;
> > > +             goto free_pad_dist;
> > >
> > >       ret =3D mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_=
POOL_SIZE,
> > >                                    pblk_ws_cache);
> > > @@ -455,9 +444,7 @@ static int pblk_core_init(struct pblk *pblk)
> > >       mempool_exit(&pblk->gen_ws_pool);
> > >   free_page_bio_pool:
> > >       mempool_exit(&pblk->page_bio_pool);
> > > -free_global_caches:
> > > -     pblk_free_global_caches(pblk);
> > > -fail_free_pad_dist:
> > > +free_pad_dist:
> > >       kfree(pblk->pad_dist);
> > >       return -ENOMEM;
> > >   }
> > > @@ -480,7 +467,6 @@ static void pblk_core_free(struct pblk *pblk)
> > >       mempool_exit(&pblk->e_rq_pool);
> > >       mempool_exit(&pblk->w_rq_pool);
> > >
> > > -     pblk_free_global_caches(pblk);
> > >       kfree(pblk->pad_dist);
> > >   }
> > >
> > > @@ -1067,7 +1053,6 @@ static void pblk_exit(void *private, bool grace=
ful)
> > >   {
> > >       struct pblk *pblk =3D private;
> > >
> > > -     down_write(&pblk_lock);
> > >       pblk_gc_exit(pblk, graceful);
> > >       pblk_tear_down(pblk, graceful);
> > >
> > > @@ -1076,7 +1061,6 @@ static void pblk_exit(void *private, bool grace=
ful)
> > >   #endif
> > >
> > >       pblk_free(pblk);
> > > -     up_write(&pblk_lock);
> > >   }
> > >
> > >   static sector_t pblk_capacity(void *private)
> > > @@ -1237,9 +1221,22 @@ static int __init pblk_module_init(void)
> > >       ret =3D bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
> > >       if (ret)
> > >               return ret;
> > > +
> > >       ret =3D nvm_register_tgt_type(&tt_pblk);
> > >       if (ret)
> > > -             bioset_exit(&pblk_bio_set);
> > > +             goto fail_exit_bioset;
> > > +
> > > +     ret =3D pblk_init_global_caches();
> > > +     if (ret)
> > > +             goto fail_unregister_tgt_type;
> > > +
> > > +     return 0;
> > > +
> > > +fail_unregister_tgt_type:
> > > +     nvm_unregister_tgt_type(&tt_pblk);
> > > +fail_exit_bioset:
> > > +     bioset_exit(&pblk_bio_set);
> > > +
> > >       return ret;
> > >   }
> > >
> > > @@ -1247,6 +1244,7 @@ static void pblk_module_exit(void)
> > >   {
> > >       bioset_exit(&pblk_bio_set);
> > >       nvm_unregister_tgt_type(&tt_pblk);
> > > +     pblk_free_global_caches();
> > >   }
> > >
> > >   module_init(pblk_module_init);
> > >
> >
