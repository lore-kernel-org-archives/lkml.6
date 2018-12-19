Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEAFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A070B20866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QSi2SIEp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fdjkykz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeLSUBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:01:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLSUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:01:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EAEF60593; Wed, 19 Dec 2018 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545249670;
        bh=NF0J2Meb9DZFop87EKE2wT3NpmrRZC00dVdCW1igt10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSi2SIEpTRflv9QFRxAoxUzu6NoCsra325LbiJQH186Nw0OdsDRxBCJPz4WtAscIJ
         x75v+Ey38Rxlij6R9NFFst0C3sXXYmlIcOTeJodQ9EMxo67Y+DTnhLo34b1Xx84tJt
         79TvqhUKAD2VGA23jZqXAiD1zIBI+g8mo5Ij6iXM=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C4BD60132;
        Wed, 19 Dec 2018 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545249669;
        bh=NF0J2Meb9DZFop87EKE2wT3NpmrRZC00dVdCW1igt10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fdjkykz7+8YMbnfyOMcXub2BpYzA6yf4jOb/7CIcuoZ2Mnk1FmGue4AMTovHdi/g0
         BjMQ0LONp1FbWpvjpm6mFNVv2yUWgn/rvCZnBeiBXYUugIAfNj2otMulnt7G2/vpPN
         CAW9qI5iBS5+zzHpHChPpUJJIAldRj8sjeTPuUxk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C4BD60132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 19 Dec 2018 12:01:07 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181219200107.GD1997@jackp-linux.qualcomm.com>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127100722.9993-3-shawn.guo@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Tue, Nov 27, 2018 at 06:07:22PM +0800, Shawn Guo wrote:
> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/phy/qualcomm/Kconfig                  |  10 +
>  drivers/phy/qualcomm/Makefile                 |   1 +
>  .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 529 ++++++++++++++++++

Just caught this...
s/snsp/snps/ in the file name? The bindings doc in Patch 1 is named
correctly.

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
