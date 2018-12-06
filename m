Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247B220838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ywF/gaOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247B220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeLFLJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:09:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFLJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:09:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so62201wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 03:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vQbr0F5I1N19hJ3J2dfIpkjXW6EPS8xeKLa9XMbzeQs=;
        b=ywF/gaOR6YqD3NDP4tk0RqvOMbvV6bwUNpqao3kbKZGZAXClhxIQ4qVFlEnXqK7iYQ
         7sVT8IJqriEAKUtRtuBlkVBPXbzyqNYug7gJhFC+dpkSS8KvLETNCozJKJEqF5yDZq8/
         axZRLW39q0tnmHV4DX5GmPpheI3dVU17KnES2ZKWV5qGhH7EDNaRSr95v5LJMpMoBwP7
         AkOl1GK+enpYOqwWyorDsCbkncc354kqsu/q9bmA5H5xbHAQYhkC2fjZ3xoFAX/V5zsn
         Gs5BltPxWucrr0RecZ8QIAuVJRWjTy/SqxzqG5HMMEXC2uUtjPF3XTjlEVTCkBU7IErw
         lT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQbr0F5I1N19hJ3J2dfIpkjXW6EPS8xeKLa9XMbzeQs=;
        b=siACopiyUS6m0VJfYaZJ2aAXeW2aB0GUUD98DGdqzNj0u1292uUGiR83NwVAAKmKGA
         5TXSfS5V9T8fFeYsEzxeAY7MdbhtPJtte6FguzLzXFRyRTXepVHYV6sR2+nP0DDg5zLW
         QUORRAlaG4dUFviMNhdHxX3OPoGjfjXth/1TzMXQpoWJi5C3dvtGNBdE38tZvhKRhBSy
         pI6eQvuDU5hRQDM6NzI8wFsQGHgjr/Zh8DyZqfpJt4Me9MoA78mJ/jjF95ktjR4dlYs1
         sQYSUp+amuvgGcEKSU73CCNi3zPXfCuwl3RVqpaN/ZPoIN+3SUzXOAxvn/3Wo0ee6h90
         gUcg==
X-Gm-Message-State: AA+aEWYTMWOn8C+P2uyK7RfX0vy/VbKXVVfHMnG22XGhs+humqT7JpPY
        uGhm/YkbGXsAfspZDmlYIum8Zw==
X-Google-Smtp-Source: AFSGD/Vm/Cr7rgcCOcIWbDOibQKduCPpmCx54NX0t/+TXCncnk8VjW5pOZPcU3yvPIg1gu3uXQ89CA==
X-Received: by 2002:adf:9591:: with SMTP id p17mr25992599wrp.224.1544094540828;
        Thu, 06 Dec 2018 03:09:00 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w12sm75900wrr.23.2018.12.06.03.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 03:08:59 -0800 (PST)
Date:   Thu, 6 Dec 2018 12:08:57 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        nhorman@tuxdriver.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: Implement a generic crypto statistics
Message-ID: <20181206110857.GB12268@Red>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-2-git-send-email-clabbe@baylibre.com>
 <20181206000458.GA209772@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206000458.GA209772@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:04:59PM -0800, Eric Biggers wrote:
> Hi Corentin,
> 
> On Wed, Sep 19, 2018 at 10:10:54AM +0000, Corentin Labbe wrote:
> > +int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb)
> > +{
> > +	struct crypto_alg *alg;
> > +	struct crypto_dump_info info;
> > +	int err;
> > +
> > +	if (cb->args[0])
> > +		goto out;
> > +
> > +	cb->args[0] = 1;
> > +
> > +	info.in_skb = cb->skb;
> > +	info.out_skb = skb;
> > +	info.nlmsg_seq = cb->nlh->nlmsg_seq;
> > +	info.nlmsg_flags = NLM_F_MULTI;
> > +
> > +	list_for_each_entry(alg, &crypto_alg_list, cra_list) {
> > +		err = crypto_reportstat_alg(alg, &info);
> > +		if (err)
> > +			goto out_err;
> > +	}
> > +
> > +out:
> > +	return skb->len;
> > +out_err:
> > +	return err;
> > +}
> > +
> > +int crypto_dump_reportstat_done(struct netlink_callback *cb)
> > +{
> > +	return 0;
> > +}
> 
> How did you test this part?  Hint: these functions are never executed.
> 

Right, it is not used, only crypto_reportstat is used by the getstat.c example tool.
And for using it, I need to do changes in crypto_user_rcv_msg().
But I am not sure if it is interesting to do so.

So I will send a patch for removing it.

Regards
