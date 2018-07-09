Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF4FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD76B20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0kNYip1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD76B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeGIMWn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:22:43 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43076 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932622AbeGIMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:22:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so35421169oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RKDsLkr1lXdEAg/nxLUnDIAm1H0MLE4fbfb6iNs7o0=;
        b=i0kNYip15MBAoXkbXj0hapDXMGZCKoumkeNttbNoKCCxRdGpKSBkjUX44yiHTIP4vT
         P7cNRazwXW57SS6f0en3KQlbTlL9cJn3P74MG5Zl7kBe/WIyDegmW+6K+0yr5Q1088Nx
         OHIeCSfd1Q43W0nNXPvvvzMlZcA8rPVyEScIAT/n6cb43zEwsawLN99nJrqIUUvA5lfw
         wSe6vx94F0y89FQPVj3U9EY+Fr+iQR4fLZ3j6U7AiQ9ALH9g4VgtM3wzatgREAOe5NrM
         GFoW67wTIsCrZNo5hSUcRWVxswSlciWTfnDdQbLRMFc6UTVHqCP5SBuAJl3t9pyeJMgZ
         hdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RKDsLkr1lXdEAg/nxLUnDIAm1H0MLE4fbfb6iNs7o0=;
        b=V+eONXJz39/6KiQ5ij+ESQal9sAlNiLMtHQWZ4JGm/64/km6x4GX8g83eQkue7qPYx
         VDgQvZwAgOFn7fBbh/9clNUckVTNsLw3gNc82P5Ykd11ASLEsfOgM1RqEqS/ceTDf3Tg
         pFFCUeCACVapfSYalE6l0RUjkFG50kbrDvt4aCrMzGhSKM/qC5suySerDfLYkkJG1SDz
         evnE5KjG192Nl5T7ajLFzCnNyHCP0m7yeJcCM7lbGS9X6I7jsM00wS92XPlE3yPR1Acz
         NZlmdZJ9kkljg9ubGujm269M0tThVJbEql2glX80lgBWShcdIVpn/lK7bz/veiUlqqQX
         UR1g==
X-Gm-Message-State: APt69E0JjoarYJT7RH192iqaHl9ydQ0EKQHqNLUQHvIef6EWMSJKIsAf
        XkoZrxD8EAlmGyskjem4vL+3SKot0fyoMQC++fq/og==
X-Google-Smtp-Source: AAOMgpfCE39HYaxkFGifyxnmrY5DjIkdsVdF34sd+YorYnVuyW0/7PY9DdyesJNkNH9dVJStnpmS+fGbUeKVfsm+A9c=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr20626595oiy.219.1531138961225;
 Mon, 09 Jul 2018 05:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180706204803.131152-1-jannh@google.com> <20180708065623.GK3014@mtr-leonro.mtl.com>
In-Reply-To: <20180708065623.GK3014@mtr-leonro.mtl.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 9 Jul 2018 14:22:14 +0200
Message-ID: <CAG48ez2nLELb0bvK_SkQZuLLReaohZbk9yjMnyC7AYHJdtEEnw@mail.gmail.com>
Subject: Re: [PATCH v2] IB/mlx5: fix uaccess beyond "count" in debugfs
 read/write handlers
To:     leon@kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 8:56 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 06, 2018 at 10:48:03PM +0200, Jann Horn wrote:
> > In general, accessing userspace memory beyond the length of the supplied
> > buffer in VFS read/write handlers can lead to both kernel memory corruption
> > (via kernel_read()/kernel_write(), which can e.g. be triggered via
> > sys_splice()) and privilege escalation inside userspace.
> >
> > In this case, the affected files are in debugfs (and should therefore only
> > be accessible to root), and the read handlers check that *pos is zero
> > (meaning that at least sys_splice() can't trigger kernel memory
> > corruption). Because of the root requirement, this is not a security fix,
> > but rather a cleanup.
> >
> > For the read handlers, fix it by using simple_read_from_buffer() instead of
> > custom logic. Add min() calls to the write handlers.
> >
> > changed in v2:
> >  - also fix write handlers
>
> No changelog in commit messages, please

I will try to do that better in the future. I never noticed that
changelogs go below the three dashes...

> > Fixes: 4a2da0b8c078 ("IB/mlx5: Add debug control parameters for congestion control")
> > Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  drivers/infiniband/hw/mlx5/cong.c |  9 +--------
> >  drivers/infiniband/hw/mlx5/mr.c   | 32 ++++++++-----------------------
> >  2 files changed, 9 insertions(+), 32 deletions(-)
> >
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
