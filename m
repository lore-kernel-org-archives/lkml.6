Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AFBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362F4206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJyWZd59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392990AbfAPNLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:11:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34443 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390326AbfAPNLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:11:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so2044520otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYbvESzi3MHLWnd2PGoU42O5hBXw411ONY7gkyHaweA=;
        b=lJyWZd59FaF+sDcCyxfI4zq0dQrY8hqtuP/ONPOlHzW4xkWKgK08Esf+0zFEmIs0R0
         sFsiEdRU/HNDlgAj9K/nixJ9rUbzeYamq/0EsNFOa3P90V833Lc4xLTgSAQn8x0929UH
         6ulmfUYONnFguxnmczQqyK4bjWgIvp6ebTMbJ68B+Zeqqi5FNjE6NKOio14LGazt29cA
         uBhLNL1cbqXfaexqapfp0cBFDX+Ber4fezboPqJxQN3wHa8DAWB9s6rPAuRhSvy4twoX
         hijroa9K6O+XS61T3wC2ARyC2VPcJdgZ+yTT2avo1qGV2FRmIMV1iqKPLhaTI7tl1PZE
         aeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYbvESzi3MHLWnd2PGoU42O5hBXw411ONY7gkyHaweA=;
        b=jdre+F3hjUSO/yZJXyF4ypieUwV0JZbr+b5OuuZmkglpl6ZoaMoLTxYphrJHqpu3Ey
         KmtIdJvVPvRbELb376zS8+vtR1z10zhySHbZxYjGCe5us9S+GPoIIslSR7I77SVnlQsw
         LLkoeRHurVd50bRQgl+wtvVGb6FmEphI2WUYyQqmNzTC2+EAZHoQN37H2OMsoL2LbSUr
         zIkAbwLeAvHkupKfr9f2u9D5Knit+i0kO33Z5oDbVfLlLqv8JaAZChiksXMEwFQcDtYf
         qpnTt19alzZx4L7Tx4B9RZ5UmIhiysWtmW4/+JKmUeAbPZjf6awLfz2LZOruzVRGTCDC
         CwMA==
X-Gm-Message-State: AJcUukeroV2I05XLXtp4L1IKPACq8wJWj8njmgJUC1qESJCfLGgTMC3p
        ffvklTitRG/RcsTsAkMBJkIuTIFoXmm394vHaxs=
X-Google-Smtp-Source: ALg8bN44D17nhZKn6Ag2Wr9n2qTeJbgXIhCDi+pB3ACsyOCmzO4A2mlXK/ld7I1p/1Zxq7ZQy/38hWxwtNb78UhBg28=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr5701786otj.228.1547644303237;
 Wed, 16 Jan 2019 05:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115170501.10952-1-daniel.baluta@nxp.com>
In-Reply-To: <20190115170501.10952-1-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Jan 2019 11:12:12 -0200
Message-ID: <CAOMZO5D_kakB82dEcXrU4EZARLj90US8Zf+sGgaKkZvUG3t=PA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx: Fix MU4_INT number
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Jan 15, 2019 at 3:05 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> MU4_INT correct number is 180, while 179 is for MU3_INT.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Two nitpicks:

1. In the Subject it would be better to specify the SoC name:
arm64: dts: imx8qxp: Fix MU4_INT number

2. It would be nice to add a Fixes tag

Reviewed-by: Fabio Estevam <festevam@gmail.com>
