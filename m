Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbeCFH7x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:59:53 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35306 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:59:52 -0500
X-Google-Smtp-Source: AG47ELsdRrMGgEgl7zlRd77pDP15TxV/7rvsSZnPkqMyp62YkE9g5sJc3JhjWpc5nYTzIK+h2NfFEp4iOPu2gN2dKoA=
MIME-Version: 1.0
In-Reply-To: <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
 <1519775750-21297-2-git-send-email-jollys@xilinx.com> <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Mar 2018 08:59:50 +0100
X-Google-Sender-Auth: S5PpMusqGaoZm_zzSMlGeOOMw8k
Message-ID: <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
To: Rob Herring <robh@kernel.org>
Cc: Jolly Shah <jolly.shah@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        sean.wang@mediatek.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>, rajanv@xilinx.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Jolly,

On Mon, Mar 5, 2018 at 11:39 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Feb 27, 2018 at 03:55:49PM -0800, Jolly Shah wrote:
>> Add documentation to describe ZynqMP power domain bindings.
>>
>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> ---
>>  .../devicetree/bindings/power/zynqmp-genpd.txt     | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/zynqmp-genpd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
>> new file mode 100644
>> index 0000000..25f9711
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt

>> +This node contains a number of subnodes, each representing a single PM domain
>> +that PM domain consumer devices reference.
>> +
>> +== PM Domain Nodes ==
>> +
>> +Required properties:
>> + - #power-domain-cells: Number of cells in a PM domain specifier. Must be 0.
>> + - pd-id: List of domain identifiers of as defined by platform firmware. These
>> +       identifiers are passed to the PM firmware.
>> +
>> +Example:
>> +     zynqmp-genpd {
>> +             compatible = "xlnx,zynqmp-genpd";
>
> What's the control interface for controlling the domains?
>> +
>> +             pd_usb0: pd-usb0 {
>> +                     pd-id = <22>;
>> +                     #power-domain-cells = <0>;
>
> There's no need for all these sub nodes. Make #power-domain-cells 1 and
> put the id in the cell value.

That was my first reaction, too...
>
>> +             };
>> +
>> +             pd_sata: pd-sata {
>> +                     pd-id = <28>;
>> +                     #power-domain-cells = <0>;
>> +             };
>> +
>> +             pd_gpu: pd-gpu {
>> +                     pd-id = <58 20 21>;

... until I saw the above.
Controlling the GPU power area requires controlling 3 physical areas?

However, doing it this way may bite you in the future, if a need arises to
control a subset. And what about power up/down order?

>> +                     #power-domain-cells = <0x0>;
>> +             };
>> +     };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
