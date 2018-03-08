Return-Path: <ldewangan@nvidia.com>
X-Google-Smtp-Source: AG47ELvdWxH+9NbrXAbRR8BwM6xWscSi60w9THBXKCJ7OcntUQUyWivhiTi+Gd3YD7nsUm3Orllw
ARC-Seal: i=1; a=rsa-sha256; t=1520522482; cv=none;
        d=google.com; s=arc-20160816;
        b=c802iCuC+IeANLqqxr1MxSvEvSyaERbVIIjw5nJ42uiD0V07bat1Ddh05KY2yYUKEc
         xs/3sE78KuLEriuDpJ6pqslA9fQe7yA7hEW0wkdR1R9WlvXmA/dmoy6J0a7EoMMWUERA
         kGlbcXE+UsXgRtMnItLG7uWcz3157Z+CY7UJ/M8nkF79YAxKTqAG8cjPrClLvukAUeIY
         jOryxB63S/XZfgT6syY4RhS1g+Avd4dQD6FPDUexXrl8x7DzEWtJiWgB46ZzmtYAGFn4
         as3/cZq8hPdRYk07ekxoWWK/BzPqeN+qfwEmfPmsMaaaOxjWcgCNX9Iko979vakE6AxD
         4YdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=TOYZQbpbpm90bwZebuaEa+rkvwJqMj+46WtBNIRBrAY=;
        b=ZaJ4t1TJh22rkcX/qXafj9cNYey67AutlgzXhr2Jpitpy0ORR39/P8w+d3p3HKlFou
         nJgbWHiLJj/5suj5H6To8v1G9FfyB7FiPkeKziukAUmhpMnQBX1wXvRtHAM652W/si1t
         ZpHieew2tCeNprmK9jkt3p/ldHHnHOBbkx3noUX/mSX2DJV1zj20orvM2WxuFWlOwgkt
         YbnaW7rfLqad+CY6rJnrwEvZKqu4NZdL5wRKCkEtFvdfdPnoYmcb6Gv3Q4LjOERf+S9i
         ggVeCoPem5bWmx1mrsezFEKYmnl0n9QczgZidVWhvQm53o8HwIs6j6qyTxOnRrNVAegZ
         Nm1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ldewangan@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=ldewangan@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ldewangan@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=ldewangan@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Thu, 08 Mar 2018 07:21:21 -0800
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
To: Guenter Roeck <linux@roeck-us.net>, Rajkumar Rampelli <rrajk@nvidia.com>,
	Mikko Perttunen <cyndis@kapsi.fi>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jdelvare@suse.com>, <corbet@lwn.net>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <pombredanne@nexb.com>,
	<mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>, <arnd@arndb.de>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
 <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
 <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
 <2628eff2-dd33-34f4-a7e1-cfe46ef88a3f@nvidia.com>
 <4556a8d2-947d-72c4-2962-3167afb53978@kapsi.fi>
 <62ba7f67-5a99-51ab-1214-eb68ebb7e642@roeck-us.net>
 <952cb50e-d9a0-ae5e-d9f6-d1ce268f0384@nvidia.com>
 <f7818e4c-17b6-c58b-3424-85749bb9c1cc@roeck-us.net>
 <5bffef40-a4a7-5f7d-a448-b2a381c57822@nvidia.com>
 <d4e745a6-5534-662e-f6d5-a91bf580f550@roeck-us.net>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
From: Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <4d00a31b-44cc-d3dc-78a2-1b7f23d777e0@nvidia.com>
Date: Thu, 8 Mar 2018 20:51:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d4e745a6-5534-662e-f6d5-a91bf580f550@roeck-us.net>
X-Originating-IP: [10.19.64.176]
X-ClientProxiedBy: DRBGMAIL102.nvidia.com (10.18.16.21) To
 bgmail102.nvidia.com (10.25.59.11)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1594383381997438610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thursday 08 March 2018 08:01 PM, Guenter Roeck wrote:
> On 03/07/2018 10:06 PM, Laxman Dewangan wrote:
>>
>>
>> The RPM is measured speed via PWM signal capture  which is output 
>> from fan.
>> So should we have the fan[1..n]_output_rpm?
>>
>
> No. I hear you clearly that you for some reason dislike fan[1..n]_input.
> While ABIs are not always to our liking, that doesn't mean that we get
> to change them at our whim. If that is not acceptable for you, I can't
> help you. And you can't change inX_input to inX_voltage either, sorry.

My opinion is only to not use "input" as this is not really the input to 
fan.
