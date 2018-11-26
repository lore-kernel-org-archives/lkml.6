Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308BA20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE9zIP8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308BA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKZNXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:23:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44104 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeKZNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:23:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5787326pfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 18:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jpN8ayL886berdPOlUtIPbkGVawvjGnRgBnYDbvlnb8=;
        b=BE9zIP8+LogRQ0KML2Vl5sZ37nqf8ke1sn894Zal3D4+WkmfNX7CcCRUJLga4t+McB
         swzLw5r5LCIxl9QIbzzo+++F1U6Emb/sy5VkFOLuCLoYSUbE2nRqz0N5OThxyxtPLg5A
         wkDJs56NMqCEcn8PrYoCkNedrVww8YxkAJHHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jpN8ayL886berdPOlUtIPbkGVawvjGnRgBnYDbvlnb8=;
        b=jq0jSwIpTh8OyAdaGqLIbWoJhaCOH1JqFqhZxu/xguPWHSpOqm5herBTB8+3jP7Dew
         gyuIeayqT7p5NF/9DnjkdxfxRC0DVNm0GdHPCqX+Ut98SHkfhz3ZdMCPXG3NCj4pkLdv
         wHYSS0/uYLiVEr1RD6+wnB7FgUONPAc8lOKeGKgQR4o+6Q+bVZx6ZLnQ0qz/rlmjNDbW
         lyUsX1mLMooSmr62OG+goPW7Fs1oo1DeESnLwOa3JktVJMp0ydr4+DQQZp85Kej3UUcW
         ZcXFifFi9t0H1NaCbeMTL8/JUIF44dB/XIQEVEz00B6PcS9Lzx+Upjh1oXh4hJEJSKgS
         H9rQ==
X-Gm-Message-State: AA+aEWZivx0b5R5Isjt4rtkHl8fNYBJL33iy1QpAj6VccXe2l8+cJ/oa
        DesJr6h5h5yVP0WvZrbOgK0zrg==
X-Google-Smtp-Source: AFSGD/WFBaMi/h7IGt1bWboV9PaWJB94JXiVev6OOwh4ClFACpQl8xjisOU9l2ZpOJ2H+cfgeSQAbg==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr22358039pgk.406.1543199440660;
        Sun, 25 Nov 2018 18:30:40 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id v12sm69958469pgg.41.2018.11.25.18.30.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 18:30:39 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:30:23 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181126023021.GC20417@dragon>
References: <20181119110812.15825-1-shawn.guo@linaro.org>
 <20181119110812.15825-3-shawn.guo@linaro.org>
 <52433bdc-bc05-2ca0-0822-c9fb702b3231@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52433bdc-bc05-2ca0-0822-c9fb702b3231@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 03:25:33PM +0530, Kishon Vijay Abraham I wrote:
> > +static int qcom_snps_hsphy_por_reset(struct hsphy_priv *priv)
> > +{
> > +	int ret;
> > +
> > +	ret = reset_control_assert(priv->por_reset);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * The Femto PHY is POR reset in the following scenarios.
> > +	 *
> > +	 * 1. After overriding the parameter registers.
> > +	 * 2. Low power mode exit from PHY retention.
> > +	 *
> > +	 * Ensure that SIDDQ is cleared before bringing the PHY
> > +	 * out of reset.
> > +	 */
> > +	qcom_snps_hsphy_exit_retention(priv);
> > +
> > +	/*
> > +	 * As per databook, 10 usec delay is required between
> > +	 * PHY POR assert and de-assert.
> > +	 */
> > +	usleep_range(10, 20);
> > +	ret = reset_control_deassert(priv->por_reset);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * As per databook, it takes 75 usec for PHY to stabilize
> > +	 * after the reset.
> > +	 */
> > +	usleep_range(80, 100);
> > +
> > +	/* Ensure that RESET operation is completed. */
> > +	mb();
> 
> How will you ensure the reset operation is complete with a memory barrier? mb
> usage here looks incorrect to me.

I agree with you, Kishon.  I think memory barrier only ensures the
register write happens rather than that RESET operation completes.
Since the IO accessors already handle memory barrier, I will just drop
the mb() from here and function qcom_snps_hsphy_init_sequence() as well.

@Sriharsha, let us know if you have a story or reason for these memory
barriers.

Shawn
