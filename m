Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F2D20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzRvxRE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F2D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbeLCCas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:30:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35720 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeLCCas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:30:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so5660959plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 18:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nDbm3Gg62A+NnRlRNNyK9kjnE0VQuTyeHAxME3tXvvA=;
        b=IzRvxRE3XUVhh9ZfVMTneM+IDX1Cj4BjFqqJxEZqp3H0tKIWkxcmH6tFzrLra/IEip
         YiiJIrdfWbkFkYH6ijAaXvfJWlKisLZzg16yy+dFgORrKvTrCZ3+a0PK9gKSwE2DXEDG
         VigteSUig8cPkOseH6P962saiRevfPMOXdRuw5jHz8hXfGLYsKmkFHJ7m+t1Vlf21ICF
         oPFObfsLQJec5Gcvl5tsVWUTXHsxSti5R/bkrZDUf0mF1GWRRGgGu8GYhJpbz/fYRYaJ
         +l+iD3SIx7k1YxM3sr2QeqPLwurp5naN4OeE103CmXpGgiXsnARf8ThExLGv4ex88FW1
         +GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nDbm3Gg62A+NnRlRNNyK9kjnE0VQuTyeHAxME3tXvvA=;
        b=CXeT2YPjoFWXjyv2/kFFfcv3fDj5O13Mi2eqsUPCdaMnrZddN2xbxW2KKvcJPAbHDK
         meO5dDaNoYS0tn8K3IAvUDjCqfaTWS/LgeE1aetHfB5I/BOll/GZwhQVGWnKK0xvRijz
         HeIdfolH+cl6/9T9/HmL0pzuevQF2fzRMWclnLZSRl7DLRDEf1dlhDuanEIqmmGvrr8z
         FqDAA27WOtUu+UZSm1UKhmHhK8Viuv6ecL7rnR9Y+buzE2Ao6ZuJxUPvUXbBqFA0k8AG
         dl9kAIMn4VRD10Gu3CRfpN03h6y48QhxtN5TCtt5MSFzHd/UzNI6LBn/73QdkVeaFHI3
         poWQ==
X-Gm-Message-State: AA+aEWZkdbGk3CQQj74wj3nEKivs+wxBm6TST0LeygqTjJ7yq5jYNLlS
        3zNeW1rRXf+c7WTVAKZc79c=
X-Google-Smtp-Source: AFSGD/V4SfzPszJESa6XCfkE8ye/tMQIgtU5K/Na3fvMAlSGWRylIfSq3cYJ+RICF7gEHupvPzgXeQ==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr14206467plk.208.1543804244635;
        Sun, 02 Dec 2018 18:30:44 -0800 (PST)
Received: from localhost ([175.223.22.143])
        by smtp.gmail.com with ESMTPSA id f67sm7038883pff.29.2018.12.02.18.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 18:30:43 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:30:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: writeback throttle
Message-ID: <20181203023040.GA427@jagdpanzerIV>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-8-minchan@kernel.org>
 <20181129022358.GA6379@jagdpanzerIV>
 <20181202231829.GA21560@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202231829.GA21560@google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/03/18 08:18), Minchan Kim wrote:
> 
> Per andrew's comment:
> https://lkml.org/lkml/2018/11/27/156
> 
> I need to fix it to represent 4K always.

Aha.

Then we need to increase bd_writes PAGE_SIZE/4K times in writeback_store()?

   wb_count = atomic64_inc_return(&zram->stats.bd_writes);
   ...
   if (wb_limit != 0 && wb_count >= wb_limit)
       zram->stop_writeback = true;

bd_wb_limit is in 4K units; but in writeback_store() we alloc a full page
and write it to the backing device. So the actual number of written bytes
can be larger on systems with page_size > 4K. Right?

	-ss
