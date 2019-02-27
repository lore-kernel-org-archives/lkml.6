Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D590FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F6021873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2AxPD1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfB0SJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:09:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39369 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfB0SJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:09:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so7818412pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W2OUFSd0FP3lORhut5RaNw1VzmkYP+Tqe9cEC63o4kU=;
        b=X2AxPD1RrJ9jYu+gE7BgffwOBUn+KRu++KX+lUgX/ziP/o7t6UsTEPMK6WmrM2pruZ
         YAA/Si5RpEuwpxqnvfPzPdPLlbVtTl4L4XQ3kZ96JNqxN6pey27VPIfSTF3pWmruYaXc
         g1dSterF/svsXaOMBTvqgMES2SvuVUGgA/aY9uHrz5hvqiDyPLbiV5kr8v/5QxGZV3j0
         q7TQdKQEBWzy+0S3gUJxH6GvGsprGdvHV8AEPiDFP5yJqfgXCAIcI1+daUUo53QOQ39J
         JzxgzNnZpyoFCyRZ1NckjTTk1pljNBi6XeY75XYehh98CFsl97wkrjhILOaKqO5PjmJP
         X1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W2OUFSd0FP3lORhut5RaNw1VzmkYP+Tqe9cEC63o4kU=;
        b=BnfuWL7/xO1LJcZASzVoiTriLyvGWHTmFpAUMJdu5fRswxywtEW24TEjuxN1m3DiwQ
         I2KYR7OTCvvXs4NtDE6nVHIPwSV9Lao08elGVSanr5rm5+EdzXMEIrjPs3eusgik+vgA
         TSrjOYLrn4emp5Ag0jzvttRk8vzoaOF4tnnm2B86NLAPS8332h8/vmwhx6erF67WqVgB
         cfhg6b91XqAMKgd5KodvAIpJ3NY+p5n08U/lfhw/xbjRBemPI8WRQcQmoW1nwApp/uP/
         UgybqdQFQ1xtsUuUq/jQu+Rs/YUyvVfp6qy9bffsRYkKIdhb3f2SfGfeMLpQBU8cbBvT
         rjRg==
X-Gm-Message-State: AHQUAuaFUIu3w0B3GRcykIZJ6ZRFsqraGyNmm2rFDbu44udnLKClAK5T
        o85qQxShvZi8IWzYeTu4D/z3Sw==
X-Google-Smtp-Source: AHgI3IYLkYETbHnXk81CULmrJRZmRbyV/Ue/YRbu8Mj1rdb984tP0QjVn6NvdnvP3Baf/Kb17KguRw==
X-Received: by 2002:a63:4d4f:: with SMTP id n15mr4185178pgl.327.1551290995391;
        Wed, 27 Feb 2019 10:09:55 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g3sm21724039pgg.41.2019.02.27.10.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 10:09:54 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:09:52 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
Message-ID: <20190227180952.GA1803@tuxbook-pro>
References: <20190226065919.22218-1-bjorn.andersson@linaro.org>
 <b17f2c12-fd2c-549e-92b9-96a422e5f07c@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b17f2c12-fd2c-549e-92b9-96a422e5f07c@free.fr>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Feb 01:27 PST 2019, Marc Gonzalez wrote:

> On 26/02/2019 07:59, Bjorn Andersson wrote:
> 
> > qcom_qmp_phy_init() is extended to support the additional register
> > writes needed in PCS MISC and the appropriate sequences and resources
> > are defined for SDM845.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   7 +
> >  drivers/phy/qualcomm/phy-qcom-qmp.c           | 160 ++++++++++++++++++
> >  drivers/phy/qualcomm/phy-qcom-qmp.h           |  12 ++
> >  3 files changed, 179 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > index 5d181fc3cc18..dd2725a9d3f7 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > @@ -11,6 +11,7 @@ Required properties:
> >  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
> >  	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
> >  	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
> > +	       "qcom,sdm845-qmp-pcie-phy" for PCIe phy on sdm845,
> >  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> >  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
> >  	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> > @@ -48,6 +49,10 @@ Required properties:
> >  			"aux", "cfg_ahb", "ref".
> >  		For "qcom,msm8998-qmp-ufs-phy" must contain:
> >  			"ref", "ref_aux".
> > +		For "qcom,sdm845-qmp-usb3-phy" must contain:
> > +			"aux", "cfg_ahb", "ref", "refgen".
> 
> qcom,sdm845-qmp-usb3-phy in a PCIe patch?
> 

Must have forgotten to fix it up after copy pasting the other line,
thanks for spotting.

> > +		For "qcom,sdm845-qmp-usb3-phy" must contain:
> > +			"aux", "cfg_ahb", "ref", "com_aux".
> 
> qcom,sdm845-qmp-usb3-phy again in a PCIe patch?
> 

Ditto.

> 
> > +static const struct qmp_phy_init_tbl sdm845_pcie_pcs_misc_tbl[] = {
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_CONFIG2, 0x52),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG2, 0x10),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG4, 0x1a),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG5, 0x06),
> > +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
> > +};
> 
> I was thinking I might need to do the same for msm8998, since downstream
> tweaks pcs_misc + 0x2c = 0x52
> (dunno if that's QPHY_V3_PCS_MISC_OSC_DTCT_CONFIG2)
> 

Yeah, we probably should add the 8998 sequences as well. I haven't been
able to compare the two side by side, but it's expected that they will
be slightly different.

> The thing is, phy driver writes unconditionally to pcs_misc + 0x0c
> (QPHY_V3_PCS_MISC_CLAMP_ENABLE). Should that be moved elsewhere?
> 

I spotted this as the only difference in the initialization sequence,
but concluded that it seems to work fine as it is. So I left that part
intact.

Regards,
Bjorn
