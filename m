Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA68D222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550048756;
	bh=CVPeviQr6pkeBRYFnlVqpb6aU+HdS7oim2DPqKrxWS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PLCvrp78KXX452JcozjBN8kNKnvWK3y6TLEG1UMmRWJIwBBEV0lkudoCHSirl3SZ1
	 8+X7EFiqatxX0mX1q6eNyCPeL/h0lz6ML6BmQ+/4IISqzGN6IQm/chPwvq5DDALEGT
	 yqPHQdDbcUbJYpEaPNu5ZOhOE5AmzwjbMX0XA19Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391229AbfBMJFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:05:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47100 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfBMJFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:05:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so1144517lfc.13;
        Wed, 13 Feb 2019 01:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DBG1R/qgj+N6ZSMlzb4Tj+z73fWz7s80r8Fcu4eKLH8=;
        b=knMfIHxZlRNq8IiCk5hKLCMwp/cFW9spn3ZeZMyXWcjeo4cgvS0nKruzI+LcXf+pJ2
         lPeNtKO4FwQ6zNQZ+jdpkJe31NMAcr/c+/zYj3PVQ16PY5DmKktqUQdKw2RoBiYVxPqH
         O4sKNxtxoQYSV6RldWkMlTPnyjwouUWmZOztV/kQ0hySnmpXyeeXqBBSfYDwE7wG8RXu
         0rvTo5vcs1C9Gy0+zw0/UkYRi5OVw8tXMF73yytRG7MSq47KVyIStq9B8dO2Mhmvf8Vy
         Lx3lx4Xq32ohVkkBdhgdlOUXytOKqs4fuoAWMlWYfJv/78FW2SAio9Du05PhK+aYrrec
         bpgw==
X-Gm-Message-State: AHQUAuYHBJjCglaMJySvm1WJ9D8ZFFJq9dxag/P7y7m5iUm6r71wJUl9
        NCbohOjH6E6seESRzoCesuo=
X-Google-Smtp-Source: AHgI3IZe+UxRRn3VCxXRfKFeul/y+r4Tmn0ny9ffgFI7MvuC2nOXjfoI+68/6DTo+3BDmjZbTqGu7w==
X-Received: by 2002:a19:9dd1:: with SMTP id g200mr5069335lfe.127.1550048752011;
        Wed, 13 Feb 2019 01:05:52 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v24-v6sm3182437ljj.65.2019.02.13.01.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 01:05:51 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtqUC-0007Zu-Lt; Wed, 13 Feb 2019 10:05:44 +0100
Date:   Wed, 13 Feb 2019 10:05:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] arm64: dts: msm8996: fix blsp2_uart1 4-pin pinconfig
Message-ID: <20190213090544.GE28278@localhost>
References: <20181220161750.12587-1-johan@kernel.org>
 <20190212210656.GA6642@hector.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212210656.GA6642@hector.attlocal.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:06:56PM -0600, Andy Gross wrote:
> On Thu, Dec 20, 2018 at 05:17:50PM +0100, Johan Hovold wrote:
> > Fix "gpiio5" typo in the (currently unused) blsp2_uart1 4-pin sleep
> > config.
> > 
> > Fixes: 22e6789f9493 ("arm64: dts: msm8996: add blsp2_uart1 pinctrl")
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> > index c5c42e94f387..1d1f7f91739a 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> > @@ -139,7 +139,7 @@
> >  		};
> >  
> >  		pinconf {
> > -			pins = "gpio4", "gpiio5", "gpio6", "gpio7";
> > +			pins = "gpio4", "gpio5", "gpio6", "gpio7";
> >  			drive-strength = <2>;
> >  			bias-disable;
> >  		};
> 
> I took one in slightly older than this one.  However, it doesn't have the fixes
> line.
> 
> 
> commit ff10032fb309d0baa0b79e28009bf154de08d341
> Author: Jakob Wuhrer <jakobwuhrer@airmail.cc>
> Date:   Fri Dec 14 18:01:30 2018 +0100
> 
>     arm64: dts: qcom: Correct "gpiio" typo in msm8996-pins
> 
>     gpiio5 is missspelt in msm8996-pins.dtsi, fix that.
> 
>     Signed-off-by: Jakob Wuhrer <jakobwuhrer@airmail.cc>
>     Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>     Signed-off-by: Andy Gross <andy.gross@linaro.org>

That's funny, submitted six days before mine for a 2+ year old issue.

The typo would prevent the pin from being reconfigured (hence the stable
tag), but at least you'd get a runtime warning when trying to set this
config.

Johan
