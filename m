Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeBLTDj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:03:39 -0500
Received: from mail-bl2nam02on0076.outbound.protection.outlook.com ([104.47.38.76]:28298
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751527AbeBLTDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:03:37 -0500
Subject: Re: [PATCH] rtc: isl12026: Add driver.
To: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20180212185915.25041-1-david.daney@cavium.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <d2337554-c3df-f915-72c7-5decd571f12f@caviumnetworks.com>
Date: Mon, 12 Feb 2018 11:03:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180212185915.25041-1-david.daney@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0002.namprd07.prod.outlook.com
 (2603:10b6:803:28::12) To CY4PR07MB3174.namprd07.prod.outlook.com
 (2603:10b6:903:cf::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a3d2685-6dff-4e3a-55bb-08d5724b5085
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR07MB3174;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3174;3:raXxP+lmx79auMaoZzMf3Inp6FKvXQfnfwPMxAdsIYfcrXrrEtcFC4/5nMmFhsBJcvVGBl0X8Q8of6Hnv4DwmYwEOprSteHUhSSRPUpK7RoRQWPyviuKd3RbbAOovJEopp6NtI3PMjMpl+SA2yV7KIUNtqCw5olHgk1Wv+S6AcTutPFNvf/PR06ao0J9rVlIdA2WuiHdtp/VolQRH+pdeECqyr56PAE1Y8XY5RAccxGuQmOpRRZaj/eS1ZLYN5AH;25:hY8nVwe3f61AaksvCJjvzyO1r6gWfuoV1FBhr30k7oNbSxdkwltiSkR8f2CNUVtfD0kM6Gy5/AlrxmPdke+aEM+IfM7IKd5SqOATlCW9cZKSI0Y0RIIkpZ9J0/3gefm6/goIq4L1V0sq0kbiX88h06h4j06ADlQvkvlP4tRssmICPatkLcVaqI0OtfeigbXt7h/NGr6V9WM/mrS8PbMMi6okIDn9XW+EJc0VzqHq5Q0FDbmg0LDMdSjToww5eNWoZobULEYaFJmnQFJHHEZZzJr9EsgN8rvS4v8RA2oQgj3xA3FvX/gyVLHGFVFs7hObQnU4PbHCTyOcyjGpO2aGYg==;31:cKFWQrSEl95ykVABph++nx0HMSgkhtM9QVucpDyZbwo2Vj50aO4Xhq0/U0h0OzDiuuPOoBVRZRQFdoy0Cz28c+kMq9aW3o6e9lL7tpkocjdipS8ozUyk7/vldDWx/d3DYs8rzu2naluYf+CPtGSc/Ev2KBNl3Tghi4DFk0pBQza+6pDhCcNQBczU8GWJgfWa+CR+oUZMaNU+pL8HxEl/ZCXW3GIaPkciJ2GN9mm/ARU=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3174:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3174;20:UbikfcKMzjgs4Cm7n0wXjQsl8gE+zvmw3W3Sz3Xsy56mQV25k2m9zJDW7txPVW8D5XY26WnhHDx4L7sOHTRPGIOppPBerxmL82tYfZZETdYMb+be2rLSDJSa9Wr4uLJVlmEwuGdEbihRdDXmDY02qZAl5rfE0l27iekGyM5sDE5rHRltB4EJHgEPjerzc8emL7NW3syAPgABbCMxCOJWMQrA9pp2PuyKxVE4f8yv2MVqJJscvZdNi4Wk2rSxA8a37LwNxRo96SU48tZf/i6MGcZKaB2eJSmbcCTU6Pq3NoXelev2vv+UnkA6u1vzGRz5jMI9W5hNbLwfiQAgyZBJBYdFQCLOO0G4/WC6deXPcIw8zZFi/uVouvtwALjHrmBi8hHdVBuuFMu28FQFTr6YHCgGQXe4XkE/ENpdIwKJSSE/t9NpaaR/2TrPlhBkYU7GDRswvVn3tNMZeNms/EOX3xeIrKVapYgikhHMaPDEBqBUQJ3gSjMHH4g0VW6qYZU7i9780b9I+R3MMNJ0VEr7H0GJoS+5grhXDJ6m3wcNbJyM+8X8zjl3vbSH/+OPm5TtmIHpV4CwYVb+pAeArWHCj8bXI+BAaDx3rCHUv2pronA=;4:/Yh9JDx23rvIBHIrxfzcByxyva9Z5voqfSWoogjxu2cKyO/FB273hwyEc8I/fnVsayg+KgbJ6xVZB2CgXqfuohiahe+Q3To/piV5BEhp0OmRAd1PP7UwsTdabAQd8ws2G0MdHMVz19a9E9osIrwiL9zyxSU5Mm28t7Lyxz+QY6CscHsWctPIC4umIJOTBwmizghddRQIkb57c+LhFbXx/Jm/Xi3vnobC9Qk3nMk81k3b5k0InowpF1S0NEZZLNk+OoaC8aEl7PPV64o2IAehBw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB317497E8E3B5550FAA04890797F70@CY4PR07MB3174.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(93006095)(3002001)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR07MB3174;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3174;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(376002)(346002)(39380400002)(189003)(199004)(53546011)(2906002)(23676004)(52116002)(110136005)(52146003)(6346003)(2486003)(31686004)(53416004)(3846002)(5660300001)(4326008)(65826007)(58126008)(6116002)(230700001)(186003)(7736002)(76176011)(69596002)(64126003)(106356001)(26005)(50466002)(305945005)(72206003)(16526019)(68736007)(316002)(478600001)(386003)(6506007)(229853002)(66066001)(6486002)(2950100002)(36756003)(81156014)(8676002)(31696002)(47776003)(81166006)(25786009)(105586002)(97736004)(53936002)(67846002)(6246003)(8936002)(65806001)(83506002)(42882006)(6512007)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3174;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMTc0OzIzOmJ4OEpyanI4VTJHano3UDFkbzF6ZUkydU1v?=
 =?utf-8?B?bUlEZm1OSC94dGwvM0Q4b0UyYWxDa1pKTEx1cGNWVW56eUwrRTVmeXF1OFFu?=
 =?utf-8?B?bGt1bmxURDhKcDNVZFlhMmgyTmJpOHZuRklzNjNOZWhoQTFvL3loWmk3UlBP?=
 =?utf-8?B?d2FyUHd5amR2ZHNMaTJMREVEOU9kcXd3ZWNUeVNLREZzaXJUQ2FhYmdiRVdr?=
 =?utf-8?B?eUNWb1Mra3ZPc1pDbDdXeWQ2WDFHTkErRW0wWkdsOC9YUXI3RzhtZmRJUlVP?=
 =?utf-8?B?Q2lEYVoxd25NdmZ2czFUR3pQQVVwYzc0aEd0bUJHYW42NjRlSlFhbU1DUkpX?=
 =?utf-8?B?TmVhV2pQV3ZpMmNVUWZqMnp4MURDSVNIeVZzbHlmZVVSM2R4MEd5T3oxUGxh?=
 =?utf-8?B?endSKzZhRVFHN3RwdndiUG1ld1ZRK0pQeFdYKzRycE5SUE45VDQydnE0V3M4?=
 =?utf-8?B?cm8zQWVYRE9JVlpya2dpSDAvUG1XWkIxeURnZTZ3ZTQ1RlRaQ1p1WG9BWW11?=
 =?utf-8?B?U0VvTHFGQnVJRDU3cWhrcTVvL3QvYnduanlYWlA3RWFxcmg2UUhTa1Z6TE9G?=
 =?utf-8?B?eGlTMWtEQ0JrdzNiNEh3TE1nL2pFamkrOURydnluUVM0Qkc5TFhxdmcxdzBl?=
 =?utf-8?B?Rm5mSGVKT2pVY0Evb3Q3N0tlTkZWeGdjTmxoQ2VOTnRMYUM4T1ZTeEs4NW9Q?=
 =?utf-8?B?YlFWSk1OL3Z2QUVDeGkxR1AxZGRYQmVwMlpMb25raGhYbG0xZTdmcSs1Mkxu?=
 =?utf-8?B?eWVRMjc1RC80aDY0cnFQZ0JMak5DK2NOUjIzKzE2S0xzeGdaSHcwSDdSUUtQ?=
 =?utf-8?B?SmFjc1ptaWZQUVlGdHVlekJjWDd0ZHRhZHpTN3JzVm9BL2pkSkVCNFI4Q1My?=
 =?utf-8?B?RnhFMWg3am5ibU1LU28wMmF3bFh3aWVVTVdUUTlwUG5yTmNxMFVvcDhIRS8y?=
 =?utf-8?B?Y0w4S292dWozTU83bEhEYXlCZGpWeW9aeEY2SklSYlVvcjY5TGFFb0JqeWlD?=
 =?utf-8?B?cnRYdjlvS1BJRWNvSytnb0Vib1ZlaDFvaUhFenBITVZhUUhBci8xTHJ0L2lh?=
 =?utf-8?B?UVNNcTMzUVNTb0VBaDgzaFcyVG5JK1JnUGtSWmY5WTl2bCttaWZjWm9GdW9Q?=
 =?utf-8?B?YUJxNE1tZnB2OGxKemhXalNjVEdXUFdNUEFDWHdQdFJoT1VSSUZqREFzNjha?=
 =?utf-8?B?Qkd6VVBEak83SWw3WTljOU1GbGJ6UFJ5RjdCSjFXOXVzQzhQbTlqVGNEZ21i?=
 =?utf-8?B?U2V6YlFBZ3ExUE81dHd6N2hCVkNrZ1hXWi9aYzJCU2JVRm5MVXIrZy9HRzRl?=
 =?utf-8?B?akZ5QWphN29LTmxIV0JVK3lEYS9kQ2E3anBXaXhSaGg1UThNeitpN1BBUndy?=
 =?utf-8?B?VExSZFBGelhKcm1KQ2tsdUFsbEhGWGwvWkIzb2loSTBlMEp2cHdPMVc0TVVw?=
 =?utf-8?B?eXBPcnJMVDJMaEJwc3ZRV21NUXJUQlJIbkpuQTVsb3hlS01HQkYyV0Y4dkUr?=
 =?utf-8?B?TGJJV0FjcmpvQWtsWkxTa0lHTnNGSis4UFdpQWlUOW50aE9UUWkxSEVrdHMz?=
 =?utf-8?B?UkdXbUhWWnEvaE1KWjU0UUtlL0VtSG0xbjJ0cjlHeUM2bEJFOGpTSUQrd1pY?=
 =?utf-8?B?WUlINlk5RUQ2TFZGa0h3N1FrTEt1ZjVVQ0xDaXlaZ2JFWENTVldmVEc4ZVFD?=
 =?utf-8?B?RHNUT1dTMVZkT2dGQjU2UHU4S3JjOTk0T21pNTNNRjQ3dkd1bTQ0Q0VlaWR6?=
 =?utf-8?B?djNDOHpkSXdOdE9sZE5sUTVEcGxzTlRFZVVIOU1uU1JGK3dTeDVWb2djUnla?=
 =?utf-8?B?Z3N2ME85U0g3V00vNDVmanFGbVptVDl2U2o4djhpTTFRQjh4OFVvUnA0YmNQ?=
 =?utf-8?B?cHNiR3VNK0pwR1FJZVRMOUVUV1FHNDk0TzNLTUphd2J0ZWZwUXJ3N3NDY09R?=
 =?utf-8?B?b0xzUjczSFNnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3174;6:w2GTsA0qUa7af65TUbW+/u1GRLz2uLNMgvDd36V3lvfpZFzMb/lxUhxvRwR5T/E76/3UO+9gw+/8opUPkwdW56HSu7Buk85TyNa1yckBzreKsu6nDc++xfFZWuhPPFrddtN76DUMwrxWMMxPT5JthlcvT9ImTZuzSvbppCVWB7UT+JqDiLVoS8POgclpF05GvEWm1OXEsrgXweV57s4bc61BwEypMcmoOxgxYEUsNxcv+xT2RIKBPW9/0ND5PSICQOqd9AcFrW4d2LKqKC5AiZuw7kE52wKXpnE1U1ufylWhqxgJsgTsx4Mb6+Sbrm/hQMeoUsKZAZtv8Dv196HxsOBGawTQywGaNhiaQa3znHM=;5:P6AdhWLkMLw1LHPkjTI8EH3MuUS8GD+Icrq+1p3OL7l1aVVI7K9BjdStJAGJ3Tw+n+6LSOmgVJNgIifXICGS3Md8a3tQmJ9eZhr5urNjp9+0Gez+/xMkon6C54OMka7jBYwxdjGfZqJGwKln7kmoE7Cc6PMSXr/BvrCfEfFNQ8w=;24:fZD1qUYlJMom3IZjuRRbz/I78ZzIrq2Ab77j67cP8Qe5F2G5kN0lVtyyZ8tdfiH4AoY4duFbQjFEtFGUJW0j1iVca1oV0t9aFhauy4IOLTo=;7:1btqwP7ymfyeWlTBbplWLXBsk5hzUMlZmpbRAa+Nwg6Z4eSrP3kgCq4D2ZLyHsK6tS7m80bp77pZ4Jb1ihkS8JrBTlK0bsIigYZuWMzTlXcJDggTdbfWYdV22rLeAZtYigrhZnYuLkHLqPWWh2oQv0msuVGQRkqCpvCdp8Jd4LjRGb3UIeS5x/c5J2OuBBeEtUqykmzwDRI+3k5xilsBB3Spi9CIACwSikbveJG3mldEsgXWF178Z8cBJI+kMrK1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:03:33.4322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3d2685-6dff-4e3a-55bb-08d5724b5085
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 10:59 AM, David Daney wrote:
> The ISL12026 is a combination RTC and EEPROM device with I2C
> interface.  The standard RTC driver interface is provided.  The EEPROM
> is accessed via the NVMEM interface via the "eeprom0" directory in the
> sysfs entry for the device.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   .../devicetree/bindings/rtc/isil,isl12026.txt      |  27 +
>   drivers/rtc/Kconfig                                |   9 +
>   drivers/rtc/Makefile                               |   1 +
>   drivers/rtc/rtc-isl12026.c                         | 550 +++++++++++++++++++++
>   4 files changed, 587 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl12026.txt
>   create mode 100644 drivers/rtc/rtc-isl12026.c
> 
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12026.txt b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> new file mode 100644
> index 000000000000..4b6c7177a95a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl12026.txt
> @@ -0,0 +1,27 @@
> +ISL12026 I2C RTC/EEPROM
> +
> +ISL12026 is an I2C RTC/EEPROM combination device.  The RTC and control
> +registers respond at bus address 0x6f, and the EEPROM array responds
> +at bus address 0x57.  The canonical "reg" value will be for the RTC portion.
> +
> +Required properties supported by the device:
> +
> + - "compatible": must be "isil,isl12026"
> + - "reg": I2C bus address of the device (always 0x6f)
> +
> +Optional properties:
> +
> + - "isil,pwr-bsw": If present PWR.BSW bit must be set to the specified
> +                   value for proper operation.
> +
> + - "isil,pwr-sbib": If present PWR.SBIB bit must be set to the specified
> +                    value for proper operation.
> +
> +
> +Example:
> +
> +	rtc@6f {

Two seconds after sending, I see that the compatible went missing.

I will wait several days for feedback and resubmit with the proper 
compatible

Sorry for the snafu,
David Daney


> +		reg = <0x6f>;
> +		isil,pwr-bsw = <0>;
> +		isil,pwr-sbib = <1>;
> +	}
>
