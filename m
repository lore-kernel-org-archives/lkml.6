Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F36DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DED20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkGeMStO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DED20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLKLNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:13:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42394 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:13:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so12562199lja.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 03:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4NJ05A1zGmSNkPKY2/dfcWwaVqhjgv6k99bIMbaHq9k=;
        b=DkGeMStODuuFv7GL7yHyIrklBrs05lUnx5dS18xjhiRKTDf79GRkc8ZDaCB3lCFSwo
         CCONpyQsdIWlDgAnZdV3+rvBLND44DqG6ZlmxV0+81crmQpnOt9dtoNF5mL5ZtDFKueS
         duYxUi9+PZK59eOHZP3tyUcwDZI6q+fcTk5oLwL2vIhdWzsD0ugWMO1IxL9NIR4cO08M
         TalVXFX3XMRrRYwigB8gjF55J+lnadorom64/Wj7Xhz+q6gFKyreemjMoYNHryK7JdRE
         EIlGxFh6OI1I17OcLBgfHClrT+v7quqzZIQpmyIQtmtbL7laD+lTeO2URztLzsN5K2Zp
         Vc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4NJ05A1zGmSNkPKY2/dfcWwaVqhjgv6k99bIMbaHq9k=;
        b=dO/tRG9MpSxYAgaqweZ0lJ6HPQATjJju6DStZTbmIRM+HK5vf/5Ym3iUG273avWd1s
         FVtQNCsZmBfo9v6OqKD8sPj/OJksuq4bioXynp/1E6R83z/5NLvpzShGR4JvyUPFVVvZ
         LyQbvWNifpNNCYHSp3Y5TeKWL3Zd078D4oTRJkrmaJrhVtyp6JV1ntON+nlMGvNGlIOL
         BumSzF4IXlxZHEMzFXpw+gK/hLI90LqCCC1jRfA4zGLm6bA5/CMWRdT8iELwZQaLdoQP
         PSlLqCfnpAn7lndmVNJoqJ3B7zSk48ZN9uGXL4up3x8r0pj690KhRLNhVQKRtQiG22rI
         AMtQ==
X-Gm-Message-State: AA+aEWYj3HHXCONxH4QvBJwAqKpERho/gfOzNmdV+06pX/CQSW0aUeNr
        yQIYub264qZoPKuwjfDmz1I=
X-Google-Smtp-Source: AFSGD/XQaYu4Gp7VlMM0XgVGLOBO3z071Q7Fobn6LMM/fYJx29DtS4Eo5CNdamNTvH/OS/flEpn20Q==
X-Received: by 2002:a2e:6a13:: with SMTP id f19-v6mr10416529ljc.41.1544526782023;
        Tue, 11 Dec 2018 03:13:02 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id f20-v6sm2612050ljk.33.2018.12.11.03.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 03:13:00 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 81A95460AA3; Tue, 11 Dec 2018 14:13:00 +0300 (MSK)
Date:   Tue, 11 Dec 2018 14:13:00 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gorcunov@virtuozzo.com
Subject: Re: [PATCH v2] ksm: React on changing "sleep_millisecs" parameter
 faster
Message-ID: <20181211111300.GF2342@uranus.lan>
References: <20181211100346.GE2342@uranus.lan>
 <154452399396.4921.3418365102240528000.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154452399396.4921.3418365102240528000.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 01:26:59PM +0300, Kirill Tkhai wrote:
> ksm thread unconditionally sleeps in ksm_scan_thread()
> after each iteration:
> 
> 	schedule_timeout_interruptible(
> 		msecs_to_jiffies(ksm_thread_sleep_millisecs))
> 
> The timeout is configured in /sys/kernel/mm/ksm/sleep_millisecs.
> 
> In case of user writes a big value by a mistake, and the thread
> enters into schedule_timeout_interruptible(), it's not possible
> to cancel the sleep by writing a new smaler value; the thread
> is just sleeping till timeout expires.
> 
> The patch fixes the problem by waking the thread each time
> after the value is updated.
> 
> This also may be useful for debug purposes; and also for userspace
> daemons, which change sleep_millisecs value in dependence of
> system load.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> v2: Use wait_event_interruptible_timeout() instead of unconditional
>     schedule_timeout().
...
> @@ -2844,7 +2849,10 @@ static ssize_t sleep_millisecs_store(struct kobject *kobj,
>  	if (err || msecs > UINT_MAX)
>  		return -EINVAL;
>  
> +	mutex_lock(&ksm_thread_mutex);
>  	ksm_thread_sleep_millisecs = msecs;
> +	mutex_unlock(&ksm_thread_mutex);
> +	wake_up_interruptible(&ksm_iter_wait);

Btw, just thought -- if we start using this mutex here don't we
open a window for force attack on the thread self execution,
iow if there gonna be a million of writers do we have a guarantee
thread ksm_scan_thread will grab the mutex earlier than writers
(or somewhere inbetween)?
