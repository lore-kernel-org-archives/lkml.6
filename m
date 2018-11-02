Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F55C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E682081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDJY5TXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E682081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeKBWla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:41:30 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36358 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKBWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:41:29 -0400
Received: by mail-wr1-f51.google.com with SMTP id y16so2026338wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PmAX+XI2DJsLf6A1GZQrvIWUReOqNceZN/7JR8vuPzQ=;
        b=RDJY5TXAU2vLu5UOxxH0eI5plAxKVn/DN2ozmGiYUxl5UXBtDI8pDW7RHLqUz3SxKX
         XlvTZfD0TfbAODVbzJljBVtKovmscHZgH2WRds1NeRzqL4R2gcuX62f2SWh9pGYbeqXh
         QgZymPiScqg5AWJXf9im6ySf2RTkz5XCq+dGX+8JI7MyQilshj+jgWjttdkm7gtQ0hqA
         63fc1DzjcVAFYur8QAgiTfnk+aUl49xLy6G2n+yAcVR9qHDqm1mukYDBxH9Jul3Ykl4s
         WtWVhVir4MW9x7dslTxjRk3Ksjy0hzEtz8CaOryfWzlTBxdM1JWADyCf+Q+Dzr3h5nKt
         uChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PmAX+XI2DJsLf6A1GZQrvIWUReOqNceZN/7JR8vuPzQ=;
        b=Dv/MFD9/aTIEKd+ceuAW48AKhUFTEfi3bs6GYk0Fmy1ZwGZk2grrmwf+PhUVl7X8cu
         6ee6f+OcJyp/KXsc6UINFkbxH+NXyNdyJ36OdKHgYKYUINluf6GWF/nFQmoOLRaCPx70
         l/ynYH2U306+KGM5ZIk+dX3VkpdjaiHvIx13U8liwYDdM6in8vkCoxIQ+YHOqDfUacaI
         pzLcBbGq2l1dZ6y+kkrZGaFkwEB77YyLKs9yICls/9oanqYwE4QVYbVZaQz7IRe3T2Bm
         93rdVMLqBmVwPIrGPKoQvRmFc9Z0NbbaqZ+ok8vvkb1OdR3JYlP8FjPR5Irb+pggT1Jr
         zy2w==
X-Gm-Message-State: AGRZ1gILRfTWnmpECqtD0NKwzsWnstDZY432dFrVm3CW4fP9XEvvd7aH
        O3JrLzxuqhB3SehUI7qwpcMBDBvVW3cXy2opv04=
X-Google-Smtp-Source: AJdET5fzNeLbi3mSqk9u1vKv8qGA25SupOuf32FjAEEazsiYBFDJYVwyaA1OkZ7U6KJMaxkOsPdlMShBW9cVdiAJtE8=
X-Received: by 2002:a05:6000:10e:: with SMTP id o14mr10680622wrx.279.1541165658143;
 Fri, 02 Nov 2018 06:34:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jean-Michel Hautbois <jhautbois@gmail.com>
Date:   Fri, 2 Nov 2018 14:35:26 +0100
Message-ID: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
Subject: sama5d: using the ebi interface from another driver
To:     boris.brezillon@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a custom board based on a sama5d3 chip. The SoC is connected to
2 pef24628 SHDSL transceivers, the first one on ebi@40000000 and the
second one on ebi@50000000.
I tried to write a basic char driver, using request_mem_region and
ioremap but I can't read or write into the device.
I have to say that the driver is based on a proprietary one, and
tested years ago on a PowerPC board.

Then, after looking into deeper details in the datasheet I understand
it is connected through EBI and it sounds not so easy :D.

I would appreciate some help/pointers on this, as there is (at least,
I could find) few documentation on how to use it except for NAND
cases.

I have something like that in my DTS, but not sure this is the correct
way to do it :

        ebi: ebi@10000000 {
            pinctrl-0 = <&pinctrl_ebi_nand_addr>;
            pinctrl-names = "default";
            status = "okay";

            dsp0: pef24628@1 {
                status = "okay";
                compatible = "intel,pef24628";
                #address-cells = <1>;
                #size-cells = <1>;
                reg = <0x1 0x0 0x8000>;
                pinctrl-0 = <&pinctrl_dsp_cs1>;
            };

            dsp1: pef24628@2 {
                status = "okay";
                compatible = "intel,pef24628";
                #address-cells = <1>;
                #size-cells = <1>;
                reg = <0x2 0x0 0x8000>;
                pinctrl-0 = <&pinctrl_dsp_cs2>;
            };

            nand_controller: nand-controller {
                status = "okay";

                nand@3 {
                    reg = <0x3 0x0 0x2>;
                    atmel,rb = <0>;
                    nand-bus-width = <8>;
                    nand-ecc-mode = "hw";
                    nand-ecc-strength = <4>;
                    nand-ecc-step-size = <512>;
                    nand-on-flash-bbt;
                    label = "atmel_nand";

                    partitions {
                        compatible = "fixed-partitions";
                        #address-cells = <1>;
                        #size-cells = <1>;
[...]
                    };
                };
            };

The pinctrl for ebi should probably be changed however, I am wondering
how the (platform ?) driver can access the adress ? Should it parse
itself the parent, and find range, etc. Or is there an accessor for it
?

Maybe can I just manually toggle the CS GPIO, and don't try to make
anything more complex than what it should be ? The driver should not
be atmel dependant...

Thanks !
JM
