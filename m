Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941F5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286FC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2avWeIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286FC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJPOaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:30:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33743 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeJPOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:30:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so24031802wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vya5/59rJPCibuVnexig501tmX1ODUQtYAJNIzOjyJ0=;
        b=N2avWeISQ9j6h6IkjExu0onmm21vvFRRGqhGv1c1AaE68UE1VqOSZ6sBV49VORmwgl
         7pMeu6SJ3W1MJhcR9Ur79TfzywkpIdjynxcuRoYgtjn0tCECKXZYR2Z+LWW8r6ew8fB1
         o5UBKqmhj7UnO1nief01/TyM1dDYDhH9IdPW5+l9a38NvaFWM72SXr1JfqSBlF92CN91
         S+PvWTybYOLM5itiYOWFtGMA6ZKix9/Fu+r1CKXPOOm7rD70ce54qAS3gwIs9PoxTj24
         JgQeOgSOvQ/TqKR/usUqLz27ZCi9f30HFozky7VOwA3nOxY4jw/NW+fr2gN2s3VXsQj3
         NG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vya5/59rJPCibuVnexig501tmX1ODUQtYAJNIzOjyJ0=;
        b=JhBgoXHTq7mmF9Isj9PqFOD8ClXIowTn+PVTMvoc6A6G4CVFlZ8v3P6B57afenbbYB
         guX+lpRy+yu+0Zd+LRFTjiFxqt+2W8nM0j/XhMu6F1QG6OkszoTFu1X1RvceQVqJJJDw
         Oh/kimnHhpZvZQfwnEeSbd7B0mVnemo15MNPLifSqhjjfJqsiGePsP4iA3+0loRmmJA7
         HBExpqZfwisfeXqxCW1/mFaEwuVddJmM+DdF44lGysIyi5APTjHCb05Gw36Yw9rYcwVs
         bLSUm+bOqMOWJb15v2zb9gKBEaswnnhmrumQsTFmzjZTB/kukAl7hEm/WduTmCPJjoWx
         b6Ug==
X-Gm-Message-State: ABuFfoiQpMnlIfj/7m+/3AxHXNMQ1UMiEAA1MmeYRzHOL/WOZPlgIEue
        RLOrmY7cL2AjUJ3EHqF6+KatX+ejElwNuoDSGjk=
X-Google-Smtp-Source: ACcGV604hxPeBPvrGHHMMmzC/FLxZh2IDSXH1p71Y9HF3H7AdFU8UIh52e6XXqmsGedEOqmSckgG+xahjqE6F2fuJLg=
X-Received: by 2002:adf:dd83:: with SMTP id x3-v6mr16944122wrl.212.1539672073945;
 Mon, 15 Oct 2018 23:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181006090935.41714-1-houtao1@huawei.com> <6401cb90-a1fe-afd5-c302-ddae40876736@huawei.com>
In-Reply-To: <6401cb90-a1fe-afd5-c302-ddae40876736@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 16 Oct 2018 08:41:02 +0200
Message-ID: <CAFLxGvw+=gfrm3SH4Hu9bt0sa6s+X=3cCjkDLvWusqhHH10yEQ@mail.gmail.com>
Subject: Re: [PATCH] jffs2: free jffs2_sb_info through jffs2_kill_sb()
To:     houtao1@huawei.com
Cc:     "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, stable@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 7:53 AM Hou Tao <houtao1@huawei.com> wrote:
>
> ping ?
>
> On 2018/10/6 17:09, Hou Tao wrote:
> > When an invalid mount option is passed to jffs2, jffs2_parse_options()
> > will fail and jffs2_sb_info will be freed, but then jffs2_sb_info will
> > be used (use-after-free) and freeed (double-free) in jffs2_kill_sb().
> >
> > Fix it by removing the buggy invocation of kfree() when getting invalid
> > mount options.
> >
> > Cc: stable@kernel.org
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  fs/jffs2/super.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> > index 87bdf0f4cba1..902a7dd10e5c 100644
> > --- a/fs/jffs2/super.c
> > +++ b/fs/jffs2/super.c
> > @@ -285,10 +285,8 @@ static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
> >       sb->s_fs_info = c;
> >
> >       ret = jffs2_parse_options(c, data);
> > -     if (ret) {
> > -             kfree(c);
> > +     if (ret)
> >               return -EINVAL;
> > -     }

Reviewed-by: Richard Weinberger <richard@nod.at>

We can carry this via the MTD tree.

-- 
Thanks,
//richard
