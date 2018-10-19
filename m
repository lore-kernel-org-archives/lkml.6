Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45342086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwa5P1Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45342086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJTDK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:10:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53949 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJTDK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:10:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so4600028wma.3;
        Fri, 19 Oct 2018 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1JxZ4IreQC7ELXhFy+O5x12lV3oLSAYXVMa99+fi6I=;
        b=Bwa5P1ErJGc/AAnlfK8iNuObcHZqyAK87bDq6lxUY1iXPsXjWw447vNUo1odG7LGXG
         qxlb46P8IQRMpC76iycB+eYbA+0UGvLnhGCbZSGyxZpzbHjj9XQB4ZI+sPnzJkX0tEai
         uT3WB8e8UG+mRhWrHPuJWig/Tgmeyj8P3yJNrzfvbCO/d1sOrMI80uqBfgoMgydTZ7cr
         EyzV235Egty/Otd/mWzge2SKeW7RjGTBHBARn8P+IbBmb9NU1FMB/2fM7oqQ/HnV8CHD
         PJny8zULT+egvL1b3gN+XRNTwpiLu1Ab3+p2C1WsHKbZzPQCwEFQoTeKkcoTuluFQsvJ
         VMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1JxZ4IreQC7ELXhFy+O5x12lV3oLSAYXVMa99+fi6I=;
        b=B468aevYXAIDP/FlWCKcm8DuD4TBtsWT1xNMhVF1IYx3XZ/KcjNO/56YHifLxvAjVh
         WztTK3SPWkNUkcxXwD8mgYil+OglDme4wNdQ/iNAM2usR96EB/lYB7/0+ain+laH6rXx
         ERwbxr/24GorBpOh0ke9kD96/ye25QZhKZ1yS2ONwHCF5mi3OPY16uf78sFjY7xZKNbB
         a9ApNYQ/4Dbh0wDtZUSzBt/fDW+yvawfvZsyZHIrVIAy2AgH3wFA7keagZ6JHOp9qz3F
         F3AkUsoGU5UUlhgF6WSLFLr8tuAomAieMY3iiS9mlxSG8zPP7sGL6eG8gE8n3GMMDOmg
         QZuQ==
X-Gm-Message-State: AGRZ1gJ5uagbB/6TvRWnGmCmGO8MpZGz/zgB8R4SzLcQenel7O4R2hT3
        UeeCqMWqc+pfIXH9CQQV6ZI=
X-Google-Smtp-Source: ACcGV63PKN7wYm8OmjLTwVQ0N0XZZLGrZNEfr9pScuZxWFIAY2AUg0ATwxrS0ISBStPlAXFCVY3h/Q==
X-Received: by 2002:a1c:cf4e:: with SMTP id f75-v6mr6069338wmg.81.1539975783075;
        Fri, 19 Oct 2018 12:03:03 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c14-v6sm5130000wmh.44.2018.10.19.12.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 12:03:02 -0700 (PDT)
Date:   Fri, 19 Oct 2018 12:03:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf/test_run: Add braces to initialization in
 bpf_prog_test_run_skb
Message-ID: <20181019190300.GA12563@flashbox>
References: <20181019182649.24301-1-natechancellor@gmail.com>
 <3e2e5343-3ead-5b4d-758d-14f04183b39e@gmail.com>
 <CAADnVQKyaU=kPZN5+Bi=NJDGh6AMV0HKZoDg+tzLGQdq+L8xaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKyaU=kPZN5+Bi=NJDGh6AMV0HKZoDg+tzLGQdq+L8xaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:47:34AM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 19, 2018 at 11:46 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> >
> >
> > On 10/19/2018 11:26 AM, Nathan Chancellor wrote:
> > > Clang warns:
> > >
> > > net/bpf/test_run.c:120:20: error: suggest braces around initialization
> > > of subobject [-Werror,-Wmissing-braces]
> > >         struct sock sk = {0};
> > >                           ^
> > >                           {}
> > >
> > > Add the braces to properly initialize all subobjects.
> > >
> > > Fixes: 75079847e9d0 ("bpf: add tests for direct packet access from CGROUP_SKB")
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  net/bpf/test_run.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > index 8dccac305268..65e049c61a7a 100644
> > > --- a/net/bpf/test_run.c
> > > +++ b/net/bpf/test_run.c
> > > @@ -117,7 +117,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> > >       u32 retval, duration;
> > >       int hh_len = ETH_HLEN;
> > >       struct sk_buff *skb;
> > > -     struct sock sk = {0};
> > > +     struct sock sk = { { {0} } };
> > >       void *data;
> > >       int ret;
> > >
> > >
> >
> > Strange, I thought this patch was still under discussion.
> > Has an old version of it being merged somewhere ?

Looks like it made its way into -next in the 20181019 version, which
is what I am working off of.

> 
> merged and reverted. This patch is not necessary.

Thank you for the heads up and sorry for the noise!
Nathan
