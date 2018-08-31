Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93085C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5F520839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1LCAC9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5F520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHaFLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeHaFLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:11:51 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3FB20837;
        Fri, 31 Aug 2018 01:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535677618;
        bh=XAgo/foIjwPHDu+g2x0L/O4M1FMc2JPpF0IBamzZ9NI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=c1LCAC9WKzEvx4TSdUMaE7y6bjLH348kxGhDvoL0GDxdFnSu+X065iZyN99zjQOoq
         AQuK1XdkGdE5ddM9MRiToiOgCiBU+yK5/ZLpYyqn5eGWhOTBmPFOB0dxSNWYLwGJ4Z
         by/Utcjf4FNYtXxQ1CKGj2t85etpmRHQyRWCCDKQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180829231505.22660-3-bjorn.andersson@linaro.org>
Cc:     Sricharan R <sricharan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Craig Tatlor <ctatlor97@gmail.com>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
 <20180829231505.22660-3-bjorn.andersson@linaro.org>
Message-ID: <153567761732.93865.5048429917627072848@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] firmware: qcom: scm: Refactor clock handling
Date:   Thu, 30 Aug 2018 18:06:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-08-29 16:15:04)
> At one point in time all "future" platforms required three clocks, so
> the binding and driver was written to treat this as the default case.
> But new platforms has no clock requirements, which currently makes them
> all a special case, causing the need for a patch in the binding and
> driver for each new platform added.
> =

> This patch reworks the driver logic so that it will attempt to acquire
> all three clocks and fail based on the given compatible. This allow us
> to drop the clock requirement from "qcom,scm", in a way that will remain
> backwards compatible with existing DT files.
> =

> Specific compatibles are added for apq8084, msm8916 and msm8974 to match
> the updated binding and although equivalent to qcom,scm both ipq4019 and
> msm8996 are kept as these have been used without fallback to qcom,scm.
> =

> The result of this patch is that new platforms, that require no clocks,
> can be use the fallback compatible of "qcom,scm".
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

