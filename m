Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC2CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8102E21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DUeZNGpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8102E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeKTEWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:22:01 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56571 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbeKTEWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542650249; x=1574186249;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vYiBfd68G62rKpPbQqXKzB2dDjgyrs+tLAKK35k4PrM=;
  b=DUeZNGpPVrkygVxDkpPI+hCDW67M6n2p4NCItoNpPQpmVuRt9n/NHiv/
   7h1v9aIw/I2CVOfiKZ7z3zWXG7AP+nyFUVfvXJfGV8yw4Z5XQ16zhQCox
   +i/WBauP7J87sHv71YdWN3joDfFFYyfd4RMlr+ncvk4iXEI7Zf/kVzpeF
   OeueRlAsJzdjs/yDn+YoTXG/VSPaPwkqZysqJRPiV8vEx4z8wFe+ARgv0
   J8SWqv7Sd6x7G6C0C/IDrU2GM5IshJ/gVaCyucfTC/wli7f0leUrk/b3P
   2zO+xRSoz8aSMGpSsGEzoHFWwpYHhY32tqo3ntLt7Ob0mCiMK5mBPmFnc
   g==;
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="99424437"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 01:57:29 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Nov 2018 09:40:19 -0800
Received: from cnf003109.ad.shared (HELO [10.86.54.248]) ([10.86.54.248])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 09:57:27 -0800
Subject: Re: [RFC 1/3] dt-binding: cpu-topology: Move cpu-map to a common
 binding.
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "juri.lelli@arm.com" <juri.lelli@arm.com>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
 <1541728209-3224-2-git-send-email-atish.patra@wdc.com>
 <20181117163253.GA6713@bogus>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <92a4a24d-6619-876f-18df-1326914f5cc1@wdc.com>
Date:   Mon, 19 Nov 2018 09:57:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181117163253.GA6713@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/18 8:33 AM, Rob Herring wrote:
> On Thu, Nov 08, 2018 at 05:50:07PM -0800, Atish Patra wrote:
>> cpu-map binding can be used to described cpu topology for both
>> RISC-V & ARM. It makes more sense to move the binding to document
>> to a common place.
>>
>> The relevant discussion can be found here.
>> https://lkml.org/lkml/2018/11/6/19
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/topology.txt | 475 -------------------
>>   .../devicetree/bindings/cpu/cpu-topology.txt       | 526 +++++++++++++++++++++
>>   2 files changed, 526 insertions(+), 475 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/arm/topology.txt
>>   create mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt
> 
> Please send this with '-M' option so we just get the real changes.
> 

Sure. I will resend it.

Regards,
Atish
> Rob
> 

