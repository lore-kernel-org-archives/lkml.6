Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A829C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45349216F7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gP4D/d50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45349216F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeHOEeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:34:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34803 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeHOEeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:34:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so37256280ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 18:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K7upa2dhVv1S7fIrkoaF1joFSVUFn1uXZQi2wCt1ioY=;
        b=gP4D/d50akZdTUmL3tQJ7MlHbib5ZFf9ZbdYJQHX4V4YzBjmvrd7UUqVekgw9/eC5M
         1APWcYG1Nf00fTcZGo6za5uVHPdlLohyyaenh0k3hXLv18vYYbCxfDOftGDw5S3TQs22
         +o/kHUBxf0WKixiNy8pa5QwhBHZhuBz+UbR6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K7upa2dhVv1S7fIrkoaF1joFSVUFn1uXZQi2wCt1ioY=;
        b=X3q/Rv786JpGFXQ/hTPFNQBQxHBjjh3KCvKwF3hmKBPigqAYS7R/e1+zBzuraJr8qj
         Ew/1dCU4oAsO7pkxKpDxT3pAMKRzjAe9JVQlZE+bTpeGDVc0yXaYxpb6zR5hLqxRPFoi
         EmjihW1HqPC8EcYGmCvcnFybqeMpoQOKO4iFQvaMejGSS2PG/VuO6OwmXJo8XNTo2b1J
         JdkhNzDZtkWXDGjpVguamslEClraA5/PIM3RJOIm3BEXI4g3QGInndQmRD4b5dckak3X
         ycCa07nLyrRtfwGsX8jfMc2zGBNzMrUDOXlSUgfLz7F4HM4nrlikqBxrb9tqb9MzI+2E
         YXVw==
X-Gm-Message-State: AOUpUlGcLz1DFYKYY7oVIIinVaPNyfS9vVaocksvxCga47hqYM/fW/St
        +JYYh6XBOq91n4cQbHtSF+yASEbCfu2MCwF6uJRGGyAMi7luuTgk
X-Google-Smtp-Source: AA+uWPywsOGS6dR50G3xYV4mqlKC2pbL4Qr6XDYgcsfEzBe79xtOrE6r0afSEbceDLffX+ua++bDWk1XEergMOVKKmI=
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr25596832oib.320.1534297467537;
 Tue, 14 Aug 2018 18:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 18:44:27
 -0700 (PDT)
In-Reply-To: <20180814202122.GA26606@rob-hp-laptop>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180814202122.GA26606@rob-hp-laptop>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 15 Aug 2018 09:44:27 +0800
Message-ID: <CAMz4kuKb_5gxMbLG1cfPwFHS9n666epy38Akz1FhDcjeAUik9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 15 August 2018 at 04:21, Rob Herring <robh@kernel.org> wrote:
> On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:
>> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>>
>> This patch adds the binding documentation for Spreadtrum SPI
>> controller device.
>>
>> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-sprd.txt |   31 ++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
>> new file mode 100644
>> index 0000000..06ff746
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
>> @@ -0,0 +1,31 @@
>> +Spreadtrum SPI Controller
>> +
>> +Required properties:
>> +- compatible: Should be "sprd,sc9860-spi".
>> +- reg: Offset and length of SPI controller register space.
>> +- interrupts: Should contain SPI interrupt.
>> +- clock-names: Should contain following entries:
>> +     "spi" for SPI clock,
>> +     "source" for SPI source (parent) clock,
>
> Do the h/w block actually get this clock or the driver needs it? In the
> latter case, it should not be in DT.

Yes, we will get the actual SPI source clock form the "source" clock property.

>
>> +     "enable" for SPI module enable clock.
>> +- clocks: List of clock input name strings sorted in the same order
>> +     as the clock-names property.
>> +- #address-cells: The number of cells required to define a chip select
>> +     address on the SPI bus. Should be set to 1.
>> +- #size-cells: Should be set to 0.
>> +
>> +Optional properties:
>> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
>> +     converted to the delay clock cycles = interval number * 4 + 10.
>
> There are read and write delay properties you can use.

Right. We've agreed introducing another field for spi_transfer to
represent this and will remove 'sprd,spi-interval' from DT.

-- 
Baolin Wang
Best Regards
