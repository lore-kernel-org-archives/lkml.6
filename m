Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10DAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E26720855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXzYQenE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E26720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeGCK53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:57:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46438 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeGCK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:57:27 -0400
Received: by mail-lf0-f68.google.com with SMTP id l16-v6so1235286lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSCaFAHLehS/ms3KFvzsmh+Y+qPusddtC4+qob4UH2s=;
        b=iXzYQenEVE3y1OnbafOENT+3FqqyNqijUiO/VlG3jViRziJG4Gct1p8DZtusWuErBu
         8WZNJ7j4NXDRyjinkbavuvGt1/BNpzdLt3HsJY94Ecv9dXP8MCXwZVz/nEMDaSZ8amYY
         Wbm9joyfm3LuumLN5qWqQEqXRD2XBultn7PmQ9wZ8Y19P9018PN5yfp1EYEWzClAqBCU
         MJzSmZf9eoT/mv/Up5Y+qHTAjYq6fuN3mD6UWhRg3pK5uyZe2PjbcK+JZ7Kr7FYkNaFa
         QJXTIRWKhoFCCRvvshcDQb7tNA0RjvQ6mZClQ19GesgT8PTMDucHIkqAaGNaR8CmnuV0
         +7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSCaFAHLehS/ms3KFvzsmh+Y+qPusddtC4+qob4UH2s=;
        b=sySTC587FdoPujQJcIE3FOkkpcCyvf8LdCt8Rh00/P6ExQUrJDsbnDo19klRLGa3RI
         brlybpJGrS5ap1LySg2ygI0p+KXRAN6S9E2s9Q43qtoBn7iBizOFzXq52Kh5tpnPkVvX
         MXVvFAXox11vGqifnOvxy3GYlo90XOFr0qvidt6MecHtIYr29V93P0yUwASZGkEPZuxt
         i8DCsvKiBVcRyVib0LTDyWyTBkRkELg2wVaVetXmDc4973egiOI8Y9UsiaYPfRiHO4Ff
         Lf9o4DXmG0WPzqcikVzoOkpMfA9yfAQxCp+xgKkkFPCZNeQuoMYkHhC4541WN/HCtDcX
         iVcw==
X-Gm-Message-State: APt69E0afzhVYRbgVoCcMEfrI/CmdBzlMieRiiQfbC1+C11Gl0xsD0Dw
        wVzimFe3grNBfT/PGUdkbTpGDH/7qdE3aDtglzta8g==
X-Google-Smtp-Source: AAOMgpeEr+J00PBMxH0Cx2DQ9frB/61iXLGIoQABfKPPPpJs3VoJLbjToc5MmSOyH4+gtcpVYD7c+MRxMo1UOtWzJLs=
X-Received: by 2002:a19:fc3:: with SMTP id 64-v6mr20314237lfp.46.1530615445955;
 Tue, 03 Jul 2018 03:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com> <20180702101732.GD19043@dhcp22.suse.cz>
In-Reply-To: <20180702101732.GD19043@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Tue, 3 Jul 2018 18:57:14 +0800
Message-ID: <CAHCio2h1G5UDRv_veWbzRAMtM+NheyVfsghoC3G80BJgOtuW7g@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
To:     mhocko@kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal
cpuset_print_current_mems_allowed is also invoked by
warn_alloc(page_alloc.c). So, can I remove the current->comm output in
the pr_info ?

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d8b12e0d39cd..09b8ef6186c6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2666,9 +2666,9 @@ void cpuset_print_current_mems_allowed(void)
        rcu_read_lock();

        cgrp = task_cs(current)->css.cgroup;
-       pr_info("%s cpuset=", current->comm);
+       pr_info(",cpuset=");
        pr_cont_cgroup_name(cgrp);
-       pr_cont(" mems_allowed=%*pbl\n",
+       pr_cont(",mems_allowed=%*pbl",
                nodemask_pr_args(&current->mems_allowed));
>
> On Sun 01-07-18 00:38:58, ufo19890607@gmail.com wrote:
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> >
> > The current system wide oom report prints information about the victim
> > and the allocation context and restrictions. It, however, doesn't
> > provide any information about memory cgroup the victim belongs to. This
> > information can be interesting for container users because they can find
> > the victim's container much more easily.
> >
> > I follow the advices of David Rientjes and Michal Hocko, and refactor
> > part of the oom report. After this patch, users can get the memcg's
> > path from the oom report and check the certain container more quickly.
> >
> > The oom print info after this patch:
> > oom-kill:constraint=<constraint>,nodemask=<nodemask>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>
>
> This changelog doesn't correspond to the patch. Also while we were
> discussing this off-list, I have suggested to pull the cpuset info into
> the single line output.
>
> What about the following?
> "
> OOM report contains several sections. The first one is the allocation
> context that has triggered the OOM. Then we have cpuset context
> followed by the stack trace of the OOM path. Followed by the oom
> eligible tasks and the information about the chosen oom victim.
>
> One thing that makes parsing more awkward than necessary is that we do
> not have a single and easily parsable line about the oom context. This
> patch is reorganizing the oom report to
> 1) who invoked oom and what was the allocation request
>         [  126.168182] panic invoked oom-killer: gfp_mask=0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0
>
> 2) OOM stack trace
>         [  126.169806] CPU: 23 PID: 8668 Comm: panic Not tainted 4.18.0-rc2+ #36
>         [  126.170494] Hardware name: Inspur SA5212M4/YZMB-00370-107, BIOS 4.1.10 11/14/2016
>         [  126.171197] Call Trace:
>         [  126.171901]  dump_stack+0x5a/0x73
>         [  126.172593]  dump_header+0x58/0x2dc
>         [  126.173294]  oom_kill_process+0x228/0x420
>         [  126.173999]  ? oom_badness+0x2a/0x130
>         [  126.174705]  out_of_memory+0x11a/0x4a0
>         [  126.175415]  __alloc_pages_slowpath+0x7cc/0xa1e
>         [  126.176128]  ? __alloc_pages_slowpath+0x194/0xa1e
>         [  126.176853]  ? page_counter_try_charge+0x54/0xc0
>         [  126.177580]  __alloc_pages_nodemask+0x277/0x290
>         [  126.178319]  alloc_pages_vma+0x73/0x180
>         [  126.179058]  do_anonymous_page+0xed/0x5a0
>         [  126.179825]  __handle_mm_fault+0xbb3/0xe70
>         [  126.180566]  handle_mm_fault+0xfa/0x210
>         [  126.181313]  __do_page_fault+0x233/0x4c0
>         [  126.182063]  do_page_fault+0x32/0x140
>         [  126.182812]  ? page_fault+0x8/0x30
>         [  126.183560]  page_fault+0x1e/0x30
>
> 3) oom context (contrains and the chosen victim)
>         [  126.190619] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,task=panic,pid= 8673,uid=    0
>
> An admin can easily get the full oom context at a single line which
> makes parsing much easier.
> "
> --
> Michal Hocko
> SUSE Labs
