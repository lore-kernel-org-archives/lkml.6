Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9062086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQx9bFAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9062086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbeFRP7l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:59:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39418 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932442AbeFRP7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:59:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id f1-v6so9266388plt.6;
        Mon, 18 Jun 2018 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kge+Zs8hE+X9b/l9dxCAGdzjoZa19GSIpeoZi0H+Z6c=;
        b=mQx9bFAzqvx8kuOtJzYm1gTQFSnlRSkxDUXXOE08VVr4adbvOxPGHDC+KGhL2dd7eF
         7jyDR6RZEGel8MJ9NQhVyIfVeuYTb2wtB4+avAf81rsvqKCR1+aq/yYpYAMcKpiR/8Wk
         5A/lVJD4pNUN4TxPnXzQhyIVSbCQ8RzomtKGldPH/z2pB4WW0yXKba/GIn2fvdV9QPlz
         guN8k5WzbUv/bdhXRGgBtB9hbpbppQUOouFsIk49XMAX5w23V+7mR5xj0BJt4Pkhs72m
         91xOTQj3YbEKT136/fchTTyvwrsgs5xG8aNE2wBu23Mha8hnkmLIkBaJYx8M2+aLmlBj
         5cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kge+Zs8hE+X9b/l9dxCAGdzjoZa19GSIpeoZi0H+Z6c=;
        b=FoaeZT4V9F3piRhppHkccbBS0Lwm3/VLzf9uoI/NnMVJW/8IBuDb8FYZ/5C1QXhT/l
         tDzmv+jjNGHh8450ItaMTZFc40bOwKHcYRd9oieaBAVa0QICHjyQeQXL2wlh4BHcCHs4
         H9qaFIt2Uf22scg2rLPeHXsIh5ZdtqJvDVxveR7muYV8B+G2v0/gp/wJp8bv1RuHuNZ4
         J8yv9TjT+cQe2H/18en4dkguJFX8/dNvFO7K5qL8l1WbIluaKZ9y0SVM2RpFXk1rAbDL
         OHvD2XXacXKiRaMtxzYiJehjGaHVi8iqchCIX7HYtCr1YMRN8PXEN9DLKj9lOHbcw+Y8
         kR4g==
X-Gm-Message-State: APt69E27TU4kIa6ZM+wTzD998fVigM4mdIzVv4DCUr9dvwsXM5SHRzqL
        vh4qN16ctoJY3nemV8snp5QTj1he
X-Google-Smtp-Source: ADUXVKLcGfgt8u6F/RN54jfrCRJ64+YRiN8Tnap9EgYKhLzQdxfOJmArxINdwNocIDXfeux5gcbKIA==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr14484279pls.284.1529337578404;
        Mon, 18 Jun 2018 08:59:38 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id 10-v6sm35418696pfs.111.2018.06.18.08.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:59:37 -0700 (PDT)
Subject: Re: [PATCH net-next 3/3] tcp: use monotonic timestamps for PAWS
To:     Arnd Bergmann <arnd@arndb.de>, Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Atul Gupta <atul.gupta@chelsio.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     y2038@lists.linaro.org, Michael Werner <werner@chelsio.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Florian Westphal <fw@strlen.de>,
        Christoph Paasch <cpaasch@apple.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Ivan Delalande <colona@arista.com>,
        =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180618152242.1566661-1-arnd@arndb.de>
 <20180618152242.1566661-3-arnd@arndb.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <67ebb94d-c73f-6c9f-493b-00c86f595120@gmail.com>
Date:   Mon, 18 Jun 2018 08:59:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180618152242.1566661-3-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/18/2018 08:22 AM, Arnd Bergmann wrote:
> Using get_seconds() for timestamps is deprecated since it can lead
> to overflows on 32-bit systems. While the interface generally doesn't
> overflow until year 2106, the specific implementation of the TCP PAWS
> algorithm breaks in 2038 when the intermediate signed 32-bit timestamps
> overflow.
>
...

>
>  
>  static inline u32 tcp_cookie_time(void)
> @@ -1361,7 +1362,7 @@ static inline bool tcp_paws_check(const struct tcp_options_received *rx_opt,
>  {
>  	if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win)
>  		return true;
> -	if (unlikely(get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_24DAYS))
> +	if (unlikely(ktime_get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_24DAYS))
>  		return true;
>  	/*
>  	 * Some OSes send SYN and SYNACK messages with tsval=0 tsecr=0,
> @@ -1391,7 +1392,7 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
>  
>  	   However, we can relax time bounds for RST segments to MSL.
>  	 */
> -	if (rst && get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_MSL)
> +	if (rst && ktime_get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_MSL)
>  		return false;
>  	return true;



Please use the time_after32(), since ktime_get_seconds() is time64_t while ts_recent_stamp is int.

Same remark for tcp_twsk_unique()

Lets clean up this stuff, thanks !

