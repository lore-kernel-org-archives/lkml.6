Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12EDECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7692620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQYjYqh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7692620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKID5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:57:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbeKID5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:57:46 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAEF20825;
        Thu,  8 Nov 2018 18:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541701262;
        bh=lGhvPaWBM1WzQNF70R0QMM75HLBPPDciFQGgDKOpBJg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=EQYjYqh0bnUX7gaS3YWena+KaXaNh+txLUGr8kOjCgnobYE6JQ0W7ZOKzya4pFmcY
         K1K+cqxRe3qT86NYeD2vZW7389X56HqLXxXSrfyPST0CwkC7Qno1QYNuueY7aQSScj
         jgxpsDlDodyOC30uPIpDAKL9xhzU3zH6ruGluG8E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181108093123.21498-1-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181108093123.21498-1-jbrunet@baylibre.com>
Message-ID: <154170126140.88331.14691547333216324636@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: meson: axg: mark fdiv2 and fdiv3 as critical
Date:   Thu, 08 Nov 2018 10:21:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-11-08 01:31:23)
> Similar to gxbb and gxl platforms, axg SCPI Cortex-M co-processor
> uses the fdiv2 and fdiv3 to, among other things, provide the cpu
> clock.
> =

> Until clock hand-off mechanism makes its way to CCF and the generic
> SCPI claims platform specific clocks, these clocks must be marked as
> critical to make sure they are never disabled when needed by the
> co-processor.
> =

> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> =

> Hi Stephen,
> =

> If you can put this one in clk-fixes as well, it would be awesome.
> It is basically the same thing as the change you took this Tuesday.
> =

> Since then, we had reports the same problem with SCPI was happening
> on the axg, calling for the same fixup.
> =


Ok. I suppose someone needs to work on clk handoff................ me?

