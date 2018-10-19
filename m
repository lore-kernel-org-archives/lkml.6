Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8982064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PouQE5fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8982064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJSRLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeJSRLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:11:16 -0400
Received: from localhost (unknown [106.200.232.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857402064A;
        Fri, 19 Oct 2018 09:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539939964;
        bh=wzUNtwyRnyAUzdraZceJTyz87zIdF0S0nCg0zyQDH2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PouQE5fAwKVXYtvI9FHEoKRHTrvvWWstQrCLCO1WufsHL3YDJKY7MppR67lhKUynJ
         IA9YfZHfOl6PCWitNro9us1xeiLF2hdydU5U/RXMqmWJ51OCaSRtOafurDm0YDC72e
         89JbxR+2L0Q5eshrd/UPTV1GVkxGjlANBSCT5b8s=
Date:   Fri, 19 Oct 2018 14:35:55 +0530
From:   Vinod <vkoul@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: pm8941-pwrkey - Add pms405 pwrkey support
Message-ID: <20181019090555.GH2400@vkoul-mobl>
References: <20180920014928.15422-1-bjorn.andersson@linaro.org>
 <20181018052437.GW2400@vkoul-mobl>
 <20181019000116.GD210757@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019000116.GD210757@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-18, 17:01, Dmitry Torokhov wrote:
> On Thu, Oct 18, 2018 at 10:54:37AM +0530, Vinod wrote:
> > On 19-09-18, 18:49, Bjorn Andersson wrote:
> > > From: Vinod Koul <vkoul@kernel.org>
> > > 
> > > Update the binding and driver for pms405 pwrkey.
> > 
> > Rob, Dmitry
> > 
> > Gentle reminder for this patch...
> > 
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 1 +
> > >  drivers/input/misc/pm8941-pwrkey.c                             | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > > index 34ab5763f494..736fba3bad54 100644
> > > --- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > > +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > > @@ -8,6 +8,7 @@ PROPERTIES
> > >  	Definition: must be one of:
> > >  		    "qcom,pm8941-pwrkey"
> > >  		    "qcom,pm8941-resin"
> > > +		    "qcom,pms405-pwrkey"
> > >  
> > >  - reg:
> > >  	Usage: required
> > > diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> > > index 48153e0ca19a..fccf63263c1c 100644
> > > --- a/drivers/input/misc/pm8941-pwrkey.c
> > > +++ b/drivers/input/misc/pm8941-pwrkey.c
> > > @@ -317,6 +317,7 @@ static const struct pm8941_data resin_data = {
> > >  static const struct of_device_id pm8941_pwr_key_id_table[] = {
> > >  	{ .compatible = "qcom,pm8941-pwrkey", .data = &pwrkey_data },
> > >  	{ .compatible = "qcom,pm8941-resin", .data = &resin_data },
> > > +	{ .compatible = "qcom,pms405-pwrkey", .data = &pwrkey_data },
> 
> I am sure I asked this question before (in context of a different
> driver), but why do we need this compatible if we already have
> pm8941-pwrkey compatible? Isn't pms405-pwrkey compatible with
> pm8941-pwrkey as far as power key block goes? In which cases do we need
> new compatibles and when can we reuse existing ones? Rob?

Relooking I do think that reuse of pm8941-pwrkey is entirely feasible,
thanks for the suggestion. We can drop this and I will update DTS

-- 
~Vinod
