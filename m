Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD41CC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720D620700
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544054283;
	bh=5nw9S5SrseexT7y46FX2g79WhMv+E97dPkmKGOSmwo0=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=AMehPB5E3eOIJKQ1vM0Q0eROggvQVlHUPjxPdPxH+tWwBQ6C+6J/QuhGhHYYAB4ce
	 TjWhy5Q0u4qWQvFSfgq3kGcHGriVpCueUW7sHbvihWitn2g0S6LJT2ce3/ZDcrm5nB
	 Qjhz8rayjc+np6LBns9GQpGfT1VV5sgC0CBB5yn0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720D620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbeLEX6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbeLEX6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:58:01 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B379A206B7;
        Wed,  5 Dec 2018 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544054280;
        bh=5nw9S5SrseexT7y46FX2g79WhMv+E97dPkmKGOSmwo0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=f1JVrhxRfcT7kht5bUr+sVQsM1QMsRWaVBFnMhpULPnGB1sXzxrCLbIo+gPusbqhw
         /ikiSGDiJN2NfXfD6E5ohRZ8qZWNjSlwgS11dc0+hM3uco+fPml6FYLZiFRQbdJjAA
         YHJS5CIpuIOiFA/ucj+AOcQny2wsluw+U+arQipI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203183330.2073-3-bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181203183330.2073-1-bjorn.andersson@linaro.org>
 <20181203183330.2073-3-bjorn.andersson@linaro.org>
Message-ID: <154405428007.88331.5206863330508732847@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-msm8998: Disable halt check of UFS clocks
Date:   Wed, 05 Dec 2018 15:58:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-12-03 10:33:29)
> Drop the halt check of the UFS symbol clocks, in accordance with other
> platforms. This makes clk_disable_unused() happy and makes it possible
> to turn the clocks on again without an error.
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

