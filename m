Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654FAC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3160E20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOFUEPWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3160E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbeKGC7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389496AbeKGC7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:59:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CCB2085B;
        Tue,  6 Nov 2018 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541525613;
        bh=n3TDijDUCf78B52Ea2HO0SYvgposIlMHA4/tTDQjAHY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=hOFUEPWddvn9M3NGbcME1uGq8+x+quIN/Pr2OxNpSd+c5KKpPT48Ud+BkQ8DMHwho
         vxOecj53YCmm39vnwn3hec6zAdITfdORI538kW7RzB1BSE40htA/TawgYG6v4krd3Z
         OWW1Kb0dS+uhWcPKnoJ6txUdqr3KqcbrNmRVMs7M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181020135024.28573-3-paul.walmsley@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com>
 <20181020135024.28573-3-paul.walmsley@sifive.com>
Message-ID: <154152561238.88331.13239370518226908068@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] dt-bindings: clk: add documentation for the SiFive PRCI
 driver
Date:   Tue, 06 Nov 2018 09:33:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2018-10-20 06:50:23)
> diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.tx=
t b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> new file mode 100644
> index 000000000000..d7c1e83fa5ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
> @@ -0,0 +1,43 @@
> +SiFive FU540 PRCI bindings
> +
> +On the FU540 family of SoCs, most system-wide clock and reset integration
> +is via the PRCI IP block.
> +
> +Required properties:
> +- compatible: Should be "sifive,<chip>-prci<version>".  As of the time t=
his
> +              file was written, only one value is supported:

I don't think we need the "As of the time" sentence. It will become out
of date almost immediately so why not just say "The list of supported
values is:"?

> +             "sifive,fu540-c000-prci0"
> +- reg: Should describe the PRCI's register target physical address region
> +- clocks: Should point to the hfclk device tree node and the rtcclk
> +          device tree node.  The RTC clock here is not a time-of-day clo=
ck,
> +         but is instead a high-stability clock source for system timers
> +         and cycle counters.
> +- #clock-cells: Should be <1>
