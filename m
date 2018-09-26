Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8216B20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FQwlXdpq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pKSFAMvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8216B20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeIZUrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:47:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIZUrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:47:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4FD7060B72; Wed, 26 Sep 2018 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537972479;
        bh=pwYOOaqj6aC5+ihKhw/JZn1+0xD8ppIn7wUUDhj/aF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQwlXdpqdlaDniefWgSHh3A7WPwuitM9r84Ak6Dd+/iVsHFnoY6Hfq5CLWCSOHHlI
         tiD0zzb/exMZr83B6lY2eQsJ3Lgo74Kqf9cFy+t+SnMu/yhxJL+cjlrw2/Hq04S0eU
         zddg11aww1WFp3ZbJkqlHh0/+xEzdrwJYIZlqb2M=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4582B6021C;
        Wed, 26 Sep 2018 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537972477;
        bh=pwYOOaqj6aC5+ihKhw/JZn1+0xD8ppIn7wUUDhj/aF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKSFAMvRTqxvd0FWsB3KFob71FfPp4qRz86SBLLvCGakzP2cKkr+p30Ss+3q4x0yK
         V1ZQQjYVqi3JChjGECVx53sTe6Z9IdwIA/XQX22NvXsy8sX26OV6o85XqXBoDGheM/
         GUT6NsWn+Ph/8hhrTJPh4ubi1WCLEn5Dl/NQU2A8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4582B6021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 26 Sep 2018 08:34:33 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Message-ID: <20180926143432.GH10761@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        robdclark@gmail.com
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925180215.GA12435@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:02:15PM -0500, Rob Herring wrote:
> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
> > This binding is intended to represent the relations between the interconnect
> > controllers (providers) and consumer device nodes. It will allow creating links
> > between consumers and interconnect paths (exposed by interconnect providers).
> 
> As I mentioned in person, I want to see other SoC families using this 
> before accepting. They don't have to be ready for upstream, but WIP 
> patches or even just a "yes, this works for us and we're going to use 
> this binding on X".
> 
> Also, I think the QCom GPU use of this should be fully sorted out. Or 
> more generically how this fits into OPP binding which seems to be never 
> ending extended...

This is a discussion I wouldn't mind having now.  To jog memories, this is what
I posted a few weeks ago:

https://patchwork.freedesktop.org/patch/246117/

This seems like the easiest way to me to tie the frequency and the bandwidth
quota together for GPU devfreq scaling but I'm not married to the format and
I'll happily go a few rounds on the bikeshed if we can get something we can
be happy with.

Jordan

> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > new file mode 100644
> > index 000000000000..5cb7d3c8d44d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > @@ -0,0 +1,60 @@
> > +Interconnect Provider Device Tree Bindings
> > +=========================================
> > +
> > +The purpose of this document is to define a common set of generic interconnect
> > +providers/consumers properties.
> > +
> > +
> > += interconnect providers =
> > +
> > +The interconnect provider binding is intended to represent the interconnect
> > +controllers in the system. Each provider registers a set of interconnect
> > +nodes, which expose the interconnect related capabilities of the interconnect
> > +to consumer drivers. These capabilities can be throughput, latency, priority
> > +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> > +depending on the use case. Interconnect providers can also be interconnect
> > +consumers, such as in the case where two network-on-chip fabrics interface
> > +directly
> 
> missing '.'
> 
> > +
> > +Required properties:
> > +- compatible : contains the interconnect provider compatible string
> > +- #interconnect-cells : number of cells in a interconnect specifier needed to
> > +			encode the interconnect node id
> > +
> > +Example:
> > +
> > +		snoc: snoc@580000 {
> > +			compatible = "qcom,msm8916-snoc";
> > +			#interconnect-cells = <1>;
> > +			reg = <0x580000 0x14000>;
> > +			clock-names = "bus_clk", "bus_a_clk";
> > +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> > +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> > +		};
> > +
> > +
> > += interconnect consumers =
> > +
> > +The interconnect consumers are device nodes which dynamically express their
> > +bandwidth requirements along interconnect paths they are connected to. There
> > +can be multiple interconnect providers on a SoC and the consumer may consume
> > +multiple paths from different providers depending on use case and the
> > +components it has to interact with.
> > +
> > +Required properties:
> > +interconnects : Pairs of phandles and interconnect provider specifier to denote
> > +	        the edge source and destination ports of the interconnect path.
> > +
> > +Optional properties:
> > +interconnect-names : List of interconnect path name strings sorted in the same
> > +		     order as the interconnects property. Consumers drivers will use
> > +		     interconnect-names to match interconnect paths with interconnect
> > +		     specifiers.
> 
> specifier pairs.
> 
> > +
> > +Example:
> > +
> > +	sdhci@7864000 {
> > +		...
> > +		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> > +		interconnect-names = "ddr";
> > +	};

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
