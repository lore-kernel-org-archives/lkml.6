Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30900C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED9420843
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="un6nW28t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED9420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeKDM2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeKDM2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:28:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EB82082A;
        Sun,  4 Nov 2018 03:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541301319;
        bh=QZSg6m8HUbGQ1Q1nS7vbtJn3vV2tBb/JKGf04U4cLU8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=un6nW28tlCkX3Sh6iDsBCWAp6+0Qy0WG8jxn2E5Xd0cyfkhFs0dEvM8T9mMBA0nMT
         xcs+v/79bUEfaLlI9plfbStbjR9fIcjYTDwwqlZyryjkci4DZO0vRqOhNZEAl5R2/K
         micNBj3fmZbzfWOKAhhnauwXLL2K2igqB7sqrAKM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181102214532.17661-1-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <20181102214532.17661-1-bjorn.andersson@linaro.org>
Message-ID: <154130131919.88331.12558287167971033698@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: sdm845-mtp: Reserve reserved gpios
Date:   Sat, 03 Nov 2018 20:15:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-02 14:45:32)
> With the introduction of commit 3edfb7bd76bd ("gpiolib: Show correct
> direction from the beginning") the gpiolib will attempt to read the
> direction of all pins, which triggers a read from protected register
> regions.
> =

> The pins 0 through 3 and 81 through 84 are protected, so mark these as
> reserved.
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

