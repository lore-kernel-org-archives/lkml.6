Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C6C64EB4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031732145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBCdV1oF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031732145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbeLCCk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:40:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42117 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbeLCCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:40:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so841450plp.9;
        Sun, 02 Dec 2018 18:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qq92mQDGvJQj9XxdRfg73xbRhL+Hun2i2FsSzUaGGhg=;
        b=NBCdV1oFQ3j/3uwHhILvrHxRkIveuK9T8qRZQQa/CWyt4bZB5fu3ehyPl3LAHimyTT
         nBcPUxuXBYr15o4xnba4my9/pXfbbg2duE/JkmWt4Wu3p9KoTXNtiDi2AlRSkhUqNT+F
         UTDUt9LgjQyLGJjRwC5SXxrBYoKiuOd++XpeTXhiWO8i1UQPTynAUArgWU95/4kSOf2u
         NZN3z+C+buAWcilR2eEITXRpvyXa9wVH9rSuxhpqWcPsEXPi58f6iQeYd4QXjyNgC5yO
         JY9K/SRu8g4dBs8ACjZopklXl9gz/7TIkrUgCABbdTgXNGD2M1Cj1A1loT55qpxu+0TF
         zmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qq92mQDGvJQj9XxdRfg73xbRhL+Hun2i2FsSzUaGGhg=;
        b=SEEQGsH91YGcLbrwGC1r1scTBPN50sdKKusXhUpGpIhiEzO3pRZsDNbrDtDjZRj1k0
         JtfBRwpttfXYTZGkZFoFki2Y4mkT9T2CVCS/15aFkuPPD30SogBrA0xRhG8g8cP224gA
         tU6aMFIHOutkQVYa8uK1l2guFGN/XVEnKytJNWG6S1PLSNRU809W4gD3ikr77pTK3w3C
         qsgWOqVKLXXv2eJHxDVdQjBjfDWv+Hfnt6M34fVlFAERwo0XK0vlUx3DDhfbsBmsFIUs
         eNLBVtp+omrXolLEP6cZq4QU6SeEWLCYYs/m8Zhi18c9oNg1I6eJ/zxIJSFELstty7mA
         qK5g==
X-Gm-Message-State: AA+aEWZMv8OeAQqpfmuozDr1nfvoJF2qgUYufrR0L+ZMkKTLJpjiD8/N
        53pb21pQIJsQTtYdq/n1QPQ=
X-Google-Smtp-Source: AFSGD/VToZynD5CidDOwNGGYYavRa2LCs64xNGrElCxxDLG8vdyCTWuJUSZz75OSeAEXn2BVd6WVKw==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr13634348plp.69.1543804824087;
        Sun, 02 Dec 2018 18:40:24 -0800 (PST)
Received: from localhost ([175.223.22.143])
        by smtp.gmail.com with ESMTPSA id j70sm16651971pfc.43.2018.12.02.18.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 18:40:23 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:40:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org, nd <nd@arm.com>
Subject: Re: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Message-ID: <20181203024019.GB427@jagdpanzerIV>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-8-dave.rodgman@arm.com>
 <20181129044333.GH6379@jagdpanzerIV>
 <5b504430-fb4b-340b-66c2-1300c816cc3a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b504430-fb4b-340b-66c2-1300c816cc3a@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/30/18 10:45), Dave Rodgman wrote:
> Looking a bit more closely, these structs are formatted fairly 
> inconsistently in the crypto directory. So, lzo-rle is consistent with 
> what lzo does... but various other files do it differently.
> 
> I'm happy to submit a whitespace cleanup patch if people would like, and 
> get everything in that directory consistent (i.e. adopt a style similar 
> to the example below)?

I'm not in any position to ask you to do this; white-space clean ups
are not very popular (it's OK for staging tree; not so much otherwise).
So we better ask David and Herbert.

> static struct scomp_alg scomp = {
>          .alloc_ctx              = lzorle_alloc_ctx,
>          .free_ctx               = lzorle_free_ctx,
>          .compress               = lzorle_scompress,
>          .decompress             = lzorle_sdecompress,
>          .base                   = {
>                  .cra_name               = "lzo-rle",
>                  .cra_driver_name        = "lzo-rle-scomp",
>                  .cra_module             = THIS_MODULE,
>          }
> };

Looks nice.

	-ss
