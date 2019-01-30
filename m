Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634C821473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548863460;
	bh=tS+PJm7qswqqTlYC2vL10l2V4MGr1LtLfus5W6c0lF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qpmG+Gji4gfWDyb/G1l8NUXY7JDlCRYeY3+DPWg1huUHqHPIYYIkebUm4VSu+aS3G
	 F3m+NSNpUzMHKMd3mNASTlcaiwxkWuS1Iu8Tfu9Mb9RqZyhCL4Uy5OlWsLy/xmNZVF
	 mbvuMmtS/0D1WODsWoHki04kFOk/BKBxZ+kwvzFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfA3Pu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:50:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32995 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfA3Pu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:50:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so26952oib.0;
        Wed, 30 Jan 2019 07:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05UvbpA+SO3/QdrZgEcALrEGdL+Mq+yrGswYqrrf44U=;
        b=BeCLUT8tybMQsIfSWikN2SVW4RPCaUkFVrgcEXzwqevYS3uUCBecSK5zop7JcDD88J
         28pZ4nFHaRUzWJhtmHP17gwl15kr54D+fjuwVP7xoENqMHMDeUnpj8eKOxfqjxyC8W0H
         EgmIwqpN1cSN9qyJSno9ktWwgYvv5mmZTi8Me/eIlbTpWCmcnJn7gVMNvyIlwDNx9KPY
         a5ViUzLjLeOvsefwfd6ALxpzrT44w2/0j5QsWy68ou2tOmaTvkl1yOEeEoTgD8nhRwnw
         Dc6GrpizX+qRJlyf/3/80eylOOCV6vheQCvYLU71ecbzhkQVNCX6kOvf6Fbsx4/UGK58
         CI/A==
X-Gm-Message-State: AHQUAuaseCIHjJXQtShMS7px2o07Wd+1gNnvnb66o7fLJDCD0c/sC87g
        o5eH/t2td30ILLLLSHvkpw==
X-Google-Smtp-Source: ALg8bN72Ne5t03XE4AobX6pT4fLRbfP+oNoK62UjK5QXWyHpowmhKmB1v68TCkX7r+z8W3d9i/tcKw==
X-Received: by 2002:aca:b58b:: with SMTP id e133mr12934157oif.25.1548863457510;
        Wed, 30 Jan 2019 07:50:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k16sm646894otl.58.2019.01.30.07.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:50:56 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:50:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v2 04/14] dt-bindings: mailbox: qcom: Add clock-name
 optional property
Message-ID: <20190130155056.GA28494@bogus>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548700381-22376-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 19:32:51 +0100, Jorge Ramirez-Ortiz wrote:
> When the APCS clock is registered (platform dependent), it retrieves
> its parent names from hardcoded values in the driver.
> 
> The following commit allows the DT node to provide such clock names to
> the platform data based clock driver therefore avoiding having to
> explicitly embed those names in the clock driver source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 24 +++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
