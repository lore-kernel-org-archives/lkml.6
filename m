Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pVmREoWwGFsHSgAAmS7hNA
	; Thu, 07 Jun 2018 04:11:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2ADE06089E; Thu,  7 Jun 2018 04:11:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga5UPEns"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9E7C760115;
	Thu,  7 Jun 2018 04:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E7C760115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbeFGELq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 00:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbeFGELn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 00:11:43 -0400
Received: from localhost (unknown [106.200.248.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603DD205F4;
        Thu,  7 Jun 2018 04:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528344703;
        bh=E+xSOpO67yIH/8LYX8s3xL0jdE3Mn7TDHNHIMrREp7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ga5UPEnszGyMrgXxRWthxaKrdt5MPSSAuoyE/+uUlIVdAuG+GCwQRLpci4SmPGDJ8
         5tgrYOv8TxloNuJJMMSgdrI1Gp3GH+NOQU1CW5xP/DMpKiHugZGxVYrx92erw1/cx8
         zJBDXuN5RDEOX2gf8xn+VwOMXfp6wXeXsWpi92wo=
Date: Thu, 7 Jun 2018 09:41:34 +0530
From: Vinod <vkoul@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Sricharan R <sricharan@codeaurora.org>, ohad@wizery.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
Message-ID: <20180607041134.GF16230@vkoul-mobl>
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180606161733.GE510@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606161733.GE510@tuxbook-pro>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-18, 09:17, Bjorn Andersson wrote:
> On Tue 05 Jun 05:56 PDT 2018, Sricharan R wrote:
> 
> > Hi Vinod,
> > 
> > On 6/5/2018 11:49 AM, Vinod wrote:
> > > On 05-06-18, 11:12, Sricharan R wrote:
> > > 
> > >> +config QCOM_Q6V5_WCSS
> > >> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
> > >> +	depends on OF && ARCH_QCOM
> > >> +	depends on QCOM_SMEM
> > >> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> > >> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> > > 
> > > Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
> > > happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM
> > > 
> 
> It says that QCOM_Q6V5_WCSS either must have a compatible state (i.e.
> builtin vs builtin, module vs builtin, but not builtin vs module) or
> that it's disabled, in which case we will hit the stub functions in
> qcom_glink.h.
> 
> I.e. this prevents QCOM_Q6V5_WCSS to be compiled builtin when
> RPMSG_QCOM_GLINK_SMEM is module, as this would give us both stubs and
> the module.

IIUC, you want to have QCOM_Q6V5_WCSS and RPMSG_QCOM_GLINK_SMEM as
modules or builtin

So, wouldn't Kconfig syntax something like where we say:
        M if RPMSG_QCOM_GLINK_SMEM=m
        bool if RPMSG_QCOM_GLINK_SMEM=y

Which makes it clear that both these have to be same type?

-- 
~Vinod
