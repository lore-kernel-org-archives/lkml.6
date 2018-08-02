Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD168C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843FE21571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoauI9QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843FE21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeHBWmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731181AbeHBWmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:42:55 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F362154D;
        Thu,  2 Aug 2018 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533243006;
        bh=lO4NGR4UKjYhqNaF95kCjECsO/kRuosHb3lGBpmHEcg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KoauI9QEIz19K3lM/a5SdRy2bESF0h5f+zIuj10zQmw7KgEUvJkmkwuapdow9yYoq
         9WTuYQb+THToJ8F9IHuUH/vy6MlaBp/Fx0cNeQAwNxWaZTHi45ZUC56LhF8Oh7hS6Z
         SrUBUMFdi99yg0AZq08//ycYpquWHexa/eCMpjEQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1533016555-3731-1-git-send-email-amit.kachhap@arm.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-clk@vger.kernel.org
References: <153296797329.17365.14490424418553594815@swboyd.mtv.corp.google.com>
 <1533016555-3731-1-git-send-email-amit.kachhap@arm.com>
Message-ID: <153324300559.10763.831180927555837774@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: scmi: Fix the rounding of clock rate
Date:   Thu, 02 Aug 2018 13:50:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Daniel Kachhap (2018-07-30 22:55:55)
> This fix rounds the clock rate properly by using quotient and not
> remainder in the calculation. This issue was found while testing HDMI
> in the Juno platform.
> =

> Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---

Applied to clk-next

