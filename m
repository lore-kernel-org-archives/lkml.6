Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7D6208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9KZDy6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7D6208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbeG0S0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbeG0S0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:26:10 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84EBC205C9;
        Fri, 27 Jul 2018 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532711003;
        bh=HS8QPX/nIXV9vGg0Zc15b0NPWTXjRnQfCSl22yFHisk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=R9KZDy6KG+cQdhXQhByUxoCanPX02JXYHS8oDBJfLbfqBxi0Ymj8nhFy4rkCKYo7p
         Q636Peo4b23L2SQQWSAGU6r+m9F7nIdqq2tId+LhB5UsMCOGfc3J5OJCxVW4tVpZ3B
         8sXzE0xDhSnXzxlTdB37nhrL5vbeUIlyiVYCYOfw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Message-ID: <153271100280.48062.2538655794734424353@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/16] clk: at91: Rework DT bindings
Date:   Fri, 27 Jul 2018 10:03:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2018-07-17 15:27:41)
> This is the promised rework of the at91 PMC clocks driver. It is mainly
> necessary to remove the DTC warnings but it also complies with the CCF
> rule that there should be one node per controller instead of one node
> per clock.
> =

> This only handles the PMC, I'm planning to also rework the SCKC bindings
> later (without breaking the DT ABI).
> =

> The series is based on top of clk-next plus at91-dt so I don't think it
> is convenient to have it this cycle. However, I would really like to
> ensure we agree on the new bindings this cycle before converting all the
> other platforms as this is a bit tedious.
> =

> The first two patches are actually fixes and may be considered for this
> cycle.
> =

> One nice note:
> at91-sama5d2_xplained.dtb goes from 29351 bytes to 22082 bytes

Patches look mostly good. Rob is happy with the bindings and so am I.

One general question is why the drivers can't be moved to real platform
drivers instead of using OF_CLK_DECLARE?

