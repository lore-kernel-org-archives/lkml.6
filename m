Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969565AbeCSSYK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031528AbeCSSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:23:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D1A21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Jolly Shah <JOLLYS@xilinx.com>, Rob Herring <robh@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <DM2PR0201MB0767FFBAECF3A0B30251DBB8B8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com>
 <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
 <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
 <DM2PR0201MB0767FFBAECF3A0B30251DBB8B8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
Message-ID: <152148383577.242365.14896728603053993045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date: Mon, 19 Mar 2018 11:23:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-03-13 11:39:13)
> Hi Rob,
> > 
> > What is the interface to the "platform management controller"? Because you
> > have no registers, I'm guessing a firmware interface? If so, then just define the
> > firmware node as a clock provider.
> 
> Yes it is firmware interface. Along with clocks, firmware interface also controls power and pinctrl operations as major.
> I am not sure if I understand you correctly. Do you suggest to register clocks through Firmware driver or just use firmware DT node as clock provider and clock driver DT node can reference clocks from FW node to register same?

I would suggest making the firmware driver register the clks and act as
the clk provider. Not sure what Rob wants.
