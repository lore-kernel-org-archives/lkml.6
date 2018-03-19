Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807254-1521433244-2-14742149406439198899
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521433243; b=wSZiutUNmU0cd8YZBmx5Q4O3GfYKDvNRawx/OfxVKzbBakU
    KQxPHVs8jdLXB84IKDsyMYTdDknDjHdwE1Y64fF/a4ECBABT4AXQ5lsBMCoMX5Xw
    BFystJ5okQMTfFPOCou/1y4ivShY4qQ4RhobDIQHKj06W2cOEsijMwvW66q6+Pgh
    7yx3Bwm5uXKHKUClbqzlBUiUi7e8adjcuUwug8TTZPw8hNR0cV/RkceyY3n2QCoO
    1TlY1lJp1S/4XRbP38hIbs1zzJJCqCleAIU195Q2Nwn09/e7UTzalAjIoG9mMwCH
    pj4RU7vx4McXB/irdteNQWSLe+3LceXnqQmcgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521433243; bh=a6dKFTnuy2lcPRwkuso+8MlDa0nPzkY5vx7HZJDS8T8=; b=g
    LVRXUOZ1z9o7ikT5W9Cj7jtc6k+Rk+2sIlFUNcAat/FOVeiXKTO0jtespluYuolX
    zEk//M2XVQFSDl0qv7DuxsQ8fjTfz6dGqlvy7cC7TKntX9qYQpc9CPtNG439X5ji
    PorxCQS74kYDSplrXs2skPvPRl0kZn0KErbeeac8RXx7O+MjQstbz2e2Ixyy4eMM
    WtkTxj0MSvRw03MpqHACRDEo5MH3EOgwz+kpURfTPpMarTNn6lgaK6VjEU9ArwgE
    c9ybGRthJ6h7B7Eym0OuLQzXFYAeVQglAzbed76Y6lZZtlCFA/k+DoRNK27NbJGP
    3+zlwwLcdooZxDd69GCJA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=D1F3tNB7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=D1F3tNB7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdejudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhsphejsehtjeertddtfeejnecuhfhrohhmpeforghnuhcuifgruhhtrghmuceomhhgrghuthgrmhestghouggvrghurhhorhgrrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtfedrvddvledrudelrdduleenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeegnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=D1F3tNB7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=D1F3tNB7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdejudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhsphejsehtjeertddtfeejnecuhfhrohhmpeforghnuhcuifgruhhtrghmuceomhhgrghuthgrmhestghouggvrghurhhorhgrrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtfedrvddvledrudelrdduleenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeefjeegnecuvehluhhsthgvrhfuihiivgepud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755100AbeCSEUa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 00:20:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754723AbeCSEU2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Mar 2018 00:20:28 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C17E660590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: Update documentation for
 Qualcomm DWC3 driver
To: Rob Herring <robh@kernel.org>
Cc: Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
 <20180318124922.kxa5q2vmhvydfp25@rob-hp-laptop>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <835029bb-08a9-16dc-e107-870615f57124@codeaurora.org>
Date: Mon, 19 Mar 2018 09:50:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318124922.kxa5q2vmhvydfp25@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,


On 3/18/2018 6:19 PM, Rob Herring wrote:
> On Tue, Mar 13, 2018 at 04:06:00PM +0530, Manu Gautam wrote:
>> Existing documentation has lot of incorrect information as it
>> was originally added for a driver that no longer exists.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  .../devicetree/bindings/usb/qcom,dwc3.txt          | 87 +++++++++++++++-------
>>  1 file changed, 59 insertions(+), 28 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
>> index bc8a2fa..df312f7 100644
>> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
>> @@ -1,54 +1,85 @@
>>  Qualcomm SuperSpeed DWC3 USB SoC controller
>>  
>>  Required properties:
>> -- compatible:	should contain "qcom,dwc3"
>> -- clocks:		A list of phandle + clock-specifier pairs for the
>> -				clocks listed in clock-names
>> -- clock-names:	Should contain the following:
>> -  "core"		Master/Core clock, have to be >= 125 MHz for SS
>> -				operation and >= 60MHz for HS operation
>> -
>> -Optional clocks:
>> -  "iface"		System bus AXI clock.  Not present on all platforms
>> -  "sleep"		Sleep clock, used when USB3 core goes into low
>> -				power mode (U3).
>> +- compatible:		should contain "qcom,dwc3"
>> +- reg:			offset and length of register set for QSCRATCH wrapper
>> +- reg-names:		should be "qscratch"
> reg-names is pointless for a single range.
Ok. Will change this.

>
>> +- power-domains:	specifies a phandle to PM domain provider node
>> +- clocks:		list of phandle + clock-specifier pairs
> How many clocks and what are they?
I will add description of the clocks in next version of patchset.


>
>> +- assigned-clocks:	should be:
>> +				MOCK_UTMI_CLK
>> +				MASTER_CLK
>> +- assigned-clock-rates: should be:
>> +                                19.2Mhz (192000000) for MOCK_UTMI_CLK
>> +                                >=125Mhz (125000000) for MASTER_CLK in SS mode
>> +                                >=60Mhz (60000000) for MASTER_CLK in HS mode
>> +
>> +Optional properties:
>> +- resets:		list of phandle and reset specifier pairs
>> +- interrupts:		specifies interrupts from controller wrapper used
>> +			to wakeup from low power/susepnd state.	Must contain
>> +			one or more entry for interrupt-names property
>> +- interrupt-names:	Must include the following entries:
>> +			- "hs_phy_irq": The interrupt that is asserted when a
>> +			   wakeup event is received on USB2 bus
>> +			- "ss_phy_irq": The interrupt that is asserted when a
>> +			   wakeup event is received on USB3 bus
>> +			- "dm_hs_phy_irq" and "dp_hs_phy_irq": Separate
>> +			   interrupts for any wakeup event on DM and DP lines
>> +- qcom,select-utmi-as-pipe-clk: if present, disable USB3 pipe_clk requirement.
>> +				Used when dwc3 operates without SSPHY and only
>> +				HS/FS/LS modes are supported.
>>  
>>  Required child node:
>>  A child node must exist to represent the core DWC3 IP block. The name of
>>  the node is not important. The content of the node is defined in dwc3.txt.
>>  
>>  Phy documentation is provided in the following places:
>> -Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
>> +Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   - USB3 QMP PHY
>> +Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt - USB2 QUSB2 PHY

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

