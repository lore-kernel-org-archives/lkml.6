Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D446C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2686F2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg1ooYTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2686F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeK3SPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeK3SPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:15:05 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B021A2082F;
        Fri, 30 Nov 2018 07:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543561606;
        bh=xSr82yDx0NPGPt5p1/8/gWCQHeKY/o05VchVCXyqQso=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gg1ooYTHcx1WqkdgUWBTKKIuZvXSqjjF+Z0ZKbvjKz1xDvmnMovEugqjj4ltn9R3s
         7Wg/z5JCjKLB9thtP5QGbOJPQSVLYFVYAZ0X+BgDI/IEH5BJLeFzrBRadWtSfMu4N2
         Y+vJ34of8byg/m2cNEDLh5rJSF/rG+MxCTRKtKXw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130065259.26497-3-bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-3-bjorn.andersson@linaro.org>
Message-ID: <154356160607.88331.15203631970252933137@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] clk: qcom: gcc-msm8998: Disable halt check of UFS clocks
Date:   Thu, 29 Nov 2018 23:06:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-29 22:52:58)
> Drop the halt check of the UFS symbol clocks, in accordance with other
> platforms. This makes clk_disable_unused() happy and makes it possible
> to turn the clocks on again without an error.
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Someone was supposed to figure out why we needed to SKIP here instead of
doing things in the proper order. Is anyone attempting to figure that
out?

