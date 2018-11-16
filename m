Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7D120685
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxDpmKCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7D120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeKQGEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:04:09 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39792 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQGEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:04:09 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so35890635itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GHy6wdHVz6xJVePiJsOim33OkU9goy49HCe4WHgDbtY=;
        b=PxDpmKCRdS1l/OOSPl2pQyVCLGFoWkHxPsorszcOLNqzRYBxAW9HNMMfjO0Jb4DUBz
         PSI4U3FyBxfKoo48Kg/Xwfg1bl+38DVHUgO6IQpjIplnW5alr01a8oZpc29U3MmlapcI
         KY4yqfdH6QHsV/cT54SSxOUMuRbhHC6DabPodU/0EOekR5oyvcbGXBClAxYCZairdlFU
         y9fcNmQXG/yjlkhIJLRJwsHCqm34RZRro5vTM0VlkMOXWbp/v8ksrdLpblYmEp8Kv1BH
         sDXH/QqQ4+vY/kYF8m+1wPtl1fEqTgJd3jxGzjsNe+icnyfrGYUS+xxNy6jre8k2ZJhG
         RY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GHy6wdHVz6xJVePiJsOim33OkU9goy49HCe4WHgDbtY=;
        b=lpE9U7haaeEhPKX4SfIGcjHsDJ28nWJYmQmpM7IvoHgG2h47zyEp2cFjiLwSEOOnpZ
         PILb0Zp1DnzBN4u/jfAmDS2nsvfmCUFAIt2Ub/Q/6eiapoPKBfhEL1VvaQ6mWg9wAaM3
         rKJFVI+AeLQdYzeMIWitHxOs1OU+jER7BjFtVcf1ydTBoJfBN+lE0ZYyk8wEGm67t79v
         XOe6ByF68r8dd5IbCplwogKNjHNQ2CneWvGx0DBzw+bK5iQkkFPewr6WcuH9l2Ggzz42
         Gz6xXLPALXif+T9fAhP9berp1ETb9cWb8pV6B/a4L3nVS6CbxY547/0WyuxujRG8pmM+
         ynwQ==
X-Gm-Message-State: AA+aEWYyePmvx5eBJCFmhywAfTmV0K7SWTOdFFobcKSrRliRrZQ12JVg
        OLqyfZElQFGoHZ8aW49nRtJVH0KpzefR2Dg9LJFoAQ==
X-Google-Smtp-Source: AJdET5ehLy2GiEKxpE3ZjnisEVXhgczMxLytihX1dgldng9uv2OAD61zg5NADLXWsPsEu4XnfPWX06xuj+LDTugBoNQ=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr10435524itf.166.1542397823331;
 Fri, 16 Nov 2018 11:50:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 11:50:02
 -0800 (PST)
In-Reply-To: <bce0322a-6392-3fd4-a6fb-562160c26198@solarflare.com>
References: <bce0322a-6392-3fd4-a6fb-562160c26198@solarflare.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 11:50:02 -0800
Message-ID: <CACT4Y+ZNM5EYwONLjfooAGb-K0GjgQhCF4aE0xo4-z1je5rYMA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix off-by-one error in adjust_subprog_starts
To:     Edward Cree <ecree@solarflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 4:00 AM, Edward Cree <ecree@solarflare.com> wrote:
> When patching in a new sequence for the first insn of a subprog, the start
>  of that subprog does not change (it's the first insn of the sequence), so
>  adjust_subprog_starts should check start <= off (rather than < off).
> Also added a test to test_verifier.c (it's essentially the syz reproducer).
>
> Fixes: cc8b0b92a169 ("bpf: introduce function calls (function boundaries)")
> Reported-by: syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com
> Signed-off-by: Edward Cree <ecree@solarflare.com>
>
> ---
> I'm assuming I don't need to get a Signed-off-by from syzkaller to use its
>  reproducer like this; I'm not an expert on the copyright niceties of works
>  written by bots.

My understanding is that copyright applies only if you directly reuse
the code (e.g. copy-paste and change). Copyright does not cover ideas
nor algorithms.
The test does not look like syzkaller reproducer. If you wrote the
test yourself, it should not have any issues with copyright. But I am
not a layer too.

The intention is that you can reuse it. I don't know if/what we need
to do to make it "official".

Thanks for the quick fix.


>  kernel/bpf/verifier.c                       |  2 +-
>  tools/testing/selftests/bpf/test_verifier.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1971ca325fb4..6dd419550aba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5650,7 +5650,7 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
>                 return;
>         /* NOTE: fake 'exit' subprog should be updated as well. */
>         for (i = 0; i <= env->subprog_cnt; i++) {
> -               if (env->subprog_info[i].start < off)
> +               if (env->subprog_info[i].start <= off)
>                         continue;
>                 env->subprog_info[i].start += len - 1;
>         }
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 6f61df62f690..550b7e46bf4a 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -13896,6 +13896,25 @@ static struct bpf_test tests[] = {
>                 .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>                 .result = ACCEPT,
>         },
> +       {
> +               "calls: ctx read at start of subprog",
> +               .insns = {
> +                       BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> +                       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
> +                       BPF_JMP_REG(BPF_JSGT, BPF_REG_0, BPF_REG_0, 0),
> +                       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +                       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
> +                       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +                       BPF_EXIT_INSN(),
> +                       BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_1, 0),
> +                       BPF_MOV64_IMM(BPF_REG_0, 0),
> +                       BPF_EXIT_INSN(),
> +               },
> +               .prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
> +               .errstr_unpriv = "function calls to other bpf functions are allowed for root only",
> +               .result_unpriv = REJECT,
> +               .result = ACCEPT,
> +       },
>  };
>
>  static int probe_filter_length(const struct bpf_insn *fp)
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/bce0322a-6392-3fd4-a6fb-562160c26198%40solarflare.com.
> For more options, visit https://groups.google.com/d/optout.
