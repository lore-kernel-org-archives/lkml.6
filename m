Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8217D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tU3iBHQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeLQWCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:02:11 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33447 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:02:09 -0500
Received: by mail-yb1-f195.google.com with SMTP id c67so5721034ybf.0;
        Mon, 17 Dec 2018 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZqpNEpuI8vbIc9YMk/n8mRpLnpM5M4LUAnws93ADdA=;
        b=tU3iBHQxVnVH9jQl6dnTm6JjHwULQUiQl3RZFXwiu9PvwxwMtL6z0Fm5ET736l4F8p
         6jD1F9KKg3nern0rVZod9kD5Ft3Yu7JxDq8MWnXIYx/QMTH6OS/J+C1bYesfWFFteByk
         jpbtv7XRzmBo1IrDu7jMF83FK1ssJX49pb1Lv8Z19sROQEMeR8oCP+yQDrWXHwG5asde
         DNkMk7S+DhetYdUUSvVFTX6sAX04+S7xz9uNoDkICZui7b6cSnDq1ZnUmiei2Wi3W8eA
         BhWZP6Lza1UAFV7NO4XfjBWraELHVORVeKmc6p5up8MkjRvvJ4zynhKWaNIany6VKvuI
         y/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZqpNEpuI8vbIc9YMk/n8mRpLnpM5M4LUAnws93ADdA=;
        b=p0d7N2vk2KJNN3zr7548CawHhH63n+esSh40mxX3CmCmBjSeS74g3xbQROfK+fTMxj
         /lRaV+jX74paNldLFrklTLAx735dDcssa/BiOrdHwl1VokyDKHCYSxEf2R+A1S+bJCGG
         qRos1QV3/rKXm1d9dTl4hzVD++Mz67wkVZUoWJ4GSAbDIuzSif2XJFstZBALsnEglF1y
         T//fpA03s6cgFSJYcul2qUEtvgJhFqyoO0Fub05fJhaWrH89k2XtFOX4pmfYXInFbXfc
         RTkXqrZ8nAkMQlJxKb9mFHOFfXMIwhfnlEnHm1PZyGDUpw2tyyxFgPAz+bEgvVfSp86y
         vKzQ==
X-Gm-Message-State: AA+aEWZl5BAIEjeVAM67CyKwXZvrPkNv07hJ1aBITjhu4q26YScy2IHj
        qMk6XK/qVqc3cbIg6aHPvuu2WSPG5w2z8Veyvlw=
X-Google-Smtp-Source: AFSGD/UiZLCQFXZL8GKHo1Cbj/6jLuHaKVTLHoYsdouGGRJppYycKZuSnaVCZ4Zb3vPMD7sbiOe2FbQ9pqSUXAL+x3c=
X-Received: by 2002:a25:418d:: with SMTP id o135mr14625749yba.166.1545084128797;
 Mon, 17 Dec 2018 14:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20181217112546.4e400eb3@canb.auug.org.au> <CALzJLG_g3QcYLM+ZXwfpu5E71nUOrG=KA4X2uR-WGeYAOYcsLg@mail.gmail.com>
In-Reply-To: <CALzJLG_g3QcYLM+ZXwfpu5E71nUOrG=KA4X2uR-WGeYAOYcsLg@mail.gmail.com>
From:   Or Gerlitz <gerlitz.or@gmail.com>
Date:   Tue, 18 Dec 2018 00:01:57 +0200
Message-ID: <CAJ3xEMjvoNZLaCWk8KydUTKH-fmqnF1Vgbu42u0ame_s-Cj3UQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Saeed Mahameed <saeedm@dev.mellanox.co.il>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:29 PM Saeed Mahameed
<saeedm@dev.mellanox.co.il> wrote:
> On Sun, Dec 16, 2018 at 4:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > I fixed it up (see below) and can carry the fix as necessary. This

> Looks good to me.

here too


> > Today's linux-next merge of the net-next tree got a conflict in:
> >   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > between commit:

> >   154e62abe9cd ("net/mlx5e: Properly initialize flow attributes for slow path eswitch rule deletion")
> > from the net tree and commit:

> >   e88afe759a49 ("net/mlx5e: Err if asked to mirror a goto chain tc eswitch rule")
> >   e85e02bad29e ("net/mlx5: E-Switch, Rename esw attr mirror count field")
> > from the net-next tree.

Just a note,

e88afe759a49  ("net/mlx5e: Err if asked to mirror a goto chain tc
eswitch rule")i

s from net  and not net-next

see it here [1] among the top 10 patches

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/log/?qt=grep&q=mlx5
