Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD43FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83764205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544030738;
	bh=2/hqaMZuBaQYW4QNk9bDPA++7Z/NdhVU7dAbfmW2ry0=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=RFL0GycXYACTkXujZgXHlIzy9lr0Ew+bg//jOpvvvwSX3o6S426Lwt67AwVW6c6jg
	 Kg09NQ3CYQeV4D2H1SiuR/9Rhsqq29hTtBLdzo1ybUtOq0qdSeI2HHQDdepMkV69w1
	 3olGyeZmYvjxYGub0JiA9CpaYgfSQChsr85T8lEE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83764205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeLERZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbeLERZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:25:16 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D7420879;
        Wed,  5 Dec 2018 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544030716;
        bh=2/hqaMZuBaQYW4QNk9bDPA++7Z/NdhVU7dAbfmW2ry0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Nnn1g+lHXQ2uvNFWs9jiVY5p9SM++5+XjEm6ndpYaMfQXo4qRjR/XzGfhJn6aM6T8
         9jW2YI6DwlppNi8sLP5/DaQeFRLd9E9StWPP/6+2WdOjB+BN2nzA+0tls4/KY/OCQX
         /ydbbwq1ES8ybmvZm9b4MaRHvV2GcH4ZIG7XtDQA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <e00097fb5b52f1d4002c8febdb3887736e84acd0.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <e00097fb5b52f1d4002c8febdb3887736e84acd0.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154403071537.88331.3953967329517258880@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 08/10] clk: clk-twl6040: Free of_provider at remove
Date:   Wed, 05 Dec 2018 09:25:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-04 03:38:32)
> use devm variant for of_provider registration so provider is freed
> at exit.
> =

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-next

