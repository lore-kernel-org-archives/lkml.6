Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC10FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668DC20C07
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfR07aMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668DC20C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeHVCEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 22:04:16 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45074 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHVCEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 22:04:16 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so34944045oic.12;
        Tue, 21 Aug 2018 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RwmqlgnCRs4TJNhMiqn55R+d42Dq1VMGt16M7XE3D74=;
        b=VfR07aMiJB7WTFbAlyco8JNKBC6lNRIZmJTvE382fA/sOh4PVdPRZfe2qnAWpsZU2f
         PJg2wXQH1hUKxFomtnnxBQDmY9yXaz+Qpkl8r8N3AfwYjp24Am4ka1r+gkcOK2Y+t/PA
         JWjZnTUN3lt0hMo7Psh5dY6+9Xh7Z4iuvoZu4nMPedXY8/hV1ygGBFhRj/mtNbTp8kHK
         O4Mg+8H6+pOJz++/LaPb+RTv8NszjPEXBo0Xv+xfa3VG2UwudmT4v0OQDZxaRxzIMlWp
         NwGIl/fnVE8ynv6ISOCi1NQYPLdWSMyuodZnUZ0QtPtsjgjWZiAwAUejbGvbGriVCrYo
         q4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RwmqlgnCRs4TJNhMiqn55R+d42Dq1VMGt16M7XE3D74=;
        b=uApDdbU+U1ef3WgE1ueyeftPRG3FUPnlHe2R0vMPZqqtL9OHzWgHfNvCqCTmM1Q6c9
         sTFN8ch11bZczPv7Rm9YrO6Cfn2V+3Yp+oZBLkWIc9xT5kQLou23EmfbVI2y5vly6/D2
         BnWNd+uN4RKxNYNDKrdH+7wPgTYw6KCHV4I4NssPXqkNZvQdO7EpfT88WwO/DmKpqGcq
         TevCcRaez6wNrlpyVSSICziRQ/PIFHw2c3BeE5afQnuhLAROok89bvDMk7/6IyRTI56Z
         kZmlvYg3J1Mild9WM7Axl1r4QJmECOgg9JtZXvgnK/WSnbYI0bKBPbyL0/SaeOx5d9Hy
         An+g==
X-Gm-Message-State: APzg51A8XPkwYBf7ERlJXcTrEx/I+4Py+PLNeVjsMgYMH8Kg4LPq5+Yp
        R6igtQw0ekYjWbmMzB1HSmrJRok+IvxjjDibmXI=
X-Google-Smtp-Source: ANB0VdbbiCDMaKNzvs7YzY49jsiJ66gmWN5Q/+JMSLAp5YMDiIoRRERq1u7lgaP2FbbclocSIB9BCiTMKayKRkbPtGg=
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr1289128oie.28.1534891330598;
 Tue, 21 Aug 2018 15:42:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 15:42:10
 -0700 (PDT)
In-Reply-To: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
References: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 21 Aug 2018 19:42:10 -0300
Message-ID: <CAOMZO5Dr9NUXuu+LECp2QHZLRhfbymHK23yCCFW-9jB=VXNn+A@mail.gmail.com>
Subject: Re: [RFC] clk: imx6: Mark imx_clk_mux as glitchy by default
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Liu Ying <victor.liu@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Tue, Aug 21, 2018 at 4:34 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> More concretely on 6qp-sdb blanking the display happens like this:
>  * imx_ldb_encoder_disable switches ipu1_di0_sel to ipu1_di0_pre from ldb_di1_podf
>  * reparenting to ipu1_di0_pre enables it and its parents up to pll5
>  * possibly glitchy muxing
>  * ipu_di_disable disables ipu1_di0 (and parents, up to pll5)

Have you seen such glitch issue in practice with the LDB clocks?

We have already taken care of it in these commits:

commit 5d283b083800867dc329e6433576664bf0fc18d5
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Mon Oct 17 22:29:14 2016 -0200

    clk: imx6: Fix procedure to switch the parent of LDB_DI_CLK

    Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk
    tree, the glitchy parent mux of ldb_di[x]_clk can cause a glitch to
    enter the ldb_di_ipu_div divider. If the divider gets locked up, no
    ldb_di[x]_clk is generated, and the LVDS display will hang when the
    ipu_di_clk is sourced from ldb_di_clk.

    To fix the problem, both the new and current parent of the ldb_di_clk
    should be disabled before the switch. This patch ensures that correct
    steps are followed when ldb_di_clk parent is switched in the beginning
    of boot. The glitchy muxes are then registered as read-only. The clock
    parent can be selected using the assigned-clocks and
    assigned-clock-parents properties of the ccm device tree node:

            &clks {
                    assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
                                      <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
                    assigned-clock-parents = <&clks IMX6QDL_CLK_MMDC_CH1_AXI>,
                                             <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
            };

    The issue is explained in detail in EB821 ("LDB Clock Switch Procedure &
    i.MX6 Asynchronous Clock Switching Guidelines") [1].

    [1] http://www.nxp.com/files/32bit/doc/eng_bulletin/EB821.pdf

    Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Akshay Bhat <akshay.bhat@timesys.com>
    Tested-by Joshua Clayton <stillcompiling@gmail.com>
    Tested-by: Charles Kang <Charles.Kang@advantech.com.tw>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

commit 03d576f202e8cd40d500aa4f7594ad702d861096
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Mon Oct 17 22:29:13 2016 -0200

    clk: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only

    Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk
    tree, the glitchy parent mux of ldb_di[x]_clk can cause a glitch to
    enter the ldb_di_ipu_div divider. If the divider gets locked up, no
    ldb_di[x]_clk is generated, and the LVDS display will hang when the
    ipu_di_clk is sourced from ldb_di_clk.

    To fix the problem, both the new and current parent of the ldb_di_clk
    should be disabled before the switch. As this can not be guaranteed by
    the clock framework during runtime, make the ldb_di[x]_sel muxes read-only.
    A workaround to set the muxes once during boot could be added to the
    kernel or bootloader.

    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

,but I think we should also take care of the other glitchy muxes as
you propose here.
