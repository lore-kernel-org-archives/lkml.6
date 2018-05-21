Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeEUPRY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:17:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35418 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeEUPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:17:13 -0400
X-Google-Smtp-Source: AB8JxZoPE27k8peo3yyajNVKnMqwUjXwh3KRoGX/sfRgUgHO+nkviomu6Gsgg2GG6DZrTOFw6JLZ4A==
Subject: Re: [PATCH] bpf: check NULL for sk_to_full_sk()
To: YueHaibing <yuehaibing@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20180521075558.11968-1-yuehaibing@huawei.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5490b571-7881-c5eb-6acf-8f45634cd2b1@gmail.com>
Date: Mon, 21 May 2018 08:17:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180521075558.11968-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2018 12:55 AM, YueHaibing wrote:
> like commit df39a9f106d5 ("bpf: check NULL for sk_to_full_sk() return value"),
> we should check sk_to_full_sk return value against NULL.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/bpf-cgroup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 30d15e6..fd3fbeb 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -91,7 +91,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
>  	int __ret = 0;							       \
>  	if (cgroup_bpf_enabled && sk && sk == skb->sk) {		       \
>  		typeof(sk) __sk = sk_to_full_sk(sk);			       \
> -		if (sk_fullsock(__sk))					       \
> +		if (__sk && sk_fullsock(__sk))				       \
>  			__ret = __cgroup_bpf_run_filter_skb(__sk, skb,	       \
>  						      BPF_CGROUP_INET_EGRESS); \
>  	}								       \
> 

Why is this needed ???
