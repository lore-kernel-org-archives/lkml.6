Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E852075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqPCewmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E852075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeIHAku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:40:50 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55496 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIHAku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:40:50 -0400
Received: by mail-wm0-f53.google.com with SMTP id f21-v6so15775754wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvQxScfV/YDGyfDv8srFeoeXHYuX5rCFeOC5uNDcEUw=;
        b=dqPCewmJWI1vyjTUl8OOCfPjvNptgbXJBeu7UFN9DJlVmmn+Sfg87buqWym1hIj7GH
         xz24TqExabq1KzxeWh/BqVmUwGL+8c+//XbGzqvANyDAkPWAqTqHoveVuxl2q51x95MH
         9OUXefe6JO6TyykAHRdGJjkMa879bJYT+HeWiaZ04hR9Qh226Dzf5KGVqUp5BQta4Ram
         4zI0AbEJxiG6bJnRzWB133MQjMDxBq9fJLWpSXwHQASrclWGlk3DnJBhGivNLXeW7sCq
         3WIh6dJcI53601O0FS6hCBxqa+kCVLgQRzU0c0pLXIz4qFCb9pS9Otp892i6bnkjOU+A
         4wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvQxScfV/YDGyfDv8srFeoeXHYuX5rCFeOC5uNDcEUw=;
        b=r81pqbMCu3cno4+CSBvSPFmuOYYRjhkp6wZQpVF7HleuKkHO2HWwpRBvmtEguJt6wr
         GlgrrIItEhK8sKJP6o8hi54rnUgLUAyuX7MWJexI/l/UspDMJDUdM0fa/Fg1Xyy+YP/g
         bRg5y0oFs3dHcdCWr2hlm+UK4CPfqBjne30WlVmLpz0FtskuiaMs8SoTcxnSi7wMDxBw
         Q77bii1yR0ONf+WMK1URouirzce7TUXzvFaWP8wBUVL1M7qd/CS/YbMq1K4khXo8oN9F
         gQkr1plbNBat/xa7muvlg7xmfEMtbHeCNL3sBDzXYkKwmfLYsojybyoMT6s7qftFlT6m
         SKSA==
X-Gm-Message-State: APzg51DoOXN8t3M1taEKBXP2wfFR54QUnLn4cECjb39kmrj4voDoJjlW
        oj2zk7RfTQt8YF0siWFIJTYEUwM=
X-Google-Smtp-Source: ANB0VdYBaoo5Iwy7KmV59/UxBbpOX/dnhMcI50WpPPmJxFb2z5JYmxO9WAyYtraznmUUQU+FIaRLHA==
X-Received: by 2002:a1c:46c4:: with SMTP id t187-v6mr5621764wma.158.1536350299526;
        Fri, 07 Sep 2018 12:58:19 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id d22-v6sm17483761wra.80.2018.09.07.12.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:58:18 -0700 (PDT)
Date:   Fri, 7 Sep 2018 22:58:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        vjitta@codeaurora.org, sumit.semwal@linaro.org,
        rientjes@google.com, mhocko@kernel.org,
        mgorman@techsingularity.net, labbott@redhat.com,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, guro@fb.com,
        cl@linux.com, vbabka@suse.cz
Subject: Re: + mm-slab-shorten-kmalloc-cache-names-for-large-sizes.patch
 added to -mm tree
Message-ID: <20180907195816.GA28375@avx2>
References: <20180906224849.1JOWr%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180906224849.1JOWr%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:48:49PM -0700, akpm@linux-foundation.org wrote:
> -	{"kmalloc-1024",         1024},		{"kmalloc-2048",         2048},
> -	{"kmalloc-4096",         4096},		{"kmalloc-8192",         8192},
> -	{"kmalloc-16384",       16384},		{"kmalloc-32768",       32768},
> -	{"kmalloc-65536",       65536},		{"kmalloc-131072",     131072},
> -	{"kmalloc-262144",     262144},		{"kmalloc-524288",     524288},
> -	{"kmalloc-1048576",   1048576},		{"kmalloc-2097152",   2097152},
> -	{"kmalloc-4194304",   4194304},		{"kmalloc-8388608",   8388608},
> -	{"kmalloc-16777216", 16777216},		{"kmalloc-33554432", 33554432},
> -	{"kmalloc-67108864", 67108864}
> +	{"kmalloc-1k",           1024},		{"kmalloc-2k",           2048},
> +	{"kmalloc-4k",           4096},		{"kmalloc-8k",           8192},
> +	{"kmalloc-16k",         16384},		{"kmalloc-32k",         32768},
> +	{"kmalloc-64k",         65536},		{"kmalloc-128k",       131072},
> +	{"kmalloc-256k",       262144},		{"kmalloc-512k",       524288},
> +	{"kmalloc-1M",        1048576},		{"kmalloc-2M",        2097152},
> +	{"kmalloc-4M",        4194304},		{"kmalloc-8M",        8388608},
> +	{"kmalloc-16M",      16777216},		{"kmalloc-32M",      33554432},
> +	{"kmalloc-64M",      67108864}

I'd rather use KB and MB suffixes or at least capital 'K'.
