Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924D8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F56B20838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBHUpSuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F56B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJYOAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:00:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34996 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJYOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:00:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8-v6so3325620plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wu+KPnXAfM67KW81AWC0ilnaLvCXr5vt9ubgZdQ7H1E=;
        b=YBHUpSuht8RtfX8nq3dNRVp+wQXjfd6ipdbkLx9b9i9HFpiuTLSNq0kN+wjBAWxRlP
         98Wh4eVEjhsRZ8dtbRthmlH1GI7Gr3iK0L0wnZG+QANwmMW1415YX2klUTN3LP4ED1Yz
         CbDPUAd1s5TLIINyceEnMwvZPHCo810PqJbhTm9sjBC3T8GK9TBY+6Q+362KzjmNxbPz
         wt1SCUanxaN3ZMqHB7fBhRt9nTta5dmQFpxUxM01WS9Fuui2b10SJGiVXFY3jU3o0nOP
         MK8HMEkcJPvPvmzGLoKhAe/+mY1a0I+g3N2B64cmh1RMr/Z3/83ASfnbLTCA/b2sebTy
         SYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wu+KPnXAfM67KW81AWC0ilnaLvCXr5vt9ubgZdQ7H1E=;
        b=SSZ76pKXU4dmh5WDZ2kmgekRBCE6qiGHqCP/hudJ0MRHH5NDm7A0eyeZiLoErAPm1u
         nU0Ai9WEZVQCLbecs9LCRJm8OreStlRKm1yo62ujwyp4KSzv2rsBYMh/KQLD91Va+ZD8
         xF4TDoePuNr3yNY7QZablgRW6nFQChbBFUgA+GfCkqcrzvKEjpBDRJu3b5UxGkBJA6ee
         Y/JEele/tF0UxKCSSD4vEtbaicLRj+lxd9J8XJFt2SMbQcyEl5KpO7bYiAaUQxkCnGkm
         L7FZNPFX/QPc57qwukZwauvdZLwhRoJlVLz0dRx3156fEhrG2YUknGScHZCEeAWnDN1R
         ERhQ==
X-Gm-Message-State: AGRZ1gIt733de96vv8bk3NXqt3nxtBdkKeH6nb7z9U9xNVaig2NZrUQL
        0SqBMtSZt4Hyn0Fs7EaJZXc=
X-Google-Smtp-Source: AJdET5dw3MTEztbeuq7xb6dkFiPyfAIsjjyBjNTBq7CGlVZjB9oJuq1G7/oHOaVssSyoMwogzBX9fw==
X-Received: by 2002:a17:902:14e:: with SMTP id 72-v6mr118137plb.299.1540445346705;
        Wed, 24 Oct 2018 22:29:06 -0700 (PDT)
Received: from localhost ([175.223.22.26])
        by smtp.gmail.com with ESMTPSA id m67-v6sm7877608pfm.13.2018.10.24.22.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 22:29:05 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:29:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
Message-ID: <20181025052901.GA17799@jagdpanzerIV>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025012745.20884-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/24/18 22:27), Rafael David Tinoco wrote:
>  static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
>  {
> -	unsigned long obj;
> +	unsigned long obj, pfn;
> +
> +	pfn = page_to_pfn(page);
> +
> +	if (unlikely(OBJ_OVERFLOW(pfn)))
> +		BUG();

The trend these days is to have less BUG/BUG_ON-s in the kernel.

	-ss
