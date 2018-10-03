Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A78A206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A78A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wand.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeJCMQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:16:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34387 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:16:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id x23-v6so4669721qtr.1;
        Tue, 02 Oct 2018 22:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X02pzJ/MWnmeedxMe/27LlHF1xiCJYk+ROXVxpRCozk=;
        b=Z2RXBokpckomZXbiKNW1in4MzLfR4bHIbbBH0bAEykr1MJafGpZN80Bh3YZ//x1Piy
         JBuOF/G6W0uC5NcCvLFH9cCfvF4lqn+l5gvz1OwkknHHsGdtsuCsCG4m4NVrG0Bf4Pt/
         XIcLRi3CTretzK6/iwq9cCwm7XNlxazkbE0n9g/RXpGBuwFugb89rf/GJP8zRBMwR8n+
         yXvhWhWWP8TyPMfHtmihVtDgnX4W+tb95X70orBtBo1q6gy3oBt2qdh2IEroKrTWXOLX
         OfIoKOOzt8Lt8UAzFQThQffni7t1dMJyrYVjreBlMbf/ABijFu/N3sZzIHgJkxre3idc
         hPYw==
X-Gm-Message-State: ABuFfohX0GNL0/F799qtq4Eqdo3ChTJZq4d5RFPUjG030RL50iV4Sy+O
        5Gog5NxZjmDLFE5Bpp8oa4dqhh+0ar7TFDLOGbj3sA==
X-Google-Smtp-Source: ACcGV62cE58IKK6cmK3YtWJu/Hoita0zbsfgCFqfm12/tOaabTeZJhrHLCaYvbsYgUkiNZsH+O77O1fp+Do+fghjso4=
X-Received: by 2002:ac8:28bb:: with SMTP id i56-v6mr15198936qti.140.1538544572402;
 Tue, 02 Oct 2018 22:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181003131848.4f76db59@canb.auug.org.au>
In-Reply-To: <20181003131848.4f76db59@canb.auug.org.au>
From:   Joe Stringer <joe@wand.net.nz>
Date:   Tue, 2 Oct 2018 22:29:12 -0700
Message-ID: <CAOftzPhjR55RurO-waNe_idrPuCY-SUCj7V0cx=HY482wv57rw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To:     sfr@canb.auug.org.au
Cc:     daniel@iogearbox.net, ast@kernel.org,
        netdev <netdev@vger.kernel.org>, linux-next@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018 at 20:19, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> x86_64-linux-gnu-ld: net/core/filter.o: in function `sk_lookup':
> (.text+0x19219): undefined reference to `__udp6_lib_lookup'
>
> Caused by commit
>
>   6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>
> I assume that __udp6_lib_lookup ended up in the IPv6 module.
>
> I used the bpf-next tree from next-20181002 for today.

My mistake, will send out a fix shortly.

Cheers,
Joe
