Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CAB214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LY9rPvhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CAB214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeJJJZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:25:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38600 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:25:22 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so5814721ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 19:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/Ozr0lPokeZhpKHzty9L7xBkCB1n0jQyRFUHf82luE=;
        b=LY9rPvhbZBzY1xYgFNjryCoo/DD0qAbY+DhUiCXpTL0IUelavZn+z+MTx3rdGq+UMX
         UjoC+I2ldyr1eSihH4qyfjzO6Jb1TegdyYRIcHCrClpXsXNvsbaurVHJxAdvfgK9vh6r
         Nsu0225rYhtA0BD9sBDyDSnP+v801CM6f6SzVHOkYwmX21Go/phMjQl1VRmpS3nl/HQE
         eWuB1edYUcxDt683cSB8VvEyxD9de0Nr9EZOUsrmIOmdozlhOq5KqCWR5tSjTfGxx4kw
         JUl+T8mZIXPkoX5Al+Ma8KqQXqKAj/fMsdFCgl2nDZMJVn6owdvTCd2QMuR4m5h/kbJK
         4hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/Ozr0lPokeZhpKHzty9L7xBkCB1n0jQyRFUHf82luE=;
        b=OuviSYnqCm5OMZxI5BEsRR2ADYar+ign83L1XrauBYNzq46pvKI0mzRc5wAhxS18Nw
         xlE2a93gMtn7v3d93DngKJYfjvBWoDLLgPRUKk4pV9Gt/asfePxfkf5mUUplpzfhLorS
         Mpr/YPWgfM3zmIJKgWogbAF8mqsjkHS+QHr7E2azPcG2wJBztcbuhEctD59fHj2YzEhu
         tYMSiwpb6875KOMC1rn0NglHnnFZWaMOQmU8y+WzmrQt3A4ATffhvp32Q2E9Ot0LMX4L
         7NV2rW2LSK4fI6Zs0XUII6IVet7Pwf/2ws+BCck6ihFq4YuCvjXdWoVA+TTow++eiTSo
         1gKA==
X-Gm-Message-State: ABuFfojyd0RSniyD4zf4QQTBpfG3JiEKxsrmXYT1qpWugkb5yAUsime0
        90YyIQ+Kx/psN1M4OIK9+zHVY8NLM0EVqFchvSS7Vg==
X-Google-Smtp-Source: ACcGV62bZcVxggkRRFII2F9MRisupTkVsL+cUmpM9ZyLnzYZ8b/stD/9IBJ5+c3+7MAUBlX5Q1uQAy7UZKihjBV5TMs=
X-Received: by 2002:a24:74d4:: with SMTP id o203-v6mr3773625itc.81.1539137131425;
 Tue, 09 Oct 2018 19:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181010015143.GD13396@shao2-debian>
In-Reply-To: <20181010015143.GD13396@shao2-debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 Oct 2018 19:05:20 -0700
Message-ID: <CANn89i+RDyhy9k22GHpJVzOWzCK3Hd6z89bABWDXmsgc6w+h9g@mail.gmail.com>
Subject: Re: [LKP] [tcp] a337531b94: netperf.Throughput_Mbps -6.1% regression
To:     rong.a.chen@intel.com
Cc:     Yuchung Cheng <ycheng@google.com>,
        David Miller <davem@davemloft.net>,
        Wei Wang <weiwan@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 7:01 PM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -6.1% regression of netperf.Throughput_Mbps due to commit:
>
>
> commit: a337531b942bd8a03e7052444d7e36972aac2d92 ("tcp: up initial rmem to 128KB and SYN rwin to around 64KB")
> https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git master
>
> in testcase: netperf
> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory
> with following parameters:
>
>         ip: ipv4
>         runtime: 900s
>         nr_threads: 200%
>         cluster: cs-localhost
>         test: TCP_STREAM
>         ucode: 0x7000013
>         cpufreq_governor: performance
>
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
>
>

This should have been fixed by :

041a14d2671573611ffd6412bc16e2f64469f7fb tcp: start receiver buffer
autotuning sooner
