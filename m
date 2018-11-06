Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D65C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3163A2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7p/D8oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3163A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbeKGCe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:34:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389386AbeKGCe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:34:29 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081CB20862;
        Tue,  6 Nov 2018 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541524099;
        bh=d0rE3jzff//eFOPVgNlhnv6w2RWbae9svza47RYybrY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=T7p/D8oOzCjp9O0R3fmyPh7/DwglEQOHdPYjUb4JKWz4kU1Ez24ezhkFSG6QsXV5v
         N6lK15TqnFbvlcKWdi0ddn/X9sMZREiQilYzJSGwPg2DPm3yba+pQPpavpFZ2otDDZ
         VJ1dW9bVQx37062wlk1yg4nZI3w3cVuFVZ0aFsCs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, chandanu@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9c82010f-f3fd-2867-352e-3584ab4ba8f0@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, linux-arm-msm-owner@vger.kernel.org
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
 <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
 <3c4cccca-2c5c-927f-f471-2bbbd71b4155@codeaurora.org>
 <9c359e26-3708-14b6-f22a-fb529446d325@codeaurora.org>
 <154083859263.98144.15690571729193618604@swboyd.mtv.corp.google.com>
 <f3e40308-d2dd-cce9-4b19-3af419841bc1@codeaurora.org>
 <154091723693.98144.6979314028521443413@swboyd.mtv.corp.google.com>
 <9c82010f-f3fd-2867-352e-3584ab4ba8f0@codeaurora.org>
Message-ID: <154152409835.88331.14046185859724133804@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port clocks
Date:   Tue, 06 Nov 2018 09:08:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-31 22:02:22)
> + Chandan from Display Port team,
> =

> On 10/30/2018 10:03 PM, Stephen Boyd wrote:
> > Also, those
> > numbers look like gigabits per second (Gbit/s) for the DP spec which
> > isn't exactly the same as a clk frequency. What frequency does the PLL
> > run at for these various DP link speeds?
> > =

> Could you please help with the above query from Stephen?

Can I safely assume that it matches the link rate shown on Wikipedia for
display port[1]? I.e.

 RBR (Reduced Bit Rate): 1.62 Gbit/s bandwidth per lane (162 MHz link
 symbol rate)
 HBR (High Bit Rate): 2.70 Gbit/s bandwidth per lane (270 MHz link
 symbol rate)
 HBR2 (High Bit Rate 2): 5.40 Gbit/s bandwidth per lane (540 MHz link
 symbol rate), introduced in DP 1.2
 HBR3 (High Bit Rate 3): 8.10 Gbit/s bandwidth per lane (810 MHz link
 symbol rate), introduced in DP 1.3

So then they're MHz but the table is written in kHz when it should be
written in Hz. Either way, the table can be removed and then we just
need to fix the DP PHY PLL code to accept Hz instead of kHz.

[1] https://en.wikipedia.org/wiki/DisplayPort#Main_link

