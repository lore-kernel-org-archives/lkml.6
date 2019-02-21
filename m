Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3CDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E772083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550786625;
	bh=GePG9ZNYDL1UfQsS/WcBOUtdgUCum5elDNu0WiIcoeM=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=jlI2kInlGB2w4mHOtXF7G9kZ4OWmLu2GZxUNsTjpEbya+jQYCvR5IUjAx9c0zW19a
	 HYFCu2X3IZHzqx7XOcB4GoXeFlgor096mF7vlj/V11vQ+r2h0/Rt3yYIHgo/YQs/Gg
	 Ah4lO87Jbeqx6VhDI19rJtNaicxn+KdMUBcO9Oyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBUWDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfBUWDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:03:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A5752077B;
        Thu, 21 Feb 2019 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550786622;
        bh=GePG9ZNYDL1UfQsS/WcBOUtdgUCum5elDNu0WiIcoeM=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=BkuIOdL1SOIlME3oCDLyoOVJlNlWtTitF+oMEO7tn380aPLCQL80TLli67mJI49sj
         mho+1ZNDb7fi8EAeMlCGWek/pAt8h5xo3c8ImwigFYg75fbBqUD6NW+WsW4F+xvOpX
         ppYoVhe3Y8z0RvfWGqEPBg9vZTOF7aZoqlOcPBac=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] clk: mediatek: correct cpu clock name for MT8173 SoC
Message-ID: <155078662163.77512.15925700437277835877@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211071555.31430-1-seiya.wang@mediatek.com> <20190211071555.31430-2-seiya.wang@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190211071555.31430-2-seiya.wang@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>
Date:   Thu, 21 Feb 2019 14:03:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Seiya Wang (2019-02-10 23:15:55)
> Change cpu clock name from ca57 to ca72 since MT8173 does use cortex-a72.
>=20
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

I'm guessing I can't apply this patch because the define is renamed
which would break older DTs. Another option would be to just add another
define and mark the old define as deprecated and unsupported. Then I
could apply the patch to clk tree.
