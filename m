Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15484C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE75A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIv/74FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfAaBdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:33:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37738 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfAaBdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:33:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so645916pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 17:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=chNsm4tZb6h6R1hCqWpWWqH84+NHXdtjwPi0mDyvQUo=;
        b=AIv/74FPykLqRDVZLUP/zzAxsj85Wrb1jAk+pcsK5IrMaylr7eMcqsoge4gX2xmLYR
         AQ526RxNzlYsc1SoZS70Yanb3HyWOe2o+LhdOvPIepOhPLQ7r4n/6MeQ3C0B3mIkVLaR
         zghOGoi7kDV69NUO7JGOv/WCRB8d1iAtRF5wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=chNsm4tZb6h6R1hCqWpWWqH84+NHXdtjwPi0mDyvQUo=;
        b=GL8E2vqeSMEvvW7xnEiSbbgYxWKw00lkRBgPAlmQ74cPR+bvQSZ6AnkzJDmOpnMGde
         QlwVoDEj3EbFlWRKSYzP9pp9NKtq1Y++yPHDYec8UWFgvmxeS/gWl1NBtMPKn9I/41Lc
         bQe65P21Ci06kqaQRzYgcLUiQYsmkzSaFSjidZ69bT+KjCPJP9isET+vgq28OLgan/m4
         RQHWGiM0E0e0+Fl2jlCd/j51BJcx55bN5EvN4xUTNYHPVoAK28TZlVw35yh1LsG7Nfhi
         zbdlh/qwc4MMuFcBhLDkKf2u3v4j/EVuNChGDVDbSEkglo0yPA2qGoG7rDRTzujkvwM4
         UK5A==
X-Gm-Message-State: AJcUukcLGBCR60THW6nPmIU3HwN0wF/H28Kl7LE6D1Lg7NUhPgrE/hlW
        ZiHvp3IyDpF3LVnKuIj235viPA==
X-Google-Smtp-Source: ALg8bN4X7e22dn1XUtX8HpTz6jki9FEt6rIGHkPZ2XAMPBYj27h5+bGQFZsg4zd5apaswaCUqVAPOA==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr29316388pge.346.1548898380530;
        Wed, 30 Jan 2019 17:33:00 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a65sm3592302pge.65.2019.01.30.17.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 17:32:59 -0800 (PST)
Date:   Wed, 30 Jan 2019 17:32:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>,
        Alexander Graf <agraf@suse.de>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
Message-ID: <20190131013244.GC27190@builder>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
 <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Jan 09:39 PST 2019, Stephen Boyd wrote:

> Quoting Rajendra Nayak (2019-01-17 20:48:01)
> >  drivers/soc/qcom/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index a5d5167c3f16..1ee298f6bf17 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -109,7 +109,7 @@ config QCOM_RPMHPD
> >  
> >  config QCOM_RPMPD
> >         bool "Qualcomm RPM Power domain driver"
> 
> Just curious, does it need to be bool for some reason?
> 

It's unfortunately not possible to have any genpd, iommu or pinctrl
drivers compiled as modules, because once you pass lateinit probe
deferral is purposefully broken. See
driver_deferred_probe_check_state().

This also means that if you're unlucky and your kernel reached lateinit
before the SMD communication with RPM is established and has brought up
the rpmpd, you are left with a completely broken system. Unfortunately
this isn't that hard to reproduce with a minimal defconfig.

Regards,
Bjorn
