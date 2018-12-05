Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D388DC65BB0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4C4214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544042603;
	bh=CAYjlmC8Keax1YTT6tg+0FRFJWKrzu3ebDM0HTUT6q8=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=YnY3HG8rL73o5lZc2opL9F+vV6B3ZpVj5Ccbt9AlPEEJ0E9h1GoJCZyx7B4+XRRTu
	 U3Y3hfN/7wV/hxBR6F9CJlGoQ9N5a24rqT4oqjJ6mKzex3TVvOKX5J1iOKGpMwRmJO
	 9S93OQ17ZDm7oYwRoMt8yDfc3IBofTyTFRS4OXKA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4C4214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeLEUnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:43:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbeLEUnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:43:22 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CBB20850;
        Wed,  5 Dec 2018 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544042601;
        bh=CAYjlmC8Keax1YTT6tg+0FRFJWKrzu3ebDM0HTUT6q8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ueM4Qx1eFxArrylzRdNzxH5ySsc+9IhfDMMfA2qJDckd4IIbzQM0BbtcxvjshePW1
         EDIB5xCOLTPdcy6yTc20qE6bJKUiZ5LlppLU/MUAiDQaKiDdrltLDq44Pi/xJoHUOX
         D/yLpEjGJZtbmX8ujoFBd3MsGs+s1wUk+ECSeXC0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181205195050.4759-5-robh@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181205195050.4759-5-robh@kernel.org>
Message-ID: <154404260092.88331.601190671449905138@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: Use of_node_name_eq for node name comparisons
Date:   Wed, 05 Dec 2018 12:43:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2018-12-05 11:50:21)
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> =

> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
> =

> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Looks ok at a glance. I'll wait for some people to ack or test it.

