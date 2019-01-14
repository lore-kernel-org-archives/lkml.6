Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498FEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C33C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547509982;
	bh=enYtFSzZNvTP8U5dsXmXf/RDRm2e5+IVEO6BYhCkr+4=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=pJJ2rnHHF2lLNoFR2Qy2eLz4L8H9wXkAYnZ875zUIIgWuyq9/gAHwlSrYjc4y0/FN
	 jaC3fR/4ERjj/0HpM3ZzJchVqy6CGrh036DZY0+lir3o8fK6/BLlDSz++eaVQLzzfs
	 9YFWFSqfawYlyk+vt65+IXy7NGjT9+RqeQZJU4pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfANXxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:53:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfANXw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:52:57 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118292064C;
        Mon, 14 Jan 2019 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547509408;
        bh=enYtFSzZNvTP8U5dsXmXf/RDRm2e5+IVEO6BYhCkr+4=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=rfPTQp94N/0qAqAFbyyys/qPLiwmktCT/Co8MigJqFodG5THwi/X+LcDaDBJmN6RM
         ouvqEWNjz9ab8PI6sE4bI4Jgc6Hhbmhx/Qg5zmKBAV5o/nFvH3RzMAjHbaxwQi9Gej
         9ejK5gMo5A0uVLrgE9wKyCjkGgt2/jPQQVv7SFQI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 03/14] pinctrl: qcom: spmi-gpio: hardcode IRQ counts
User-Agent: alot/0.8
In-Reply-To: <20190113154716.5145-4-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org> <20190113154716.5145-4-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154750940734.169631.518209342778368193@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 15:43:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-13 07:47:05)
> The probing of this driver calls platform_irq_count, which will
> setup all of the IRQs that are configured in device tree. In
> preparation for converting this driver to be a hierarchical IRQ
> chip, hardcode the IRQ count based on the hardware type so that all
> the IRQs are not configured immediately and are configured on an
> as-needed basis later in the boot process. This change will also
> allow for the removal of the interrupts property later in this
> patch series once the hierarchical IRQ chip support is in.
>=20
> This patch also removes the generic qcom,spmi-gpio OF match since we
> don't know the number of pins. All of the existing upstream bindings
> already include the more-specific binding.
>=20
> The pm8941 code was tested on a LG Nexus 5 (hammerhead) phone.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

