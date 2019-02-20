Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8214C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB22147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrZj/jj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfBTAly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:41:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46462 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfBTAlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:41:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so19207057ljg.13;
        Tue, 19 Feb 2019 16:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9aaC2/Mq3x4alH5sbegWE8Nf5qgEyZiqDnYhUKPq0Yo=;
        b=PrZj/jj90o4uwCflnCfpq3estU0nOSk/o3WQ205tos6JoDnB8dYYX2H2uuebT75HR7
         onAf+CuPzucGc8mA69bC9rkao1OjQ8S5i5E7NYo7asQY6CuQrxiEAMHyl5W7ghaCEDWq
         kMyU6EaT4iv+I8bmY8bO7HchQN2sbx1CwyrLQSs0YcFnhxkcz2zpmt4wuHudXY5aFdzB
         zmrEWn+XNv7q2YoqN47emF/Nd/zQC7yzAPyy6FailstXA8dhChZBu3KjpK0nJJ80z4zV
         emcJh/VQcxZi2td5e2ssykZkwOIvdEgdVLvDRqF51FyfyofvTo2UlKt6eBVohuAF9wqR
         fgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9aaC2/Mq3x4alH5sbegWE8Nf5qgEyZiqDnYhUKPq0Yo=;
        b=qUH7QbtHZ63l/MoCD7nHLPwfGFg9B0EGqmFBbUjcodHzaFWG5dWeHCrFEKXqIwhV9R
         BC2TzPaZwPx2aGnl7slJQlyo57izQMs32KqHv5rUkb6arn0gA/8Enl/v8gfGup1Xwbl8
         LqHutcQ9DJgBjNYqWvIXupGDm2dZkyqBUWILLBgdcxEs+1iaF7lsHpxbziI7e014pxbr
         JdSWf26DTJrwmL0bEq0wa6uaCp3vcT6zG992JrBMYnwPN1Dh2jpm5Y8ryukM6ksAap6u
         zQadutTHfaM9widRn9qhltwFnQhdxrDQffl/Cai8C7+EoJsRJgOVajLw+obX3yuigHFh
         O00w==
X-Gm-Message-State: AHQUAuava2XoyQyQwfM5bkFp0gJzOjAtYEOcWKxUIJ/9eMIw1xQCSnzw
        4U3JF/F5t0B9HRm7EPlwcUlUOAhGmfotkXhsXm0=
X-Google-Smtp-Source: AHgI3IYKwUHCfYTFg37GHetHZUvvwmFdL/VvUOnbphEFOUV6usVSX8VWUqUCJEzFCrWRxhHs36Jcm76XgbP+fwgGaN4=
X-Received: by 2002:a2e:4c0a:: with SMTP id z10-v6mr18995149lja.85.1550623310918;
 Tue, 19 Feb 2019 16:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20190220113729.49f28f73@canb.auug.org.au>
In-Reply-To: <20190220113729.49f28f73@canb.auug.org.au>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Feb 2019 16:41:38 -0800
Message-ID: <CAADnVQK3qg2k67LRiOqDmFnELrFOD1dLkrNbAvbMyu6xGpjBLw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the net-next tree with the bpf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 4:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the net-next tree got a conflict in:
>
>   tools/testing/selftests/bpf/test_progs.c
>
> between commit:
>
>   f6be4d16039b ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN")

Ouch. Thanks for the heads up.

Daniel,
should we drop this one from bpf tree ?
I don't think it's strictly necessary.

> from the bpf tree and commits:
>
>   bf0f0fd93945 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for flow dissector")
>   ab963beb9f5d ("selftests/bpf: add bpf_spin_lock C test")
>   ba72a7b4badb ("selftests/bpf: test for BPF_F_LOCK")
>
