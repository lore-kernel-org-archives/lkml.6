Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35B6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8FB21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfA1Lha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:37:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50617 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfA1Lh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:37:29 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1go5EF-000643-0S; Mon, 28 Jan 2019 12:37:27 +0100
Message-ID: <1548675446.6421.4.camel@pengutronix.de>
Subject: Re: drivers/media/platform/imx-pxp.c:683: possible cut''n'paste
 error ?
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     David Binderman <dcb314@hotmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 28 Jan 2019 12:37:26 +0100
In-Reply-To: <AM6PR08MB38005C4E593AFF9A77FED8D89C950@AM6PR08MB3800.eurprd08.prod.outlook.com>
References: <AM6PR08MB38005C4E593AFF9A77FED8D89C950@AM6PR08MB3800.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-01-27 at 08:17 +0000, David Binderman wrote:
> Hello there,
> 
> drivers/media/platform/imx-pxp.c:683:24: warning: duplicated ‘if’ condition [-Wd
> uplicated-cond]
> 
> Source code is
> 
>                } else if (ycbcr_enc == V4L2_YCBCR_ENC_709) {
>                         if (quantization == V4L2_QUANTIZATION_FULL_RANGE)
>                                 csc2_coef = csc2_coef_rec709_full;
>                         else
>                                 csc2_coef = csc2_coef_rec709_lim;
>                 } else if (ycbcr_enc == V4L2_YCBCR_ENC_709) {
>                         if (quantization == V4L2_QUANTIZATION_FULL_RANGE)
>                                 csc2_coef = csc2_coef_bt2020_full;
>                         else
>                                 csc2_coef = csc2_coef_bt2020_lim;
>                 } else {
> 
> The condition on the second if looks wrong. Suggest code rework.

Thank you, I have sent a patch.

regards
Philipp
