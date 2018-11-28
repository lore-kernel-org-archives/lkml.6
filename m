Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0320863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRJtzBpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA0320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeK2JP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeK2JP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:15:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8692081B;
        Wed, 28 Nov 2018 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543443171;
        bh=Ob/DPWxZd1w5vD9jytaAxFaCAlCL6bRTZa7PztH0qys=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=NRJtzBpmSIebDT7BT6gpK2MzRcUguYpcUAfYmq9Bdsu2AlXrprtX5njxjxCsDefEn
         0dTZvbF8Dg8rVWQiG8/DtTFDPWEvt7JXVNxFrGztwiFaXC+B9j+qc0Ofu4qgBt0OTU
         nlhNyZwN9+0gHHenfhmcXS+vKJhJEnCSCKzwholc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, linus.walleij@linaro.org,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <154344291239.88331.14159206270303255502@swboyd.mtv.corp.google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
References: <20181123150600.27445-1-tiny.windzz@gmail.com>
 <154344291239.88331.14159206270303255502@swboyd.mtv.corp.google.com>
Message-ID: <154344317086.88331.8296424241716107824@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: nomadik: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Wed, 28 Nov 2018 14:12:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-11-28 14:08:32)
> Quoting Yangtao Li (2018-11-23 07:06:00)
> > Use macro to simplify the code.
> > =

> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> =

> Applied to clk-next
> =


Except this doesn't compile. I fixed it, but please actually compile
your patches before sending next time.

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index e331634d34df..a95aa96f4a68 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -455,7 +455,7 @@ static const char * const src_clk_names[] =3D {
 	"RNGCCLK   ",
 };
 =

-static int nomadik_src_clk_show(struct seq_file *s, void *what)
+static int nomadik_src_clk_debugfs_show(struct seq_file *s, void *what)
 {
 	int i;
 	u32 src_pcksr0 =3D readl(src_base + SRC_PCKSR0);
