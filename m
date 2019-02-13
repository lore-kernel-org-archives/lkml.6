Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F2B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550079825;
	bh=TbfWk5CfHlkm9v5iLC16NXhclESuNrAJ56dy9GYwMmI=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=kqeIDqZMkAhU/zZmqyH7JWHimUE21WczmAFf/vO5VTq3FP4PkpCetlO4ZYA6HKmk3
	 bfmDr0jcOrWTniDahAmqAYils1uveW3488Li+MldnaGWHJbfd2xN7R1olX+C6bdZZy
	 Qa+1emVFni60CZYGKMA+F/O0huFqsFXUWU55lBds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393235AbfBMRno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfBMRnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:43:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C9820700;
        Wed, 13 Feb 2019 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550079822;
        bh=TbfWk5CfHlkm9v5iLC16NXhclESuNrAJ56dy9GYwMmI=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=pZBCA6sGaKZr4s7ygA+8LOrA2p3OhQceZzJtsRqVpoev7O1oJefwe3Guw2+QM3/4Z
         qO40GkNqEW7xK6oCI7lbF/qDcx32qgUQeKC/EHmPy2WJiJkg/ds7nJ5uOCqvxNdtOk
         9UkejubmzUCH1gJBhFN8TSWCGuvHhoxNwlULGN/k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
In-Reply-To: <f3d5163067e97426a9bb00991d200f04bcd0058b.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v9 3/8] clk: bd718x7: Support ROHM BD70528 clk block
Message-ID: <155007982166.115909.16929990408175018819@swboyd.mtv.corp.google.com>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com> <f3d5163067e97426a9bb00991d200f04bcd0058b.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 09:43:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2019-02-13 05:29:55)
> ROHM BD70528 is an ultra low power PMIC with similar 32K clk as
> bd718x7. Only difference (from clk perspective) is register address.
> Add support for controlling BD70528 clk using bd718x7 driver.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

