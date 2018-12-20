Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F4021741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmRmYrbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbeLTLLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:11:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34749 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbeLTLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:11:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so738405pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 03:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQxCJ/ZPH7GbC+BtIxqFEoElJ4uwznnc56A4ZWlcFl4=;
        b=BmRmYrbD1SnHPJKSmA7bWMy2TBE/PiwDdsZXkyY2NJSBSvZStk/JLUZgw0kgqXWtrN
         ehEIqx4IRnsOky1ulSRT9KB6MUF75viEM1n0vAEwtSEjWb7bgyi+CLfBysh7X2xVeIjN
         WEwWz7p1K8Z0mqbLmkxMVgKI6Ed75hCh9txZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQxCJ/ZPH7GbC+BtIxqFEoElJ4uwznnc56A4ZWlcFl4=;
        b=La4oRgyz7b9+F3ZZCFVj7mYvjRCUCAW6BytTt01x1Jp61n6hip8PADdD4eUfOkNByo
         +uq8EVFzV9uvm+3Ti3khrTaCyVM5ZnfIusJvnWLxedUUFaMCe2+Ob8pIOVn8r4+FnYnd
         6dpvS7ZryeNTpDN1myKig6ytiYrdWiHkYDciFHlkiFo5l1o4UtF5tlTlc35M5V8TNXFe
         xkHflNcpP2N9zZKtK93wxghu2L8j3adJTnA2/t3IBT4RdQV8iFOGt2121nQVIrEKzwWF
         GEDZ8DKbYB4HQ7jwEjI26Lgl6SK6hSgujbPQHaDJFlopdNdUsbxWKsgIDRyCatfsuETa
         5juQ==
X-Gm-Message-State: AA+aEWalUSjP0hGP86V2v/nTuIXM5Cm0N/O0QWHHBSYovL7ArBTMT5Tj
        oNIo3Eh7VVLX7KHZQRXhDcwinA==
X-Google-Smtp-Source: AFSGD/VVrj/P6iIEgBm8+vprX0q5ZLLJoYFKjR4Nn83qLOYDHLjKhsQ1pIO09j3wThP+tXVCA5rNRg==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr21990786pgk.21.1545304277233;
        Thu, 20 Dec 2018 03:11:17 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id v89sm30206809pfk.12.2018.12.20.03.11.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 03:11:15 -0800 (PST)
Date:   Thu, 20 Dec 2018 19:09:58 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     mgautam@codeaurora.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v6 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181220110956.GA17416@dragon>
References: <20181220010112.16824-1-shawn.guo@linaro.org>
 <20181220010112.16824-3-shawn.guo@linaro.org>
 <f106782b6d8e26ebf851f00563c68948@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f106782b6d8e26ebf851f00563c68948@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manu,

On Thu, Dec 20, 2018 at 09:33:43AM +0530, mgautam@codeaurora.org wrote:
> Hi Shawn,
> 
> On 2018-12-20 06:31, Shawn Guo wrote:
> >It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> >is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> >
> >Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >---
> ....
> 
> >+
> >+/* PHY register and bit definitions */
> >+#define PHY_CTRL_COMMON0		0x078
> >+#define SIDDQ				BIT(2)
> >+#define PHY_IRQ_CMD			0x0d0
> >+#define PHY_INTR_MASK0			0x0d4
> >+#define PHY_INTR_CLEAR0			0x0dc
> >+#define DPDM_MASK			0x1e
> >+#define DP_1_0				BIT(4)
> >+#define DP_0_1				BIT(3)
> >+#define DM_1_0				BIT(2)
> >+#define DM_0_1				BIT(1)
> 
> Can we rename these to something more readable? e.g.:
> #define DP_FALL_INT_EN    BIT(4)
> #define DP_RISE_INT_EN    BIT(3)
> ...

Good suggestion.  Will do.

> 
> >+
> >+enum hsphy_voltage {
> >+	VOL_NONE,
> >+	VOL_MIN,
> >+	VOL_MAX,
> >+	VOL_NUM,
> >+};
> >+
> >+enum hsphy_vreg {
> >+	VDD,
> >+	VDDA_1P8,
> >+	VDDA_3P3,
> >+	VREG_NUM,
> >+};
> >+
> >+struct hsphy_init_seq {
> >+	int offset;
> >+	int val;
> >+	int delay;
> >+};
> >+
> >+struct hsphy_data {
> >+	const struct hsphy_init_seq *init_seq;
> >+	unsigned int init_seq_num;
> >+};
> >+
> >+struct hsphy_priv {
> nit-pick - indentation for following structure members?

Hmm, my personal taste says no, because I found that it's hard to keep
the indentation when adding new members later.

> 
> >+	void __iomem *base;
> >+	struct clk_bulk_data *clks;
> >+	int num_clks;
> >+	struct reset_control *phy_reset;
> >+	struct reset_control *por_reset;
> >+	struct regulator_bulk_data vregs[VREG_NUM];
> >+	unsigned int voltages[VREG_NUM][VOL_NUM];
> >+	const struct hsphy_data *data;
> >+	bool cable_connected;
> 
> You can get cable-connected state from "enum phy_mode mode" which
> is present in this driver.
> E.g. cable_connected is false if mode is neither HOST nor DEVICE.
> 
> 
> >+	struct extcon_dev *vbus_edev;
> >+	struct notifier_block vbus_notify;
> 
> extcons not needed if you use "mode" for the same purpose.

The extcon is there for indicating cable connection status.  I'm not
sure that phy_mode can be used for that purpose.  For example, what
value would phy core set phy_mode to, if we disconnect the cable from
phy_mode being HOST or DEVICE?

> 
> 
> >+	enum phy_mode mode;
> >+};
> >+
> 
> 
> >+
> >+static int qcom_snps_hsphy_vbus_notifier(struct notifier_block *nb,
> >+					 unsigned long event, void *ptr)
> >+{
> >+	struct hsphy_priv *priv = container_of(nb, struct hsphy_priv,
> >+						    vbus_notify);
> >+	priv->cable_connected = !!event;
> >+	return 0;
> >+}
> >+
> >+static int qcom_snps_hsphy_power_on(struct phy *phy)
> 
> Can you instead merge this power_on function with phy_init?

I can do that, but what's the gain/advantage from doing that?

> 
> >+{
> >+	struct hsphy_priv *priv = phy_get_drvdata(phy);
> >+	int ret;
> >+
> >+	if (priv->cable_connected) {
> 
> Why distinguish between cable connected vs not-connected?

This is based on the vendor driver implementation.  It does a more
aggressive low power management in case that cable is not connected,
i.e. turning off regulator and entering retention mode.

> 
> >+		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> >+		if (ret)
> >+			return ret;
> >+		qcom_snps_hsphy_disable_hv_interrupts(priv);
> >+	} else {
> >+		ret = qcom_snps_hsphy_enable_regulators(priv);
> >+		if (ret)
> >+			return ret;
> >+		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> >+		if (ret)
> >+			return ret;
> >+		qcom_snps_hsphy_exit_retention(priv);
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static int qcom_snps_hsphy_power_off(struct phy *phy)
> >+{
> >+	struct hsphy_priv *priv = phy_get_drvdata(phy);
> >+
> >+	if (priv->cable_connected) {
> >+		qcom_snps_hsphy_enable_hv_interrupts(priv);
> >+		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> >+	} else {
> >+		qcom_snps_hsphy_enter_retention(priv);
> >+		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> >+		qcom_snps_hsphy_disable_regulators(priv);
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> 
> 
> 
> ..
> >+static const struct phy_ops qcom_snps_hsphy_ops = {
> >+	.init = qcom_snps_hsphy_init,
> >+	.power_on = qcom_snps_hsphy_power_on,
> >+	.power_off = qcom_snps_hsphy_power_off,
> >+	.set_mode = qcom_snps_hsphy_set_mode,
> 
> .phy_exit()?
> I believe that is needed as dwc3 core driver performs
> phy_exit/phy_init across pm_suspend/resume.

I just do not see anything that we should be doing in .exit hook right
now.

Shawn

> 
> 
> >+	.owner = THIS_MODULE,
> >+};
> >+
> 
