Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755659AbeCSPnO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeCSPnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:43:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0973217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELtDTOz8ZA47OHWlhF0HxOfe0Tbt/Ev4lmZn1V80Wb5DAyHC6Qf6h2wEsr2kUSqTyi/+EZOnkWhpYg7ZHp0Gd0s=
MIME-Version: 1.0
In-Reply-To: <20180316163107.67gaxcjksn76ztmn@us-sjc-wireless-10-16-34-48.amer.corp.natinst.com>
References: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
 <1521215669-23874-2-git-send-email-p.pisati@gmail.com> <20180316163107.67gaxcjksn76ztmn@us-sjc-wireless-10-16-34-48.amer.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 19 Mar 2018 10:42:30 -0500
X-Gmail-Original-Message-ID: <CANk1AXQvCVLvSNJJUpazmiqauzHU6bHxn_gayWCFr8aidM=yHw@mail.gmail.com>
Message-ID: <CANk1AXQvCVLvSNJJUpazmiqauzHU6bHxn_gayWCFr8aidM=yHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt: bindings: fpga: add lattice machxo2 slave spi
 binding description
To: Moritz Fischer <mdf@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:31 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Fri, Mar 16, 2018 at 04:54:28PM +0100, Paolo Pisati wrote:
>> Add dt binding documentation details for Lattice MachXO2 FPGA configuration
>> over Slave SPI interface.
>>
>> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan

>> ---
>>  .../bindings/fpga/lattice-machxo2-spi.txt          | 29 ++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
>> new file mode 100644
>> index 0000000..a8c362e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
>> @@ -0,0 +1,29 @@
>> +Lattice MachXO2 Slave SPI FPGA Manager
>> +
>> +Lattice MachXO2 FPGAs support a method of loading the bitstream over
>> +'slave SPI' interface.
> Nit: a 'slave SPI'
>> +
>> +See 'MachXO2ProgrammingandConfigurationUsageGuide.pdf' on www.latticesemi.com
>> +
>> +Required properties:
>> +- compatible: should contain "lattice,machxo2-slave-spi"
>> +- reg: spi chip select of the FPGA
>> +
>> +Example for full FPGA configuration:
>> +
>> +     fpga-region0 {
>> +             compatible = "fpga-region";
>> +             fpga-mgr = <&fpga_mgr_spi>;
>> +             #address-cells = <0x1>;
>> +             #size-cells = <0x1>;
>> +     };
>> +
>> +     spi1: spi@2000 {
>> +        ...
>> +
>> +             fpga_mgr_spi: fpga-mgr@0 {
>> +                     compatible = "lattice,machxo2-slave-spi";
>> +                     spi-max-frequency = <8000000>;
>> +                     reg = <0>;
>> +             };
>> +     };
>> --
>> 2.7.4
>>
>
> Thanks,
>
> Moritz
