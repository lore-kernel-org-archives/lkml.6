Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeEWJHV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:07:21 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51592 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754378AbeEWJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:07:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Wed, 23 May 2018 11:07:17 +0200
From: Stefan Agner <stefan@agner.ch>
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?=
        <sebastien.szymanski@armadeus.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: imx6ull-colibri-wifi: remove operating
 points
In-Reply-To: <20180523043032.2htohlypynnvpiye@vireshk-i7>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180522062853.24799-3-sebastien.szymanski@armadeus.com>
 <20180523043032.2htohlypynnvpiye@vireshk-i7>
Message-ID: <dc3523800c274e96dc5642c9c5b65ebe@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 06:30, Viresh Kumar wrote:
> On 22-05-18, 08:28, Sébastien Szymanski wrote:
>> Operating points are now defined in the imx6ull.dtsi file so remove
>> them from board device trees.
>>
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi | 14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
>> index 3dffbcd50bf6..183193e8580d 100644
>> --- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
>> +++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
>> @@ -20,20 +20,6 @@
>>
>>  &cpu0 {
>>  	clock-frequency = <792000000>;
>> -	operating-points = <
>> -		/* kHz	uV */
>> -		792000  1225000
>> -		528000	1175000
>> -		396000	1025000
>> -		198000	950000
>> -	>;
>> -	fsl,soc-operating-points = <
>> -		/* KHz	uV */
>> -		792000  1175000
>> -		528000	1175000
>> -		396000	1175000
>> -		198000	1175000
>> -	>;
>>  };
>>
>>  &iomuxc {
> 
> Maybe you should merge this with the previous patch itself.


I am with Viresh here, I rather prefer this in a single commit so it is
clear that frequencies moved to the base device tree.

Also, add a comment that frequency selection is now handled in code,
e.g.:

"The valid frequencies for a particular SKU are now selected by the
cpufreq driver according to ratings stored in OTP fuses."

But the two device tree changes with the driver do what they should do
here, so:

Tested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan
