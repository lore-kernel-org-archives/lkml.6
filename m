Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B2C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833AF217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJP+qiiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfAWBK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:10:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34765 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfAWBK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:10:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so260291pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 17:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RgICq338Rfpcqt7l6bk977+dsbE4WA9fy3r7TXZFDis=;
        b=MJP+qiiHxWJT/jqPQmXjxrM+UQzfgvBRR+zcuFGs/5JfYlq4VjViQTDfc38UNMsfxI
         cXRBRRuUm9Yha9lhFqA4u6wtickqH+N486oBxImvls7xfFsHhUNHpr1j95NMX5DhlQPp
         0TgvIpo6KtpxepfVCEEUIJl2hwrZa4XOiavz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgICq338Rfpcqt7l6bk977+dsbE4WA9fy3r7TXZFDis=;
        b=T+8trY0+J+Z2CCaSPLEDuJqQpNlAmKQ6vExon/i6jRRsDkD6asDW0k81oMuT0gevHB
         KdzrCVgiwz7g6YPEIBawClAQoCMQyOeptCvAWb4hH+mrLj131gvXRU4aqZl4Rn+hYqdp
         /SdecF2QpKURxsrMHIEYnc3nIndjcZta3twjnXAb0YJMFkHonA4GPopgsFZayp39Pt7z
         kjOIj+Tn/6FjlmnVsuDiGJVGpYq8c1QB6NwdATallhhuwOt7eI+ZbGITd8nuHamGaKPG
         pu/ktgy7b6wtrnlhYFUAU/jBJ28ezuWYC05YpLaHXi/vsJvEP8R7gePyqauBwlLpettH
         z7DQ==
X-Gm-Message-State: AJcUukedCzi1ZZSV+eVVs08wfvQR2ITQXaCLIxO56QqE1O8x8/JTuPfr
        D9PRcGbOcE6ggWoKbOGH9XI+GA==
X-Google-Smtp-Source: ALg8bN6EEuxTD23rjDBgLzvCH9wdn+Az6jXrn9FYBUY+ZtbhRUIWX0Op6xJt//4WfKqkSpt8Lbn9bQ==
X-Received: by 2002:a63:9e58:: with SMTP id r24mr206960pgo.264.1548205825547;
        Tue, 22 Jan 2019 17:10:25 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z14sm19758370pgv.47.2019.01.22.17.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 17:10:24 -0800 (PST)
Date:   Tue, 22 Jan 2019 17:10:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Message-ID: <20190123011022.GJ31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-11-bjorn.andersson@linaro.org>
 <CAD=FV=XuA0Sm0fXfaHtib7+rji1s3s_SmjHc6d_DbEQ1LROq+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XuA0Sm0fXfaHtib7+rji1s3s_SmjHc6d_DbEQ1LROq+A@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 16:28 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Mon, Jan 21, 2019 at 9:52 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > From: Sibi Sankar <sibis@codeaurora.org>
> >
> > This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
> >
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v2:
> > - Picked up Sibi's patch
> > - Fixed reg to work with address/size-cells as 2
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 5cc2615461da..78df5f1bce2d 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1617,6 +1617,64 @@
> >                         clock-names = "xo";
> >                 };
> >
> > +               mss_pil: remoteproc@4080000 {
> > +                       compatible = "qcom,sdm845-mss-pil";
> > +                       reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
> > +                       reg-names = "qdsp6", "rmb";
> > +
> > +                       interrupts-extended =
> > +                               <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
> > +                               <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> > +                               <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> > +                               <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> > +                               <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> > +                               <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> > +                       interrupt-names = "wdog", "fatal", "ready",
> > +                                         "handover", "stop-ack",
> > +                                         "shutdown-ack";
> > +
> > +                       clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
> > +                                <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> > +                                <&gcc GCC_BOOT_ROM_AHB_CLK>,
> > +                                <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
> > +                                <&gcc GCC_MSS_SNOC_AXI_CLK>,
> > +                                <&gcc GCC_MSS_MFAB_AXIS_CLK>,
> > +                                <&gcc GCC_PRNG_AHB_CLK>,
> > +                                <&rpmhcc RPMH_CXO_CLK>;
> > +                       clock-names = "iface", "bus", "mem", "gpll0_mss",
> > +                                     "snoc_axi", "mnoc_axi", "prng", "xo";
> > +
> > +                       qcom,smem-states = <&modem_smp2p_out 0>;
> > +                       qcom,smem-state-names = "stop";
> > +
> > +                       resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
> > +                                <&pdc_reset PDC_MODEM_SYNC_RESET>;
> > +                       reset-names = "mss_restart", "pdc_reset";
> > +
> > +                       qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
> > +
> > +                       power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
> > +                                       <&rpmhpd SDM845_CX>,
> > +                                       <&rpmhpd SDM845_MX>,
> > +                                       <&rpmhpd SDM845_MSS>;
> > +                       power-domain-names = "load_state", "cx", "mx", "mss";
> > +
> > +                       mba {
> > +                               memory-region = <&mba_region>;
> > +                       };
> > +
> > +                       mpss {
> > +                               memory-region = <&mpss_region>;
> > +                       };
> > +
> > +                       glink-edge {
> > +                               interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
> > +                               label = "modem";
> > +                               qcom,remote-pid = <1>;
> > +                               mboxes = <&apss_shared 12>;
> > +                       };
> > +               };
> > +
> >                 sdhc_2: sdhci@8804000 {
> 
> Can you please sort by unit address now that you have a device tree
> that has more stuff?
> 

Of course, sorry for missing that.

Regards,
Bjorn
