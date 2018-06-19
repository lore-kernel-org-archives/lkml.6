Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AFAC28D1F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0C920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE0B7VdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0C920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757404AbeFSVTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757347AbeFSVTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:19:49 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3DE220652;
        Tue, 19 Jun 2018 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529443187;
        bh=ints95HFmTV2bIaYnHJntseYucl2h4ijaXmjTe+ETVI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jE0B7VdVeA5zD6hXt0yUJdWVfDdaqCAEFN6oGZ+xCDmh6H7ALucqgAFl7o1ykrf3n
         Ou++DIG9AKHIlc/fhM7duKcttgPwyWDW1Gp+8sDVnilig5bEN5KiRX7wQ3ODoZ7Tc6
         /b2lA+jSbXnLV5W4mRoKDxsUEoY6DZ+k0xwaMOmo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <152640754443.34267.2752714761157535255@swboyd.mtv.corp.google.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180418000926.4998-1-bjorn.andersson@linaro.org>
 <152640754443.34267.2752714761157535255@swboyd.mtv.corp.google.com>
Message-ID: <152944318698.16708.666113900436407121@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Add some missing gcc clks for msm8996
Date:   Tue, 19 Jun 2018 14:19:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-05-15 11:05:44)
> Quoting Bjorn Andersson (2018-04-17 17:09:26)
> > @@ -3350,6 +3522,7 @@ static struct clk_regmap *gcc_msm8996_clocks[] =
=3D {
> >         [GCC_AGGRE0_CNOC_AHB_CLK] =3D &gcc_aggre0_cnoc_ahb_clk.clkr,
> >         [GCC_SMMU_AGGRE0_AXI_CLK] =3D &gcc_smmu_aggre0_axi_clk.clkr,
> >         [GCC_SMMU_AGGRE0_AHB_CLK] =3D &gcc_smmu_aggre0_ahb_clk.clkr,
> > +       [GCC_AGGRE1_PNOC_AHB_CLK] =3D &gcc_aggre1_pnoc_ahb_clk.clkr,
> >         [GCC_AGGRE2_UFS_AXI_CLK] =3D &gcc_aggre2_ufs_axi_clk.clkr,
> >         [GCC_AGGRE2_USB3_AXI_CLK] =3D &gcc_aggre2_usb3_axi_clk.clkr,
> >         [GCC_QSPI_AHB_CLK] =3D &gcc_qspi_ahb_clk.clkr,
> > @@ -3360,6 +3533,19 @@ static struct clk_regmap *gcc_msm8996_clocks[] =
=3D {
> >         [GCC_PCIE_CLKREF_CLK] =3D &gcc_pcie_clkref_clk.clkr,
> >         [GCC_RX2_USB2_CLKREF_CLK] =3D &gcc_rx2_usb2_clkref_clk.clkr,
> >         [GCC_RX1_USB2_CLKREF_CLK] =3D &gcc_rx1_usb2_clkref_clk.clkr,
> > +       [GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK] =3D
> > +                                       &hlos1_vote_lpass_core_smmu_clk=
.clkr,
> =

> drivers/clk/qcom/gcc-msm8996.c:3512:10: warning: Initializer entry define=
d twice
> drivers/clk/qcom/gcc-msm8996.c:3536:10: also defined here
> =

> Resend please, or at least let me know what to do here. It looks like
> the one you sent has the parent chain setup properly so that the bus
> rcgs are in the chain of clks, while the one that is already there
> doesn't have the chain setup.

Reminder, this fell out as one of the patches I looked at merging for
v4.18 but didn't make the cut because of this confusion.

