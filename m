Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A27C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE502084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEelePge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE502084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbeGSPFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:05:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeGSPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:05:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so3904703pgp.11;
        Thu, 19 Jul 2018 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLQF/Rr3CcrUgKUwqEEy4FdbYdVvg6yrQ1ObadMgpzs=;
        b=PEelePgeNZxC9yaDkGqyTFMKkNNrGUymB1aE2i10+Bp9XOD6eLDc9tCvknTKVsNytd
         oOVO/GEXDgMrYVg50V3Iz5UvKdDJfuEDrQ2LbvwJXx23MR4NtmALHp1mt1Y/mHaddTK3
         1jmmRAy60mhUmY/XpAfstPSWWgru14z/j6Dlrj/xSPrhiacKzzuV6Nhe8ehgUiPUScCX
         4XHu83xpheKnGbxsUdeLGxbGXLxI9s5e5qBQhcUXVY+YgP/xiEqduAcLgo0wu6eJ3j0b
         09FyAJV2fXgMXdQLQilQaekQw1hMItKxftTRMpeOzUmbjTkHI4u3gaI54FO9pBiYbzVw
         P0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLQF/Rr3CcrUgKUwqEEy4FdbYdVvg6yrQ1ObadMgpzs=;
        b=RT/oNpdDDSWL/Q6Cc2BnJ7XJgHXrJ+8rDEKptEoPykafyg4S9UTOq3OCkhw9u7PJ5P
         ikSMwYYUGuci2seqKgC59Xitse+xDLDlCR/6T8ZcdKyd8lzf6Z+ZlGLa8F6sl392Mp1A
         MMsGbNyEhdACbKh/dmABH0GOe/gPokpqiSu+t0zvI1rXab2xyNGIk4otfp7jdA9xicO+
         le+77Us3Mnn24rumDyzjHrifeLfKNHusuO8MAsAjU4n8RrWLrl2LWIJ+lceeZJMO7lZM
         sZws+MRchQdpFqt47KGShPPDpVN23eEsIaCuIob85QNgZiUb+patOmazxqjxg46qbMYZ
         Ky/w==
X-Gm-Message-State: AOUpUlErZZDKm+t3dPpKiRA/hb8rDBcaKnwYItmSEom6LtacTcydNm+z
        PDxo8/uIeAYAx4J20iHWQ9CVB1r1
X-Google-Smtp-Source: AAOMgpdTdwjf/p1KV+0CyZ6XbZN6KcWEMDLAb7GylaHT8Zpb8UP+EqqY71B8QCudrzuARH3EZvkz3Q==
X-Received: by 2002:a62:3a5b:: with SMTP id h88-v6mr9805677pfa.61.1532010112521;
        Thu, 19 Jul 2018 07:21:52 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id t69-v6sm1494086pfj.7.2018.07.19.07.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 07:21:51 -0700 (PDT)
Subject: Re: [PATCH] bpf: synchronize bpf uapi header with tools
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>
References: <20180719125355.26441-1-treeze.taeung@gmail.com>
 <77e00498-74ae-1ee5-8f4b-ad8b3c5f8929@netronome.com>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <92fb6df6-e631-eba5-a7b3-f6d7173988fb@gmail.com>
Date:   Thu, 19 Jul 2018 23:21:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <77e00498-74ae-1ee5-8f4b-ad8b3c5f8929@netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 07/19/2018 11:01 PM, Quentin Monnet wrote:
> Hi Taeung,
> 
> 2018-07-19 21:53 UTC+0900 ~ Taeung Song <treeze.taeung@gmail.com>
>> To pick the change in:
>>
>>    4c79579b44b1 ("bpf: Change bpf_fib_lookup to return lookup status")
>>
>> This bpftool build warning occurs:
>>
>>    Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
>>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: David Ahern <dsahern@gmail.com>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>> ---
>>   tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++++++-----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 59b19b6a40d7..b7db3261c62d 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1857,7 +1857,8 @@ union bpf_attr {
>>    *		is resolved), the nexthop address is returned in ipv4_dst
>>    *		or ipv6_dst based on family, smac is set to mac address of
>>    *		egress device, dmac is set to nexthop mac address, rt_metric
>> - *		is set to metric from route (IPv4/IPv6 only).
>> + *		is set to metric from route (IPv4/IPv6 only), and ifindex
>> + *		is set to the device index of the nexthop from the FIB lookup.
>>    *
>>    *             *plen* argument is the size of the passed in struct.
>>    *             *flags* argument can be a combination of one or more of the
>> @@ -1873,9 +1874,10 @@ union bpf_attr {
>>    *             *ctx* is either **struct xdp_md** for XDP programs or
>>    *             **struct sk_buff** tc cls_act programs.
>>    *     Return
>> - *             Egress device index on success, 0 if packet needs to continue
>> - *             up the stack for further processing or a negative error in case
>> - *             of failure.
>> + *		* < 0 if any input argument is invalid
>> + *		*   0 on success (packet is forwarded, nexthop neighbor exists)
>> + *		* > 0 one of **BPF_FIB_LKUP_RET_** codes explaining why the
>> + *		*     packet is not forwarded or needs assist from full stack
>>    *
>>    * int bpf_sock_hash_update(struct bpf_sock_ops_kern *skops, struct bpf_map *map, void *key, u64 flags)
>>    *	Description
>> @@ -2612,6 +2614,18 @@ struct bpf_raw_tracepoint_args {
>>   #define BPF_FIB_LOOKUP_DIRECT  BIT(0)
>>   #define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
>>   
>> +enum {
>> +	BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */
>> +	BPF_FIB_LKUP_RET_BLACKHOLE,    /* dest is blackholed; can be dropped */
>> +	BPF_FIB_LKUP_RET_UNREACHABLE,  /* dest is unreachable; can be dropped */
>> +	BPF_FIB_LKUP_RET_PROHIBIT,     /* dest not allowed; can be dropped */
>> +	BPF_FIB_LKUP_RET_NOT_FWDED,    /* packet is not forwarded */
>> +	BPF_FIB_LKUP_RET_FWD_DISABLED, /* fwding is not enabled on ingress */
>> +	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
>> +	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
>> +	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
>> +};
>> +
>>   struct bpf_fib_lookup {
>>   	/* input:  network family for lookup (AF_INET, AF_INET6)
>>   	 * output: network family of egress nexthop
>> @@ -2625,7 +2639,11 @@ struct bpf_fib_lookup {
>>   
>>   	/* total length of packet from network header - used for MTU check */
>>   	__u16	tot_len;
>> -	__u32	ifindex;  /* L3 device index for lookup */
>> +
>> +	/* input: L3 device index for lookup
>> +	 * output: device index from FIB lookup
>> +	 */
>> +	__u32	ifindex;
>>   
>>   	union {
>>   		/* inputs to lookup */
>>
> 
> This has been updated in the bpf-next tree already, see commit
> 9b8ca3795199 ("tools: bpf: synchronise BPF UAPI header with tools").
> 
> Best regards,
> Quentin
> 

OK ! Thanks.

--
Thanks,
Taeung
