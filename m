Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA2ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E736214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwJYdvhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E736214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJRBqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbeJRBqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:46:17 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6998B2148E;
        Wed, 17 Oct 2018 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539798571;
        bh=ofxnyTIuy8xcSzTD7ernV/y8nzk3KxkV+svpMJr7fZg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=UwJYdvhkgdSkuoB4auBhKT02SIK4wGG4GRLH3maseSCtdCi0U+vL9PjJJbIlxrqb8
         2n6tQq4IThGYm/i3Z6CuKru2aPVGuaKq3a8XLjy3LZi1zy1OVkmMXF+V68JjpCHJhO
         QPUpyUtrbX0QF8HBQd032Xe5c74NWeu1O5ftMiwk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181016142200.19741-2-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <20181016142200.19741-2-alexandre.belloni@bootlin.com>
Message-ID: <153979857072.5275.3162831436786210773@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 01/22] clk: at91: audio-pll: fix audio pmc type
Date:   Wed, 17 Oct 2018 10:49:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2018-10-16 07:21:39)
> The allocation for the audio pmc is using the size of struct clk_audio_pad
> instead of struct clk_audio_pmc. This works fine because the former is
> larger than the latter but it is safer to be correct.
> =

> Fixes: ("0865805d82d4 clk: at91: add audio pll clock drivers")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

