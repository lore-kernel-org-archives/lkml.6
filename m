Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562CCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5B522360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gdMrnR8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5B522360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbeKMSza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:55:30 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:52060 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeKMSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:55:30 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 78E6710C11FC;
        Tue, 13 Nov 2018 00:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542099503; bh=aBa2bMm5hEV6tMn5GmkPsjzltylxRQUiDM60RWt4Azg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=gdMrnR8iPWlfuzwz/Gqtfi/Prwe4XKekEsFhXFvzJjEO4ybVvW2j0Qa9VQlzwasNd
         M0WwPo8ZzyR+cBVGzaIel5JcimCF/7GtOgogPSD1sWu7CXAVywjiseKYhxR627gz72
         kTRVyyiTE8RvoZsdZHlWbdjfppm/BHOrwtdac/Yja9gldXgH8TBF0Eu/YnCzO1/c8P
         PG/OH7pwtslZV8IN1wDq7+hYNLwRNsR0aq/HMA47BeTR/q4Wbe7FY/YaLRV+eLpUc0
         G08J53fGiUcdmLYdj0OBtBRGRS1ouLf7zWRhZKQcp+LDbqkNPtIveUQa+449qjBsP9
         bSpYgrFI2O7tA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1DB36558B;
        Tue, 13 Nov 2018 00:58:20 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 00:58:20 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 09:58:19 +0100
Received: from [10.107.25.130] (10.107.25.130) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 09:58:18 +0100
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
From:   Luis Oliveira <luis.oliveira@synopsys.com>
Message-ID: <0cfb65eb-42c5-c548-12e9-c495d5e5156a@synopsys.com>
Date:   Tue, 13 Nov 2018 08:58:16 +0000
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

