Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D8ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7806220657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsHpWfor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7806220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeIRTAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:00:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46122 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:00:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id l42-v6so1602598qtf.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aHqdKKA6YhqrnJHZrKBTgbSZYHpTHEvQMsfHnXZCSTg=;
        b=XsHpWforhCmxqa6h9FYqwmvLxDLIoeNTOa9lI5aP+h1/offkUmD7cJjeLIpMrr6V1q
         gNWqzq0tV9EaizXG07/yvqWreDYmp/7uXNbxiJSzwFauRlIrmJkH65ClkwriNekIgcVl
         G4Dl9RW7j/91dQoIo9Byi2lFQUwsimu6JGohFpmTNWgYOcxg/LyPtkjAhKHpTfmqgkn+
         SMsGcvEc0q5vmwvtBX4BCWqYm44cHm0sIbfHbQ26uABA5VrOBGlAkWEWi2BC1EOvTFK5
         +YlHffDGXMmiunon3LsVNlRfjXYQwM0OCJrqQaKU3lvSOEY5ODPahbRWFQKDE1UeUhYr
         +Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aHqdKKA6YhqrnJHZrKBTgbSZYHpTHEvQMsfHnXZCSTg=;
        b=U/tc5Kl1/UNwslP1hKvR+28kcZD7Pujkn5WFh50KXg9AnITS8T8XUSWxP6eXB+yyD2
         DLJWFwk+Bbd9GU4UQt21IxeljyS4YapIBqZsGHGi3K0gUxLPn10euUzpKrzVfrUYCyZW
         Gj1QoYjcU9YqUU9ffBIYRQ2UnBaQ1QFJ+wQNKFrFtd/JH8Uh+ootS0ZqopS8cHUrt6AK
         xXyRDYfB92lm2maEuNX5tD6kQoEwNBY6LoaF1yGf+uHPQbOiOfmTVmpXZw4udXp+mrS1
         Bo8hDkEhUXumaNrCkUL+Ej9bm4ChFvbR0GkiZx2VTP0LhRLNdmoDDwSpVTjrGASOx0Ri
         cQig==
X-Gm-Message-State: APzg51CVtGhMs/r+2knSkahYYKlW9mjTFbmHpIsKgTe0xU8SoFDF3Nk5
        4L+ozBw45PAYCdsvOdUy3A==
X-Google-Smtp-Source: ANB0VdbkZpLGFKufic8O2AaUdmXnNivkSSIDVzmrD7B5Bs7fNAplTeKYh7NjdFcDcefo8eqUie9t+g==
X-Received: by 2002:ac8:29ef:: with SMTP id 44-v6mr20373668qtt.174.1537277287275;
        Tue, 18 Sep 2018 06:28:07 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g184-v6sm10148993qkb.15.2018.09.18.06.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 06:28:06 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:28:00 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] [PATCH] perf/x86/intel/uncore: Use
 boot_cpu_data.phys_proc_id instead of hardcorded phy id 0
Message-ID: <20180918132759.j4y3mrel2sfsq6a7@gabell>
References: <20180910144750.6782-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910144750.6782-1-msys.mizuma@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On Mon, Sep 10, 2018 at 10:47:50AM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Physical package id 0 is not always exists. We should use
> boot_cpu_data.phys_proc_id here.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 51d7c11..53b981d 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
>  
>  void bdx_uncore_cpu_init(void)
>  {
> -	int pkg = topology_phys_to_logical_pkg(0);
> +	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
>  
>  	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
>  		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
> -- 
> 2.18.0
> 
