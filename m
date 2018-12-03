Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88AEC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E06A208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp5Dqw7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E06A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeLCRqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeLCRqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:46:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25E42087F;
        Mon,  3 Dec 2018 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543859162;
        bh=AAPuM5qgkSx1WQ4xtaRzRFiUZq4YKSqvPxRjBsTUblM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Qp5Dqw7n2O5Vs/x7viHXtEqcuarVqRgpBYmZZfzJS56uvvMmvtrgj8uKLzoPgxVS6
         fRiJ6sXtQsK6R60CnplxCrmuzZMHrzP+z6YwvVckHG4I4s7VPOI8yX7uyHTXS1MAm2
         Yj3g6wnKba5iLsAWPeDF9vv7bqsZ7a8Ezs8mkr44=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543602089-21086-3-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
 <1543602089-21086-3-git-send-email-tdas@codeaurora.org>
Message-ID: <154385916141.88331.12696569463331774426@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 2/3] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Mon, 03 Dec 2018 09:46:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-30 10:21:28)
> Add device tree bindings for Low Power Audio subsystem clock controller f=
or
> Qualcomm Technology Inc's SDM845 SoCs.
> =

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

I noticed that a #define was lost after some revisions for some always
on clk, but I suspect we never care and will never need to turn it on so
I just went with it and dropped it too. Let's cross fingers and hope
that doesn't come back to haunt us!

