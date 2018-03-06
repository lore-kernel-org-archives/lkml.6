Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AG47ELtiNXqIxVyDQt66lIpjTFiRYZUBEU7YO9qIZaPSkzEO2X8Ixl76M5x+R/CzBxfQ/cOKwVID
ARC-Seal: i=1; a=rsa-sha256; t=1520363136; cv=none;
        d=google.com; s=arc-20160816;
        b=hmrnKgSJbqFjB0B7vfFKBA4vwl27uVdaljv7udlwwcaMB3hlkiwbvMTxMRQv0rLqUL
         vpPhvHDD+fJCvFzW7QDv4LQlVoZYdO+9ucltLlclvkPnyQqdlz5PkUg24iZS50J8XGR2
         LPIsiXN9lpip75vWzv+5xpAIucPs7fILb9+yHrCed6lslbO3a+Kvd2JAIndrUwbptpX8
         5gqiIO+qlJ7RsKA7qE82CYwD8im0oRUBm9ez9I0m4RY+eOd/OMtHIkwq1rvO55QP1S91
         4Oiw6VN6U7fuwDLmjNMcjfedScJ/oZnDMB3Nuv8pHRaenh2jH4cfJO4Xj8uaosBk5Sl9
         2SDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=rfqdvN4UpsnhQHFy6igeYqPMrQElXon5a7zjxAtGD5k=;
        b=mN3ydsbPBsA+sEQ8jdd4FEH3eAj8p7N6bchsFilDBtlaQM+d6ohugH8Zj08hEVshTv
         Kxlk26THt9kcSyd6zWjSanMWf3xsTolYomQ0wGeaRE2dl9dFIFy2LQ0pAz1DNElEBoNP
         usoKwWv2Qi+7vSyIZx2zPky4p/tERfiCj6hm3RgpLZleeeRaMckNrvbtsHSGxnAL5PUs
         j6zHfUdPGmPFRJzul1aoTppT2tSa0YRfSboIpKnkF7Etob1AaVBvALciem4pgGYcrlvY
         yxFqEGy4c2cQfCWIU2ZxK50m8T19kaeV6CaNPHLyKxDzH3pSqIrxEfRtencUuh0/AjD8
         O6sA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="205989469"
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
To: Pavel Machek <pavel@ucw.cz>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
 gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
 benh@kernel.crashing.org, andrew@lunn.ch, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
Date: Tue, 6 Mar 2018 11:05:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306124002.GA13950@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1594216296727595604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pavel,

Thanks for sharing your time on reviewing it. Please see my answers inline.

-Jae

On 3/6/2018 4:40 AM, Pavel Machek wrote:
> Hi!
> 
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
>>
>> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> new file mode 100644
>> index 000000000000..8a86f346d550
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> @@ -0,0 +1,73 @@
>> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
> 
> Are these SoCs x86-based?
> 

Yes, these are ARM SoCs. Please see Andrew's answer as well.

>> +Required properties:
>> +- compatible
>> +	"aspeed,ast2400-peci" or "aspeed,ast2500-peci"
>> +	- aspeed,ast2400-peci: Aspeed AST2400 family PECI controller
>> +	- aspeed,ast2500-peci: Aspeed AST2500 family PECI controller
>> +
>> +- reg
>> +	Should contain PECI registers location and length.
> 
> Other dts documents put it on one line, reg: Should contain ...
> 
>> +- clock_frequency
>> +	Should contain the operation frequency of PECI hardware module.
>> +	187500 ~ 24000000
> 
> specify this is Hz?
> 

I'll add a description. Thanks!

>> +- rd-sampling-point
>> +	Read sampling point selection. The whole period of a bit time will be
>> +	divided into 16 time frames. This value will determine which time frame
>> +	this controller will sample PECI signal for data read back. Usually in
>> +	the middle of a bit time is the best.
> 
> English? "This value will determine when this controller"?
> 

Could I change it like below?:

"This value will determine in which time frame this controller samples 
PECI signal for data read back"

>> +	0 ~ 15 (default: 8)
>> +
>> +- cmd_timeout_ms
>> +	Command timeout in units of ms.
>> +	1 ~ 60000 (default: 1000)
>> +
>> +Example:
>> +	peci: peci@1e78b000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x1e78b000 0x60>;
>> +
>> +		peci0: peci-bus@0 {
>> +			compatible = "aspeed,ast2500-peci";
>> +			reg = <0x0 0x60>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			interrupts = <15>;
>> +			clocks = <&clk_clkin>;
>> +			clock-frequency = <24000000>;
>> +			msg-timing-nego = <1>;
>> +			addr-timing-nego = <1>;
>> +			rd-sampling-point = <8>;
>> +			cmd-timeout-ms = <1000>;
>> +		};
>> +	};
>> \ No newline at end of file
> 
