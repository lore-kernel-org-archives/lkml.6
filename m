Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C8C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608CF208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544824795;
	bh=HM+pvOXnrVygvetIkh6Obe539vg/4SVk5T1UxvWkShU=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=EHL4ZkBLieSLb5qFaP2Xm8WJv2F/hVwbFM/TamOsxgTW1GMVsIR/0To/Moz156hdh
	 g0Dl2LLKvuKDU2hi7Xv6r2dCIgqcH/Ei7EtYAzSwF8Dw0rQ8wdXwLSODpPWn0upXeq
	 X7bbhRCoGZ5SBYUTMVVx5ldyPmmW+HcltdruFRQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeLNV7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731020AbeLNV7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:59:53 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95EEF2080F;
        Fri, 14 Dec 2018 21:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544824793;
        bh=HM+pvOXnrVygvetIkh6Obe539vg/4SVk5T1UxvWkShU=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=QcopODKbU4RpoGGdn8CaiRzYCU/HTo1GxBNIQAkfnin4+0SoY7JLy1pQmUnBNZP/7
         cneCLtH+NeFt0qfa2HRhcAE1F7a3rYarI3yncT//Ffz3m24zhU2bl88o4t8AKcsRqM
         RiVaM/Z7hQugntgLwxpKxMn6fCPjoXD+8PNTFGiM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181210073240.32278-10-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3 08/12] clk: mediatek: Add MT8183 clock support
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com> <20181210073240.32278-10-weiyi.lu@mediatek.com>
Message-ID: <154482479243.19322.7465842539016312943@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Fri, 14 Dec 2018 13:59:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-12-09 23:32:36)
> +       "apll2_ck"
> +};
> +
> +static const struct mtk_mux top_muxes[] =3D {
> +       /* CLK_CFG_0 */
> +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_AXI, "axi_sel",
> +               axi_parents, 0x40,
> +               0x44, 0x48, 0, 2, 7, 0x004, 0, CLK_IS_CRITICAL),

Please document why CLK_IS_CRITICAL is being used everywhere it's used.

> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MM, "mm_sel",
> +               mm_parents, 0x40,
> +               0x44, 0x48, 8, 3, 15, 0x004, 1),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_IMG, "img_sel",
> +               img_parents, 0x40,
> +               0x44, 0x48, 16, 3, 23, 0x004, 2),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_CAM, "cam_sel",
