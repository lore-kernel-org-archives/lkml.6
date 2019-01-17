Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3707A20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hh2YrvBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfAQV4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:56:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46355 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:56:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so5015260pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E95iS04JD8c1gfFifaxe2iUtKc4lBX+hCiCCLK5LnMk=;
        b=Hh2YrvBXo62JJT0kCUpxc08K7c3hTqN03MbPJCOluLZXxGufvCOK4k7O1s///wXMSL
         cJhdQkwx7UY3iTeE8VbyVCReMGn1yBu+GEHJIEIvl1WtmvCFd6ABCFmHSYbfqpG8/uRu
         XvNqn4o2rnwZsm+kDpXpYLZ2PjKph5vgG3ou0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E95iS04JD8c1gfFifaxe2iUtKc4lBX+hCiCCLK5LnMk=;
        b=ENp1dEuBVq8TpB4DeoiM6Hk2zi7GTCp4dqSWteuFQDvU4DZ2IiFIwt9slUEgueiM5H
         5EyMphPLeMJrdzpZRKxb5RSQgrQH97BvdHnvwbuPsJVGLEmBZlw/DSOUh6yjF9Qgdf+o
         CO4nCTIHl4UteAd1BgJbBdsu/FXuPBp+GnPQp57+dh4dVKQszabXUvgQfaPWnXS/007v
         U5BIeyVezvVTKQM3svwa7uCGyJChXxKyuxgUyqYuaHBGqhlGDR3FltIw9oXcjNYVCr+C
         NCCWEaPFk+dmNmt7Dm0ALtL+zYF9nxNe2I1iHLd2aRnLFrJdoqfhMKGlHD20qUQRlKSO
         Bzsw==
X-Gm-Message-State: AJcUukea2ceqZ38CTNXGudDRA+vzSPtXp2RyPciDXZVGR12+8taAjVH6
        taw0LJ+ZQ774W4bqcYZ2KnE8cQ==
X-Google-Smtp-Source: ALg8bN4cOrJDZu74k42ORsaNpY0Zg9Pi5YUKzDTy8FYeN59CRIjHfKqx3ShEOZV4EKHMPvgflMJw3g==
X-Received: by 2002:a63:c904:: with SMTP id o4mr14909659pgg.331.1547762198906;
        Thu, 17 Jan 2019 13:56:38 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 125sm3284491pfx.159.2019.01.17.13.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:56:38 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:55:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Add WCN3990 BT node
Message-ID: <20190117215559.GC12955@builder>
References: <20190117044006.12463-1-bjorn.andersson@linaro.org>
 <20190117192812.GV261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117192812.GV261387@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Jan 11:28 PST 2019, Matthias Kaehlcke wrote:

> On Wed, Jan 16, 2019 at 08:40:06PM -0800, Bjorn Andersson wrote:
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
> 
> CTS and RX are input signals, no need to configure drive strength in
> this case IIUC.
> 

Right, didn't think that far when I hacked this up.

> > +		bias-no-pull;
> 
> On another SDM845 based device we observe garbage on RX at
> initialization time, unless we enable a pull-up.
> 
> > +	};
> > +
> > +	rts {
> > +		pins = "gpio46";
> > +		drive-strength = <2>;
> > +		bias-pull-down;
> > +	};
> 
> On our device we don't configure a pull on the lines driven by the
> AP. I think a pull-down on RTS should be fine though since it matches
> the pull (during reset) on CTS of the BT module.
> 
> > +	tx {
> > +		pins = "gpio47";
> > +		drive-strength = <2>;
> > +		bias-pull-up;
> > +	};
> > +};
> 
> Similar to RTS, the pull matches the one on RXD of the BT module.
> 
> For reference, this is what we currently use on our device:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1391888/3/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> 

Thanks, I will update the patch.

Regards,
Bjorn
