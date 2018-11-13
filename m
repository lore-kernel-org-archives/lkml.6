Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D212C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414A922419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E+0/kurc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414A922419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbeKMT17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:27:59 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57700 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbeKMT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:27:58 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9920324E0F1F;
        Tue, 13 Nov 2018 01:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542101445; bh=aBa2bMm5hEV6tMn5GmkPsjzltylxRQUiDM60RWt4Azg=;
        h=From:Subject:To:CC:References:Date:In-Reply-To:From;
        b=E+0/kurciBadzHTPpYTEsV2iJhQfs4MYpuQ43NTjsYQNPpuyblO4gg+QfKmGdYMq+
         r4FKX1QZ6wWNz8KyxsjhcaNs5LV+OEIaLRbUwTd3yIhOZrxXo4HHrEHjAbLR405R3h
         /SY6vpthLKltR+R1yKat43AXpxGNyT3kl2hlxHmTiB28XYfAwCOHQ54ODbfnZZvphC
         Z0n0hiS0Ewymtss3omc7aLsdaIyQc3h5hZjwg8boutRYpKN7GqnkUYa/I5C8DrLXNz
         0Wlab02Dl1gGUXFvYXGebZDzW/s7Z3SLHqZOAFM8eCrcaxG+GdYU5Kj37u2Ut9nIpe
         etntq2Ky7n9Zw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2EA523B35;
        Tue, 13 Nov 2018 01:30:43 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 01:30:42 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 10:30:41 +0100
Received: from [10.107.25.130] (10.107.25.130) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 10:30:41 +0100
From:   Luis de Oliveira <luis.oliveira@synopsys.com>
Subject: Re: [V3, 1/4] Documentation: dt-bindings: phy: Document the Synopsys
 MIPI DPHY Rx bindings
To:     Rob Herring <robh@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <joao.pinto@synopsys.com>, <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Keiichi Watanabe" <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        <devicetree@vger.kernel.org>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
 <1539953556-35762-2-git-send-email-lolivei@synopsys.com>
 <20181024173611.GA30655@bogus>
Message-ID: <67816d9f-97c9-8d9b-ff55-15861bf47f75@synopsys.com>
Date:   Tue, 13 Nov 2018 09:30:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024173611.GA30655@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.130]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, my responses inline.

On 24-Oct-18 18:36, Rob Herring wrote:
> On Fri, Oct 19, 2018 at 02:52:23PM +0200, Luis Oliveira wrote:
>> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
>> RX mode.
>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> ---
>> Changelog
>> v2-V3
>> - removed gpios reference - it was for a separated driver
>> - changed address to show complete address
>>
>>  .../devicetree/bindings/phy/snps,dphy-rx.txt       | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>> new file mode 100644
>> index 0000000..03d17ab
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>> @@ -0,0 +1,28 @@
>> +Synopsys DesignWare MIPI Rx D-PHY block details
>> +
>> +Description
>> +-----------
>> +
>> +The Synopsys MIPI D-PHY controller supports MIPI-DPHY in receiver mode.
>> +Please refer to phy-bindings.txt for more information.
>> +
>> +Required properties:
>> +- compatible		: Shall be "snps,dphy-rx".
>> +- #phy-cells		: Must be 1.
>> +- snps,dphy-frequency	: Output frequency of the D-PHY.
> 
> Needs a unit suffix (-hz).
> 

Yes,

>> +- snps,dphy-te-len	: Size of the communication interface (8 bits->8 or 12bits->12).
>> +- reg			: Physical base address and size of the device memory mapped
>> +		 	  registers;
> 
> How many, what are they, and what order? Looks like 3 below.
> 
> Also, a tab after spaces error.
> 

Yep, I will fix it. Thanks

>> +
>> +Example:
>> +
>> +	mipi_dphy_rx1: dphy@d00003040 {
>> +		compatible = "snps,dphy-rx";
>> +		#phy-cells = <1>;
>> +		snps,dphy-frequency = <300000>;
>> +		snps,dphy-te-len = <12>;
>> +		reg = < 0xd0003040 0x20
>> +			0xd0008000 0x100
>> +			0xd0009000 0x100>;
>> +	};
>> +
>> --
>> 2.7.4
>>

