Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572FBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D132087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="G579AefQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfAROPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:15:32 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57680 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfAROPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547820929; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkNNW/dI81cbH2kw0vmnMq2W7RjddJVYl94J+FIvKqk=;
        b=G579AefQ/4l83VXzQhtgVi4FJMr+Q1CzPAc4EzaHWHYyclT9q6pRHVoUBEeQmMTP9qcCBa
        koJ+LUmMymY1GRsN60EHSQwbiqYWyMF3IycGHiURZPOq8iCEXcZT3o+5A61ISS5wyKu6LM
        UFfJ/DtpucV9jxSqnmfNKAsCX568MDQ=
Date:   Fri, 18 Jan 2019 11:15:14 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/8] MIPS: DTS: CI20: Set BCH clock to 200 MHz
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <1547820914.1909.1@crapouillou.net>
In-Reply-To: <20190118090736.6f1283bd@bbrezillon>
References: <20190118010634.27399-1-paul@crapouillou.net>
        <20190118090736.6f1283bd@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 18, 2019 at 5:07 AM, Boris Brezillon 
<bbrezillon@kernel.org> wrote:
> Hi Paul,
> 
> On Thu, 17 Jan 2019 22:06:27 -0300
> Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>> 
> wrote:
> 
>>  This is currently done inside the jz4780-bch driver, but it really
>>  should be done here instead.
>> 
> 
> I disagree with that statement. If it's a per-SoC constraint then you
> can select the appropriate rate based on the compatible in the driver.
> If the clock rate depends on the NAND chip it probably means it's used
> to generate the RE/WE pulse and should depend on the NAND timings
> passed to ->setup_data_interface(). In either case, this should not be
> specified in the DT.

Alright, I'll drop the patch.

> Regards,
> 
> Boris
> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net 
>> <mailto:paul@crapouillou.net>>
>>  ---
>>   arch/mips/boot/dts/ingenic/ci20.dts | 3 +++
>>   1 file changed, 3 insertions(+)
>> 
>>  diff --git a/arch/mips/boot/dts/ingenic/ci20.dts 
>> b/arch/mips/boot/dts/ingenic/ci20.dts
>>  index 50cff3cbcc6d..aa892ec54d0a 100644
>>  --- a/arch/mips/boot/dts/ingenic/ci20.dts
>>  +++ b/arch/mips/boot/dts/ingenic/ci20.dts
>>  @@ -111,6 +111,9 @@
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&pins_nemc>;
>> 
>>  +		assigned-clocks = <&cgu JZ4780_CLK_BCH>;
>>  +		assigned-clock-rates = <200000000>;
>>  +
>>   		nand@1 {
>>   			reg = <1>;
>> 
> 


