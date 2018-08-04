Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB16DC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B60217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phpRH/cI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B60217CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeHEBXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:23:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40431 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHEBXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:23:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so10326290wma.5;
        Sat, 04 Aug 2018 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEZ5Ryle6taSFs08GCvHG15UEeJCFWp9DkfVejQPBsw=;
        b=phpRH/cI0nCkCVPKWeXepU5ncFhFDuJf9Tw73/W41pzJwsGGhoFX5rQNI+KxHytoU0
         avCvvnWvJ+TScD4QoNREM4nBN4ZHoy5BJtWrAPp4ba/FcFlCraPuedfw2Uo3QHR+jahV
         gVZNbdQP/iRMgNg3RRIwbZSlzbofgU6U1DZI/bM2yfTfJqG27/BMENfTiOJb4bdjoPux
         iKdwr/Bc+ba7vc4CykvIo4b5n4Sf1LrT0eBOPGSUbP6NMWud01K/uCMPZHQc2r/8/9jH
         o/M3+GgsGO6+rLxSPgXPrs0vCdNDfKpopq7flAo8RdGyZXxI0HxA6LZJ3XVXY3UWbzAQ
         iv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEZ5Ryle6taSFs08GCvHG15UEeJCFWp9DkfVejQPBsw=;
        b=AjbWFwSmpLPwGyoSfuFQOOoVzu2OSuabTBiUt/s5tz97XcFMVOli7dX8tXlLiiCPQe
         jjz6rHaD4hR4SJ2HYol7Q8jMU2mt1k3gx3wE3Sm6JgcivDYBunvA7BAMMWlbNrFDcHvI
         OoJfZQ2U4eAB659dcW5QldnVLf7GyIFrUzrVI/O0ZySEa3x/Ty/r1JMKdJjZ70MCt8cw
         9UpezQxhRd/XZjFpBJPl9etEdQ3MjG1eB7Buno55kO4/h1IJDez4kErXQPz/yXIbR18F
         2/VQweGYX2jMfy2pfJrhs/3j8x2c0Iw9usY9xEBkQoNrnjKOmUqKAT6DwhgLAcXrDu/R
         0dpQ==
X-Gm-Message-State: AOUpUlEiy1SPP6S+OfApOZWejzew+uEMhKHcV07RVGEZH59bxczTJdQt
        6NQc45EQeOckndoH/0mJhWcsuWChSojUvQ==
X-Google-Smtp-Source: AAOMgpcDapHZF31U8Dwd4v/KrEvyFxZKGYPk9mz3Ltehp6xVctfPBy9JntOQ4+H+9hSv4YkeOQoyBQ==
X-Received: by 2002:a1c:80b:: with SMTP id 11-v6mr8724770wmi.125.1533424864846;
        Sat, 04 Aug 2018 16:21:04 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g10-v6sm6884047wrv.90.2018.08.04.16.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 16:21:04 -0700 (PDT)
Date:   Sat, 4 Aug 2018 16:21:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
Message-ID: <20180804232102.GA3982@flashbox>
References: <20180804082702.434482435@linuxfoundation.org>
 <20180804082706.427556290@linuxfoundation.org>
 <20180804180734.GA25546@flashbox>
 <1533422007.2679.141.camel@arista.com>
 <20180804224956.GA5384@flashbox>
 <1533424322.2679.144.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533424322.2679.144.camel@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 12:12:02AM +0100, Dmitry Safonov wrote:
> On Sat, 2018-08-04 at 15:49 -0700, Nathan Chancellor wrote:
> > dmesg output attached, please let me know if you need anything else.
> 
> Could you try with this diff instead?
> It looks like, I'm too bad with shifts and shifted for 64 bytes.
> 
> -- 
> Thanks,
>              Dmitry

> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 7d860a22e5fb..b78bb7dc06fe 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1011,7 +1011,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
>  
>  	if (nlk->ngroups == 0)
>  		groups = 0;
> -	else
> +	else if (nlk->ngroups < 64)
>  		groups &= (1ULL << nlk->ngroups) - 1;
>  
>  	bound = nlk->bound;

This fixed my issue. If needed:

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the quick response!
Nathan
