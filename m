Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755165AbeCHBUZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754875AbeCHBUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:20:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF172178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELsMb8Yzy8I90H/OlUkNGNRF476j1X2ljkssH2yaaRfQTFLH4P9HMwkkzjQI901waNQQ+ngNP2myZIs9sHqFAFM=
MIME-Version: 1.0
In-Reply-To: <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com> <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
 <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Mar 2018 19:20:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
Message-ID: <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock driver
To: Jolly Shah <JOLLYS@xilinx.com>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 4:47 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> Hi Rob,
>
>
>> -----Original Message-----
>> From: Rob Herring [mailto:robh@kernel.org]
>> Sent: Monday, March 05, 2018 5:46 PM
>> To: Jolly Shah <JOLLYS@xilinx.com>
>> Cc: mturquette@baylibre.com; sboyd@codeaurora.org;
>> michal.simek@xilinx.com; mark.rutland@arm.com; linux-clk@vger.kernel.org;
>> devicetree@vger.kernel.org; Shubhrajyoti Datta <shubhraj@xilinx.com>; linux-
>> kernel@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
>> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
>> driver
>>
>> On Wed, Feb 28, 2018 at 02:27:40PM -0800, Jolly Shah wrote:
>> > Add documentation to describe Xilinx ZynqMP clock driver bindings.
>> >
>> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
>> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> > ---

>> > +95         dpll_post_src
>> > +96         vpll_int
>> > +97         vpll_pre_src
>> > +98         vpll_half
>> > +99         vpll_int_mux
>> > +100                vpll_post_src
>> > +101                can0_mio
>> > +102                can1_mio
>> > +
>> > +Example:
>> > +
>> > +clk: clk {
>> > +   #clock-cells = <1>;
>> > +   compatible = "xlnx,zynqmp-clk";
>>
>> How do you control the clocks?
>
> Clocks are controlled by a dedicated platform management controller. Above clock ids are used to identify clocks between master and PMU.

What is the interface to the "platform management controller"? Because
you have no registers, I'm guessing a firmware interface? If so, then
just define the firmware node as a clock provider.

Rob
