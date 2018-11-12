Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A31C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CFA223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+IDfX7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CFA223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeKLUKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:10:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50950 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbeKLUKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:10:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id 124-v6so7926998wmw.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RaepbgZnLCmJbEVH8ufwwquGnCkm1W1fCpZdWbk4T1Q=;
        b=j+IDfX7eU2SyX3qILnn7UYCIX9lOv9nnKsToUXAPC0QB/8x+U5pXzyU7r8gwpQRvq4
         7yNXaYTLt/zmPNtHfsloaVcx9bqbH/gvfIp9jyLncH8GjiI5VJ2u+95lvxBxDCeQ7sCu
         CPZufcU5llbz/GrPFtow1DE1D14veulhqkE9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RaepbgZnLCmJbEVH8ufwwquGnCkm1W1fCpZdWbk4T1Q=;
        b=YmAXXRg58qsK4bU47jkmWpR+N0nTAR3vpyhcjwPp7Q3HUv4RsqIUT6U+LDi85E3nwy
         95YtNWXwaVI2F72Rb1xlrz2CmKWRuokH7V1cKwjJZP0zUjN48R6VEgFylzQ4DwSKPHP9
         k2lz4Y0vQ1OawS2FBh1fTSxfu/QA7Sl8BHor/0gGWT8fY+wWExyiRFtyZ9+jPituPQJD
         pwg09Bd93wKV7mqsOsMm6FcYSbEHj+1mfspvgMjpEh/pOl2rxsnBegDETIN4k5Qb9xpa
         OwA/52j0EqraYb2mGXa5qyUwhSVRWYe0xdO6rDoX90tDjwoSdyEucu5hy1ERDCBPTSMj
         EpZA==
X-Gm-Message-State: AGRZ1gJ5IpEi7NdAO1zvwi6Z0yDHOZTkhluX8JPd7Ir7WF309ZI++NK6
        4n72kyLPTf3dRxcIj0lBT8Csnw==
X-Google-Smtp-Source: AJdET5c2i+0KsI8VNo68XqPz1Jw2z8mM2uA9O2N+dmwX6R+IVIOkkbehr4XbYflRLzzkJjAqurKM4w==
X-Received: by 2002:a1c:ae0a:: with SMTP id x10-v6mr7445388wme.137.1542017845774;
        Mon, 12 Nov 2018 02:17:25 -0800 (PST)
Received: from [192.168.43.112] ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id q12sm1086490wmf.2.2018.11.12.02.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 02:17:25 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <9e8adb3271680165d85994a225713391@natalenko.name>
Date:   Mon, 12 Nov 2018 11:17:22 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        lennart@poettering.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 12 nov 2018, alle ore 11:00, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> On 12.11.2018 10:56, Paolo Valente wrote:
>> Hi Jens, Tejun, all,
>> about nine months ago, we agreed on a solution for unifying the
>> interface of the proportional-share policy in blkio/io [1].  Angelo
>> and I finally completed it.  Let me briefly recall the problem and =
the
>> solution.
>> The current implementation of cgroups doesn't allow two or more
>> entities, e.g., I/O schedulers, to share the same files.  So, if CFQ
>> creates its files for the proportional-share policy, such as, e.g,
>> weight files for blkio/io groups, BFQ cannot attach somehow to them.
>> Thus, to enable people to set group weights with BFQ, I resorted to
>> making BFQ create its own version of these common files, by =
prepending
>> a bfq prefix.
>> Actually, no legacy code uses these different names, or is likely to
>> do so.  Having these two sets of names is simply a source of
>> confusion, as pointed out also, e.g., by Lennart Poettering (CCed
>> here), and acknowledged by Tejun [2].
>> In [1] we agreed on a solution that solves this problem, by actually
>> making it possible to share cgroups files.  Both writing to and
>> reading from a shared file trigger the appropriate operation for each
>> of the entities that share the file.  In particular, in case of
>> reading,
>> - if all entities produce the same output, the this common output is
>>  shown only once;
>> - if the outputs differ, then every per-entity output is shown,
>>  preceded by the name of the entity that produced that output.
>> With this solution, legacy code that, e.g., sets group weights, just
>> works, regardless of the I/O scheduler actually implementing
>> proportional share.
>> But note that this extension is not restricted to only blkio/io.  The
>> general group interface now enables files to be shared among multiple
>> entities of any kind.
>> (I have also added a patch to fix some clerical errors in bfq doc,
>> which I found while making the latter consistent with the new
>> interface.)
>> Thanks,
>> Paolo
>> [1] https://lkml.org/lkml/2018/1/4/667
>> [2] https://github.com/systemd/systemd/issues/7057
>> Angelo Ruocco (7):
>>  kernfs: add function to find kernfs_node without increasing ref
>>    counter
>>  cgroup: link cftypes of the same subsystem with the same name
>>  cgroup: add owner name to cftypes
>>  block, bfq: align min and default weights with cfq
>>  cgroup: make all functions of all cftypes be invoked
>>  block, cfq: allow cgroup files to be shared
>>  block, throttle: allow sharing cgroup statistic files
>> Paolo Valente (5):
>>  cgroup: add hook seq_show_cft with also the owning cftype as =
parameter
>>  block, cgroup: pass cftype to functions that need to use it
>>  block, bfq: use standard file names for the proportional-share =
policy
>>  doc, bfq-iosched: fix a few clerical errors
>>  doc, bfq-iosched: make it consistent with the new cgroup interface
>> Documentation/block/bfq-iosched.txt |  31 +++--
>> block/bfq-cgroup.c                  | 148 +++++++++++++-------
>> block/bfq-iosched.h                 |   4 +-
>> block/blk-cgroup.c                  |  22 +--
>> block/blk-throttle.c                |  24 ++--
>> block/cfq-iosched.c                 | 105 +++++++++++----
>> fs/kernfs/dir.c                     |  13 ++
>> include/linux/blk-cgroup.h          |  10 +-
>> include/linux/cgroup-defs.h         |  14 +-
>> include/linux/cgroup.h              |  13 ++
>> include/linux/kernfs.h              |   7 +
>> kernel/cgroup/cgroup.c              | 262 =
+++++++++++++++++++++++++++++-------
>> 12 files changed, 483 insertions(+), 170 deletions(-)
>> --
>> 2.16.1
>=20
> I thought all the legacy stuff including CFS et al. is going to be =
removed in v4.21 completely=E2=80=A6
>=20

Thanks for pointing this out.

People with a lower kernel version than the future 4.21 just cannot
and will not be able to use the proportional share policy on blk-mq
(with legacy code), because of the name issue highlighted in this
email.  If this patch series gets accepted, a backport will solve the
problem.  In this respect, such a backport might even happen
'automatically', as most bfq commit seem to get backported to older,
stable kernels.

In addition, this extension
- extends the whole cgroups interface, in a seamless and
  backward-compatible way, to prevent future issues like these;
- solves a similar issue with throttle (which AFAIK won't go away
  with 4.21).

Thanks,
Paolo

> --=20
>  Oleksandr Natalenko (post-factum)

