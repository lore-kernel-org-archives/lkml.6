Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FFBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F80921878
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F80921878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHQRcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:32:22 -0400
Received: from muru.com ([72.249.23.125]:54044 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbeHQRcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:32:22 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4E38A8080;
        Fri, 17 Aug 2018 14:32:29 +0000 (UTC)
Date:   Fri, 17 Aug 2018 07:28:45 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     t-kristo@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm: dts: am4372: setup rtc as system-power-controller
Message-ID: <20180817142842.GB7523@atomide.com>
References: <1532498135-9031-1-git-send-email-j-keerthy@ti.com>
 <20180808090607.GR99251@atomide.com>
 <bc07ac40-accc-64aa-a277-063833645545@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc07ac40-accc-64aa-a277-063833645545@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180808 09:11]:
> 
> 
> On Wednesday 08 August 2018 02:36 PM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [180725 05:59]:
> >> RTC alarm2 is connected to pmic_en line and hence can be used to control
> >> the pmic enabling/disabling. Hence add the system-power-controller for rtc
> >> node.
> >>
> >> Signed-off-by: Keerthy <j-keerthy@ti.com>
> >> ---
> >>  arch/arm/boot/dts/am4372.dtsi | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> >> index f0cbd86..d4b7c59 100644
> >> --- a/arch/arm/boot/dts/am4372.dtsi
> >> +++ b/arch/arm/boot/dts/am4372.dtsi
> >> @@ -469,6 +469,7 @@
> >>  			ti,hwmods = "rtc";
> >>  			clocks = <&clk_32768_ck>;
> >>  			clock-names = "int-clk";
> >> +			system-power-controller;
> >>  			status = "disabled";
> >>  		};
> >>  
> > 
> > Should this be queued as a fix for v4.19-rc series?
> 
> Yes this makes pmic to shutdown during power off.

OK thanks applying into omap-for-v4.19/fixes.

Tony
