Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC83C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020F92083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPJo4/2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020F92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeIFG0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeIFG0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:26:43 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D9F2083E;
        Thu,  6 Sep 2018 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536198827;
        bh=lJRig0ZcODVpBqJAPqNJl1YWe/0ASEA0dSSmzQITys0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gPJo4/2XzJD2eBEnG5X5aXnAwvitb+DqCpyGKtVUWjcSRPcldHQiOvduRZrdArovV
         nKiIaa2DtVCl4M4QmMUN0b4UqpdSPXeoInllqRoMnGTfl3rWLpypzT5xGGBzQTahlO
         Vm4yWV2Q1qvop+1UPQBMSpoP+5k/r9TfTkg+RUF8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <47adf305-f649-dca6-e45e-51c7b418d418@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
References: <1533298874-22863-1-git-send-email-tdas@codeaurora.org>
 <1533298874-22863-2-git-send-email-tdas@codeaurora.org>
 <153540448713.129321.8622050618939041593@swboyd.mtv.corp.google.com>
 <47adf305-f649-dca6-e45e-51c7b418d418@codeaurora.org>
Message-ID: <153619882706.119890.168416195348998783@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Wed, 05 Sep 2018 18:53:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-09-05 11:26:36)
> =

> On 8/28/2018 2:44 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-08-03 05:21:13)
> =

> >>
> >>   Example:
> >>          clock-controller@900000 {
> >> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt =
b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> >> new file mode 100644
> >> index 0000000..062e413
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> >> @@ -0,0 +1,33 @@
> >> +Qualcomm LPASS Clock Controller Binding
> >> +-----------------------------------------------
> >> +
> >> +Required properties :
> >> +- compatible           : shall contain "qcom,sdm845-lpasscc"
> >> +- #clock-cells         : from common clock binding, shall contain 1.
> >> +- reg                  : shall contain base register address and size,
> >> +                         in the order
> >> +                       Index-0 maps to LPASS_CC register region
> >> +                       Index-1 maps to LPASS_QDSP6SS register region
> >> +- qcom,lpass-protected : Boolean property to indicate to GCC clock co=
ntroller
> >> +                        for the lpass GCC clocks.
> > =

> > Why is this here?
> > =

> =

> Yes, I kept it to make sure it is marked in GCC clock driver too. May be =

> should remove it.
>

It isn't a property of the LPASS clock controller though so I don't see
why it is here.

