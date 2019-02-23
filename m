Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6745B20700
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550881619;
	bh=SP/1cHra3Tcltjz9JkogmABd/tngLTG8rsecyNeAEFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OA5+ZnRX2cRUXm3tUPuM/JTIQgSv5Lzs800i4p2UrdmzTCuRyBiwddrZskN7fvNdc
	 T7hbR6WaqV3uCa/gjRje5ey4UGhMJ3YB4+4Ec6uLqykSdhCK5NoFftGerL4TAKkO0c
	 HWnPO93pRvko67cgeaHllEFGyJMVr+BgWMx9ziOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfBWA06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:26:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34339 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWA05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:26:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id g16so3172527oib.1;
        Fri, 22 Feb 2019 16:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rkTyld8FXlYaOrIXKcaXrW4TiYfGon6V/Ep0+e07DbY=;
        b=jA5SlmjpuRXtxZw/y3CzmB3E/6YPnEJh4287B3W0tj+mxKmWttpho97P+ads6YRu7g
         COukOOdYtI43hk6o09lW3OtK5KxPfDxQ2gqrKk+Y1J5EWRAFUZqXeykbNV/VTuDn3rFz
         zbZm6kXX8EPgHWAkiaE/Iy9werFuerqXvO1FGabOTVl0ASjU0NhihefRrs1PwNkvsqCw
         DQAmIw1zOcwku7WthOrkdF+4gLnCKXVdRpySb0XaKIIgTLO92Fl1roaTGmyl8iQwLjwU
         z13+LzqjyGGz3k17Z4PJnShQiBFgGEd0/jjw4dsqw3r0fwlXWWlg2xzF20XJPLu+g9U1
         +QIQ==
X-Gm-Message-State: AHQUAuYvVtNM7HFdjGZPstFGGWLSaIrP5nytIWJ6Dvy0IYQ1WqQdf/xH
        ekCqy/t91YRbHv559ZCuzw==
X-Google-Smtp-Source: AHgI3IYHqqVAy0KA3BIHqcpiSQMKSAmhAqJqaatlFQyN6e4920C/X78TLWV18/wn+/n8WNveU/bezQ==
X-Received: by 2002:aca:3906:: with SMTP id g6mr4283241oia.149.1550881616409;
        Fri, 22 Feb 2019 16:26:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 97sm1325575otc.25.2019.02.22.16.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:26:55 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:26:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org,
        swboyd@chromium.org
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
Message-ID: <20190223002655.GA6631@bogus>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
 <20190123170758.GB512@tuxbook-pro>
 <5ca1ce61-c458-5550-f89d-ab361f1ec456@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca1ce61-c458-5550-f89d-ab361f1ec456@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 08:41:20PM +0200, Georgi Djakov wrote:
> Hi,
> 
> On 1/23/19 19:07, Bjorn Andersson wrote:
> > On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:
> > 
> >> Add documentation for the interconnect and interconnect-names bindings
> >> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
> >>
> >> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> >> ---
> >>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> >> index dab7ca9..44d7e02 100644
> >> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> >> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> >> @@ -17,6 +17,12 @@ Required properties if child node exists:
> >>  - #address-cells: 	Must be <1> for Serial Engine Address
> >>  - #size-cells: 		Must be <1> for Serial Engine Address Size
> >>  - ranges: 		Must be present
> >> +- interconnects:	phandle to a interconnect provider. Please refer
> >> +			../interconnect/interconnect.txt for details.
> >> +			Must be 2 paths corresponding to 2 AXI ports.
> >> +- interconnect-names:	Port names to differentiate between the
> > 
> > s/Port names/Path names/
> > 
> >> +			2 interconnect paths defined with interconnect
> >> +			specifier.
> > 
> > These two names are significant in that they must match what the driver
> > expects, hence you must actually specify them here.
> > 
> > And as the scope of these strings are local to the QUP node you can omit
> > "qup" from them, so make them "memory" and "config" (or perhaps iface,
> > to match the clock naming?).
> 
> Actually there was a discussion in the past where we decided include
> both the src and dst endpoint names in this property so that there is
> some symmetry with the "interconnects" property. It would be nice to be
> consistent across different drivers at least for now.
> If we want to denote the master and slave ports here, my two cents would
> be for "qup-mem" and "cpu-qup" or something similar?

Well, there's a proposal from Maxime to add 'dma-memory' or something. 
You all need to sort this out.

I assume config or cpu-qup is for register access? Why is this needed? 
That should get described thru the DT tree. The interconnect stuff was 
supposed to be for the non-cpu centric view (i.e. DMA masters). Maybe 
it's fine, but that's not my initial reaction.

Rob
