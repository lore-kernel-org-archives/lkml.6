Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA50C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61756208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0gWM1qCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfACUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:10:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37755 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfACUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:10:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so30719447ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0Yjossshc4/KAwUVWK38uJ5MXVeqDGRfuaO8ILv0rk=;
        b=0gWM1qCU4dnP0oDRuP5X83oz+b3euRZ9bRg4PSEOHCVt7Lgp+7C8B7ujh1ZXOeYGsO
         smyVcA8RwxdeRhaOLVY52JtwvU7tI7oOtg1eP8/kgRFCuwwGSGgDs5sa8V/HpLw21M20
         /6CcfAjRG2tNdbq3ckx56XDLPZDDXbwWcoVE86zwJleRTF2in1FuaNHzQuDGUFHPC4Wa
         GakuXM+jUn7AWEzC1pD+ttSRkFmpU7V1t1Qm6w/BixzwQijSBMFNssCo0ag4VuiO9qk4
         bKcRJjDdu+KffiJ95qUzzk6141bMJbhM/7WgNPvtn0GFwbR6PqS0HOsVci/wo3TRZbiy
         k5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0Yjossshc4/KAwUVWK38uJ5MXVeqDGRfuaO8ILv0rk=;
        b=DLP6UF1veD6Bgkrkf3Kte56xVdELg2Wr81Ujgabo1XTxiveHwWcHaYCHPcuDXN0fmo
         RtwNGrVNT5Dq4eH6WAOTZxtgnxh0wqk7QOhcX8r8KjEFjZzFriIqNfoFTlSqEOlKLNI1
         1APOHNQSOP/Z7nmO/KJoyctEhPMCtOnnICgbntrYKPrX/wp9fvqPJHNFpD/ZwG30dWii
         30/nohHg1T0WSTbs83Wtryc4bT7j3Ce9gLm1V1C7Sg6soC8NBC1/g1IjpvbUOMq/2wtU
         IFvmm/ZpQDQ1NNuvnWmlpp69m8O005X4BcUEWgygu9G9it5+tRdflgPmU5NiXGH4KKIp
         KEbA==
X-Gm-Message-State: AJcUukdqwYM6HeFTDv0dTv3Efle5JUINXAhBabTKM/BBtf+N4IHHaLYB
        ORNjH1R0VQy4p4CJXbJYwTU9mXn56L/LUFn1lzvb
X-Google-Smtp-Source: ALg8bN4RIVAcrkAK/kPlUhOb06YbW3Z54mck3vagnDJT4tncPjppVpRomV55D0J7DoTtlLQa9K9pi8qCMhQgm5aEfzE=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr6418289ljh.42.1546546242675;
 Thu, 03 Jan 2019 12:10:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <8e617ab568df28a66dfbe3284452de186b42fb0f.1533065887.git.rgb@redhat.com>
 <CAHC9VhQFqs1SyvximK+8XJG5Fk3p9WsWhEV5sY6kksN9tc6eKw@mail.gmail.com> <20181101220724.ggkqyf5kjv7lhabx@madcap2.tricolour.ca>
In-Reply-To: <20181101220724.ggkqyf5kjv7lhabx@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Jan 2019 15:10:31 -0500
Message-ID: <CAHC9VhRU-Qss41CnV3mE32tXmZ3FQpy++t4yPUkh9CjuAzxYCA@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 01/10] audit: collect audit task parameters
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 6:07 PM Richard Guy Briggs <rgb@redhat.com> wrote:
&gt; On 2018-10-19 19:15, Paul Moore wrote:
&gt; &gt; On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs
<rgb@redhat.com> wrote:
&gt; &gt; &gt; The audit-related parameters in struct task_struct
should ideally be
&gt; &gt; &gt; collected together and accessed through a standard audit API.
&gt; &gt; &gt;
&gt; &gt; &gt; Collect the existing loginuid, sessionid and
audit_context together in a
&gt; &gt; &gt; new struct audit_task_info called "audit" in struct task_struct.
&gt; &gt; &gt;
&gt; &gt; &gt; Use kmem_cache to manage this pool of memory.
&gt; &gt; &gt; Un-inline audit_free() to be able to always recover that memory.
&gt; &gt; &gt;
&gt; &gt; &gt; See: https://github.com/linux-audit/audit-kernel/issues/81
&gt; &gt; &gt;
&gt; &gt; &gt; Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
&gt; &gt; &gt; ---
&gt; &gt; &gt;  include/linux/audit.h | 34 ++++++++++++++++++++++++----------
&gt; &gt; &gt;  include/linux/sched.h |  5 +----
&gt; &gt; &gt;  init/init_task.c      |  3 +--
&gt; &gt; &gt;  init/main.c           |  2 ++
&gt; &gt; &gt;  kernel/auditsc.c      | 51
++++++++++++++++++++++++++++++++++++++++++---------
&gt; &gt; &gt;  kernel/fork.c         |  4 +++-
&gt; &gt; &gt;  6 files changed, 73 insertions(+), 26 deletions(-)
&gt; &gt;
&gt; &gt; ...
&gt; &gt;
&gt; &gt; &gt; diff --git a/include/linux/sched.h b/include/linux/sched.h
&gt; &gt; &gt; index 87bf02d..e117272 100644
&gt; &gt; &gt; --- a/include/linux/sched.h
&gt; &gt; &gt; +++ b/include/linux/sched.h
&gt; &gt; &gt; @@ -873,10 +872,8 @@ struct task_struct {
&gt; &gt; &gt;
&gt; &gt; &gt;         struct callback_head            *task_works;
&gt; &gt; &gt;
&gt; &gt; &gt; -       struct audit_context            *audit_context;
&gt; &gt; &gt;  #ifdef CONFIG_AUDITSYSCALL
&gt; &gt; &gt; -       kuid_t                          loginuid;
&gt; &gt; &gt; -       unsigned int                    sessionid;
&gt; &gt; &gt; +       struct audit_task_info          *audit;
&gt; &gt; &gt;  #endif
&gt; &gt; &gt;         struct seccomp                  seccomp;
&gt; &gt;
&gt; &gt; Prior to this patch audit_context was available regardless of
&gt; &gt; CONFIG_AUDITSYSCALL, after this patch the corresponding audit_context
&gt; &gt; is only available when CONFIG_AUDITSYSCALL is defined.
&gt;
&gt; This was intentional since audit_context is not used when AUDITSYSCALL is
&gt; disabled.  audit_alloc() was stubbed in that case to return 0.
audit_context()
&gt; returned NULL.
&gt;
&gt; The fact that audit_context was still present in struct task_struct was an
&gt; oversight in the two patches already accepted:
&gt;         ("audit: use inline function to get audit context")
&gt;         ("audit: use inline function to get audit context")
&gt; that failed to hide or remove it from struct task_struct when it
was no longer
&gt; relevant.

Okay, in that case let's pull this out and fix this separately from
the audit container ID patchset.

&gt; On further digging, loginuid and sessionid (and
audit_log_session_info) should
&gt; be part of CONFIG_AUDIT scope and not CONFIG_AUDITSYSCALL since
it is used in
&gt; CONFIG_CHANGE, ANOM_LINK, FEATURE_CHANGE(, INTEGRITY_RULE), none
of which are
&gt; otherwise dependent on AUDITSYSCALL.

This looks like something else we should fix independently from this patchset.

&gt; Looking ahead, contid should be treated like loginuid and
sessionid, which are
&gt; currently only available when syscall auditting is.

That seems reasonable.  Eventually it would be great if we got rid of
CONFIG_AUDITSYSCALL, but that is a separate issue, and something that
is going to require work from the different arch/ABI folks to ensure
everything is working properly.

&gt; Converting records from standalone to syscall and checking
audit_dummy_context
&gt; changes the nature of CONFIG_AUDIT/!CONFIG_AUDITSYSCALL separation.
&gt; eg: ANOM_LINK accompanied by PATH record (which needed CWD addition to be
&gt; complete anyways)
&gt;
&gt; &gt; &gt; diff --git a/init/main.c b/init/main.c
&gt; &gt; &gt; index 3b4ada1..6aba171 100644
&gt; &gt; &gt; --- a/init/main.c
&gt; &gt; &gt; +++ b/init/main.c
&gt; &gt; &gt; @@ -92,6 +92,7 @@
&gt; &gt; &gt;  #include <linux rodata_test.h="">
&gt; &gt; &gt;  #include <linux jump_label.h="">
&gt; &gt; &gt;  #include <linux mem_encrypt.h="">
&gt; &gt; &gt; +#include <linux audit.h="">
&gt; &gt; &gt;
&gt; &gt; &gt;  #include <asm io.h="">
&gt; &gt; &gt;  #include <asm bugs.h="">
&gt; &gt; &gt; @@ -721,6 +722,7 @@ asmlinkage __visible void __init
start_kernel(void)
&gt; &gt; &gt;         nsfs_init();
&gt; &gt; &gt;         cpuset_init();
&gt; &gt; &gt;         cgroup_init();
&gt; &gt; &gt; +       audit_task_init();
&gt; &gt; &gt;         taskstats_init_early();
&gt; &gt; &gt;         delayacct_init();
&gt; &gt;
&gt; &gt; It seems like we would need either init_struct_audit or
&gt; &gt; audit_task_init(), but not both, yes?
&gt;
&gt; One sets initial values of init task via an included struct,
other makes a call
&gt; to create the kmem cache.  Both seem appropriate to me unless we move the
&gt; initialization from a struct to assignments in audit_task_init(),
but I'm not
&gt; that comfortable separating the audit init values from the rest of the
&gt; task_struct init task initializers (though there are other
subsystems that need
&gt; to do so dynamically).

My original thinking was focused on the use of init_struct_audit as an
initializer when audit_task_init() was already creating a kmem_cache
pool and a zero'd/init'd audit_task_info could be obtained via the
usual kmem_cache functions.  Alternatively, although I don't believe
it would be recommended for this case, would be to use
init_struct_audit as an init helper if we included the audit_task_info
struct directly in the task_struct, as opposed to a pointer.  What I
missed was the simple fact that you're only using init_struct_audit
for the init_task, which pretty much makes my original question rather
silly :)

--
paul moore
www.paul-moore.com
