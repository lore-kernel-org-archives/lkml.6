Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB27C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861DA20861
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546035205;
	bh=Bxvd2wa9BmgPJJpuINfZCM58kcl1C1buLtgjYqw1lDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oQ/gqyWSG/37q8kQ2m0egiM+k6IjWbCTgfShvzZ4XqFbRKSKiS6GOSFjEIAAG1xS1
	 cAsPv61ARCN6pucKple6eQ9pDNsCW7/szWJgD0Av7C8zsd6GmMddG0r2NSlg/MIuly
	 B8hLqrUyYUiAo3wGZXmlTeHGa0+JkVxjrGtdWbyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeL1WNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:13:24 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50988 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeL1WNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:13:23 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so30076442iti.0;
        Fri, 28 Dec 2018 14:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKEfelqOq2gGwLjo0XQ2T0KpKa7LeSHcUdqYDA7/jqQ=;
        b=cxi6Bq6fEYud4t+a0tM9X5Ra+PlQQK3NAznlwnwGW2fe5mNmRt00FaNfgxz7YlqvBf
         dxOZJLtaapHaIZQ42PchYJC0f4I9d75kCj9egKGi3LpFtCy9/5nvUr2XqQ+C+WfNjjOe
         WtScJ13gDEZi6PUmprOmq/rL4V+NDgRsT+bJI3PD9BNFi+hw3GEc5EltLdxleS0sscLZ
         tEB0lmgVh/ivawEgA/dKZczZODvEMK2RbWKasuYiMe3r2Bnw+ynxKFNLoZiG/3szKuwa
         6a9O70fIVl+fOtu/sfUCcs8We0JLTeVb4iCbEaR6TRyF8QgCo4xlnExFjJWC81gN27CM
         bffQ==
X-Gm-Message-State: AA+aEWbcJUt9YeylTRMMxsvOqmrg9ALUsGZ3A2Y5mM1sk64S2DouI8h9
        B8ShD2ZeDpwXOqE2+XtxFg==
X-Google-Smtp-Source: AFSGD/WP/tLgexSuFImvy1fY2RRxDJl66c0TzFxGkE6HC7AkvWn+Fo+qbyCf4qt1n6OTQrd7mqhbOw==
X-Received: by 2002:a02:650d:: with SMTP id u13mr20215121jab.136.1546035202413;
        Fri, 28 Dec 2018 14:13:22 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id v189sm15957622itb.42.2018.12.28.14.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:13:21 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:13:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        clew@codeaurora.org, akdwived@codeaurora.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, evgreen@chromium.org,
        briannorris@chromium.org, sricharan@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: remoteproc: qcom: Add missing clocks
 for SDM845
Message-ID: <20181228221321.GA16248@bogus>
References: <20181228185307.25645-1-sibis@codeaurora.org>
 <20181228185307.25645-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228185307.25645-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018 00:23:01 +0530, Sibi Sankar wrote:
> Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.
> 
> Fixes: fb22022ff63d ("dt-bindings: remoteproc: Add Q6v5 Modem PIL
> binding for SDM845")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v4:
>   * Re-order clocks for consistency as suggested by Rob
> 
> v3:
>   * Fixup dt-binding documentation as suggested by Doug
> 
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt   | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
