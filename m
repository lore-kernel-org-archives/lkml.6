Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FECC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287C2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="llhyG5yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5287C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeJPGo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:44:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44070 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJPGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539644266; x=1571180266;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TNWsDsrY0+1IONRcBFghvNkJcTRtv8K90Rbf9IJ+PFU=;
  b=llhyG5yhwEdBrUDKs7kaZBrTIqXbCfYvvvIEzvTckqcvfttkpppKbxPt
   qG+ZgKpXXzaWCHVTSTZgFGqsAMq6gTtPbR28KaqHzKVerFJY+utW3pO30
   /1ryrZP8G2EzMIP3bwcOWjrOtJQK5tqa8HaUpnrHGcoL2rg/T/C16iBFQ
   R8INjZQWcbl+htsmFyNiUP4DOHSipwQQTxURImlb1Sga+jQPgofFkRYFE
   GlD9bTwDamguUN2fBjOvPbJK0nWW7JZTmUi+tFm2WOHPG7QalT8QClhvZ
   kxDCfOPZZylsrmTRZf14wWwBSE81bfcYPK4hLladEpEiZKEdTfkYdBoxN
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,386,1534780800"; 
   d="scan'208";a="189691623"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2018 06:57:45 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 15 Oct 2018 15:42:10 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.73.114]) ([10.111.73.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2018 15:57:36 -0700
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
To:     Thierry Reding <thierry.reding@gmail.com>,
        Wesley Terpstra <wesley@sifive.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, hch@infradead.org
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
Date:   Mon, 15 Oct 2018 15:57:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010134926.GD21134@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 6:49 AM, Thierry Reding wrote:
> On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> DT documentation for PWM controller added with updated compatible
>> string.
>>
>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> [Atish: Compatible string update]
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-sifive.txt         | 32 ++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>> new file mode 100644
>> index 00000000..532b10fc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>> @@ -0,0 +1,32 @@
>> +SiFive PWM controller
>> +
>> +Unlike most other PWM controllers, the SiFive PWM controller currently only
>> +supports one period for all channels in the PWM. This is set globally in DTS.
>> +The period also has significant restrictions on the values it can achieve,
>> +which the driver rounds to the nearest achievable frequency.
> 
> What restrictions are these? If "nearest achievable" is too far off the
> target period it might be preferable to error out.
> 

@Wes: Any comments?

>> +Required properties:
>> +- compatible: should be one of
>> +	"sifive,fu540-c000-pwm0","sifive,pwm0".
> 
> What's the '0' in here? A version number?
>

I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive 
Guys decided mark it as version 0.

@Wesly: Please correct me if I am wrong.

>> +	PWM controller is HiFive Unleashed specific chip which warrants a
>> +	specific compatible string. The second string is kept for backward
>> +	compatibility until a firmware update with latest compatible string.
>> +- reg: physical base address and length of the controller's registers
>> +- clocks: The frequency the controller runs at
>> +- #pwm-cells: Should be 2.
>> +  The first cell is the PWM channel number
>> +  The second cell is the PWM polarity
>> +- sifive,approx-period: the driver will get as close to this period as it can
> 
> Given the above comment, maybe "sifive,period"?
> 

ok.
In Unleashed board, the DT is loaded by FSBL (first stage boot loader). 
Thus, changing device tree entries requires a FSBL update. If we update 
this string, we need to update the driver to parse both properties so 
that existing devices with older firmware continue to work.

This is probably ok as we anyways do that for compatible strings. Just 
wanted to update that here for the record.

Regards,
Atish
> Thierry
> 

