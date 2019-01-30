Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD24EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CC12184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548878288;
	bh=auzSKkbIEQQTzGpRyUPk07IQZuonZSp+zZ7+wEqWpfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WOzU4Mx3nOBZMsHVfrq1WEC5AcWdf+fkp2/TCUgei17GpBCHnfXy3RGRV9MAxjDX9
	 +EwRupbLXkTtsRa/VXPy1hAvUeUt0W+YYxPAHifSV6AAR9owsja4cEWFhP2HcrVerm
	 tPv9ESijECCvebPpORpBmorqIUlGLpYloMN2aGh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbfA3T6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:58:07 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33671 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfA3T6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:58:06 -0500
Received: by mail-oi1-f170.google.com with SMTP id c206so742734oib.0;
        Wed, 30 Jan 2019 11:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZcYzu0XjnK7ywS/pcBhJtKfTj5X5hJvMdL0Iq5P8/Y=;
        b=B6zdlDVsqC/QrNclgGDto1OgtMzN2iCjA9jGNo4zbMLtdw8xQQahilzrHVVhjHQqKE
         eXUIca22ipu7e0rm5Pbx/5SH9/zOwQuL796ZWcBbaGiv8vq4JxWXu5ysXXa7MLkW+hTO
         2OyBOe20hbksq0ZbZegVJFK66vMHSRulXu41NS1PyNd6zSoRdyOJ6JXfFTOTZbP5mdVO
         Iq4Z3GVd9uDnDIVqpYdoK/PBANgBSrgDJop/y5JNTCCyhnGyI1qCHjzosUYw+At4R6fI
         dYlVYHKnNFEWZyTXbxDl8f8nDZH1+4rSVQLkLOOEvhsbCyG9filfJZsWRzbdzgkJEQBe
         df9g==
X-Gm-Message-State: AJcUukfJ+Wqs559YH2N93lCYSXH3ghgFBXFFUzlwqal6T2bZ1uuAgbtT
        cxLFDPX/y0h3JLKfH2r0gcQLm+yI/w==
X-Google-Smtp-Source: ALg8bN6hYc4WHO50wzh4bDO+i49t3fFwjsPXLqrIpVkGXV4X4Ic1T0rL0FTHyckX5dygEsZAoOTTAA==
X-Received: by 2002:aca:1702:: with SMTP id j2mr13514559oii.267.1548878285580;
        Wed, 30 Jan 2019 11:58:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c9sm945599otb.38.2019.01.30.11.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:58:04 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:58:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, khasim.mohammed@linaro.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        vkoul@kernel.org, shawn.guo@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] USB SS PHY for Qualcomm's QCS404
Message-ID: <20190130195804.GA5908@bogus>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:35:13PM +0100, Jorge Ramirez-Ortiz wrote:
> This set adds USB SS PHY support to Qualcomm's QCS404 SoC
> The PHY is implemented using Synopsys SS PHY 1.0.0 IP
> 
> The code is losely based on Sriharsha Allenki's
> <sallenki@codeaurora.org> original implementation.
> 
> v2:
>   enable OTG mode detection
>   move vdd voltage levels to driver
>   use bulk_ control interfaces
>   ss-phy-bindings [1]
> 
> [1] ss-phy-binding discussion:
>  - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
>  was never merged. Rather than trying to re-use these bindings (or
>  delete them) I  propose that we go ahead with the new separate
>  bindings for HS and SS: if  not now - investigation  in progress- in
>  the  future  it might be  possible to have again a common phy driver
>  for  which these old  bindings would be the binding agreement. 

Either use/extend the old binding or remove it if it is not being used.

Rob
