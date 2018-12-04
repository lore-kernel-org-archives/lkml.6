Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB8A2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZnKSKkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB8A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeLDRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeLDRnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:43:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43A102081B;
        Tue,  4 Dec 2018 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543945431;
        bh=RRWDlkVfdE3/Hh28w73eOgqZveXY6VsFj+5N80amkjM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lZnKSKkm0XYj6ORKEdBCdJ2up/CPNDqMXjr3QbsKtOstEoA7iKvIMXbr5fesrxNVC
         jBQ8Qul83Cn5C0CYj/SXbRN0NKrcpC/2v+38/G4xcvcRcYdyLINENtUvzxHH3tbwEg
         KgFDfHTy4O+LBMI728+zRjW3Nib3hVxA9Tx0w4q8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204125839.14505-1-narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181204125839.14505-1-narmstrong@baylibre.com>
Message-ID: <154394543049.88331.11854270462393390489@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: meson-gxbb: switch video clocks mux tables to static
Date:   Tue, 04 Dec 2018 09:43:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2018-12-04 04:58:39)
> Makes the following sparse warnings silent:
> drivers/clk/meson/vid-pll-div.c:58:26: warning: symbol '_get_table_val' w=
as not declared. Should it be static?
> drivers/clk/meson/gxbb.c:1585:12: warning: symbol 'gxbb_vid_pll_parent_na=
mes' was not declared. Should it be static?
> drivers/clk/meson/gxbb.c:1620:12: warning: symbol 'gxbb_vclk_parent_names=
' was not declared. Should it be static?
> drivers/clk/meson/gxbb.c:1980:12: warning: symbol 'gxbb_cts_parent_names'=
 was not declared. Should it be static?
> drivers/clk/meson/gxbb.c:2036:12: warning: symbol 'gxbb_cts_hdmi_tx_paren=
t_names' was not declared. Should it be static?

I fixed all of these already in the patch I sent you.

> @@ -1983,7 +1983,7 @@ static struct clk_fixed_factor gxbb_vclk2_div12 =3D=
 {
>  };
>  =

>  static u32 mux_table_cts_sel[] =3D { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };

I was talking about this mux_table_cts_sel array. Can this be const?

