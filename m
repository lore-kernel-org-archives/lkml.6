Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C046F208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfUm5uc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C046F208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeH1HeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:34:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34656 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1HeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:34:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so137585pgv.1;
        Mon, 27 Aug 2018 20:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwkOMU4rgKMwmvkmJPXh7LjgRLQj25lHmk5z8lBBzKI=;
        b=gfUm5uc7BGZyU5kmJ+6kp8lnH3eJNqIRWxlzP1d3iQBj2KcQXm4au6Dz61xdsskRuW
         HGGwD7CBxgiIxKGf1hBCMEyXjP6/8SU/qhArRCTFmplHp11gkvS5h090XoyXtDmpZjeZ
         9ja4COAc3TN98RwIaQbcWn7OkyyjHEdQSQNafmgNXNqOm/xNrvAFDhxkgDUE+YvqfpcB
         nqJ8ZtpCYifRnohjlew+Lfk9A5Zbw4FYqwk10kJHBTvoCDn/bZQpDXN8jO4sv00E5ZIo
         Ct0JDecX7FFA/iOMUcGMcTgeIzw/YGpjA4y3Sla8KT6MpLKOX2sqyhb173BS1ukEZCOz
         gUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwkOMU4rgKMwmvkmJPXh7LjgRLQj25lHmk5z8lBBzKI=;
        b=Ot1cgZDiLbLUedoXTrR/4lFa9MeezGe0tPT6Tg+gNxpzJxsA66bDjPHCSzhn6SS/Ti
         sMLmoJLMBiTncM9vNZYgzyTdsMOl+bCqlnnTeDXRewMqCjvGfjFC3nyxniC8hgZnSrGf
         4fblETAylf1bQflEfsiwP19BlPDkjdNg5f3M1ATCuMaDfQSADqivic7T3Lv+t2/0CLPo
         zWwT4MJywF1S1EOckySaVuBwObbNIwdSYkqNP2Q4Rj8Xyb92gQpieeS60GlKrV5VBFCm
         l+fgX1udhcWXZ9nAj9KjVJgA889RQH9lFx023FNAAVGWxBO+d6RwdxnLTdIFq+a56Aqe
         /WRQ==
X-Gm-Message-State: APzg51BFHIcXsT8nETkwDnhz00orWQv3thzRLzvVi7jRVG3q9mMqhbsU
        tnIZB/w17ggUxAk9N3aAWeM=
X-Google-Smtp-Source: ANB0VdZp1Zu3qBcn93VBj1FDQs6b/Tu5T/uG8r/KkOgmIFZGC2sUljygqC2bo+5kAkN7E0ZABNT7fg==
X-Received: by 2002:a62:9349:: with SMTP id b70-v6mr17172635pfe.193.1535427886354;
        Mon, 27 Aug 2018 20:44:46 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:695e])
        by smtp.gmail.com with ESMTPSA id w69-v6sm772406pgd.37.2018.08.27.20.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 20:44:45 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:44:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     daniel@iogearbox.net, kafai@fb.com, ast@kernel.org,
        mka@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: fix build error with clang
Message-ID: <20180828034442.drkvs6erk4dh65eu@ast-mbp>
References: <20180827193042.3573-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827193042.3573-1-stefan@agner.ch>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:30:42PM +0200, Stefan Agner wrote:
> Building the newly introduced BPF_PROG_TYPE_SK_REUSEPORT leads to
> a compile time error when building with clang:
> net/core/filter.o: In function `sk_reuseport_convert_ctx_access':
>   ../net/core/filter.c:7284: undefined reference to `__compiletime_assert_7284'
> 
> It seems that clang has issues resolving hweight_long at compile
> time. Since SK_FL_PROTO_MASK is a constant, we can use the interface
> for known constant arguments which works fine with clang.
> 
> Fixes: 2dbb9b9e6df6 ("bpf: Introduce BPF_PROG_TYPE_SK_REUSEPORT")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, Thanks

