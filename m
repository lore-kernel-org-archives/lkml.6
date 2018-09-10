Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BF1206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9AXdQ8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BF1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeIJNOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:14:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51330 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeIJNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:14:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so20543267wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=miz7XwqkZXD9bwwd32bMIsO+A1YK7OSx6uIiBliy004=;
        b=X9AXdQ8dIEAerEND9S5GuczQJQeTR0XSwNpeXZnd+wFC3pqB/6w/LXwvCclfZ5qGIr
         VRPNB7d7cIOCtCZrqXJ2ZqtKgi1lbffDuO4vo5eZbmIruiztPDPh0+pBMED3h1uNgh4a
         dmEIvM/zq1NAzYn9MUDKfVraY2cck1njxjgJAeKyoQ2duG3XpQeuGRvaQstulWAAHeKI
         KaJLdLIQieSIsfn7BSnLueu7OuMsAovXRp1d/KLGoIW7FhXFc9wY7rnV9UO82oF/V7J/
         DgFACz1SuPNt2zzQqQVhK+V69UfkfcqxwRiHInWAxVp2N/FAI9jFDSHr3I/+kzNYbBrr
         DKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=miz7XwqkZXD9bwwd32bMIsO+A1YK7OSx6uIiBliy004=;
        b=lOhysC7SSaYNnTpi20jGXEmQZP1a0uhQquhrVW+w6TX6fjRlYI0ssa5HbSXcP470+r
         GFVddhdQOfhVI+aR63DyoCbVXjL7PuK3LPA2DXc9lj2Btx6rn0fJAmbZMkpLe7npOeem
         HLgkZigSuVZTHSnL9RR/QtXJyNpyNhdDsgZeAUiV0Cufksvr1qZ6EjPrStlIsSixkcxW
         X7OYxbqBG6SFOB5JwjI8GqKsIichMZK0iRgqecLzrbO6XEcdT82Wdv8hibEncUGYiOg0
         rifebHUqKA5s2Br3OUMjc3yl93d6Q5SkGBgsHtjEcHuWD0IgHucdjVWPbtJTxcVONM/9
         4heA==
X-Gm-Message-State: APzg51BQEKWztfDAWLJnCA4MC24Rmv8+s/xDRPNG9iFUb+SeWtEStOaU
        wzo2Mu+raHi5FfB7KhXjnUA=
X-Google-Smtp-Source: ANB0VdZN0ZMJdjj4+QSoaRNhYJc7U0AQSRmeZF+7f7KGtNSjxL2ICLIQKalvciTMQu4ILj86Uh+uqw==
X-Received: by 2002:a1c:938a:: with SMTP id v132-v6mr12607646wmd.114.1536567674203;
        Mon, 10 Sep 2018 01:21:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f18-v6sm15022358wrw.32.2018.09.10.01.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 01:21:13 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:21:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
Message-ID: <20180910082111.GA48257@gmail.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Morten Rasmussen <morten.rasmussen@arm.com> wrote:

> The SD_ASYM_CPUCAPACITY sched_domain flag is supposed to mark the
> sched_domain in the hierarchy where all cpu capacities are visible for
> any cpu's point of view on asymmetric cpu capacity systems. The

>  /*
> + * Find the sched_domain_topology_level where all cpu capacities are visible
> + * for all cpus.
> + */

> +	/*
> +	 * Examine topology from all cpu's point of views to detect the lowest
> +	 * sched_domain_topology_level where a highest capacity cpu is visible
> +	 * to everyone.
> +	 */

>  #define SD_WAKE_AFFINE               0x0020  /* Wake task to waking CPU */
> -#define SD_ASYM_CPUCAPACITY  0x0040  /* Groups have different max cpu capacities */
> +#define SD_ASYM_CPUCAPACITY  0x0040  /* Domain members have different cpu capacities */

For future reference: *please* capitalize 'CPU' and 'CPUs' in future patches like the rest of 
the scheduler does.

You can see it spelled right above the new definition: 'waking CPU' ;-)

(I fixed this up in this patch.)

Thanks!

	Ingo
