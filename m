Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91AE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdVjWw9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91AE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLGG6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:58:03 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45571 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:58:02 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so708674vke.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZOd1HCwYL4EI9gdruLWAIYGBWR7S24FTB3evQP/yYI=;
        b=DdVjWw9Wj4oKnPZvmgUyqs6EWS/j2rAzFonoi+YC1A+XQLodRvFo349umHBwiWuUIS
         tc2TAe81Ri+EwQWUL29MPcxMCQCZgI6TWtV+MdV5jnLgV24VFJCojw+FI1bRQ3xxFk98
         3uOGlKHk82HMT1/OxR9LLDPNghfTAD3tUKoV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZOd1HCwYL4EI9gdruLWAIYGBWR7S24FTB3evQP/yYI=;
        b=krfwR+opLJtneYyl4tEM87D054PxqSBckd9sGb4BYL782kgNTYru7WXex4OtH3JZD1
         rAyYQNwlxQnx93YIBRJmX+Pryo7exSVM0q59mKx//l6nzVk1jMND09tbP0wWuJw4xkmQ
         hj1xsmDn50BaxP/idDznWXwsAAucJLcDwc30qQ/gKzGuqd41g378TakjfDEbeRyZTQR1
         5HNh0aLnlMvVfjNgFrvdJDshfE+EcJQm1h2R6cpr7AzQCXSXl6h5qyA4RZdli0xpwvd2
         2dlq1O6mBLfBxpcbb6OizhOgwjTYML6awEDNITuaypy+X8T9A6Q6EJ0NE1P3D/+jldUd
         9G4Q==
X-Gm-Message-State: AA+aEWZZWz6zWw3Rfwj6ikAS79eFStHTTfZMGImb120854+M1APDMnsx
        brlIugSkijYC76A26wzEWsiWPOedId5b9wvkActI5A==
X-Google-Smtp-Source: AFSGD/XrStUbmiDugpBO9UY1l5Jwq5y4XrGrJbIt7EIi24aCMys8UPb4rdUghV8gVaf8Y+lKO/r08cvJ4b5QMCNhjFY=
X-Received: by 2002:a1f:b58d:: with SMTP id e135mr413989vkf.86.1544165881652;
 Thu, 06 Dec 2018 22:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20181207122456.754129f4@canb.auug.org.au>
In-Reply-To: <20181207122456.754129f4@canb.auug.org.au>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 7 Dec 2018 12:27:50 +0530
Message-ID: <CAHLCerMsVE1Rm1sP1aBvXf7eAYr3Jzk=cNda+wMRUHnv+zf27g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the thermal tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Rui,

On Fri, Dec 7, 2018 at 6:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Zhang,
>
> After merging the thermal tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/thermal/qcom/qcom-spmi-temp-alarm.c:26:10: fatal error: thermal_core.h: No such file or directory
>  #include "thermal_core.h"
>           ^~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   150a4fe8c335 ("drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir")

Apologies for the build error. My scripts failed to enable the config
and test it correctly. There was bug on where the .config file ended
up. I've fixed it and sent v4 of the patches. Please consider applying
them instead.

Regards,
Amit

> I have used the thermal tree from next-20181206 for today.
>
> --
> Cheers,
> Stephen Rothwell
