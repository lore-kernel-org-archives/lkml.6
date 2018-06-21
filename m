Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F0520846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFnVD51D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F0520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbeFUK45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:56:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38636 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbeFUK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:56:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so4109149lfh.5;
        Thu, 21 Jun 2018 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jU9ggecRmLkohCgXGqXNxsjAZgBTgwebKbsIuldTQok=;
        b=nFnVD51DUXupLNoXA1M73OrVaiUa9bCxwHfnZhraTCgzZQhxRXoic+HWlBplbZQORq
         A8B/G5GrT4OlyAO4fhTdaIhFxZ1w4T7ewdX3h45K0TJjzsxUwUVRicuJJKRkVu/rRUw+
         4B9gY77BvE7IOdAkIbxxC1zomehSIjH7GxTvFoPA5hlIVNEX53ZD87L971K3gGK9dxaU
         SpfnACkWea6fVfZ36prCbBIVuJmSXIXLa60c3xPFaJ2grwpe1JiJCiC9TjoYb9FmuXbb
         3AEw2Cxjiw/fjgz8/a5sM8YDwJJrury07rEkXEuOJ7VZcdeJXngcynp1+brl7ncU31Bj
         tPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jU9ggecRmLkohCgXGqXNxsjAZgBTgwebKbsIuldTQok=;
        b=An0vL6DAPuuNxv7lLQAFTJhIoxbp8Z1tZYEOfWHR3gN8Btjl4OWd740R2LPpLniIgt
         aAnR2+V3knDeTEAEy8i83nEZQz58mVbc72nCHgyOs0Aw5BBGqOg0ncbgTH3lgzVYhFah
         1QjXAV40zbHVCu9Lww1tcybTMNpBdc6fTgQdGdoStSAXEJ8vL4Dyj3aWBERW6y7W9reO
         kIevdwMPIyq2DtdqB+LwqGC4Cio3Hsc5FTgGNNNMXSkFKdUDtYuWL0lz7dR4ISybyvzL
         vVxt4op32mElsEmDExWp2QyQxRnM7buwA32/DFg2AN8JdqOnN4IznIdT5+tM3BybJYcX
         Ul5w==
X-Gm-Message-State: APt69E2cBmWXGS8GWlUjnhC7JBbVSoQJwhgBwg3Ts4wgSA5B7NE66wSM
        DlzIgLcTxz8cGRu4NtcMEA==
X-Google-Smtp-Source: ADUXVKKMglqHpdVv6V9JDhL0F7HidTU0BEEkOm5daVtppkxJS0h7M79TKbUWeQF+E0HYcZ1UgPQn3g==
X-Received: by 2002:a19:20c1:: with SMTP id g184-v6mr16060503lfg.96.1529578613156;
        Thu, 21 Jun 2018 03:56:53 -0700 (PDT)
Received: from [192.168.0.4] (89-64-25-103.dynamic.chello.pl. [89.64.25.103])
        by smtp.gmail.com with ESMTPSA id t197-v6sm203232lfe.32.2018.06.21.03.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 03:56:52 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
X-Google-Original-From: Piotr Bugalski <elvis@carbonite>
Date:   Thu, 21 Jun 2018 12:56:50 +0200 (CEST)
To:     Boris Brezillon <boris.brezillon@bootlin.com>
cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH 2/2] dt-bindings: spi: QuadSPI driver for Atmel
 SAMA5D2 documentation
In-Reply-To: <20180620164741.2a8da424@bbrezillon>
Message-ID: <alpine.DEB.2.20.1806211252390.28763@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com> <20180618162124.21749-3-bugalski.piotr@gmail.com> <20180620164741.2a8da424@bbrezillon>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

On Wed, 20 Jun 2018, Boris Brezillon wrote:

> Hi Piotr,
>
> On Mon, 18 Jun 2018 18:21:24 +0200
> Piotr Bugalski <bugalski.piotr@gmail.com> wrote:
>
>> Documentation for DT-binding change.
>>
>> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
>
> I'm pretty sure I didn't make a single suggestion about the DT
> bindings you use here ;-).
>

Ok, I misunderstood a bit your idea, but I think from next release this
field will be in good place. So it was just prepared for the future ;-)

>> Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
>>
>> ---
>>  .../devicetree/bindings/spi/spi_atmel-qspi.txt     | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
>
> I'll comment on this aspect in more details when replying to the cover
> letter, but I think you should re-use the bindings defined in
> Documentation/devicetree/bindings/mtd/atmel-quadspi.txt (IOW, move the
> existing file to the Documentation/devicetree/bindings/spi directory).
>
> It's the same HW block, and just because you develop a new driver to
> replace the old one doesn't mean you should have 2 different bindings in
> parallel.

I'll change it in next version.

>
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
>> new file mode 100644
>> index 000000000000..d52b534c9c2b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
>> @@ -0,0 +1,41 @@
>> +* Atmel Quad Serial Peripheral Interface (QSPI)
>> +
>> +Required properties:
>> +- compatible:     Should be "atmel,sama5d2-spi-qspi".
>> +- reg:            Should contain the locations and lengths of the base registers
>> +                  and the mapped memory.
>> +- reg-names:      Should contain the resource reg names:
>> +                  - qspi_base: configuration register address space
>> +                  - qspi_mmap: memory mapped address space
>> +- interrupts:     Should contain the interrupt for the device.
>> +- clocks:         The phandle of the clock needed by the QSPI controller.
>> +- #address-cells: Should be <1>.
>> +- #size-cells:    Should be <0>.
>> +
>> +Example:
>> +
>> +qspi1: spi@f0024000 {
>> +	compatible = "atmel,sama5d2-spi-qspi";
>> +	reg = <0xf0024000 0x100>, <0xd8000000 0x08000000>;
>> +	reg-names = "qspi_base", "qspi_mmap";
>> +	interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
>> +	clocks = <&qspi1_clk>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_qspi1_default>;
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "winbond,w25m02gv", "spi-nand";
>
> "winbond,w25m02gv" is undocumented and unnecessary since SPI NANDs are
> automatically detected. Also, maybe you should declare a SPI NOR in the
> example since SPI NAND support has not yet been merged.
>

I was mainly focusing on NAND-flash with QSPI inteface so I took
example from tested configuration. Next time I'll use NOR-flash.

>> +		reg = <0>;
>> +		spi-max-frequency = <83000000>;
>> +		spi-rx-bus-width = <4>;
>> +		spi-tx-bus-width = <4>;
>> +
>> +		...
>> +	};
>> +};
>> +
>
> Regards,
>
> Boris
>

Thanks,
Piotr

