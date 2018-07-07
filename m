Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23620C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47F122479
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGxO2uRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47F122479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932833AbeGGCyc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:54:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43562 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932524AbeGGCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:54:31 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so9786036pfm.10;
        Fri, 06 Jul 2018 19:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkhNCOBV9Ag3o8nk0JUTNQj62zrTskGSwFAXDO/LRfc=;
        b=kGxO2uRyK5gFBHAfGiP27t3/XbyyHgQaPnAc3MQMW0BG5gxMVggDqnpwXSUw8jd1Ym
         ATFiU4GRfAmdtOv6UX56FKchsZz+i4Ll5GaElFy5VOh+YNwFLkNOW2OoFif2We4K7Amm
         tkZcHrIWqSPw0u336Ya51Xa9pyn1eOfnAWfa1QiAJ2upSU6vaVEkX+P/vkLgZkBqMdlk
         n2o7Ro2oNtCumLvL+Q6GfpF1LOrHsTiQUIE2JwrC2zNtbEcxJbeGx3PxDyWfhq7kQFu9
         6X/+mgmsRoavqLy6qu/mJwPCQTwnU1yDkYcNeVVicLa0gNbn9ZSUYmGRXjiA4qugHRnT
         E+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkhNCOBV9Ag3o8nk0JUTNQj62zrTskGSwFAXDO/LRfc=;
        b=X6xsACCQWn9QMKoAReZSAd39+b1wIXVpgOROgTmeu9EWm6i3qOggN0HTU9/8qVvvzF
         nNcFPlkdE+uv+mjOs6AOlyRuq9+afJVoVWs4748gCqMJNDJbfBI0bqJTi++EQjt62gF6
         fjE/dgXgUnvC/bFWrv5HNLx0ZQ8WnYuQDGI5LdD7lgYW10Ts2Oa978f4ZdPv1iAehEIM
         Pnqhd/v2mhhrpSvV4z8xpKtooMrVtpfn0wNHLGhXI/p/xyGs53Duui0TVSzPky0NuEmy
         U207QBTs09+fZwi3cf0ntkvH62Bp8Ii0Lzxz01N1vnqVMe1jgtlT+A42CWJcKXVTVsm1
         TXIw==
X-Gm-Message-State: APt69E3whDplA+ek+Fr8VV3VVMOj8vHR2H01PNgQbR/yQDk/wHHIUOF9
        WMYE8fWzmhRsJN2Q8HTlmEI=
X-Google-Smtp-Source: AAOMgpfvk0UTBeYqu8mo4Fqhq5Cgk8Tv11NLBoqLryAYzdSHYWYFIaoL32U2HtngQXW9hXcnjxOuHA==
X-Received: by 2002:a65:5784:: with SMTP id b4-v6mr5227631pgr.315.1530932070833;
        Fri, 06 Jul 2018 19:54:30 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:b777])
        by smtp.gmail.com with ESMTPSA id r87-v6sm20050167pfb.1.2018.07.06.19.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 19:54:29 -0700 (PDT)
Date:   Fri, 6 Jul 2018 19:54:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     joelaf@google.com, ast@fb.com, linux-kernel@vger.kernel.org,
        timmurray@google.com, daniel@iogearbox.net, netdev@vger.kernel.org
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
References: <20180707015616.25988-1-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707015616.25988-1-dancol@google.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
> BPF_SYNCHRONIZE waits for any BPF programs active at the time of
> BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
> RCU data structure operations with respect to active programs. For
> example, userspace can update a map->map entry to point to a new map,
> use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
> complete, and then drain the old map without fear that BPF programs
> may still be updating it.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> ---
>  include/uapi/linux/bpf.h |  1 +
>  kernel/bpf/syscall.c     | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b7db3261c62d..4365c50e8055 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -98,6 +98,7 @@ enum bpf_cmd {
>  	BPF_BTF_LOAD,
>  	BPF_BTF_GET_FD_BY_ID,
>  	BPF_TASK_FD_QUERY,
> +	BPF_SYNCHRONIZE,
>  };
>  
>  enum bpf_map_type {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d10ecd78105f..60ec7811846e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
>  	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (cmd == BPF_SYNCHRONIZE) {
> +		if (uattr != NULL || size != 0)
> +			return -EINVAL;
> +		err = security_bpf(cmd, NULL, 0);
> +		if (err < 0)
> +			return err;
> +		/* BPF programs are run with preempt disabled, so
> +		 * synchronize_sched is sufficient even with
> +		 * RCU_PREEMPT.
> +		 */
> +		synchronize_sched();
> +		return 0;

I don't think it's necessary. sys_membarrier() can do this already
and some folks use it exactly for this use case.

