Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeDFUrg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeDFUre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:47:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129AF20CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Quentin Schulz <quentin.schulz@bootlin.com>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        shiraz.linux.kernel@gmail.com, vireshk@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
References: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
 <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
Message-ID: <152304765337.94378.9011588137332248203@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: spear: fix WDT clock definition on SPEAr600
Date: Fri, 06 Apr 2018 13:47:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Quentin Schulz (2018-04-06 00:50:45)
> There is no SPEAr600 device named "wdt". Instead, the description of the
> WDT (watchdog) was recently added to the Device Tree, and the device
> name is "fc880000.wdt", so we should associate the WDT fixed rate clock
> to this device name.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

Applied to clk-next

I take it there are other problems though, e.g. clcd. Why not use DT
lookups instead of clkdev ones?
