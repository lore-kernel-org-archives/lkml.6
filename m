Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906C9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547E221916
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550415514;
	bh=cZ8Uk+5ObAOcxlqUWwO3h3jKNMcubG4uM5UBjsfTFbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bjdhx1sRHoRJyY1JjYLwaMCfOBs3VHTlKFJLY4qK+SX0QmfZdxpmCjTf1oIQkAsfj
	 FQwezOs2TgiOszwAbQzsGxwCwRzg/WC9XiOj5c3gtVZnC4L98jCB9fP71kqYpD4KLz
	 Q8JSf5D9Md4gsB962B+sq6NKS/F5aYm0uOIQ6U3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBQO6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:58:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52512 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBQO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:58:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so14759604wml.2;
        Sun, 17 Feb 2019 06:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DHBLfTGFPdlt8VAn5Pxnenv7TXacU2a+22zGIRrQc0=;
        b=RtpwgS30J22nKDViMy4BGnsC+8V/MVusx1hjJtuinlyPTlC9bwXbo0RPNHk9FZRMQZ
         qql77v2y+qL2Eb3Itwx27zb3bR7Cwq3PtjY/YBgoTdZYmciqd/c0LU23fpjXOWR8o7ah
         vsjTAAFtKTG7lgPUr4RPfYyt0bCVl/AvTXlVry0Bmxig91BUnbO21KDNiuFv2Gba//6q
         Abcwl1QGtkEz+I/kEfQPjBrguJKmAw6OK201YpvzV3WU3jarpbcohns9eiZQcJi9YG86
         MrTk/rk/LGajm9cyIogTmR6iX1jUIrh5uKbATjB5pe1OWPTwDbiewwv28T0tzSyU00Va
         7qUQ==
X-Gm-Message-State: AHQUAuZ4ZTFieUVPs7gVKMiJiGBLds565E27Bey+2yXaGguVBt19NFsa
        AzCKzljcCG/BPqmyLNl79iPt/ylBkOgwYCydB9Y=
X-Google-Smtp-Source: AHgI3IYCQmSjv2WK6XHGWHUN0QF+BMn21Ky4olGhmalqj2KWeiEK1Z43P2pqkl+qgV/F9vI7jWd+sTPbu16zf+PlDG0=
X-Received: by 2002:a1c:4844:: with SMTP id v65mr13722608wma.66.1550415508290;
 Sun, 17 Feb 2019 06:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20190215215354.3114006-1-songliubraving@fb.com> <20190215215354.3114006-9-songliubraving@fb.com>
In-Reply-To: <20190215215354.3114006-9-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 17 Feb 2019 23:58:16 +0900
Message-ID: <CAM9d7ch-VtYcxpHDnZwqfpx8Ab74CAg8z44Jhc=t8rzQH603kQ@mail.gmail.com>
Subject: Re: [PATCH v3 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
To:     Song Liu <songliubraving@fb.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Feb 16, 2019 at 6:55 AM Song Liu <songliubraving@fb.com> wrote:
>
> This patch enables perf-record to save btf information as headers to
> perf.data A new header type HEADER_BTF is introduced for this data.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---

[SNIP]
> +static void print_btf(struct feat_fd *ff, FILE *fp)
> +{
> +       struct perf_env *env = &ff->ph->env;
> +       struct rb_root *root;
> +       struct rb_node *next;
> +
> +       down_read(&env->bpf_progs.bpf_info_lock);
> +
> +       root = &env->bpf_progs.btfs;
> +       next = rb_first(root);
> +
> +       while (next) {
> +               struct btf_node *node;
> +
> +               node = rb_entry(next, struct btf_node, rb_node);
> +               next = rb_next(&node->rb_node);
> +               fprintf(fp, "# bpf_prog_info of id %u\n", node->id);

How about saying it's "btf" info?

Thanks,
Namhyung


> +       }
> +
> +       up_read(&env->bpf_progs.bpf_info_lock);
> +}
