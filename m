Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D296C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EC120693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="zRGeTNYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EC120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeblueprint.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936117AbeFSWGp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:06:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34613 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755392AbeFSWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:06:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so20399391wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59+kwJ2GVvJ1cMz6rrR3HyZ//Qp2XLVVuED/suVUyco=;
        b=zRGeTNYsOwRpYxHfRrAiJG+71WUVHOTRYXkMYau3pam8mRJYxpeylyooQJjQ3rkxqe
         PD0aYG7csc1yoR8npX3OpnDSyUUcUfuBBxKZ1RW/wgpZmMfLRGhTB+OEvbX1JKXQjuL5
         vqvi2jpkDN86xczNv7q5oWUs+sbeyk3tt8U+IEUexF9icL/Mj7g0gRDLkB28EXmohucS
         PcI3pUMlMPugvfATK9Ji9ENQhGZZYkAUHtss2xraGeBGZorkzZuj/HcsAJ+0EToixNZe
         xmjMM4t4dUTvpBwAOIGY5tKQE+XDWGKKsYT7esc54J6Zv21MQ241rcfPMZCfgnjGS+kv
         KhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59+kwJ2GVvJ1cMz6rrR3HyZ//Qp2XLVVuED/suVUyco=;
        b=bok01MBVJeQxQfaH/zbEg3VTJn6zSilOKpRVSWavaVr6JP0X/iKl0l9lm7phiuHZa/
         cvPXdrmzrVRbNYLMm24vAK3vnH8d0DUQbzsR/ADAFzS+riLeHOpvfCtrLV+GAjVMq9oh
         0C7DuJdP8TgKcnGCIEry1XOzcaUSgUCZS+kgTHDE7j6ghy2L6i9GQELfCoHfgYyUmTU7
         u8xXoSkDp4Haojd/SJ7dr0A2SdKukT4f+yqoovIROfkeUZQtpQh4iVXqAZywOLOgdDz8
         bJegtYTPJt4XMXuail+1jTxjm3VsfiRT67z4BtW9EpaBjd+DY/kwHUVYceEkhpIHawVV
         UtpQ==
X-Gm-Message-State: APt69E1u7ZJwXRqfmvhe/wi+/LPeFPGJAi2CpJ4WFZz+DBQrZBIkAbSE
        XogpYyazXrjE/MqCR3fGfZzYLA==
X-Google-Smtp-Source: ADUXVKLWPVs5A7rNIypCQ87ZhD6rchNIbvBmwGsKy8RqK8oduouVqmXH57qVJAb74UVENkbX0ZhaOA==
X-Received: by 2002:a50:a45d:: with SMTP id v29-v6mr15844449edb.237.1529446000640;
        Tue, 19 Jun 2018 15:06:40 -0700 (PDT)
Received: from localhost ([2a02:c7f:9214:6300:de53:60ff:fe39:5599])
        by smtp.gmail.com with ESMTPSA id x2-v6sm411570edr.24.2018.06.19.15.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:06:40 -0700 (PDT)
Date:   Tue, 19 Jun 2018 23:06:39 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, riel@surriel.com
Subject: Re: [RFC 00/11] select_idle_sibling rework
Message-ID: <20180619220639.GA14960@codeblueprint.co.uk>
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530142236.667774973@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May, at 04:22:36PM, Peter Zijlstra wrote:
> Hi all,
> 
> This is all still very preliminary and could all still go up in flames (it has
> only seen hackbench so far). This is mostly the same code I posted yesterday,
> but hopefully in a more readable form.
> 
> This fixes the SIS_PROP as per the outline here:
> 
>   https://lkml.kernel.org/r/20180425153600.GA4043@hirez.programming.kicks-ass.net
> 
> and Rohit's suggestion of folding the iteration loops.
> 
> For testing I would suggest to ignore the last 3 patches, those are purely
> cleanups once the first lot is found to actually work as advertised.

This series looks pretty good from my testing. I see double-digit
improvements to hackbench results and only one case of a clear
regression (easily offset by all the wins).

Are you aware of any regressions for particular benchmarks I should
take a look at?
