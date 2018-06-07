Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4X4KCv2yGFuJYQAAmS7hNA
	; Thu, 07 Jun 2018 04:22:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2D1C4608BA; Thu,  7 Jun 2018 04:22:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMYYoW4v"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A90F56089E;
	Thu,  7 Jun 2018 04:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A90F56089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeFGEWk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 00:22:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43130 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeFGEWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 00:22:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id a14-v6so3459973pgw.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 21:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r1SZ0yGw1NPDUsukctEMR4knqWdA4cs7D8GQD/tXXCY=;
        b=RMYYoW4v3XRBsw+RuYlOG1KObpaGm/dtPqrWKIBKXgryuq/X4Km5ag03Y1hdw3lzeq
         BFhcJAoHr8pBX2x88svY7vNj0Ze5+67RxyxfMLBh5tIRKNHlt0Hw6txyEmYp4wnp+50V
         wwEzRouzMznMUcb6WK5GPfsdGFlPpPeYT1IdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1SZ0yGw1NPDUsukctEMR4knqWdA4cs7D8GQD/tXXCY=;
        b=fUGRIVpnaXx9VE9hghWxKBi/b48LcsLZ4EcYEM8QZi8IBvj3cZWqs/8BSi6XFs3L+7
         HWxaqF5ENww918/eCXhovreWk061lPx7ZarpNjgY3b6bqzE7vYnEqslzpWA1hgpiQwFy
         WWAbwmenb7GxU90yaBYtD5Idn4fO75c0QFmIQFYdWdZG8nCF0/1iWLEdU6n54s0MZYmU
         NymbXrDf7TGCxmUWz1mRGeqxNd7b80Z1IjwAlZi3KnUEjxl8MoC4Avshuq+F6DFUfH7r
         nN3gFhJkua2ZeAzfYU/2Bz3UihcCu5LWKSIlZdg1mBgpfSsJUGyyWmVwthsJ95DR8Jq7
         WXgQ==
X-Gm-Message-State: APt69E3C0yTXUQuT3WD+dZjLPlIRBfikDS/aUu3qHK6M8OfuxjQug+UQ
        5KPzGlNi4bOZtt1eedsvSRg7Kg==
X-Google-Smtp-Source: ADUXVKJAFgxky0AN4CVeuFSd9d6RqEhXVB4ekuQnBTrMWKcDn4symjZv8pfHLYI+jQM5y6gbWmLXYA==
X-Received: by 2002:a65:6119:: with SMTP id z25-v6mr248954pgu.139.1528345357021;
        Wed, 06 Jun 2018 21:22:37 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s17-v6sm113088566pfi.165.2018.06.06.21.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 21:22:36 -0700 (PDT)
Date: Wed, 6 Jun 2018 21:24:43 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vinod <vkoul@kernel.org>
Cc: Sricharan R <sricharan@codeaurora.org>, ohad@wizery.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
Message-ID: <20180607042443.GK510@tuxbook-pro>
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180606161733.GE510@tuxbook-pro>
 <20180607041134.GF16230@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607041134.GF16230@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Jun 21:11 PDT 2018, Vinod wrote:

> On 06-06-18, 09:17, Bjorn Andersson wrote:
> > On Tue 05 Jun 05:56 PDT 2018, Sricharan R wrote:
> > 
> > > Hi Vinod,
> > > 
> > > On 6/5/2018 11:49 AM, Vinod wrote:
> > > > On 05-06-18, 11:12, Sricharan R wrote:
> > > > 
> > > >> +config QCOM_Q6V5_WCSS
> > > >> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
> > > >> +	depends on OF && ARCH_QCOM
> > > >> +	depends on QCOM_SMEM
> > > >> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> > > >> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> > > > 
> > > > Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
> > > > happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM
> > > > 
> > 
> > It says that QCOM_Q6V5_WCSS either must have a compatible state (i.e.
> > builtin vs builtin, module vs builtin, but not builtin vs module) or
> > that it's disabled, in which case we will hit the stub functions in
> > qcom_glink.h.
> > 
> > I.e. this prevents QCOM_Q6V5_WCSS to be compiled builtin when
> > RPMSG_QCOM_GLINK_SMEM is module, as this would give us both stubs and
> > the module.
> 
> IIUC, you want to have QCOM_Q6V5_WCSS and RPMSG_QCOM_GLINK_SMEM as
> modules or builtin
> 

RPMSG_QCOM_SMD, RPMSG_QCOM_GLINK_SMEM and QCOM_Q6V5_WCSS are all
tristate.

> So, wouldn't Kconfig syntax something like where we say:
>         M if RPMSG_QCOM_GLINK_SMEM=m
>         bool if RPMSG_QCOM_GLINK_SMEM=y
> 

If we ignore SMD for a while we have the following combinations:

glink/wcss
y     y - valid
y     m - valid
y     n - valid
m     y - link failure (invalid)
m     m - valid
m     n - valid
n     y - valid (platform uses wcss, but not glink)
n     m - valid (-----"-----)
n     n - valid

So to distill this we have the two valid cases:
module/no if RPMSG_QCOM_GLINK_SMEM=m
yes/module/no if RPMSG_QCOM_GLINK_SMEM=y

and the way you express that in Kconfig is the somewhat awkward

  depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n

> Which makes it clear that both these have to be same type?
> 

They don't have to be of the same type, only of a compatible type.

Regards,
Bjorn
