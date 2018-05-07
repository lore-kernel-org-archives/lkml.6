Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeEGEuf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 00:50:35 -0400
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:54272
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750737AbeEGEuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 00:50:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH v3] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525334313-28661-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1EA102@SW-EX-MBX01.diasemi.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <e17e2c9e-923d-fea6-26be-5f14c99a45cb@amd.com>
Date: Mon, 7 May 2018 10:20:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1EA102@SW-EX-MBX01.diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: PN1PR01CA0109.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::25)
 To BL0PR12MB2356.namprd12.prod.outlook.com (2603:10b6:207:4d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2356;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2356;3:HAxqYjbZWPbt9rkzazpnyTyf5BeaqjUjrQo5+poBBI6pPpOpsXyV9BgajH+9okNdll9QSX5hV+yM73LgWuSz+v1/9l4OlhDCJ1aK2kLxFMr4tkr/WXWXKwExBgkqwAhyNfTq2NlquU+KWAJUo80S3TZlPtRJ/HWidHxPDCmwcWKHkCA4VXotcr9TUhuH3p9PeE8R/vKx6tkxF0qca8wxFjiZjrAhq1Dg7srYznXzXVugSSljaXsLR753jsBWhaL+;25:1tNt6yMpLXBanXDIioiEDqLe85IEYI8O7I4DrZ7XmKOF70/fdxAHyOcrpgWsf1iGJ/Dz4HN/3+w3YR9U4q6XV23z0Kq9TH8piYTepduN3Y3na6fxpCV0odyzAYPyZP9DuijGtufqjwntXvMTsbwULYK3KGDQGALZzaF9/0vRz5i1tZC0bsqqNAKhWP0ufc4rbw/gOknUPM4YwVYKZAy10fqbD2+hQkoHd7IWDOMLAMacS8/p61gso1yTJBpB6a/OpUkdqUEpPRCLU1aMZV2r6UFkLKWWyRgjbbEFBU2r8ZKaCxaXi65BCr+RPS7wfZasHALvcTCMeYdTn9D6rMCVPw==;31:KwYcmMewgSrD/uARquUnDkeU0gsPvQz9YJ6rQMm3cgQqE8lx9KNoA3zFIAJTI+HVJhC2Xm83Db1hBEn/kpBbO00n72Mw6p8jEAIpanqtxXOTOMUhEaWsYaVe+X8WopOnjuz9v5Rrb7+Eae6y0rqKTU/UOWCMn3IH+A5BHnLwVJCYSFr+90tcigsVj8dh6u3cE7w2aquOkXe1U5nW26PW42jUh91ji0TJJYTwEFYQBFQ=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2356:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2356;20:RwtBnHAMmoOx6KuLnnKsSbXgM+69pDuf+SX1USndhdjp86UzXgSkJRjNZ42aMw9DthMoWYzaUJFuxQ0FmsvuTUZ4OHFrFLspRBe9YrBmBvppZpQHQ0gH6UmR+UYmiZIXrp3EPtzhlN4NJdg9XyuxAKZi8h4gXrfdWEUcIko9LFZpWlVXroWQ92a3ZV93Q/vtV0joK+S11ciqtYymqLN/gl4EnjqiDXRmCJTYkEOBBLJkS5nNwQXdyd2aqczCR2dqakNQHJLmYVq4vBoABIm5D+hPAkl0kQCB9WCdYbSO26bK4KzeqjSJjuNicFqVfE86uuKyPczaSrR1jjWL9/v4U6VzLPuiiOp0/itgjrxjmdMNr9Arg5eTankiUzWGWjRJ2zEqhU4JwqGONERX9bEmdLHdnX7MY2dJS9b4ylJ9KUy9+R1G/pWYicDCFBlxtCEXy+p+iMG8gxr7wXsjcVzPajdobb7luHoz6g0uF+4E2UqS1x6pV+JXShZ3L5hvGnSX;4:SOyQiANSkVxEIMoKyropWEJc61D9+G/YyDPKn6YsxQKW4CkhJ0sK16XpSVHNWntn0qHDt9uJXIQ3zWA9bLVIFjrVQT3JIxGq7DGkplXdnLJcTdniJyqD92h9CwHftRxOed0oE5SR/iBOYm8pLIOd3f/P9GiieMAK5223LFsE3Zlpr2ylgorRpn33SG1ij5Gk270qb5fjt2QYayKMBMAPzO3thGjqpWIN34MX9eaLRtiM7kGRjnFB0AcINuZEzqF/7pkKpwUFre9f8D7yyYyFavVlgLnOPXQ4Pe+hdU3vW6Wlq1FBvjN38zrQbUE3CGrI
X-Microsoft-Antispam-PRVS: <BL0PR12MB2356C6BF6648CEF78E282131F89B0@BL0PR12MB2356.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR12MB2356;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2356;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(106356001)(31686004)(6486002)(230700001)(229853002)(6916009)(25786009)(4326008)(68736007)(97736004)(3260700006)(6666003)(2906002)(105586002)(36756003)(64126003)(16576012)(8676002)(81166006)(386003)(53546011)(76176011)(59450400001)(58126008)(316002)(54906003)(72206003)(66066001)(65806001)(65956001)(6306002)(7736002)(86362001)(476003)(47776003)(52116002)(52146003)(2486003)(23676004)(966005)(77096007)(26005)(16526019)(186003)(6116002)(3846002)(486006)(305945005)(39060400002)(2616005)(53936002)(65826007)(6246003)(5660300001)(81156014)(31696002)(8936002)(956004)(446003)(11346002)(478600001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2356;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjEyTUIyMzU2OzIzOkpQV2JBNmtJL3J6TmJQNEdKY1BSSlpSaUdC?=
 =?utf-8?B?N0FlaGxoWDRVL1daM3ZZYVZJQmV2T0l6WnZjZ1RJczQ3RUNpWTZqRERrS2JC?=
 =?utf-8?B?V2JvK3hJcml4Z1NpbGQrenZENlhzOGFwNElSekxMSUViRFR0L2xud01qNEly?=
 =?utf-8?B?aFNpMm1rMTVmblN2YWZNZVROY1R6TG9GY1RhLzNWakZrQk8yY25Cdmlwc2Uz?=
 =?utf-8?B?ZUJxa2YrM1VqcnoxOGxzdkxlZG5LMDluMlNoK0VKWVJqS3QvN1lXcE1ocDZ2?=
 =?utf-8?B?NVZBbU85aWoxNk1Hb1dBWmVCS05GWXJudjdobjdENnFYR1N2dWduWTFZdWdi?=
 =?utf-8?B?ZFZFRVhPV2I1bUQ4ZlBWbHdDWW5Ya01ubGR6ZkMyWi9XTm9yYXF5OFFWdFlX?=
 =?utf-8?B?UmdxNUlqU3NQQS9TSGpRZEMrQWhyaGYvTVRseUNYVlVQRzQ3eXBkbk10YmU2?=
 =?utf-8?B?Q203VmEwZ1NITGhNUlZWZ2JLNmp4MWFIUmhzeHZZSE5kWmE1aTF3RTJyV3Fh?=
 =?utf-8?B?STVIMW1TMnBTZ3F3MHFiWC9XNWtxUGROYUFIT2pEbE1saStLc2hSNVQyNEdP?=
 =?utf-8?B?bTdjTlhqQVFHU01tbmZ0NWV0UnBxUVN4ankzM1I0RlpBY1c4TnBBaE15aitB?=
 =?utf-8?B?U25wOXpseUJOM08ydGpwZHNLdm5Wd21kSitFQVhwUnhKakFnZkdUWDB2ZStT?=
 =?utf-8?B?NDF6ZkYweEpzM3lSeXVuK3Iya2VTTW9HSDhKbmowNjNXcEs0dkJ0RjF1ZTQz?=
 =?utf-8?B?M2x2THRpbVFBVEwzWElVc2d5Z1BGSmREZUdHR0JsN054V3NsSXp5VWNaemtz?=
 =?utf-8?B?cWJ6akc0UVUzNytpeHUyQ2RLcEcxODh3UFplZElPcnozcnpzUllXdHNnc2JT?=
 =?utf-8?B?aTM0NGNxWWpYMXJDZUpqK1lWTGJXOStrY1J2ek5ycHZIMzFCVDhhUkdaOTla?=
 =?utf-8?B?Q2tMR0JYanZET3R0Qmd4Z0hpRnZBdzZEcEN3MUxyMU5oblRybmhCZWFOQzVu?=
 =?utf-8?B?Z0taSTMwdENoNTl0V3d2Rll1YXB3R0x5QW9uSG0vTmMyTUF2WnlFdGk5ck1r?=
 =?utf-8?B?Q2tRK2dsVWRFS0xtQnNRMFkxUTNPZ1M0V0N3SjBPU1pZV2Vuc3d4Skp1ME1O?=
 =?utf-8?B?QTRLczZFVUpydkVET2s4RHRvZEQ5QVlZRUMwcGt2ckpKeUJGbk4wUnB5ckYw?=
 =?utf-8?B?RlpSbk1jZ0wyeE41aGowdDQwWldJdXhlbTlqSVVoQW1WeExRdUpyRXlvNVFD?=
 =?utf-8?B?OVp4c2l4R0d5dXdjRS9Pc2tkTXJHMzgrOThIYUNDd0sra001b056MXpNNGhG?=
 =?utf-8?B?M1pWL1NqcFFVR3RyelF6eU1qek4zdTFOa0tEZHdTUDM1UDBRVGtsbWIrdk90?=
 =?utf-8?B?T3dMSEpPSlkzMDZ5SkJycHhWNmtuVW04b05XYmk4RE1zWk9NOU1mbTJCcWUy?=
 =?utf-8?B?QTM2eFBmTStCamJmdCtPMlBQSmNTRk16bUsyMHc0UFNqQ2oyWWtSNHhzQUFX?=
 =?utf-8?B?OTN0c1MvbU1KdFEzVm9RcUhwMFlqWFdvbElJaERmaUlKbkQrUFBZSmNBTDFH?=
 =?utf-8?B?NDl2M0IzSWdRK3hkUzljNHBKL2RqQVZqV1o1UDk4VWo3UzRXZGNHREprQzM2?=
 =?utf-8?B?MHExaGNzclNxSnQxZkE0ZHE2QjRSUXFieFpGM3U0K0VpQ3ZhNlJmbnEvdDB0?=
 =?utf-8?B?RVo5eFZQczJ2bWNhMGxteUY4ZWttWE1Eby9Ja0VZcHpQcjdmMFgvKzZxYzA4?=
 =?utf-8?B?d1BYZ2ZXNW9Yb0Q0OWZPb0lndGdCOHk0MnNJK05vaVR2Y3QyZ0wzNi9XWUFF?=
 =?utf-8?B?b05KK2dNM3NVSHVuUGtHUGdOeFR6KzdBc3dYbkFqb213REgxcWFoNnBXUDNS?=
 =?utf-8?B?S2dBZHlHVitCL05IVkxETVY3OG5LaE9PWWd6TVZnWG1aeS9TT3N5UTNTS0lD?=
 =?utf-8?B?enh1MlkwSURaTEdGdUxPNFJSWmJDRWRuSTVVeGxZeDJSVitWSTN1S3FmS0E4?=
 =?utf-8?B?NlIveDdBWlZZUml0SzVvVVJ5RzhIQzRlT0V1VEVCK3hmM3pYTTVDYkw4Snpr?=
 =?utf-8?B?YXE5Sjl5U1NleFdTYlRsY1V5ZU41T0d0SlZqQmV2UThhdGRhOWs0dVcwaDN3?=
 =?utf-8?Q?z9UorjpYvsgeu65DYCVlwoI=3D?=
X-Microsoft-Antispam-Message-Info: AVY8AWQ3NQR1PYkWMUyi/KAoAEFeDPl9pauI/QAMqsJeZIV9cadxiceuXY7u1A8H6v4qswKqsX6dlL248m1DFtk9C1UXarrahDmJaT9if/1tx8oSClMffF648KFJef74xwTMl9lQYlp2jS3g1jNKtJFg2zek6KKVIMFNcz54SOeQ5NFZaFrCM8kErTwJQS+o
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2356;6:FU6BapBqD3HyRR1RKXotr3xhBvq9qUi6OyxBAeAXMhPWCuMzXIffQBx2Clx2T9I5i/BXQq3xeMYgwkVv/VpbA4ptrzZIrXW4af/+OmqICcOLBfP+NmxsCGKeCV8vmihs07BpEVXgeNv33Tw+il0UXwTuQrl9gZstovYN5jF0qoX7BPy8zH72dCpB/LQ2OWbZpUiKfNnT7a/q2TFH8BfXCxcj/Z6XYjl6YIZD/u2DjdC6UAVj9RRAdaTTN2J2WkJunN9qDcBISRsTcIZiHElU8NPbWCMUxJrmq/GCZVhoOqXnYbN1yj+Sboug7wJlOyaKgoZqppjO/f9UArd4Y0jmNgt1Wd4DliwzltySr++SYf/8eeHjcaP2IJrR/8oFOogIsRWognGA0BiXB1ZIxKgl2pdzfipTUh3U33dZEbZauoZMVW2sH9vW1zzvwxgNWI8VxlGyRNsRGxgOv+3cqZT04g==;5:A82whMKg1DI75c156F9HOuh/bkQDYfXwjQUdacfnPO6wkOT3ek2Tx3PRC9w2jlFHPU1jVoQVzagS7SnJcO+14Y0NNHuHOZLV4xKtCYTvOB2RBqrDqWae1q2tVXgcQYOJiHBPJWydEnhL6WAPx9cZgKgRgQ6boBX1xHTFQNq5/Lc=;24:pI6qeQkv9zCoj54Ll58/en4Tn3qXhVAr0gVfUEHushbo8CK1nwW8c1mmSs639FKaYhw2xIoa2ReSQFGsb5c/2VDhtUbDSrH1c0eUh+nvybU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2356;7:pBdzY/tk/Bb8jy2ofkA6p9bZOlxFiRSMoSbDtCp4KL3Q/Gihs5OPyYyzlS59OU/IU0OtQkqSiKu/98k0/hpPcZfibcH3tBcESXpL4hk13x3r/JG+nVdxr0rBV+5FCMKSivqlerPYpHtuCET6eOrVwztDS/hK5E5df2nm9RVpdmL/Te9ItZGGVdsQ5MzIhUWDEm/St/djnNd8KbFcZ0MzckIX6Mb8y5e8peSNV/6eTbP8o8YzpZwrGsDpN/YM5NRc;20:3ZjIzI2cHsEcQf0LpmJV6U+Om//znyTyvXvZUCQwePynZUXPAfqXJYNBq1Z3fmm6eeuYqYo8HELLr+rQwkJJz19XtPpFA79b+USfP/ig4PDGbNKLuqa23Ahai5Vj/4RunmY1OIv4FFtuF/jP1v/Iu1w7B7ui+8sSjPxF02lndg8HPAF3MO94NRKZOQOA+ryDt9UfugeDp38v3gZaKWF1u+x577QuabXvpVEtDKdB5DMFlpZCokjGsSMxiz4tanP1
X-MS-Office365-Filtering-Correlation-Id: a8a38e9d-0895-46c4-31bf-08d5b3d60f0e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 04:50:27.2098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a38e9d-0895-46c4-31bf-08d5b3d60f0e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2356
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2018 2:45 PM, Adam Thomson wrote:
> On 03 May 2018 08:59, Akshu Agrawal wrote:
> 
>> Non-dts based systems can use ACPI DSDT to pass on the mclk
>> to da7219.
>> This enables da7219 mclk to be linked to system clock.
>> Enable/Disable of the mclk is already handled in the codec so
>> platform drivers don't have to explicitly do handling of mclk.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>> v2: Fixed kbuild error
>> v3: Add corresponding clk_put for clk_get
>>  include/sound/da7219.h    |  2 ++
>>  sound/soc/codecs/da7219.c | 10 +++++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
>> index 1bfcb16..df7ddf4 100644
>> --- a/include/sound/da7219.h
>> +++ b/include/sound/da7219.h
>> @@ -38,6 +38,8 @@ struct da7219_pdata {
>>
>>  	const char *dai_clks_name;
>>
>> +	const char *mclk_name;
>> +
>>  	/* Mic */
>>  	enum da7219_micbias_voltage micbias_lvl;
>>  	enum da7219_mic_amp_in_sel mic_amp_in_sel;
>> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
>> index 980a6a8..ecd46fc 100644
>> --- a/sound/soc/codecs/da7219.c
>> +++ b/sound/soc/codecs/da7219.c
>> @@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct
>> snd_soc_component *compone
>>  		dev_warn(dev, "Using default clk name: %s\n",
>>  			 pdata->dai_clks_name);
>>
>> +	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
>> +
> 
> Personally am still not keen on this. To me the use of a device_property_*
> function suggests the same property resides in both DT and ACPI, but here we're
> only using this for the ACPI case. DT has no want or need for this. I still feel
> we should look at something more generic in the clock framework, although I do
> agree with Mark that this should be properly specced.
> 

I am not an expert in field of ACPI, IMO forming a Spec and changing
ACPI to have DT like clock framework is good to have but a bigger change
which should be taken up later.

The current code of handling of mclk in the driver is usable only by DT.
The device_property (though ACPI specific) makes this code, a common
code for DT and ACPI based devices.

https://www.kernel.org/doc/Documentation/acpi/DSD-properties-rules.txt
"....Still, for the sake of code re-use, it may make sense to provide as
much of the configuration data as possible in the form of device
properties and complement that with an ACPI-specific mechanism suitable
for the use case at hand......"

Thanks,
Akshu
