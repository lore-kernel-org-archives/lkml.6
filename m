Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87726C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AC2208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+DzafQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AC2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbeK0ULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbeK0ULo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:11:44 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDC5420989;
        Tue, 27 Nov 2018 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543310069;
        bh=3JbcYND1I76NoKoDOpd7gQ5ZKdNCPNWV7bLGsSd7PSs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=B+DzafQ44H6eltE9uhlLFoN+g6dPBtYV7HnwKr4LWXONqzSHum9SW/nSaI4lt3xvU
         DF2MYflj0KCl33FagDyS1Dz1E3Va0qI74nTc5wAQpADHPqdYedO2Bf75lQ5q4NULMn
         mthDlXMXDO4YfM5KC8jiecYiHI+EhsKDIKcajMm8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542873221-13693-4-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
 <1542873221-13693-4-git-send-email-tdas@codeaurora.org>
Message-ID: <154331006901.88331.9760589510991406736@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v10 3/3] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Tue, 27 Nov 2018 01:14:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-21 23:53:41)
> +
> +static struct clk_branch lpass_qdsp6ss_core_clk =3D {
> +       .halt_reg =3D 0x20,
> +       /* CLK_OFF would not toggle until LPASS is not out of reset */

Is this really "CLK_OFF won't toggle until LPASS it out of reset"?

