Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F75C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E274E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730538;
	bh=rylVSC7jJeP6um1CjbVRtc2oPbnHhFWfSgtqO+GJlfo=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=nNiF8AgQDUrWh1PW+oaDHjNRbC+1PcrvWIWht+9YhQR1cjag8oOaJRvNu42D1Devf
	 hfNUpTuD7AthFYKH6LFSwNHDHQdJsUQqlOsJkNwihwpZFbd5bcLia7k1+7w21BX9nm
	 AwcsPCIyyC1xfBA+6SxrcQ5BQajQiSqDGfj/F5n8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E274E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeLMTs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeLMTs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:48:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA6202086D;
        Thu, 13 Dec 2018 19:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730535;
        bh=rylVSC7jJeP6um1CjbVRtc2oPbnHhFWfSgtqO+GJlfo=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=Q0BWAt/kpPYVMp9CN2MMNi4yChTHUAdDADms08aYIS4N5JNN3DpW4+fEgqZXmsoG3
         5gclOvLbjMm/N0666S8j1zjgS5CKCrv2RirqsgHfLUNMU4db0/bOYAbg5eohqHpFi0
         D5aQn6HzQSCUTvDHq5oumTAGHAmy5j7urUeugPPQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181206215858.3880-2-sboyd@kernel.org>
Subject: Re: [PATCH 1/8] clk: renesas: Remove usage of CLK_IS_BASIC
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-2-sboyd@kernel.org>
Message-ID: <154473053490.19322.3731378889854414729@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Date:   Thu, 13 Dec 2018 11:48:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-12-06 13:58:51)
> This flag doesn't look to be used by any code, just set in various clk
> init structures and then never tested again. Remove it from these
> drivers as it doesn't provide any benefit.
>=20
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: <linux-renesas-soc@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

