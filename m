Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3551FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5E121476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/6quLI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5E121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJTCLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeJTCLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:11:16 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25BB421470;
        Fri, 19 Oct 2018 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539972248;
        bh=l+48uxuwMCp7aRsfH+1ouqo/EKevGKWiDgWwWjFUyQs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=G/6quLI11VAdoY6U1q62BFJM1SRRDiLucuJraWbh95MdyrmYwdLbSmly4rkLnnw+D
         uX+QD9yckHwORS7SpOI38/j9v5RT4FncaxOjlkW+IxPhZm2Y+FNrCMpMcert2pAO3H
         gKdTgpc/2ygdBCW59vEIgqDl49Jj5+Z6z7+y43Ek=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <efc5b030-f344-80ce-f57e-582207f436fe@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <153988248599.5275.8444799485095155762@swboyd.mtv.corp.google.com>
 <efc5b030-f344-80ce-f57e-582207f436fe@amlogic.com>
Message-ID: <153997224756.53599.3138050846693192599@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock controller
Date:   Fri, 19 Oct 2018 11:04:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jianxin Pan (2018-10-19 08:50:08)
> On 2018/10/19 1:08, Stephen Boyd wrote:
> > Quoting Jianxin Pan (2018-10-17 22:07:24)
> >> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.=
txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >> new file mode 100644
> >> index 0000000..9e6d343
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >> @@ -0,0 +1,31 @@
> >> +* Amlogic MMC Sub Clock Controller Driver
> >> +
> >> +The Amlogic MMC clock controller generates and supplies clock to supp=
ort
> >> +MMC and NAND controller
> >> +
> >> +Required Properties:
> >> +
> >> +- compatible: should be:
> >> +               "amlogic,gx-mmc-clkc"
> >> +               "amlogic,axg-mmc-clkc"
> >> +
> >> +- #clock-cells: should be 1.
> >> +- clocks: phandles to clocks corresponding to the clock-names property
> >> +- clock-names: list of parent clock names
> >> +       - "clkin0", "clkin1"
> >> +
> >> +Parent node should have the following properties :
> > =

> > The example only has one node. Can you add two nodes?
> OK. This clock is used by nand and emmc. I will add a new example for emm=
c too.
> Thank you for your review.

Maybe I misunderstand. I thought the clk controller was two nodes, but
it isn't? This wording is trying to explain what a consumer should look
like?

