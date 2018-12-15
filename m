Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BF1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D792080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnEXop1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeLON1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:27:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35884 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLON1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:27:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so7006637wrp.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0is6RZdTE95QKK/hhbwz5QJMg73ytv622kW2Ph/I3rE=;
        b=rnEXop1OFlhyEqoFRiO8y9xCQXpCx3ty4iJzbrEe7MjF9ywZsf+fpbYmlH0r5Q+6Xi
         QMbErt2tPk+puBH1vqpzqlnG4EKG9E+uzrJwsmeqV5SunP6aXyM77Pe9fanZLwQybQA2
         bEznsWCdeK2R3nkz9aW5xpn4SsCIomms+RxMzjfebzLQySYDIXROMjqNexlDbqIu9eXd
         JMdONZeaPqIiU7phRu0L4Eto/NeiVSn9soQXmHJ0ojiRistm2tjy0MfWDxCX4nzkBT+V
         S538OxSFnVVlEtOJ079j1tN1zqWDT/bkxTY+Uvy60beqwj/jUR0/bh0WbzcrJdzd2RMv
         Zhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0is6RZdTE95QKK/hhbwz5QJMg73ytv622kW2Ph/I3rE=;
        b=PTr3qVyoF6gBfSFJsW+1L6ybovWo5EfRvwFS/OfTIAx3CrjVStxzwNABA53DDV5lzC
         Mdubd6s1HIf5M/wyQFI9gcbNKrKu/rGVPI2vkJOzTOD5HGwwk+l1KiOcgogOsI4iOnng
         7S6ktfWpFZCRVh9C45y3lf5WTIJTye2ayS47t6PXsz/EuRqjWLL8zcKkwVxCvQWJRcpT
         ikfbuZ36K8GDDpj1svjYWEqCaCGwQE4p6tJRVfOPmSNVwkjCTKdNKJrtvTCNshFADToS
         367pzuNu1+PzjXDdyQubSlUQI4A9F2geleKhibo8ypJv9Y0EJLpV3XfRAxZPtBZSMekB
         4q9Q==
X-Gm-Message-State: AA+aEWYXpuxRSiZKZdXmg57X7QzsO75f6ZwAvHfXZfnEOPplLI8Akq+1
        A2GYubMz6J43jpZmieNr17TOhAK1kxIViRqtoamx7g==
X-Google-Smtp-Source: AFSGD/VSLfWR9yqjxswcSZUluJ7dy5OU7owZbFjIdLiTD3VELmrikzZ4DoeamKmvWb/GxycXketTl0OU9X9uhuupew4=
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr5963304wrx.149.1544880464806;
 Sat, 15 Dec 2018 05:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20181209062133.106781-1-houtao1@huawei.com> <ae0156e3-82f7-1ae1-c8dc-2ccf4648fc57@huawei.com>
In-Reply-To: <ae0156e3-82f7-1ae1-c8dc-2ccf4648fc57@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 15 Dec 2018 14:27:33 +0100
Message-ID: <CAFLxGvyR+WNfYPn8Yj_i-1mtvwde4zwiS9he1M8iczEFhZZhjA@mail.gmail.com>
Subject: Re: [PATCH] jffs2: make the overwritten xattr invisible after remount
To:     houtao1@huawei.com
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 2:23 PM Hou Tao <houtao1@huawei.com> wrote:
>
> ping ?

Sorry for the delay.
I'll try now to review all the pending jffs2 patches.

> On 2018/12/9 14:21, Hou Tao wrote:
> > For xattr modification, we do not write a new jffs2_raw_xref with
> > delete marker into flash, so if a xattr is modified then removed,
> > and the old xref & xdatum are not erased by GC, after reboot or
> > remount, the new xattr xref will be dead but the old xattr xref
> > will be alive, and we will get the overwritten xattr instead of
> > non-existent error when reading the removed xattr.
> >
> > Fix it by writing the deletion mark for xattr overwrite.
> >
> > Fixes: 8a13695cbe4e ("[JFFS2][XATTR] rid unnecessary writing of delete marker.")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  fs/jffs2/xattr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 49 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> > index da3e18503c65..b2d6072f34af 100644
> > --- a/fs/jffs2/xattr.c
> > +++ b/fs/jffs2/xattr.c
> > @@ -573,6 +573,15 @@ static struct jffs2_xattr_ref *create_xattr_ref(struct jffs2_sb_info *c, struct
> >       return ref; /* success */
> >  }
> >
> > +static void move_xattr_ref_to_dead_list(struct jffs2_sb_info *c,
> > +             struct jffs2_xattr_ref *ref)
> > +{
> > +     spin_lock(&c->erase_completion_lock);
> > +     ref->next = c->xref_dead_list;
> > +     c->xref_dead_list = ref;
> > +     spin_unlock(&c->erase_completion_lock);
> > +}
> > +
> >  static void delete_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
> >  {
> >       /* must be called under down_write(xattr_sem) */
> > @@ -582,10 +591,7 @@ static void delete_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *re
> >       ref->xseqno |= XREF_DELETE_MARKER;
> >       ref->ino = ref->ic->ino;
> >       ref->xid = ref->xd->xid;
> > -     spin_lock(&c->erase_completion_lock);
> > -     ref->next = c->xref_dead_list;
> > -     c->xref_dead_list = ref;
> > -     spin_unlock(&c->erase_completion_lock);
> > +     move_xattr_ref_to_dead_list(c, ref);
> >
> >       dbg_xattr("xref(ino=%u, xid=%u, xseqno=%u) was removed.\n",
> >                 ref->ino, ref->xid, ref->xseqno);
> > @@ -1090,6 +1096,40 @@ int do_jffs2_getxattr(struct inode *inode, int xprefix, const char *xname,
> >       return rc;
> >  }
> >
> > +static void do_jffs2_delete_xattr_ref(struct jffs2_sb_info *c,
> > +             struct jffs2_xattr_ref *ref)
> > +{
> > +     uint32_t request, length;
> > +     int err;
> > +     struct jffs2_xattr_datum *xd;
> > +
> > +     request = PAD(sizeof(struct jffs2_raw_xref));
> > +     err = jffs2_reserve_space(c, request, &length,
> > +                     ALLOC_NORMAL, JFFS2_SUMMARY_XREF_SIZE);
> > +     down_write(&c->xattr_sem);
> > +     if (err) {
> > +             JFFS2_WARNING("jffs2_reserve_space()=%d, request=%u\n",
> > +                             err, request);
> > +             delete_xattr_ref(c, ref);
> > +             up_write(&c->xattr_sem);
> > +             return;
> > +     }
> > +
> > +     xd = ref->xd;
> > +     ref->ino = ref->ic->ino;
> > +     ref->xid = xd->xid;
> > +     ref->xseqno |= XREF_DELETE_MARKER;
> > +     save_xattr_ref(c, ref);
> > +
> > +     move_xattr_ref_to_dead_list(c, ref);
> > +     dbg_xattr("xref(ino=%u, xid=%u, xseqno=%u) was removed.\n",
> > +               ref->ino, ref->xid, ref->xseqno);
> > +     unrefer_xattr_datum(c, xd);
> > +
> > +     up_write(&c->xattr_sem);
> > +     jffs2_complete_reservation(c);
> > +}
> > +
> >  int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
> >                     const char *buffer, size_t size, int flags)
> >  {
> > @@ -1097,7 +1137,7 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
> >       struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
> >       struct jffs2_inode_cache *ic = f->inocache;
> >       struct jffs2_xattr_datum *xd;
> > -     struct jffs2_xattr_ref *ref, *newref, **pref;
> > +     struct jffs2_xattr_ref *ref, *newref, *oldref, **pref;
> >       uint32_t length, request;
> >       int rc;
> >
> > @@ -1113,6 +1153,7 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
> >               return rc;
> >       }
> >
> > +     oldref = NULL;
> >       /* Find existing xattr */
> >       down_write(&c->xattr_sem);
> >   retry:
> > @@ -1196,11 +1237,13 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
> >               rc = PTR_ERR(newref);
> >               unrefer_xattr_datum(c, xd);
> >       } else if (ref) {
> > -             delete_xattr_ref(c, ref);
> > +             oldref = ref;
> >       }
> >   out:
> >       up_write(&c->xattr_sem);
> >       jffs2_complete_reservation(c);
> > +     if (oldref)
> > +             do_jffs2_delete_xattr_ref(c, oldref);
> >       return rc;
> >  }
> >
> >
>


-- 
Thanks,
//richard
