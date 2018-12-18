Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B910C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AAB21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545148472;
	bh=IYG5JIvTCCrQ2xnpdw3InbnGib5FBiurBC4A/VSwnkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hRuV5Nfb/qJcglABrJ+ldErr+l/VwmzIogeYPU7+/wBNHJgDbtfK8uwhO2Hpa0epd
	 Kq6D7GHKvRZRyAJRN8koSxGJT/W58GGPM96Ni1t6/ros3fDHVakiAaU/wSNhKgNLwR
	 4aCLHaWiAwWFh3TRd+5u9BgEa2cZou0QAOiLuo7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeLRPyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:54:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34583 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:54:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so16153373otk.1;
        Tue, 18 Dec 2018 07:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqpQA/tQCpMTJLT+MYI77+ulnJ5pu9lxMggGQ3JFqdE=;
        b=mVt2e+HNQfx3P4+hpGytx/mf/GICQGOtsgBeV0uxQneXD21d3X7ynJPmn4KOVkjPPD
         ETGjHR1rAwud9nstL/5RXIvHOxqGX8kELo+S73IPf0p37qm/Q1K1pw+zW7SUogwNzJA4
         J2A1miRKavFpVc8WDOp4XR4MstlLRKDaP3QHtjN7dKu6fNRHOux5fe8D9QnxIkdNffiW
         Y6B/5KpJU/JQpqlMuQ6DoPhdIbe7Ww6FjBSxdvFQCpXDxFSyDSLoJ9chp82uS/oJcRwS
         NUSohjqRMmEzdydf0sYxfYaZ5Fxkslee15z5OS8zdr8dSLQnF/2hw9Nr+u7w4D8IDVbw
         v/aw==
X-Gm-Message-State: AA+aEWZ776SQ0f22/bZljoRERT11TFpYhrvXgrhUEPE67NmYGCGDrC3z
        j2m3VhofNoq12kb0L0se8g==
X-Google-Smtp-Source: AFSGD/WNU4wbuPuv7O/eR9LjodatOw/Q60cEovcb3fuzzUJxjNzFlq5rRbK+FcgJjg/bxGwTRQ0KKA==
X-Received: by 2002:a9d:781:: with SMTP id 1mr11735833oto.250.1545148469925;
        Tue, 18 Dec 2018 07:54:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o189sm7944889oif.23.2018.12.18.07.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 07:54:29 -0800 (PST)
Date:   Tue, 18 Dec 2018 09:54:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com, kishon@ti.com,
        faiz_abbas@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated
 message for am65
Message-ID: <20181218155428.GA7670@bogus>
References: <20181207081119.29162-1-faiz_abbas@ti.com>
 <20181207081119.29162-3-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207081119.29162-3-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 13:41:18 +0530, Faiz Abbas wrote:
> Commit 26a4f38d1316 ("dt-bindings: mmc: sdhci-of-arasan: Add new
> compatible for AM654 MMC PHY") added a new compatible for supporting
> controllers on TI's AM65x SOCs. It turns out that the controller is
> not compatible with the arasan driver's phy and consumer model as it
> requires some phy registers for core sdhci functionality. This calls
> for the binding to branch out to a new driver.
> 
> Therefore, add a deprecated message for the ti,am654-sdhci-5.1 binding.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
