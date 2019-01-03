Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C413C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D043B206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3toxlsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfACEFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 23:05:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfACEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 23:05:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so16094427pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 20:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmAMGJjbEFUPnx8DvRbshnXJTlBhiy6DyguNEsgLwy8=;
        b=d3toxlsEWaTM6cQSgoT4SikTmtF41ajWQc3Etgu5pwM8gA9mj53knElJ3h2Kn0akGA
         kua0Crfx5uHRnxdIWpN8AwLyoL0cy7J8WX5SfWdlcOig5OEN1gbgHSnBCC7vyZyziAih
         ZBwjwnFyBwmZDfezQUXu7hxY20/VA4SQOQlAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmAMGJjbEFUPnx8DvRbshnXJTlBhiy6DyguNEsgLwy8=;
        b=DjrbQWnwV/JoWQ9SVsUOMaGU3tLGrKqTdoRUyUY6UX2oa3hJsoTKCI+laRC4Hbeljc
         RQ88KgnsbOsF9PNSUKq8qHeWbxNIJafc/q4m2w1BSqXZ7/Jj6+/SSDVDiLwVBowxhqw9
         fRe6bXA8fO+1M7gEZbQ/AB7niPk6vQ5s85mS8f4EnrFNDutpQlOYynejV9F1g9v7fYPE
         t4B8nm70ESQq/cNl0bBGHrqRbtf4o3dd8cf4QBp3V0UZ42zjDmPUY9jiNqxiBu7AJIoU
         64lb7G2XerPkmzYn5g0qaGDHk1czJUcVCyf/LwHcyFFIN8bY+re+cFvP0/U0uH4S6/2M
         Uk4A==
X-Gm-Message-State: AA+aEWbaNFZH7YRhRDvgGldpOYSMqL2y4Mi8T6VBIArb98XCuvlR+yi+
        kl9snAbcADsQhXcutYNQsR6y9Q==
X-Google-Smtp-Source: AFSGD/XTtfrNIruOc5jNb6iakAaXp140Rq3MM5fVVRHyLgF6gXNyIyarybEgmO5lkU+GTmkDyTcogg==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr47245662pfb.55.1546488349386;
        Wed, 02 Jan 2019 20:05:49 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id z9sm153089019pfd.99.2019.01.02.20.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 20:05:48 -0800 (PST)
Date:   Thu, 3 Jan 2019 09:35:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] cpufreq / Documentation: Update cpufreq MAINTAINERS entry
Message-ID: <20190103040546.akeyvennctxnfcw7@vireshk-i7>
References: <7154380.sNYZWJVSaJ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7154380.sNYZWJVSaJ@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-01-19, 12:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Update the MAINTAINERS entry for cpufreq by making it clear that it
> is not just drivers and adding current documentation records to it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  MAINTAINERS |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/MAINTAINERS
> ===================================================================
> --- linux-pm.orig/MAINTAINERS
> +++ linux-pm/MAINTAINERS
> @@ -3888,7 +3888,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/ti/cpmac.c
>  
> -CPU FREQUENCY DRIVERS
> +CPU FREQUENCY SCALING FRAMEWORK
>  M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-pm@vger.kernel.org
> @@ -3896,6 +3896,8 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>  T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
>  B:	https://bugzilla.kernel.org
> +F:	Documentation/admin-guide/pm/cpufreq.rst
> +F:	Documentation/admin-guide/pm/intel_pstate.rst
>  F:	Documentation/cpu-freq/
>  F:	Documentation/devicetree/bindings/cpufreq/
>  F:	drivers/cpufreq/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
