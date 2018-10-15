Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C90AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530962089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E8P+KUnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530962089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeJPAHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:07:08 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:48236 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:07:08 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9919910C04F7;
        Mon, 15 Oct 2018 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539620474; bh=1rpkrGKNclJObwrMn5TvdLkiiVbrUhLrjM008725t00=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=E8P+KUnQjiiOPlEJvMpgvyay3Bpo+jq+9R86WBi9UNX804d7D9BQCbhUB0YzIDDun
         ex8f+WBzlkMjuTCLFtigLw7l2uE9kG1RZHWZ6RT+baGAWG+JnFOdGEwlKyveVscN+L
         vdJdAxDmk8pa4g4I4cCwNQhQUJUjIEJ7lduShCk8s/6GsFfHSMaPyk+fTbiUcyg/VI
         6FMfONGUGEa/0tYOWdRc1zdQpOQXauZZkfv2QQEEymdftzLwJIL8xaD6jaGmz031FU
         X1Sg9ArQFcM0Dpo5Z0n8K//9ynO+X71qwnZBNQnia5G5xWt1zrNsQ/Ac9uMfcZy+2H
         rbApbuu3H668A==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id CEAFB3253;
        Mon, 15 Oct 2018 09:21:09 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 15 Oct 2018 09:21:09 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 15 Oct 2018 18:21:06 +0200
Received: from [10.107.19.163] (10.107.19.163) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 15 Oct 2018 18:21:06 +0200
Subject: Re: [V2, 2/5] Documentation: dt-bindings: Document the Synopsys MIPI
 DPHY Rx bindings
To:     Rob Herring <robh@kernel.org>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Joao.Pinto@synopsys.com>, <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        <devicetree@vger.kernel.org>
References: <20180920111648.27000-1-lolivei@synopsys.com>
 <20180920111648.27000-3-lolivei@synopsys.com> <20181012164548.GA11873@bogus>
From:   Luis Oliveira <luis.oliveira@synopsys.com>
Message-ID: <5f3b530b-1869-2749-ef05-60fb272d56f8@synopsys.com>
Date:   Mon, 15 Oct 2018 17:21:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012164548.GA11873@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.163]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 12-Oct-18 17:45, Rob Herring wrote:
> On Thu, Sep 20, 2018 at 01:16:40PM +0200, Luis Oliveira wrote:
>> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
>> RX mode.
> 
> "dt-bindings: phy: ..." for the subject.
> 
Yes, you are right.

>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> ---
>> Changelog
>> v2:
>> - no changes
>>
>>  .../devicetree/bindings/phy/snps,dphy-rx.txt       | 36 ++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>> new file mode 100644
>> index 0000000..9079f4a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
>> @@ -0,0 +1,36 @@
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
>> +- snps,dphy-te-len	: Size of the communication interface (8 bits->8 or 12bits->12).
>> +- reg			: Physical base address and size of the device memory mapped
>> +		 	  registers;
>> +
>> +Optional properties:
>> +- snps,compat-mode	: Compatibility mode control
> 
> type? values?
> 

I will remove this in V3.

>> +
>> +The per-board settings:
>> +- gpios 		: Synopsys testchip used as reference uses this to change setup
>> +		  	  configurations.
> 
> Preferred to be named (e.g. foo-gpios). How many? What are their 
> functions?
> 

Ok, thanks for reviewing this.

>> +
>> +Example:
>> +
>> +	mipi_dphy_rx1: dphy@3040 {
>> +		compatible = "snps,dphy-rx";
>> +		#phy-cells = <1>;
>> +		snps,dphy-frequency = <300000>;
>> +		snps,dphy-te-len = <12>;
>> +		snps,compat-mode = <1>;
>> +		reg = < 0x03040 0x20
>> +			0x08000 0x100
>> +			0x09000 0x100>;
>> +	};
>> +
>> -- 
>> 2.9.3
>>

