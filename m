Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5C9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0612075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wlgwgUQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0612075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbeGIHhZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932241AbeGIHhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:37:23 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A44C2075B;
        Mon,  9 Jul 2018 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531121842;
        bh=QPQpZAQhX2RtWlI//nINTBOzge25auddXC9Uivwfy64=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=wlgwgUQeqH0xScXFtiCJkcq82NEjvv+9BtIP8K6b+yjFWJF4u/fsKElRHTGRiVkH6
         N7c6+0tC8fVP+PGPy9037/4bCaD5aEzOWTn3DbkJ4OXh5vJ3MZxeD1HIaaiLqSLEI6
         EPZBritfw6pAcM5Fh66jWB+nsjfcPXqsLp66rXLI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
 <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
 <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
Message-ID: <153112184177.143105.15452587215679149679@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for SDM845
Date:   Mon, 09 Jul 2018 00:37:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-09 00:07:21)
> =

> =

> On 7/9/2018 11:46 AM, Stephen Boyd wrote:
> >>
> >>   > Why is the nocache flag needed? Applies to all clks in this file.
> >>   >
> >>
> >> This flag is required for all RCGs whose PLLs are controlled outside t=
he
> >> clock controller. The display code would require the recalculated rate
> >> always.
> > =

> > Right. Why is the PLL controlled outside of the clock controller? The
> > rate should propagate upward to the PLL from here, so who's going
> > outside of that?
> > =

> The DSI0/1 PLL are not part of the display clock controller, but in the =

> display subsystem which are managed by the DRM drivers. When DRM drivers
> query for the rate clock driver should always return the non cached rates.

Why? Is the DSI PLL changing rate all the time, randomly, without going
through the clk APIs to do so?

