Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAAEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF332075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNuN3GSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF332075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJaAgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:36:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45399 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeJaAgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:36:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so13954460qtj.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OeZIwayCWQ6XYEBnHlqoCfxNVrtXG8gOPPDqAGaAy5c=;
        b=GNuN3GSVx8RiUoZJxCRI7Ziyfe/hPxcEinp8xucTIIdvjDqk3BeivG5rxYn6099xzs
         pU8iEmmc9emOMEDfzCZuLmJEL8p9XU/ABZ5opfJbE1mUf95e5v6Rhf9/Dp5Qf5HAliKi
         /ddNCDHw84mfdGSb866PlgjNMTw0wanfwEEZA+5fE7qm3qq6rUPcsNa5zWeQUXFVVRRV
         SKz8LB90WzsA6KAQf/382JALC7XFyAxfreoXHZ8t1fgVIfSqsrd57Pkp4N8rttwQqoWQ
         HPDekbXWFwQcK6Y+f1Z9+VP6vFMVzYHi+wrL7M9VbSMm6+015b48CKeSZ/aPT4PE82hH
         O8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OeZIwayCWQ6XYEBnHlqoCfxNVrtXG8gOPPDqAGaAy5c=;
        b=pYR1plMPDnsarJI5LsL5UKLMFpI/4drdU/lI9epRjqcd3XLI+HdjGuRhAaJh7JzafC
         geZxNI1wywzepH4xf9Y36R/zRgNxfeScfQTomgjQeuUahrs704jOMVufMBotYI29YZzW
         dxygRb8/rbdpyVCk+OVXvZIqinsBok2h9EPOeo6CJQHnUIi/oxncfeBabnl3eMHdRYfk
         4n54tesjU5wHj2RvBeTg1yGVLeQUFRoghOGUs5sJlbd1OhwGdmNdoQDkh2Yme5VBUPkv
         czXAmWCApHyzdTgXo7FHa7S+Q/zhuid8MAYB9JpKBOB9E8/V1m5ow2+0gCwhwHOSI4Sg
         GNRA==
X-Gm-Message-State: AGRZ1gIpOV2hMViQzH4YWzhx2j9hCCKxdlRluVMPyQVxtI6RQmB8WHKh
        qXQxxN8NzERRt7/8p12uetjSE7dLkwtrvb3e2pg=
X-Google-Smtp-Source: AJdET5ePej7ubH9DVsqDFWE9zrZhNmBo4aeW2CYSQ0OXaaIVqTIdnUZYDxLIq1eTN1wZ2NYZFRoMPAUOvvHeIlMicnY=
X-Received: by 2002:ac8:2c49:: with SMTP id e9-v6mr2743202qta.17.1540914153111;
 Tue, 30 Oct 2018 08:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181030144530.89995-1-smuchun@gmail.com> <201810302302.5Bvf0Uf8%fengguang.wu@intel.com>
In-Reply-To: <201810302302.5Bvf0Uf8%fengguang.wu@intel.com>
From:   =?UTF-8?B?5a6L54mn5pil?= <smuchun@gmail.com>
Date:   Tue, 30 Oct 2018 23:42:22 +0800
Message-ID: <CAPSr9jGMw7WsgV86QetPq_hYsOLZ0cP1tvQz6Uta5wEHezfRgg@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Remove unnecessary CONFIG_RT_GROUP_SCHED in rt_se_prio()
To:     lkp@intel.com
Cc:     kbuild-all@01.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sorry that I did not consider CONFIG_SMP is also not configured.
In this case, 'struct rt_rq' has no member named 'highest_prio'. So, I
I understand why the code here needs CONFIG_RT_GROUP_SCHED.
When CONFIG_SMP or CONFIG_RT_GROUP_SCHED is configured,
'struct rt_rq' will have member named 'highest_prio'.

So, this patch does't make sense.


kbuild test robot <lkp@intel.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Muchun,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on v4.19 next-20181030]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Muchun-Song/sched-rt-Rem=
ove-unnecessary-CONFIG_RT_GROUP_SCHED-in-rt_se_prio/20181030-225925
> config: i386-randconfig-x002-201843 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386
>
> All errors (new ones prefixed by >>):
>
>    kernel/sched/rt.c: In function 'rt_se_prio':
> >> kernel/sched/rt.c:900:15: error: 'struct rt_rq' has no member named 'h=
ighest_prio'
>       return rt_rq->highest_prio.curr;
>                   ^~
>
> vim +900 kernel/sched/rt.c
>
> ac086bc2 kernel/sched_rt.c Peter Zijlstra  2008-04-19  894
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  895  static inline=
 int rt_se_prio(struct sched_rt_entity *rt_se)
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  896  {
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  897      struct rt=
_rq *rt_rq =3D group_rt_rq(rt_se);
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  898
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  899      if (rt_rq=
)
> e864c499 kernel/sched_rt.c Gregory Haskins 2008-12-29 @900              r=
eturn rt_rq->highest_prio.curr;
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  901
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  902      return rt=
_task_of(rt_se)->prio;
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  903  }
> 6f505b16 kernel/sched_rt.c Peter Zijlstra  2008-01-25  904
>
> :::::: The code at line 900 was first introduced by commit
> :::::: e864c499d9e57805ae1f9e7ea404dd223759cd53 sched: track the next-hig=
hest priority on each runqueue
>
> :::::: TO: Gregory Haskins <ghaskins@novell.com>
> :::::: CC: Gregory Haskins <ghaskins@novell.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
