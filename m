Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535DC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130B20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg2LK28A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A130B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJSIEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:04:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:04:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so14936256pgm.7;
        Thu, 18 Oct 2018 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LKh/SE8ixOEm7r9y+VXef1Xuo27KdKeNGIx79XYrmTg=;
        b=Kg2LK28ARwUSgD/FKaurWfVyIIyrpUxUlqInyngL6piou+ZmQ/YGk2YqR7ZbZMmSSQ
         HkaUPajAxE0DdnXFJwfL18XwtQePkniGTMSC6FkvbP2Qzl6hN9R58klvadXmKVNeFJST
         4/02B5VQppQ4pewrZ1698D4fxrsN5Cc2giVyA0wiegSgtMo6KXJ/NhcFWLU8xUaxfFHK
         3XWOIo1ADRtE12Ogy3YHV5itda23A3DGYPubXo1qAaZ8WyEp8Bnwh8Pgy3zloYg9h1nI
         X18Avd4wJztspzwb+OrVOeINRRl3/uowtv6Oh0SVLufGeyqIByzeiffZja8WJhqSCFEu
         /fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LKh/SE8ixOEm7r9y+VXef1Xuo27KdKeNGIx79XYrmTg=;
        b=otVKAsPuWMJqJC692UZ3K4MD9ZJwenmngonBkH+6CSdX1chcN0lJD7IcYeZ0DWugjd
         KQMV79u5+nIYKiMNZDRe2L1ZmPrLQfO4WRwxrLglqq01dvs3fHEocAXkkWXzt4gdeQYs
         fgCXhKj9ya8yLT+lSLW1E60mlhOq4mrsOAF9ylx56mtyAFglnGhLo+mmNSsyRnRvJ8J2
         6yE9oZnjJHIln3isDbxlMQp+4+sOkW57Y0E9HEasaN8lAHUj5EawxndYwBKbvDp7i8zd
         EZHS0bIm0lt0abQynXZae09cKyWdhI9P4nWHjN8JkSoXF4BRPGixrlcDsWKvjYJERSfe
         J48w==
X-Gm-Message-State: ABuFfohNT8YKRfVziJ3BYZYmG0L94HfvYAkTqyYjajgYbTlXmaC76QSl
        e/eMvTT5XihrZjit6rooBSQ=
X-Google-Smtp-Source: ACcGV6260pF05PrdYtPa1lujAx2FaOC9YcFjhxJW9QkO4vQ7vNwhxjkqKujogrVoXmCdMYV0lUaEXQ==
X-Received: by 2002:a62:c2c1:: with SMTP id w62-v6mr32092819pfk.35.1539907279509;
        Thu, 18 Oct 2018 17:01:19 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h8-v6sm30806270pgg.23.2018.10.18.17.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:01:18 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:01:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: pm8941-pwrkey - Add pms405 pwrkey support
Message-ID: <20181019000116.GD210757@dtor-ws>
References: <20180920014928.15422-1-bjorn.andersson@linaro.org>
 <20181018052437.GW2400@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018052437.GW2400@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:54:37AM +0530, Vinod wrote:
> On 19-09-18, 18:49, Bjorn Andersson wrote:
> > From: Vinod Koul <vkoul@kernel.org>
> > 
> > Update the binding and driver for pms405 pwrkey.
> 
> Rob, Dmitry
> 
> Gentle reminder for this patch...
> 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt | 1 +
> >  drivers/input/misc/pm8941-pwrkey.c                             | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > index 34ab5763f494..736fba3bad54 100644
> > --- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
> > @@ -8,6 +8,7 @@ PROPERTIES
> >  	Definition: must be one of:
> >  		    "qcom,pm8941-pwrkey"
> >  		    "qcom,pm8941-resin"
> > +		    "qcom,pms405-pwrkey"
> >  
> >  - reg:
> >  	Usage: required
> > diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> > index 48153e0ca19a..fccf63263c1c 100644
> > --- a/drivers/input/misc/pm8941-pwrkey.c
> > +++ b/drivers/input/misc/pm8941-pwrkey.c
> > @@ -317,6 +317,7 @@ static const struct pm8941_data resin_data = {
> >  static const struct of_device_id pm8941_pwr_key_id_table[] = {
> >  	{ .compatible = "qcom,pm8941-pwrkey", .data = &pwrkey_data },
> >  	{ .compatible = "qcom,pm8941-resin", .data = &resin_data },
> > +	{ .compatible = "qcom,pms405-pwrkey", .data = &pwrkey_data },

I am sure I asked this question before (in context of a different
driver), but why do we need this compatible if we already have
pm8941-pwrkey compatible? Isn't pms405-pwrkey compatible with
pm8941-pwrkey as far as power key block goes? In which cases do we need
new compatibles and when can we reuse existing ones? Rob?

Thanks.

-- 
Dmitry
