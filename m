Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E81ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F20721470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9adCg9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F20721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJTCxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:53:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35496 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeJTCxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:53:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8-v6so16244433plb.2;
        Fri, 19 Oct 2018 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNTxO+FAYOU3GFS5Byj/lT1Lgbt0YCl4QVwLg4sjdGY=;
        b=b9adCg9FIvvtxEBzQl9ndYyDcvLhiw0rDtXxS4Su+yBc0ll17vi30p7jdyBpH3dTah
         MnCAW4p6DbdgTj32RWaD8VjzIOAm8HCEo5V2AKkLEcB9BOlEr0rJRqFbsBq2FgNepkY4
         34dUhJC5+DVJJzz8Q6O7ycSFPWfzomb84RWPvd7HKizLlwUUhEgaHeLIrHyF98DjqRrw
         wnOYTP9/KWDs8PjKdIwcbNJ0yW4Px5gO9GeM/lKeaVXQRuHyY4AIutykhCAsohp/wSAo
         iYSutL0sdSpYiLym0uTTnnwN5+YgTiPf5nOjxLgJp6sZRc2RI2nxy13bDiPaMiXO6rVZ
         gJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNTxO+FAYOU3GFS5Byj/lT1Lgbt0YCl4QVwLg4sjdGY=;
        b=bYBQvKUG56Q4y1MlAMwkNpmPApLuEIPIBvX+c8b0Hzz4SsgNLg/w92rhL8jfk4WfVZ
         oIccLZwBCq6x09gGDBvLNxXAwVDjNrl0s2oUuYp2/aiK6RrGKnRchTD+aGOc0/xa18tj
         gtGpEilvkA68DAHCBKMnxPEc8XY3m/6eir2MYTO8lfxZS6r4mvGycFEgIEeuhu8xxeP6
         jOrDqJA91CTj9K8lX0Mk6PSYdZTUUW8J+GJg+SUgdOvrXO5uwgt7W4N2iF5n1DwDs818
         8LZRiRmEk4FvPB1pEOy+hzcJc2etzUvpuC6Bw3+63AEvQnaiw6wx/evQUkMb8RQCPztt
         yJeA==
X-Gm-Message-State: ABuFfohh0ByHA5C5592j4djFdJkKK4+9nqZxI1/RkEjZM9UAh2wNSxbO
        EPitHmDnI5lQA0WSXIF73VaDeosY
X-Google-Smtp-Source: ACcGV61obHqsGPSSuTjQKr4FpLUuZKGoa1RHEkVdcN0xs2LounIjZqZmg3U/5ZX7+d7JEH9YGhyI7Q==
X-Received: by 2002:a17:902:bd98:: with SMTP id q24-v6mr25099358pls.284.1539974786177;
        Fri, 19 Oct 2018 11:46:26 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm37578941pfa.109.2018.10.19.11.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:46:25 -0700 (PDT)
Subject: Re: [PATCH] bpf/test_run: Add braces to initialization in
 bpf_prog_test_run_skb
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181019182649.24301-1-natechancellor@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <3e2e5343-3ead-5b4d-758d-14f04183b39e@gmail.com>
Date:   Fri, 19 Oct 2018 11:46:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019182649.24301-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2018 11:26 AM, Nathan Chancellor wrote:
> Clang warns:
> 
> net/bpf/test_run.c:120:20: error: suggest braces around initialization
> of subobject [-Werror,-Wmissing-braces]
>         struct sock sk = {0};
>                           ^
>                           {}
> 
> Add the braces to properly initialize all subobjects.
> 
> Fixes: 75079847e9d0 ("bpf: add tests for direct packet access from CGROUP_SKB")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  net/bpf/test_run.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 8dccac305268..65e049c61a7a 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -117,7 +117,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	u32 retval, duration;
>  	int hh_len = ETH_HLEN;
>  	struct sk_buff *skb;
> -	struct sock sk = {0};
> +	struct sock sk = { { {0} } };
>  	void *data;
>  	int ret;
>  
> 

Strange, I thought this patch was still under discussion.
Has an old version of it being merged somewhere ?
