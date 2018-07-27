Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26960C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD092089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLVL0QAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD092089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbeG0NOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:14:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42880 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbeG0NOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:14:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so2220812plo.9;
        Fri, 27 Jul 2018 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hxJwWDR0hDUb7YEBpzHPvooLfs601E5bzOEHzuDPbY4=;
        b=tLVL0QAzuVMeFLV1gPdJM9Ql9b/cp9/7xeVMhgta2y0ihH8RkTPbHQNphrIPEqT7Hw
         i/9dVWfYRgYshXyczLEFvLi98TC+Uipwc2tr0rZLRv/rbJNgjNtOWVK5WFz61v8a9tMa
         ratWOgtWrWJGp+1b+aNT/B2TxC2uJIFOclZK3ZyaX5v/9AIE9943vFuyX409Komtpm59
         zYb9fQLq50mUFrTh6zJ+CQxu0SYMHQ8f+Cq9pGvXXg9lWgEkZLGpKxVEtHJuX/xzPkbV
         uL/Vdge/TL4xOBjbMLA6jVDOgzIli01KoshtBIxspzQw6sUzSEuCSoQJB/jPwQmGR5wr
         NRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxJwWDR0hDUb7YEBpzHPvooLfs601E5bzOEHzuDPbY4=;
        b=NGwV0XPx8dW6bAS1QH8OqPuTY+XwxKlBe5Z3Blzl/XRXzxn87qdYHNirV5rY9lbmaM
         sNpL128xCqAf0wPlTPc8HRFGdRA0aNTD4RnVGXgPvH4w0whK/htJ7EHEQ3irN7Aos0h2
         Mj9XcHDQjIR1A+Fq7zcG/KpobBH+LMpHoAxY1GhEFx3iFzLJgLMcuHrNiM4fxD516XHI
         Q55fVSXChSqHEGvuKeZv+aNcllHXjQEDE9sOymbeSFDK6YY7Pem8+JUm5CrztUdXo+QI
         o18kPlZmi1Lb5JviSqb2yiu6+n3Vs4GPcuyr6jkDJS6OGbbodn+eWUL+ORJdt+WbNyIA
         HrUA==
X-Gm-Message-State: AOUpUlEd9UwvU1NC/aPk1uEvXDtvgcrhh4l5mldd0QGkjzlAxfGyWHMv
        LwQRVYcxsLcqEz3E715mL2yAg6gh
X-Google-Smtp-Source: AAOMgpcohS40q06n5QIqFwqAoTVF1mONTmpwyCZ9dFmKvD59VmsdoB+hf/jj14cqgONM/ZfGm0iezg==
X-Received: by 2002:a17:902:a5cb:: with SMTP id t11-v6mr5742204plq.71.1532692348010;
        Fri, 27 Jul 2018 04:52:28 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id j5-v6sm5750546pff.139.2018.07.27.04.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:52:27 -0700 (PDT)
Subject: Re: [PATCH] net/rds/Kconfig: RDS should depend on IPV6
To:     Anders Roxell <anders.roxell@linaro.org>, davem@davemloft.net,
        santosh.shilimkar@oracle.com, ka-cheong.poon@oracle.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20180725222008.32186-1-anders.roxell@linaro.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <68f68676-0d91-125f-5697-31cc459ab24e@gmail.com>
Date:   Fri, 27 Jul 2018 04:52:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180725222008.32186-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2018 03:20 PM, Anders Roxell wrote:
> Build error, implicit declaration of function __inet6_ehashfn shows up
> When RDS is enabled but not IPV6.
> net/rds/connection.c: In function ‘rds_conn_bucket’:
> net/rds/connection.c:67:9: error: implicit declaration of function ‘__inet6_ehashfn’; did you mean ‘__inet_ehashfn’? [-Werror=implicit-function-declaration]
>   hash = __inet6_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
>          ^~~~~~~~~~~~~~~
>          __inet_ehashfn
> 
> Current code adds IPV6 as a depends on in config RDS.
> 
> Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to struct in6_addr")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  net/rds/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/rds/Kconfig b/net/rds/Kconfig
> index 41f75563b54b..607128f10bcd 100644
> --- a/net/rds/Kconfig
> +++ b/net/rds/Kconfig
> @@ -1,7 +1,7 @@
>  
>  config RDS
>  	tristate "The RDS Protocol"
> -	depends on INET
> +	depends on INET && CONFIG_IPV6

You probably meant :

        depends on INET && IPV6


>  	---help---
>  	  The RDS (Reliable Datagram Sockets) protocol provides reliable,
>  	  sequenced delivery of datagrams over Infiniband or TCP.
> 
