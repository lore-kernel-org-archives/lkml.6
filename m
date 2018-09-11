Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911B120866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1buQGvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911B120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeILDOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:14:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46251 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeILDOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:14:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so12918998pga.13;
        Tue, 11 Sep 2018 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gn9LPKxAdbOFeosTNmLgoD68w/wDjzgz9vhdf8pSbf0=;
        b=Y1buQGvn8tqSv6LuKCWnhQso1Xmj12FcY41q5RCtuzYvhew/3yxVMzvEj0LXo5HAvX
         q87Hz/2QWLa7ai65F9YUIvk57klyqFgqWcKb8Kro8ypcmP2Iq8JROJPZGwKhaYOYECXk
         MZE6UISMIhY+2D4MoRrz1PiHYtXMXVs2Mntmn92WzTLzLXc+1SFdc2OkwK8sFPNTg9R0
         A3prpjY9AwkUP9czpBhpu1CAlLGqjh6hlTzDbQUtoSxPSi2/coqy1vexOTQNbwTF56ps
         5C2cuo1LmEL+pMuepDgTNZCCFOPrUC/D/yq3eVzHsgrp/Ut+qxC2LMgL0eocm0f031i1
         SNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gn9LPKxAdbOFeosTNmLgoD68w/wDjzgz9vhdf8pSbf0=;
        b=bp6ERP3I6fuWx8fLhx1pzQF0rtGlf4IkW6HCEGcUgU/XtteQGoer9yPDaqvvzD6wKa
         4c8RFEkeEUmFvmDrH+YtZLApu3rp5R4WXInymw444MI43oMbWjv3YNRp2SiLypAti2XU
         3afn8+E/zFxN8Uk7IcxE/4uL9W1D669SegLwHWhEgzG0++kOSpQtoiiYerT5Ie4MObXn
         LAOsbm84WY2Q6GTHrBvL6pd70Yv7J2H9GSbvyNaJ+QMze+mSRTPI0Odfn+who/ityzAT
         OP7fC+Sz/pOwiFGDA1yA8jo7PElkVe6VGD87MHnVEN6Nedbhioahi3INzLJHIXbptcgk
         LXaA==
X-Gm-Message-State: APzg51CuV1xJmfUBrMAbKi78IbDjOYqjrEPVYlgFf1kU4BLCIBvQB8S7
        oNDgShVBj3CEjuudQhuja9w=
X-Google-Smtp-Source: ANB0VdZ1GcPbq2aNMjpnY0GxK4z4sMkB5nOXC3NUe27rZUvBLcLdzEHk5ZeY48rh5JIa0a+U23fKiQ==
X-Received: by 2002:a62:89d8:: with SMTP id n85-v6mr31606146pfk.83.1536704010526;
        Tue, 11 Sep 2018 15:13:30 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::4:2d48])
        by smtp.gmail.com with ESMTPSA id 9-v6sm32752015pfc.20.2018.09.11.15.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 15:13:29 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:13:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        tehnerd@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core/filter: fix unused-variable warning
Message-ID: <20180911221326.cwsf6rfpkhvoywhw@ast-mbp>
References: <20180907125005.32383-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907125005.32383-1-anders.roxell@linaro.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 02:50:05PM +0200, Anders Roxell wrote:
> Building with CONFIG_INET=n will show the warning below:
> net/core/filter.c: In function ‘____bpf_getsockopt’:
> net/core/filter.c:4048:19: warning: unused variable ‘tp’ [-Wunused-variable]
>   struct tcp_sock *tp;
>                    ^~
> net/core/filter.c:4046:31: warning: unused variable ‘icsk’ [-Wunused-variable]
>   struct inet_connection_sock *icsk;
>                                ^~~~
> Move the variable declarations inside the {} block where they are used.
> 
> Fixes: 1e215300f138 ("bpf: add TCP_SAVE_SYN/TCP_SAVED_SYN options for bpf_(set|get)sockopt")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  net/core/filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d301134bca3a..0ae7185b2207 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4043,14 +4043,14 @@ static const struct bpf_func_proto bpf_setsockopt_proto = {
>  BPF_CALL_5(bpf_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>  	   int, level, int, optname, char *, optval, int, optlen)
>  {
> -	struct inet_connection_sock *icsk;
>  	struct sock *sk = bpf_sock->sk;
> -	struct tcp_sock *tp;
>  
>  	if (!sk_fullsock(sk))
>  		goto err_clear;
>  #ifdef CONFIG_INET
>  	if (level == SOL_TCP && sk->sk_prot->getsockopt == tcp_getsockopt) {
> +		struct inet_connection_sock *icsk;
> +		struct tcp_sock *tp;
>  		switch (optname) {

I've added empty line after variable decl and applied.

