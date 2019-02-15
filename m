Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0132192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2UbqpTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfBODCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:02:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43838 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfBODCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:02:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so4104984pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 19:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+mYBDXcQURYSYQDCc87+R5sN/LwABa+hRgvYSMc6Iko=;
        b=N2UbqpTRG2flXF7SzDeA/+wdel+cMyZU7emN20njVw1e6udZI8ig3jGEiR5XpcKo+p
         y2QncWKfTdHFV4CKJpT28GbLkHzeI2J51lCvv5goAYFrMf2XmH8t5KAl0zFcxU5GkHPl
         TA6kuDRSZKgl2XwTS5414CQYgZ4Y0lsrtFVAcm6kODXuDCctezCf+NSO4MXRwzO0D1RB
         0tQYkG75ZjQFJqHPBLR82QnWoZ2bThHCp/55T/n8BCS68Na4NE57xIgdLhFvaom3MxaN
         i7z+3u95mtYxUDljunMhAKIjpIN459fdJlIoAX2DEqHNW2OfvS+X0/4uxmotVsWzW45S
         W0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+mYBDXcQURYSYQDCc87+R5sN/LwABa+hRgvYSMc6Iko=;
        b=txfC5x6wucJcN1WEjbDuxz8Agkjh4JZwyuuI3RiX8lvWcBT+mCb+ocYR9dXczPv9LO
         EwcREQx0dHC/4kNl8R6PPrgWgiuL45uC+VfkO6ncfd18GTdj0bsbCzZc1bCdVhtSGJa0
         p1W/JpVFlvKXGpggwS1KxtCy2sJpvw+E2QV9A87J2Q2Z+AVJgZFXc9RmQoBCaf34Blvj
         XdqhnL7w08+PJECaYJySFoGK0YY0h9m90z1fc9YyUPNNA2vZa5kqmIOzfjamSH+Q3o3d
         6KkpmTFG5mDWyc2YcrSkxTsTAiJqvG+FSFncbAk5QjIQHK1VmlfLSS4kNVjITksdzIZE
         x2xA==
X-Gm-Message-State: AHQUAuboFqkfe97Ocmjx8HsXG7ab8Rm6NHiHIqd5WlVdQXhONXUWsu/C
        fAeKDMAZ94mAViEd1ArXt8VI6g==
X-Google-Smtp-Source: AHgI3IZCE2rUfBlTQFy5mSifPWnyMNwWalA3yaHDw3LpLq1MT710D9V//x8Z09qLcmB1DRKSCTMTDQ==
X-Received: by 2002:a63:f201:: with SMTP id v1mr3009787pgh.232.1550199731122;
        Thu, 14 Feb 2019 19:02:11 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id z9sm10386367pfd.99.2019.02.14.19.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 19:02:09 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:32:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in
 genpd_dev_pm_attach_by_name()
Message-ID: <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
References: <20190214181249.2749-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214181249.2749-1-dianders@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-19, 10:12, Douglas Anderson wrote:
> The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> to of_property_match_string() where the argument is "const char *".
> Adding a const here allows a later patch to add a const to
> dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> that was declared "const" in a driver.
> 
> Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")

Not sure if this should be counted as a fix.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/base/power/domain.c | 2 +-
>  include/linux/pm_domain.h   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

For both the patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
