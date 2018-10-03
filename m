Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36CAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522C213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INnU9bNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7522C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJCWaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:30:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37439 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:30:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so1752958pgq.4;
        Wed, 03 Oct 2018 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rOSOJRmEP7qKdxzO+HTC72SVlqpsUVbiWKPUAvly+C0=;
        b=INnU9bNk8bMHO2/CTIwV7yZArShcgWq5zWKB2oPM98AhhSMa6jCD+sGf7jEv9/DFwk
         ubs8+biQFLXk8plluDS+RutsnhHgDoWMnDwHAQrgulkMNVEqkl2H42T+fJbJV9nrMSFp
         BsJozFhH1i03C0x1vAn3z/lF/rWzJ++X6FN3I482x8I34WWlaYYbXqccedE8raRk4w9G
         RY49TBXOg71EQBbqG4n78HASYLzZMXaY6ekMl7OTzdDQRnNB+DuKDWIn8PBdGCJbWR7X
         QiMkTrlQeT+U5HDPUgYPXoS+ARa1QqoYwunXn35v1jH9S8PFYj4w+g6+p0Rgp842Hh1D
         v54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rOSOJRmEP7qKdxzO+HTC72SVlqpsUVbiWKPUAvly+C0=;
        b=esPBX+hQoKpWFEGD148OIPxVdjZEher3EbgFmCglzM9b8BW77nmzIfFL6o7LxVlHzW
         pq9k8I69+oZhwKRoZjy4iVuM+2JCIKHKpSuXQDjv4LCGV+CWdCHtNunxZyN7SnRZ3atK
         dP4QFDVUvwE6x/q7yqK8y01CjP0vBZJmsnU2DV3+mSB011FE8lohXxo6Wax1Rd6dcp6o
         ekO+be1Cc3o0DRVzUyPjCKix2loZebhOU9CEhrq/0QYUz2hAmGzm9gEhaYpgydvdrZen
         MXE8rZ3I98E0XJDFUVz0B0Dur9LzQJsc6QR4hsRCm0/JyfHRkq35Gw9X1cynkpj25Ee9
         zODA==
X-Gm-Message-State: ABuFfohVdiuI39sOA7QV5R750ecpXIr1ZmmYmI5ZeCFHfTaPplC/1ek0
        yJpQ1KlAwsclr3rjagMvstGSn1Eu
X-Google-Smtp-Source: ACcGV6144TrblwnPKd+iHXDQl3HW49Blceb2J3xrQQbiAQCPyQnKMON9ABwN2/u4B+k0X7Q9zRe15Q==
X-Received: by 2002:a65:5188:: with SMTP id h8-v6mr1905329pgq.288.1538581274699;
        Wed, 03 Oct 2018 08:41:14 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id 70-v6sm3440866pfz.27.2018.10.03.08.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:41:14 -0700 (PDT)
Subject: Re: [PATCH net-next] inet: do not set backlog if listen fails
To:     Yafang Shao <laoar.shao@gmail.com>, edumazet@google.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538579279-11614-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9863d8b1-7249-e5ec-0400-4007798e69e2@gmail.com>
Date:   Wed, 3 Oct 2018 08:41:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538579279-11614-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2018 08:07 AM, Yafang Shao wrote:
> These two backlog members are not necessary set in inet_csk_listen_start().
> Regarding sk_max_ack_backlog, it will be set in the caller inet_listen
> and dccp_listen_start.
> Regraing sk_ack_backlog, it is better to put it together with
> sk_max_ack_backlog in the same function and only set on success.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/dccp/proto.c                | 1 +
>  net/ipv4/af_inet.c              | 1 +
>  net/ipv4/inet_connection_sock.c | 3 ---
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/dccp/proto.c b/net/dccp/proto.c
> index 875858c..34d48cd 100644
> --- a/net/dccp/proto.c
> +++ b/net/dccp/proto.c
> @@ -959,6 +959,7 @@ int inet_dccp_listen(struct socket *sock, int backlog)
>  		err = dccp_listen_start(sk, backlog);
>  		if (err)
>  			goto out;
> +		sk->sk_ack_backlog = 0;


This is racy, remember that dccp and tcp have lockless listeners.

Do not change sk_ack_backlog after a TCP/DCCP socket is ready to accept new flows.
