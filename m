Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7899C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130B20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb7W6dwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A130B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeLDSkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDSkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:40:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E509520672;
        Tue,  4 Dec 2018 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543948846;
        bh=70FCe/g3xQN8TQUOhW/j45IzCZfy8wgmX9zghLqJmvg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=fb7W6dwaC+lurnNVkMlTjzHA4T3Ew09bB45HwH+1pFtHIHCR13rEpDZPgJnZfaai7
         VBwYlyfUa+LTHFSyQk5EiZ8PUqoSUeFI/MD09ssjtGAj8row1pQv5qXKRZ6qvGR+Ov
         YcboxsQYdJBrG5VyCDrqXvM+LPNZi+7eKa8p1x40=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     k.konieczny@partner.samsung.com, linux-samsung-soc@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204165248.17572-6-k.konieczny@partner.samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
Message-ID: <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Date:   Tue, 04 Dec 2018 10:40:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kamil Konieczny (2018-12-04 08:52:48)
> +
> +static const unsigned long imem_clk_regs[] __initconst =3D {
> +       ENABLE_ACLK_IMEM,
> +       ENABLE_ACLK_IMEM_INT_MEM,
> +       ENABLE_ACLK_IMEM_SSS,
> +       ENABLE_ACLK_IMEM_SLIMSSS,
> +       ENABLE_ACLK_IMEM_RTIC,
> +       ENABLE_ACLK_IMEM_SMMU_SSS,
> +       ENABLE_ACLK_IMEM_SMMU_SLIMSSS,
> +       ENABLE_ACLK_IMEM_SMMU_RTIC,
> +       ENABLE_ACLK_IMEM_ARBG_TX,
> +       ENABLE_ACLK_IMEM_SMMU_ARBG_TX,
> +       ENABLE_PCLK_IMEM,
> +       ENABLE_PCLK_IMEM_SSS,
> +       ENABLE_PCLK_IMEM_SLIMSSS,
> +       ENABLE_PCLK_IMEM_RTIC,
> +       ENABLE_PCLK_IMEM_SMMU_SSS,
> +       ENABLE_PCLK_IMEM_SMMU_SLIMSSS,
> +       ENABLE_PCLK_IMEM_SMMU_RTIC,
> +       ENABLE_PCLK_IMEM_SMMU_ARGB_TX,
> +};
> +
> +static const struct samsung_gate_clock imem_gate_clks[] __initconst =3D {
> +       /* ENABLE_ACLK_IMEM */
> +       GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200=
",
> +                       ENABLE_ACLK_IMEM, 24, 0, 0),
> +       GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
> +                       ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),

Why is there so much use of CLK_IGNORE_UNUSED in this file?

> +       GATE(CLK_ACLK_SROMC, "aclk_sromc", "aclk_imem_200",
