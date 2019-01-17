Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10544C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CA320859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRT2e9DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfAQVyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:54:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38604 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfAQVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:54:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so5029040pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPiogN1LQUoixBoKl0t+wQb+aHthD2AwFUOA3iGMr0Q=;
        b=eRT2e9DSWxMCOxMuw5NAIqnsfQOIw4LSvMda2qE7BFlccPwG2ohrOiUXBanr5wHvyz
         AD4VZ9m2GT4xfFGIIDvK3emB60BPpt/0cfx83DaCOBPtsK0IH7ZF0w2zcsebu8H4RKJK
         JT7ywAPe/ih65/ZACN80bgr7dHRors5IRt12U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPiogN1LQUoixBoKl0t+wQb+aHthD2AwFUOA3iGMr0Q=;
        b=TZMDpIVlOMb3QGb3/cMVlDRBSZ/nxgYizIstIsqtC/OmEkOQC3kG+lDL25z5LgI1p2
         zZfnRVk3XAsWZTAqsVzl3u1qlbQVCwuXu90sTTmoFldq+yrjkEXbFNbyDwXJsPLnTThp
         Lclz4uEE688W2EJj3QDo47Dw5pj7c5UUBWJ1PuwpFUk2H58ujjbGVy/5a6BZQZKLVCs/
         L1MX0DtkkB1i73+WJv6rLgkLry8to68SQ58kdHskeohcaQrkgpELdj5K1yniqGYbQt4u
         jYmFD3ivCg5C6z3ruqZafX08+2d7/QoHSFi25a8rAyquIhlwdVxQFec0/PmMF6mG9TBC
         /OHw==
X-Gm-Message-State: AJcUukfvRUuNfkEh1sOvoRGccT5BxbMDgWYfUXguBTskwX09InE1yn88
        r9EIr8Z9zMdtMvgcgjzqU+4atQ==
X-Google-Smtp-Source: ALg8bN4jAC6gWEn7q9aTE9nyNHiUVzXIei7KRx8yUImvyLvuBEpe5x4bbQmEPNGfOV5A2B7P4qS0hg==
X-Received: by 2002:a63:295:: with SMTP id 143mr14524774pgc.362.1547762043993;
        Thu, 17 Jan 2019 13:54:03 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m3sm6111266pfi.102.2019.01.17.13.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:54:03 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:53:24 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Add WCN3990 BT node
Message-ID: <20190117215323.GB12955@builder>
References: <20190117044006.12463-1-bjorn.andersson@linaro.org>
 <aebd3bbb4bb3faac2570244af610b43d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aebd3bbb4bb3faac2570244af610b43d@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16 Jan 22:10 PST 2019, Balakrishna Godavarthi wrote:

> Hi Anderson,
> 
> On 2019-01-17 10:10, Bjorn Andersson wrote:
[..]
> > +&qup_uart6_default {
> > +	pinmux {
> > +		pins = "gpio45", "gpio46", "gpio47", "gpio48";
> > +		function = "qup6";
> > +	};
> > +
> > +	ctsrx {
> > +		pins = "gpio45", "gpio48";
> > +		drive-strength = <2>;
> > +		bias-no-pull;
> > +	};
> > +
> > +	rts {
> > +		pins = "gpio46";
> > +		drive-strength = <2>;
> > +		bias-pull-down;
> > +	};
> > +
> > +	tx {
> > +		pins = "gpio47";
> > +		drive-strength = <2>;
> > +		bias-pull-up;
> > +	};
> > +};
> > +
> >  &qup_uart9_default {
> >  	pinconf-tx {
> >  		pins = "gpio4";
> 
> 
> [Bala]:
>        GPIO 45 is CTS
>        GPIO 46 is RTS
>        GPIO 47 is Tx
>        GPIO 48 is Rx.
> 
>        Tx & RTS are inputs to APPS processor, bias should be disable as the
> source i.e. BT chip will pull them up.
>        CTS & RX are outputs from APPS processor, where as CTS is GPIO which
> need to toggled, so the default state should be pull down.
>              RX is should be pulled up.
>        when TX & RX are pulled high it indicates that the lines are ideal
> i.e. no data.
> 
> Above is just my assumption, not sure whether they work on MTP.
> 

I will update and verify.

Thanks,
Bjorn


