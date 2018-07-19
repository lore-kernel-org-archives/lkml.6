Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC9FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E698520673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zu6Oh7qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E698520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbeGSOou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:44:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52562 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbeGSOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:44:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so6327518wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0esw3hM68QSW8K9UtNDGX/kDURh+Gkg72W0bd3uugY=;
        b=zu6Oh7qruqoa0AZrkd6H5bBx7JCTwhghjzxiE5zeRjy9qUctD8+m6ztYwAcHINuooM
         xbmfHTPgT4xk9SMMeuTYlDxWxCBsLvfjAe4gKtVTBlTiwURTAAzG6iiQUC9YTBITuQNt
         8K3WvJ3fCcvkVfm7u8gd/HEDLbAFcivFuADEci+BiYWCalgBCtbuk0zDL7/QmHFJO+Vu
         X4+OeV8+4PT+sXcinpRWsl6lgm9naeCeCJNpk4mk3frv4/OuHZUEwZiLBSf335nFF2fI
         yAlo0VN+PtCY3OhHDJY+/Lx57V4plrzqhOKDRE9YBq63PstKPkHwTmvDFziuqDq1DVdX
         He8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g0esw3hM68QSW8K9UtNDGX/kDURh+Gkg72W0bd3uugY=;
        b=KFmbDxeK59x3EOt5l57ZVoyCzV+urFXz6IUgU+wZ5wRIQ24zdwQqqALg4G7sxL+IR2
         gtvwtIUTpx/couIxO1KHJVOO++g7FIXkmrc5Ehzr7sLULuwyQCeF8aqZshMXP4RlcXbP
         FCd+wOa862KnqZMVXAXpKllujnlACMgP613V593JDnXggvQHV3/O5zYk4i23UfwaQR9s
         eMflcGlJ1kkQ6mLIge1h+jQ92ioPljFFse00FTqUTRm4ME+s6zDYNFG7jANjAlZZAljk
         a6Q6Sr9jKrnZO5EZp55/9MjBuMjZ8+jVMBRNx18WDMD1x6P7PPwm4kr/tqhAkksdiHoa
         EX0w==
X-Gm-Message-State: AOUpUlHKXlDyUz2Uhy7CYYuP6VSbiJHXVqprSQMLl4B+3ZguO+wMF+qs
        gwb7HwcpozVMK5cAptc7uQVMHw==
X-Google-Smtp-Source: AAOMgpdsIKg+Ve+XjJan45JBynRlEVXPNnrc8HnwxY9IP3BXwUXUir3dSsgUqJSmPsScJoQG9N+zoA==
X-Received: by 2002:a1c:647:: with SMTP id 68-v6mr4531600wmg.82.1532008888776;
        Thu, 19 Jul 2018 07:01:28 -0700 (PDT)
Received: from [172.20.1.93] (host-79-78-33-110.static.as9105.net. [79.78.33.110])
        by smtp.gmail.com with ESMTPSA id f2-v6sm5918481wre.16.2018.07.19.07.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 07:01:27 -0700 (PDT)
Subject: Re: [PATCH] bpf: synchronize bpf uapi header with tools
To:     Taeung Song <treeze.taeung@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>
References: <20180719125355.26441-1-treeze.taeung@gmail.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <77e00498-74ae-1ee5-8f4b-ad8b3c5f8929@netronome.com>
Date:   Thu, 19 Jul 2018 15:01:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719125355.26441-1-treeze.taeung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taeung,

2018-07-19 21:53 UTC+0900 ~ Taeung Song <treeze.taeung@gmail.com>
> To pick the change in:
> 
>   4c79579b44b1 ("bpf: Change bpf_fib_lookup to return lookup status")
> 
> This bpftool build warning occurs:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>  tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 59b19b6a40d7..b7db3261c62d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1857,7 +1857,8 @@ union bpf_attr {
>   *		is resolved), the nexthop address is returned in ipv4_dst
>   *		or ipv6_dst based on family, smac is set to mac address of
>   *		egress device, dmac is set to nexthop mac address, rt_metric
> - *		is set to metric from route (IPv4/IPv6 only).
> + *		is set to metric from route (IPv4/IPv6 only), and ifindex
> + *		is set to the device index of the nexthop from the FIB lookup.
>   *
>   *             *plen* argument is the size of the passed in struct.
>   *             *flags* argument can be a combination of one or more of the
> @@ -1873,9 +1874,10 @@ union bpf_attr {
>   *             *ctx* is either **struct xdp_md** for XDP programs or
>   *             **struct sk_buff** tc cls_act programs.
>   *     Return
> - *             Egress device index on success, 0 if packet needs to continue
> - *             up the stack for further processing or a negative error in case
> - *             of failure.
> + *		* < 0 if any input argument is invalid
> + *		*   0 on success (packet is forwarded, nexthop neighbor exists)
> + *		* > 0 one of **BPF_FIB_LKUP_RET_** codes explaining why the
> + *		*     packet is not forwarded or needs assist from full stack
>   *
>   * int bpf_sock_hash_update(struct bpf_sock_ops_kern *skops, struct bpf_map *map, void *key, u64 flags)
>   *	Description
> @@ -2612,6 +2614,18 @@ struct bpf_raw_tracepoint_args {
>  #define BPF_FIB_LOOKUP_DIRECT  BIT(0)
>  #define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
>  
> +enum {
> +	BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */
> +	BPF_FIB_LKUP_RET_BLACKHOLE,    /* dest is blackholed; can be dropped */
> +	BPF_FIB_LKUP_RET_UNREACHABLE,  /* dest is unreachable; can be dropped */
> +	BPF_FIB_LKUP_RET_PROHIBIT,     /* dest not allowed; can be dropped */
> +	BPF_FIB_LKUP_RET_NOT_FWDED,    /* packet is not forwarded */
> +	BPF_FIB_LKUP_RET_FWD_DISABLED, /* fwding is not enabled on ingress */
> +	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
> +	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
> +	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
> +};
> +
>  struct bpf_fib_lookup {
>  	/* input:  network family for lookup (AF_INET, AF_INET6)
>  	 * output: network family of egress nexthop
> @@ -2625,7 +2639,11 @@ struct bpf_fib_lookup {
>  
>  	/* total length of packet from network header - used for MTU check */
>  	__u16	tot_len;
> -	__u32	ifindex;  /* L3 device index for lookup */
> +
> +	/* input: L3 device index for lookup
> +	 * output: device index from FIB lookup
> +	 */
> +	__u32	ifindex;
>  
>  	union {
>  		/* inputs to lookup */
> 

This has been updated in the bpf-next tree already, see commit
9b8ca3795199 ("tools: bpf: synchronise BPF UAPI header with tools").

Best regards,
Quentin
