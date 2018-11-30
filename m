Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E4C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F052081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUnJe+jC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F052081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeK3OMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:12:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3OMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:12:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so1847870pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 19:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjm8/1+ia9UZFWBDJ3m0SVJAbwiXDqg0s3YVtGkTV70=;
        b=pUnJe+jCps1WEfY0HMiXHckKNF5yGaUkVXLxnVmuPWuaQMLHxZ7JSUiItVKWD2pGf6
         tC0XZkYtRYmbHd+YDpS6qGMqqBxbCuK9tUoneKY4ELGRs3P9S1w2WypAcMPqUd2Z/Gsn
         srq+w3RcnZR4tYuVd5pxGINFjrDsk2Zl7fF6Kw15nOEWUWIgyjW+K/Uiwuek5W5m/HNe
         sgnndGeBARakJNeBNuwpppg0GDHb/nFcQP32whMMIXDoh3VprWhVbiPPMR93mK7jVxep
         dyXhyNv9M3abn9vNzG+ewDjTX8BIjUOBr+jGyJ2sXNqm8E9ARMVrNTzgtA0MPo8sbrST
         PHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjm8/1+ia9UZFWBDJ3m0SVJAbwiXDqg0s3YVtGkTV70=;
        b=N221KiRXbnYrzhXlXbtQ2IzM7Z93D9W2zlmMoCrRpPOh9M1olG8PG0HL36QVLeDwU1
         KHL5+O9P1KWTJ+OwdeR99YskY1U6s1lgcqBOxxVVMoA5tGSCol8KZ0qHfaR9FaG+P7sP
         N0TQ9hEXo+5K8/dFmhoSm6h6yIlWLw1qZ4Mp/IETuUnygglPnYXUTPlC3K+2G9PV3MD5
         m3M8qa5s8EZNMglOe08f6xnNjZ9T3hL2bAltEQ1DQl/yN9MIQADk1MpfUepI/rhWRJXh
         /nZleIhAg/a+JOUnXIsKKNA0dtzCK0DwnKxjZDtnqGFGfx28r1YyO4W+KQO/jYBzl461
         HVGQ==
X-Gm-Message-State: AA+aEWZjihGdSNx48Dse0r8WvaW1NmAzd3jo4UxjXCkJY7uk8dmklr6s
        yFEQxQ0DhYFklg4yazuTgoQ=
X-Google-Smtp-Source: AFSGD/U5E/nY8s+FuRg5wavxJRctPU/SIG0zQnOxB1cHBzD/GjSXL7dCyEpjQbReQ/jnhBaFmmFAJA==
X-Received: by 2002:a63:ca0a:: with SMTP id n10mr3428253pgi.258.1543547104297;
        Thu, 29 Nov 2018 19:05:04 -0800 (PST)
Received: from localhost ([175.223.39.43])
        by smtp.gmail.com with ESMTPSA id y6sm10672579pfd.104.2018.11.29.19.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:05:03 -0800 (PST)
Date:   Fri, 30 Nov 2018 12:05:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Message-ID: <20181130030500.GA605@jagdpanzerIV>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-8-dave.rodgman@arm.com>
 <20181129044333.GH6379@jagdpanzerIV>
 <293c53a6-3313-359a-c5d0-2e2fa453494a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293c53a6-3313-359a-c5d0-2e2fa453494a@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/29/18 10:21), Dave Rodgman wrote:
> > [..]
> >> +++ b/drivers/block/zram/zcomp.c
> >> @@ -20,6 +20,7 @@
> >>   
> >>   static const char * const backends[] = {
> >>   	"lzo",
> >> +	"lzo-rle",
> >>   #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
> >>   	"lz4",
> >>   #endif
> > 
> > [..]
> > 
> >> +++ b/drivers/block/zram/zram_drv.c
> >> @@ -41,7 +41,7 @@ static DEFINE_IDR(zram_index_idr);
> >>   static DEFINE_MUTEX(zram_index_mutex);
> >>   
> >>   static int zram_major;
> >> -static const char *default_compressor = "lzo";
> >> +static const char *default_compressor = "lzo-rle";
> > 
> > OK, so it's not just "separate lzo-rle", it's also "switch zram to
> > a new compression algorithm by default". I'd say that usually I'd
> > expect this to be separate patches.
> 
> Yes, fair point. akpm has picked this up now though, so probably a bit
> late to break it out into a separate patch?

Andrew accepts patches to patches, and patches to patches to patches, etc.
He is very flexible :)

I don't have a very strong opinion. Would probably be better to split
it, tho. Let's hear from Minchan.

	-ss
