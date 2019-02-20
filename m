Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE7720838
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ao00oHbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfBTSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:23:26 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38087 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfBTSXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:23:25 -0500
Received: by mail-vs1-f67.google.com with SMTP id h132so2755205vsd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZB42KzKTw2BNfWV8SxyF1MeIRkWuw3eKpXtz7R2gepY=;
        b=Ao00oHbBUNGp1R/QdiW5n9NriWqQDf+ZLL8cAnFOeDXqJul1fyN4SRuUlbmHtT+Dm6
         SYYJauvdZOcMcSyJwSkQjqHAENZnqszQ/Ux+1TcigWs2mUfWoAgauMrarFOdJSPz+jC+
         N/6Icfl7XvmDwXAAqwbK0Q92dERIrRTp1rf+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZB42KzKTw2BNfWV8SxyF1MeIRkWuw3eKpXtz7R2gepY=;
        b=DtNQL0/gMhomUSegFwSvcCM8mujBmUc4M5y5nwSOy2SlRNnJHZC/eGUU5QMb2pBOyF
         +bTPV3PqKR041meuUqzULpKfWSVwWpKuW3VGz0mtEg32Z1sgEv52hE0kEQQ7Rn0Kd5bM
         OlKZys9jzKR8eAsqKYl3b8pzhQLpG1WuBoahCwAu6l9lwHMwsxtbV/t4Yha5E1njNAsL
         Y+T5QpssC18CLtPHhlxyx09ho9P+17iKd9szVkDNFp/IKqjxUVQLjvTAW8IvkpgZ1m74
         yU1VpBtxL+80yL3hXfFCi8cMzkP+1k5HzxnsiK1pqLoGbELZAsGtsJ43eumghXAP9O/w
         h8Zw==
X-Gm-Message-State: AHQUAuZ5werKDM67CJCp3VOmyIMesSMnN9Emr6Sf8TKfUVrpSEExjXVt
        2pF0ecL4/fpb9MjcACmDekAtiA7PWso=
X-Google-Smtp-Source: AHgI3IbzdP6rXQbqnGK60KLFsPmtzwLS4grlZwgyQAAnyUgy92+av7klxlp4ci69nk1Ts76IDfSAYA==
X-Received: by 2002:a67:7488:: with SMTP id p130mr8141808vsc.164.1550687003831;
        Wed, 20 Feb 2019 10:23:23 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id c6sm2094751vkf.45.2019.02.20.10.23.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 10:23:23 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id j8so8553317uae.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:23:22 -0800 (PST)
X-Received: by 2002:ab0:4741:: with SMTP id i1mr15665649uac.36.1550687002226;
 Wed, 20 Feb 2019 10:23:22 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cedfe1058250076c@google.com> <69ff36f9-8729-9b58-5595-1b35aa4a7825@iogearbox.net>
In-Reply-To: <69ff36f9-8729-9b58-5595-1b35aa4a7825@iogearbox.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 10:23:09 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+PKtahYQ4okNZbD8uYNgxX09kNg2VxeqqYRufvZr559g@mail.gmail.com>
Message-ID: <CAGXu5j+PKtahYQ4okNZbD8uYNgxX09kNg2VxeqqYRufvZr559g@mail.gmail.com>
Subject: Re: BUG: assuming atomic context at kernel/seccomp.c:LINE
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     syzbot <syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>, kafai@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Network Development <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 2:00 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 02/20/2019 10:32 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    abf446c90405 Add linux-next specific files for 20190220
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17f250d8c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=463cb576ac40e350
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8bf19ee2aa580de7a2a7
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com
> >
> > BUG: assuming atomic context at kernel/seccomp.c:271
> > in_atomic(): 0, irqs_disabled(): 0, pid: 12803, name: syz-executor.5
> > no locks held by syz-executor.5/12803.
> > CPU: 1 PID: 12803 Comm: syz-executor.5 Not tainted 5.0.0-rc7-next-20190220 #39
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> >  __cant_sleep kernel/sched/core.c:6218 [inline]
> >  __cant_sleep.cold+0xa3/0xbb kernel/sched/core.c:6195
> >  seccomp_run_filters kernel/seccomp.c:271 [inline]
> >  __seccomp_filter+0x12b/0x12b0 kernel/seccomp.c:801
> >  __secure_computing+0x101/0x360 kernel/seccomp.c:932
> >  syscall_trace_enter+0x5bf/0xe10 arch/x86/entry/common.c:120
> >  do_syscall_64+0x479/0x610 arch/x86/entry/common.c:280
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> False positive; bpf-next only. Pushing this out in a bit:
>
> From d56547070162a105ff666f3324e558fa6492aedd Mon Sep 17 00:00:00 2001
> From: Daniel Borkmann <daniel@iogearbox.net>
> Date: Wed, 20 Feb 2019 10:51:17 +0100
> Subject: [PATCH bpf-next] bpf, seccomp: fix false positive preemption splat for
>  cbpf->ebpf progs
>
> In 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
> a check was added for BPF_PROG_RUN() that for every invocation preemption is
> disabled to not break eBPF assumptions (e.g. per-cpu map). Of course this does
> not count for seccomp because only cBPF -> eBPF is loaded here and it does not
> make use of any functionality that would require this assertion. Fix this false
> positive by adding and using __BPF_PROG_RUN() variant that does not have the
> cant_sleep(); check.
>
> Fixes: 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
> Reported-by: syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/filter.h | 9 ++++++++-
>  kernel/seccomp.c       | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f32b3ec..2f3e29a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -533,7 +533,14 @@ struct sk_filter {
>         struct bpf_prog *prog;
>  };
>
> -#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
> +#define bpf_prog_run__non_preempt(prog, ctx)   \
> +       ({ cant_sleep(); __BPF_PROG_RUN(prog, ctx); })
> +/* Native eBPF or cBPF -> eBPF transitions. Preemption must be disabled. */
> +#define BPF_PROG_RUN(prog, ctx)                        \
> +       bpf_prog_run__non_preempt(prog, ctx)
> +/* cBPF -> eBPF only, but not for native eBPF. */
> +#define __BPF_PROG_RUN(prog, ctx)              \
> +       (*(prog)->bpf_func)(ctx, (prog)->insnsi)
>
>  #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index e815781..826d4e4 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -268,7 +268,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>          * value always takes priority (ignoring the DATA).
>          */
>         for (; f; f = f->prev) {
> -               u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
> +               u32 cur_ret = __BPF_PROG_RUN(f->prog, sd);
>
>                 if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
>                         ret = cur_ret;
> --
> 2.9.5



-- 
Kees Cook
