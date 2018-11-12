Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C94C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FDB214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCZFuQEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FDB214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeKLTvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:51:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34893 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbeKLTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:51:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so7520810wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9fSKAzP9ruRBEA1MT9Z13pRnkDRt7j8j4EnmxP10Ums=;
        b=PCZFuQEnWqBGooqnIOMnX/hRrLxg2cS/5rByMG9iV8msjbZWdJqOweg452LQc/NV+n
         IDjltLKRCB3UVBn8nvUqb5TsYJ+U2sGuvj1BPAYLWwg1H/iZLkatkttOs5E+ukee07H4
         QMcdsTA6dgj2iuYNuC16+mA852flmhuC3Kf1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9fSKAzP9ruRBEA1MT9Z13pRnkDRt7j8j4EnmxP10Ums=;
        b=aZ4uP0k20cbouRVEyYXystBANxokP475sFeUGggWdbuwc40QeSwz91xIPHlc1YwoJo
         wv11iLKwg/XL22uMTxA9yXlx5y+3TyVgES6BhDuFz6+qvqya7a82XF4ui9+53XIV6UV9
         a//w/Y4nqbMbPy9VJZHsVANU893P4JNr8lM1jXj65qDEPIZHhgbqMF7/3Oj6ktBdoPz+
         PQHfm6t3z5MG7G1dHwhZT9RVDStCB6g9d18MvzuMfIFJHfKceYhTZTAu19eNqCQCr6ne
         vUcmpzOyVSzE1oHmaTGaJYL9kVMaulUbECncFVEhGssuOwmbLo4hKrNMf01PZe75+GO2
         htfw==
X-Gm-Message-State: AGRZ1gL3or8uRxle6M+eJpMMG50FwgE8csJ2qy1saOab69oP7mSeFlT2
        hGB81gvZ5lK2kkiTnYjQLhpOhA==
X-Google-Smtp-Source: AJdET5exIBdE8SylbVFXphKgfG329L/77XgrdfvXEV2V0gIdVy6hd3Xa4vIe69L+DVcvrpZvpbkOyg==
X-Received: by 2002:a1c:c10b:: with SMTP id r11mr940555wmf.84.1542016712631;
        Mon, 12 Nov 2018 01:58:32 -0800 (PST)
Received: from [192.168.43.112] ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id t129-v6sm12292695wmd.14.2018.11.12.01.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:58:32 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
Date:   Mon, 12 Nov 2018 10:58:29 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, lennart@poettering.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <A25880F5-BA4E-4BF3-8AD2-1AB528551FC0@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to CC Lennart, sorry.

> Il giorno 12 nov 2018, alle ore 10:56, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens, Tejun, all,
> about nine months ago, we agreed on a solution for unifying the
> interface of the proportional-share policy in blkio/io [1].  Angelo
> and I finally completed it.  Let me briefly recall the problem and the
> solution.
>=20
> The current implementation of cgroups doesn't allow two or more
> entities, e.g., I/O schedulers, to share the same files.  So, if CFQ
> creates its files for the proportional-share policy, such as, e.g,
> weight files for blkio/io groups, BFQ cannot attach somehow to them.
> Thus, to enable people to set group weights with BFQ, I resorted to
> making BFQ create its own version of these common files, by prepending
> a bfq prefix.
>=20
> Actually, no legacy code uses these different names, or is likely to
> do so.  Having these two sets of names is simply a source of
> confusion, as pointed out also, e.g., by Lennart Poettering (CCed
> here), and acknowledged by Tejun [2].
>=20
> In [1] we agreed on a solution that solves this problem, by actually
> making it possible to share cgroups files.  Both writing to and
> reading from a shared file trigger the appropriate operation for each
> of the entities that share the file.  In particular, in case of
> reading,
> - if all entities produce the same output, the this common output is
>  shown only once;
> - if the outputs differ, then every per-entity output is shown,
>  preceded by the name of the entity that produced that output.
>=20
> With this solution, legacy code that, e.g., sets group weights, just
> works, regardless of the I/O scheduler actually implementing
> proportional share.
>=20
> But note that this extension is not restricted to only blkio/io.  The
> general group interface now enables files to be shared among multiple
> entities of any kind.
>=20
> (I have also added a patch to fix some clerical errors in bfq doc,
> which I found while making the latter consistent with the new
> interface.)
>=20
> Thanks,
> Paolo
>=20
> [1] https://lkml.org/lkml/2018/1/4/667
> [2] https://github.com/systemd/systemd/issues/7057
>=20
> Angelo Ruocco (7):
>  kernfs: add function to find kernfs_node without increasing ref
>    counter
>  cgroup: link cftypes of the same subsystem with the same name
>  cgroup: add owner name to cftypes
>  block, bfq: align min and default weights with cfq
>  cgroup: make all functions of all cftypes be invoked
>  block, cfq: allow cgroup files to be shared
>  block, throttle: allow sharing cgroup statistic files
>=20
> Paolo Valente (5):
>  cgroup: add hook seq_show_cft with also the owning cftype as =
parameter
>  block, cgroup: pass cftype to functions that need to use it
>  block, bfq: use standard file names for the proportional-share policy
>  doc, bfq-iosched: fix a few clerical errors
>  doc, bfq-iosched: make it consistent with the new cgroup interface
>=20
> Documentation/block/bfq-iosched.txt |  31 +++--
> block/bfq-cgroup.c                  | 148 +++++++++++++-------
> block/bfq-iosched.h                 |   4 +-
> block/blk-cgroup.c                  |  22 +--
> block/blk-throttle.c                |  24 ++--
> block/cfq-iosched.c                 | 105 +++++++++++----
> fs/kernfs/dir.c                     |  13 ++
> include/linux/blk-cgroup.h          |  10 +-
> include/linux/cgroup-defs.h         |  14 +-
> include/linux/cgroup.h              |  13 ++
> include/linux/kernfs.h              |   7 +
> kernel/cgroup/cgroup.c              | 262 =
+++++++++++++++++++++++++++++-------
> 12 files changed, 483 insertions(+), 170 deletions(-)
>=20
> --
> 2.16.1

