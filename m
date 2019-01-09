Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F76C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB9321738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062957;
	bh=KNDEipFrtz5Wc4vrJ7sCDkWIwUgvnFZ0W0yxxbBs8lk=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=Ig0c3Qjh8+bBnkgLvDiFSzQk+cUNYFHrCNi+FmZhluUTiaTV2U4EsZGuaTZ1GZj7D
	 rTNwwOJ0YynKVxIbOZi4JgmWJwwA7UljySlab0qS42Ei63kkwUcLHY7EpeMlkIOlAu
	 VuNULJwAUs0iInPsAOmwksV5mrlhJVNlWqsx/X/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfAITmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfAITmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:42:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7144020859;
        Wed,  9 Jan 2019 19:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547062955;
        bh=KNDEipFrtz5Wc4vrJ7sCDkWIwUgvnFZ0W0yxxbBs8lk=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=S5srZ8Eo2bZxGh9EXvFlWvP5tNclUvi9Us7v2Koe6O7wfi3Va4+D5jrKwub4VyH8i
         rURtiOv1aOZDRJiADvwx3TsgKu2DkIJsK/so+VB4HqSzEUBtwK3xt3ai4EpQl+j12d
         BvHSmfChiZfZh1dXkGw51XT0m+4Uw8gepc61OwYY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] clk: Add Fixed MMIO clock driver
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kotas <jank@cadence.com>
To:     Jan Kotas <jank@cadence.com>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <20181213124929.32736-3-jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181213124929.32736-1-jank@cadence.com> <20181213124929.32736-3-jank@cadence.com>
Message-ID: <154706295457.15366.6974721928926110954@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 11:42:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jan Kotas (2018-12-13 04:49:29)
> This patch adds a driver for Fixed MMIO clock.
> The driver reads a clock frequency value from a single 32-bit memory
> mapped register and registers it as a fixed rate clock.
>=20
> It can be enabled with COMMON_CLK_FIXED_MMIO Kconfig option.
>=20
> Signed-off-by: Jan Kotas <jank@cadence.com>

This needed to use the clk_hw based APIs and add a static. I made the
changes myself. Let me know if you have any problems with what's in
clk-next and it can be fixed.

