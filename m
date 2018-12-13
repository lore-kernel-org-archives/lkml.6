Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE2DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002D820811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYf6S2ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002D820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbeLMVxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:53:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46872 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMVxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:53:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so3495890wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 13:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V98FXn7UfqNg7tuJqtNf1bNRYMrfTFPMN328XT4aSm4=;
        b=AYf6S2ml5VIBD3Wqg03HsTOmdKsvwZ4n0Kv6oYajtWMhVhB5s41FDdbS24/7eJLMgE
         hZcFf51wLznQLORlPwodhF3VYqvlmruVuQLUZV7WSmQwcHbQ70JfxHv6k1BBeE2mhGa+
         i6KHxped6UGf2cW8fBQ9cEno2rvHgVS1m8QrNoryy6WHdFTYATev2zwPO2Gw1MT/bKcx
         KzyMcFx8/+X1o3GDghc0Sx4iOMveymdmMVHT9xJ7+VN2gnFHh6WAfyVnK371cb5AJe1Y
         Em2F0Z0zTVDwJXHO6uIbr48y6arTQlNpHDxZw2zLC7b+kLPt4DwG52VJ1VX44iGPs6R+
         oTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V98FXn7UfqNg7tuJqtNf1bNRYMrfTFPMN328XT4aSm4=;
        b=oxBLmxvFV0aElSsbAl5Qb5UPiCxU5gcR7Z2v7/wT2nbOnkbWCUUaICYZmZGtrb/hhX
         xxuGxI1tNwGFRZJ6wb9h+P4jNWFodSyokYsxYGO6GW4hVSGzzUK/fyZadVaEigcKhuCj
         oFpntUkPZTvNGGPRfm9dsovxw5l2VLfL+8+dSoRicY1ccd8/qIYsH6v1b26ARNJRozgQ
         CHqL5UveC0X2xd52Q5Zzsle+tMIogpcxwZNe5K4FZpxrjEk6lHwX/W+2qn/KeBZ8PZJS
         N71vgoR0Hv42MyZomLwTw+4KJFqW5Qxkxo3Bn9YWFMTpRLwwFTW5TvSd7tijFyDvOFfS
         YDvw==
X-Gm-Message-State: AA+aEWbsFGOvSc+NDm6hwPeaSqZSxafPqJJoRPNCgMF6vDXaZboL/AxX
        uCRY2Dr0Wb1x2eKzVFNHN7NCTDyFfIztlaYuE0dM87XR
X-Google-Smtp-Source: AFSGD/Xzw52RRZK+GO+tqpvnUsJ0yF3/4YyrVwEUWgXYEVbDEW4PSdVY8+hWDegpL6B/KcCCMTrbkjkPH2dpjbd0qi0=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr386764wru.291.1544737994196;
 Thu, 13 Dec 2018 13:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20181020110753.98407-1-houtao1@huawei.com> <20181209075256.43ca759f@bbrezillon>
In-Reply-To: <20181209075256.43ca759f@bbrezillon>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 13 Dec 2018 22:53:02 +0100
Message-ID: <CAFLxGvyfM4tKH8hVoWDuYcojcHOQABvvDKZd1Mwbc8TMC5R5Jw@mail.gmail.com>
Subject: Re: [PATCH] jffs2: fix invocations of dbg_xattr() for dead jffs2_xattr_ref
To:     boris.brezillon@bootlin.com
Cc:     houtao1@huawei.com, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 7:52 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Sat, 20 Oct 2018 19:07:53 +0800
> Hou Tao <houtao1@huawei.com> wrote:
>
> > When jffs2_xattr_ref is dead, xref->ic or xref->xd will be invalid
> > because these fields will be reused as xref->ino or xref->xid,
> > so access xref->ic->ino or xref->xd->xid will lead to Oops.
> >
> > Fix the problem by checking whether or not it is a dead xref.
> >
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  fs/jffs2/xattr.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> > index 3d40fe02b003..0c4c7891556d 100644
> > --- a/fs/jffs2/xattr.c
> > +++ b/fs/jffs2/xattr.c
> > @@ -550,7 +550,8 @@ static int save_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
> >       ref->xseqno = xseqno;
> >       jffs2_add_physical_node_ref(c, phys_ofs | REF_PRISTINE, PAD(sizeof(rr)), (void *)ref);
> >
> > -     dbg_xattr("success on saving xref (ino=%u, xid=%u)\n", ref->ic->ino, ref->xd->xid);
> > +     dbg_xattr("success on saving xref (ino=%u, xid=%u)\n",
> > +                     je32_to_cpu(rr.ino), je32_to_cpu(rr.xid));
>
> Nit: align the second line on the open parens (same applies to the
> other chunk).
>
> Sorry, I can't comment on the actual change. I'll let Richard look
> at it.
>
> >
> >       return 0;
> >  }
> > @@ -1329,7 +1330,11 @@ int jffs2_garbage_collect_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_
> >       rc = save_xattr_ref(c, ref);
> >       if (!rc)
> >               dbg_xattr("xref (ino=%u, xid=%u) GC'ed from %#08x to %08x\n",
> > -                       ref->ic->ino, ref->xd->xid, old_ofs, ref_offset(ref->node));
> > +                             is_xattr_ref_dead(ref) ?
> > +                                     ref->ino : ref->ic->ino,
> > +                             is_xattr_ref_dead(ref) ?
> > +                                     ref->xid : ref->xd->xid,
> > +                             old_ofs, ref_offset(ref->node));
> >   out:
> >       if (!rc)
> >               jffs2_mark_node_obsolete(c, raw);
>

Since is_xattr_ref_dead() is cheap, can you please add two macros.
Something like:
static inline uint32_t xattr_ref_ino(struct jffs2_xattr_ref *ref) {
 if (is_xattr_ref_dead(ref))
  return ref>ino;
 else
  return ref->ic->ino;
}

Same for xid.
-- 
Thanks,
//richard
