Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F5AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41FF208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYEUSNMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41FF208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeGPQ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:26:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37903 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeGPQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:26:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id v15-v6so6489335pff.5;
        Mon, 16 Jul 2018 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09zSuwGrVUb+Tv8WWFSr49gOMfXtRZgCQmlurziTdKo=;
        b=uYEUSNMDTMV1WW10o7EEc+KvvAoUFvEIH3nu8cGDA/JqswNXaNIH9gIZL3OeMP57ax
         akPMbVcsFvtsj4HSu3IUAppFw8VzkH28cUKceT6nLZJxNbQS8zRM8FgT/VYIN7QQjx+2
         10lx5FDR8v4dzKIfJlROrFKmqXPjpMXckzJoOO2vOhlxVtTGyOgMfEjwKTJ6pP2J+t4R
         1jLOb2m+edj5swt590V3BxmixxHujgIYCZtdzdEVA+aRCwOREvjRt35rYyO3ecBMVQLg
         m5Glrelr1GgLbnl1mpkzoXKWd2HztzUeiDwUJrJDa7KzdRyYoPXhWrnb3D5TYXP8US4F
         QuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09zSuwGrVUb+Tv8WWFSr49gOMfXtRZgCQmlurziTdKo=;
        b=YqD72RpxX4fg0UP4B7/f0E74/ssfLTuUuEmKBrAj6d9qN+pGgaGXFybp0IR7E7GJH1
         xMp0yEPIkJcf9ii9jw/PaSN52R4x8mZUMn0eq01yC7aix3JIY+vxlEzbC1J0Ch+0CkH5
         aDzZFISJLdBqEHLKn3mcSUbLXrAN2QaJglFlswi0WqDxvUIfsCd6MFmW7gEhsYfpZb9M
         LJ/why+sVH4B8/vJKLJvwYJhvIWPSWwOFAaNPcCxZieDycRafGe6fQymTDKMb/MSLMbG
         CZtPhaw1YBzSel90lifgxRrMq44CGAH7V73Bc7Siys+xtSZrf3dU4w27hLs2sdjfJh4v
         2VkA==
X-Gm-Message-State: AOUpUlF+oQBuRP4yXAE7rw8L186ARf1zSMZAgUma4UDYLeYVLIHuntga
        k6WUZyc+tuSY2ezQZx/Mtp4=
X-Google-Smtp-Source: AAOMgpewk0JU8P70cwpC3BhMyLpkDiCdnrQlCZ4idW5gcE6eMjvsakJjMewdP6tZuIzFEL2GVraSSQ==
X-Received: by 2002:a63:a44a:: with SMTP id c10-v6mr15869675pgp.198.1531756706316;
        Mon, 16 Jul 2018 08:58:26 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id q28-v6sm69936391pfg.144.2018.07.16.08.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 08:58:25 -0700 (PDT)
Subject: Re: [net-next, 2/3] tcp: convert icsk_user_timeout from jiffies to
 msecs
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180713000241.17608-1-jmaxwell37@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1f74d1b6-d404-dd18-5d8b-a08529599126@gmail.com>
Date:   Mon, 16 Jul 2018 08:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180713000241.17608-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2018 05:02 PM, Jon Maxwell wrote:
> Create a seperate helper routine called tcp_retransmit_stamp() as per Neal 
> Cardwells suggestion. To be used by the final commit in this series and 
> retransmits_timed_out().
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
>  net/ipv4/tcp_timer.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index fa34984d0b12..8ab8c9645294 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -22,6 +22,20 @@
>  #include <linux/gfp.h>
>  #include <net/tcp.h>
>  
> +u32 tcp_retransmit_stamp(const struct sock *sk)
> +{
> +	u32 start_ts = tcp_sk(sk)->retrans_stamp;
> +
> +	if (unlikely(!start_ts)) {
> +		struct sk_buff *head = tcp_rtx_queue_head(sk);
> +
> +	if (!head)
> +		return 0;
> +	start_ts = tcp_skb_timestamp(head);
> +	}?


Indentation is fuzzy.

Can you send a new version, with a cover letter ?

git format-patch -o ../output --cover-letter --subject-prefix "PATCH net-next" origin

...

Thanks !
