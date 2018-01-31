Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeAaJOS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:14:18 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:31977 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeAaJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:13:46 -0500
Subject: Re: [alsa-devel] [PATCH] sound/tlv320dac33: Add device tree support
To: Ladislav Michl <ladis@linux-mips.org>, Pavel Machek <pavel@ucw.cz>
CC: <mark.rutland@arm.com>, <alsa-devel@alsa-project.org>,
        <lgirdwood@gmail.com>, <tony@atomide.com>, <abcloriens@gmail.com>,
        <tiwai@suse.com>, <martijn@brixit.nl>,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>,
        <patrikbachan@gmail.com>, <ivo.g.dimitrov.75@gmail.com>,
        <khilman@kernel.org>, <serge@hallyn.com>, <devicetree@vger.kernel.org>,
        <pali.rohar@gmail.com>, <robh+dt@kernel.org>,
        <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <aaro.koskinen@iki.fi>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>, <clayton@craftyguy.net>,
        <sakari.ailus@linux.intel.com>, <sre@kernel.org>, <bhumirks@gmail.com>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f3f23e16-2045-78bd-b77e-f236cab3b85d@ti.com>
Date: Wed, 31 Jan 2018 11:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180129232031.GA7695@lenoch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-01-30 01:20, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
>>
>> This adds device tree support to tlv320dac33.c.
>>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
>> new file mode 100644
>> index 0000000..6cbd311
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
>> @@ -0,0 +1,32 @@
>> +Texas Instruments - tlv320dac33 Codec module
>> +
>> +The tlv320dac33 serial control bus communicates through I2C protocols.
>> +
>> +Required properties:
>> +
>> +- compatible - "ti,tlv320dac33"
>> +- reg - I2C slave address
>> +
>> +Optional properties:
>> +
>> +- power-gpios - gpio pin to power the device, active high
> 
> While driver used gpio in platform data, isn't it more likely
> regulator which powers device?

It is GPIO, and according to the non public TRM it is connected to the
reset pin of the codec.

So the correct name should be reset-gpios

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
