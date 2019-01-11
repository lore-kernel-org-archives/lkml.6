Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B28C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DB42084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6IntYz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfAKXDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:03:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40181 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAKXDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:03:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so16862498wrt.7;
        Fri, 11 Jan 2019 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQ5h+xhK2WPV3aQfmhX+HBY2D680bNRzz82XYueIohA=;
        b=B6IntYz1GV6y+FhWWvCe3tDRV6+tvOAoovxxtpx6Ath6vNrbApzS5YWy57NucML9Hq
         1D95DSlqzP4ikM6GQrsGLcQGJCd86YXG9qCyFAo65lzmfHZxbZm4Zl9zBVa06Yfj0Z/k
         N3aG+TIANtKd9f+0O90U6U0kNK/j2gdU1Sw4tP/ONSTw0zVrMKnChySKyngwcWR1xrnh
         7mm4YFutSaB2Qe5tGUC7EDwV53OqObCsiHemD5GYiBEJYVLo6jDwFPEj28G/R84S+Q+f
         uAV36jp2jT+WVTyAGR5MOkiE/IO1FwjkHZgFZOQOfG/HUl0wOo3QRUdgEpVRfFXQ5C7R
         50Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQ5h+xhK2WPV3aQfmhX+HBY2D680bNRzz82XYueIohA=;
        b=AUm2ljL63m9zBZKrI10exfvlQy+SRvPByyrC1B/RjPnJ0JNnZ1wk9mXMZMVAWQA3pm
         8wUczzQirQPtbhvCxf+zozEkX2xZoov0RDdEYyh64yqCf7oU6Y1c9xw6RjcGfwb6qFEu
         8TPQFCsTUbjI3HrMxw0sn09jeH0OSSY5SHgAdXRHPD709ekz4eLxngBTqOLxoQ5mgsej
         KlHXWNjF5V195QF2LVTijqJT9z4BMqVve86zmJ73wK/6632oj+CaMeUuK2DGPKGzRMwe
         CfQpXsCaLn21VRk3F9dWuCf/Xm+p54jjYTLDkXWHMVYffWievLYpp9qqkBe6zo5JTkhw
         yDmw==
X-Gm-Message-State: AJcUukewbsAwc7/vUmWvZyHhgCAOHQJrpTiz/8eM1wOHQx6q0MfeUsu8
        qJg87Xrb8i3tV3b5Pqx5quENI/0=
X-Google-Smtp-Source: ALg8bN7tJLDeQGg3bLnRcig8/yzEDnjAZh9HJ/TdrA1tOUeQTT5w/udLj2aeNk+5AhoafvkZvZBfdg==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr14999367wrn.11.1547247826558;
        Fri, 11 Jan 2019 15:03:46 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id k3sm102630279wrm.7.2019.01.11.15.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 15:03:45 -0800 (PST)
Date:   Sat, 12 Jan 2019 02:03:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Tan Hu <tan.hu@zte.com.cn>
Cc:     zhong.weidong@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: only export statistics of softirqs for online cpus
Message-ID: <20190111230343.GA20267@avx2>
References: <1547119441-28314-1-git-send-email-tan.hu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547119441-28314-1-git-send-email-tan.hu@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:24:01PM +0800, Tan Hu wrote:
> @@ -12,13 +12,13 @@ static int show_softirqs(struct seq_file *p, void *v)
>  	int i, j;
>  
>  	seq_puts(p, "                    ");
> -	for_each_possible_cpu(i)
> +	for_each_online_cpu(i)
>  		seq_printf(p, "CPU%-8d", i);
>  	seq_putc(p, '\n');
>  
>  	for (i = 0; i < NR_SOFTIRQS; i++) {
>  		seq_printf(p, "%12s:", softirq_to_name[i]);
> -		for_each_possible_cpu(j)
> +		for_each_online_cpu(j)
>  			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
>  		seq_putc(p, '\n');
>  	}

This should break userspace:

	https://sources.debian.org/src/netsniff-ng/0.6.5-1/ifpps.c/#L330

This code gets the number of "possible" CPUs from sysconf(3) and doesn't
parse header to find out which CPUs are online.
