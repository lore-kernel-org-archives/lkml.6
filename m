Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEDHod (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:44:33 -0400
Received: from mail-ve1eur01on0095.outbound.protection.outlook.com ([104.47.1.95]:30800
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750709AbeEDHob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:44:31 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se;
Subject: Re: [PATCH v5 1/2] irqchip: add support for Layerscape external
 interrupt lines
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-kernel@vger.kernel.org
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-2-rasmus.villemoes@prevas.dk>
 <alpine.DEB.2.21.1803011308440.1396@nanos.tec.linutronix.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <4684c3ce-b56a-334d-f556-6e8524d8126c@prevas.dk>
Date: Fri, 4 May 2018 09:44:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803011308440.1396@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: HE1PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::32) To HE1PR10MB0443.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:40::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR10MB0443;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR10MB0443;3:+s8A70vl/Eubg+GE/+y2rSuea2uOL1vzq9m+scOH9Iz0Hd4HB/W4WJMHZujLfFBFb22oxQFgPJ6sT7yyVHT4e5F99Uqr5F1nSpQoG2DUfy+5d4yvTjTa1aR+ySNViwc+sjo7J4AluxNdNwfNXxs+4ieMTRsgiMV0//2VrXFRnnpmfK37UYXGwmqqq1BkQh4gdtr3oUKZM/I1Nnpg8ZBw88uKpKclhsRC3G9DUj1LS/CUdKAQjlnRzYNomXwu7QwE;25:0NXkpmtfCTOTwuwcIaYm/Ocz7Pl8FGK9m5NpWwk1Gp7Q/gbI6xgKjmJ8Do7J5NpvC6VNWUZ1beVJRrLtiI/XQ9OVaGngvUNhMAsUfdWhfDA5MdttUiqmONSZHH91Ft5JBbL1PTfRRVKPsCExkOPrxLUOpV+kIcy6WnbbP3UI/1oNt2oxOpkQLVErqRG9db3OuSyx7lvMThfSGDYpuN/v1kEOKUGuo5Pkea5EJLEGXi/n9Tfbxft/hTxitZ8dMgTU1lBNRqwGGjdyfu881ZUvNCtVPWark7+vf/kAZLQggd8igCl59V8xwzMn8gTtFnAHOfeku9mGod5RbCtPKBJTdA==;31:jkY7cO5TZA4KYvhRQQQw2cBzS/+Kyi4ufbmcAUDfibKDc/Dli5dovkyXWEhZix03g0GgvhrrIgE2wSsp0WPqDCIemhyBibhBmstqjxB1c4lyVNolnb+62ZpFsL8Av4SlWItG4stTbOjD4LBWG88ocBsfOq8hdNKHFvLBYTy91idPwTFNaXRYDFL7Dwy6XD2884UIorhsitBXsEDfTJflvoqs4X0bUSWrSFiyW1RnYI0=
X-MS-TrafficTypeDiagnostic: HE1PR10MB0443:
X-Microsoft-Antispam-PRVS: <HE1PR10MB0443164A94C2CE50E102644C8A860@HE1PR10MB0443.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR10MB0443;BCL:0;PCL:0;RULEID:;SRVR:HE1PR10MB0443;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR10MB0443;4:UUALpGGpwISaxhgkE1ghVQU8YhBQI5cCjcWUQmoW1gTX+RB7/ZhC3NRqjFYNFmgYRGuslY1t5J8VQ4+epJFZ6jTFyZYmiQGNNZGfMqeq8zRmkNR/J0mzyDtG/z8lKBwoV/390CP/qHM2cdvg71P+VfG1Xa/Hl53ihWFQCz+2vYdeddI+hnugavf6UXrMK9WqU9qKtbcZV/VuYiyzNGK2k6+x7k+z/EB99C7n/JE1gPuAyb+LfJkLxYtYEwfnKjnAb64wlJZ3eO8wj3BWxBadPA==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(39850400004)(396003)(346002)(366004)(377424004)(199004)(189003)(966005)(8656006)(65806001)(8936002)(50466002)(446003)(230700001)(2616005)(956004)(16576012)(81166006)(316002)(8676002)(72206003)(44832011)(93886005)(25786009)(54906003)(81156014)(486006)(42882007)(58126008)(478600001)(4326008)(74482002)(66066001)(6486002)(68736007)(53936002)(65956001)(5660300001)(3846002)(6306002)(8976002)(305945005)(6246003)(47776003)(31696002)(97736004)(11346002)(59450400001)(16526019)(105586002)(77096007)(65826007)(26005)(31686004)(36756003)(7736002)(6116002)(229853002)(76176011)(386003)(52116002)(52146003)(64126003)(53546011)(23676004)(186003)(2486003)(106356001)(2906002)(6916009)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR10MB0443;H:[172.16.11.52];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjEwTUIwNDQzOzIzOnFlNUZJbVByQXVWY3J1MExBbjJDKzExamgr?=
 =?utf-8?B?R0FEVlROc3l5WGlpMndJaFN5M3pQczJwdUNicGhjK1VzUUZjbVpLT291RENr?=
 =?utf-8?B?R3lnSHBoeUZBakl2amI5K21yZzdxNzREVklabkN1eURxeHM4VHkrdlduS1NT?=
 =?utf-8?B?RWlGcTFvdURoNFljMGJFbzdjN3I5YXQ4S2kwNWdIWCt3OER6bUhiMmZWWUc1?=
 =?utf-8?B?VmVqbkFwQ01nNm9xOWdaSmtsclp2OUJmL1lBbjUxSElCZG5VR2paMGJhanEx?=
 =?utf-8?B?bDA4MEN2RklxcnBDS0YrZ0FXRmcyblhsSSsxN1FZVDVVUTFaellUR3FiNnRs?=
 =?utf-8?B?dzQ3Q0NNNDRFdFZLUnlHMHdFdWRTL0NsaTVuTkxFQTJiM3BUTG9wY3RMUmdU?=
 =?utf-8?B?Vm1zRzVXalJTZUl0VDdCSnRaSGFNVDh0dlFHdmtFV0lyT2ZOYWpJTlFoQjYx?=
 =?utf-8?B?c2FNaXlvNFBQWVlQUnhIWTBteElBQjhNVlhJdkZsZmxIeGxHTG9yVDROWVIx?=
 =?utf-8?B?aWdGOW43bE1mMXBOcml2WTNHQUFOUW9rTXNNS201cmlWWGR6T1NXMmdDRnN3?=
 =?utf-8?B?b2YrUmlOeE9Kd3RteGNwUHlCaHppTmtJSERyKzN0S0x6aXBTQWVLNUxzNk40?=
 =?utf-8?B?UU4vbEo4NjBNNlZjUTlzNURtRXZrbkVsVXk5V2htNlVTMmVGSW5BM0lBbnA5?=
 =?utf-8?B?VGtQTzVEeldHcU5ySS9na3pIaE10YW8vTnFweXExU05mcEpod3hvK1dMdXQz?=
 =?utf-8?B?T2xYQkwzaEZSVjVWZkQzMnFBSXR0TURmcHBndnRMcFh1aGwyMktDMDhXcW1E?=
 =?utf-8?B?OEV3cnhDMUc4bnFVeFdwUDlXdWNmNVhZWFdsN2xlRjFIcXN4RjN4a05vaWVi?=
 =?utf-8?B?c3UwOFVGR2pMV2hRNnB1U1lpUnVVMks5QmVBd2RlU3pRR0lEem1WTXdmOTlH?=
 =?utf-8?B?UG0rTE1ST0E2M2xXQU80aysrN25vS3crSWF4a1ZvUHVNVUEzUnMzbFZ6NHho?=
 =?utf-8?B?bklUWWc3OTlHRmV2YjZMclZJUHRadnFxQjNKTVB2emgzb1YySlNGL2p4SDh0?=
 =?utf-8?B?RXZubmhDcXlNcXR1eVJQby90VUVDNXdTTE5YVURwTkN6bFh5VVdXekxycWpC?=
 =?utf-8?B?UytxNjJJU0tsdjBFNzQwa0p4RWFzamgzd0RRTzdvRkNheEZncmNwUlplWmFz?=
 =?utf-8?B?aldPUW5VNDc0TklWSStoSVNiSWN0NzBwS25DQ2Q4QlA0aGlwRmFvYUtQY0FK?=
 =?utf-8?B?SmdWU3FjU2RwZEU4OHg2OUVLV2p1bjYwNkZFblBVSVRpL1ZXcUJXRFhueDcz?=
 =?utf-8?B?RExGUVBxYm1hS0JNdGpWZWFnY1VmVEZrbXVhMCtDVnp3OG9Nb0R4eWltY2I1?=
 =?utf-8?B?cXBEUzlLejZWUWF5Y2NQNDg5NWxjbDd0S3FHd0tDT2pLcmlSYkJVMWd0eXly?=
 =?utf-8?B?eUUvcWh4b2ZNSEUwdG0xNTJwRnlyQlVEdUN2dnRSQUZqOWx5dlJLcXA1Skkw?=
 =?utf-8?B?YWVzQnRMaUtkZVpJY1VTeGQrQkpKS2RBWDdrYVJMK2dnR241Lzczd0NpU1M2?=
 =?utf-8?B?WmhVQ0VJeGlQdTJ6TWhxNHBTVHJSRlc1K29oNVA1S3JPRXVoOE9oSFAyZUpK?=
 =?utf-8?B?dXF1ejN5aWhlb0dIV254c3pOV3FmZFNkMHY2MW9qM3FPbm1Mb1FZaVpkOElr?=
 =?utf-8?B?Mmk2ai9IVS9SREZQeC9DTDlGL0UrR0JsMEMya003RlZySmpBUGZTMS9TQU9J?=
 =?utf-8?B?N2hrWCtKUUdSTS9yMzhQYklmUDljbEpCOTU2QnlqUlkxbGo4M0E5NTdGNENv?=
 =?utf-8?B?UTZPVk5HTmVMRSttUnc0WnhmOURxUUhWeENsck1rVFhlNDVDbGlKYXZwN2dv?=
 =?utf-8?B?RmYxeTIyRnIwRXU0RS9tOS80UElJS0xzSzVLRHNCUnZsWTRWOUdYeURFWWVh?=
 =?utf-8?B?c1YvOWxSR1NOUXdZZ0xMaWVXZ0ViRko5cUhqS3kvZ1pSRHc2eHBTRE9Ld1BO?=
 =?utf-8?B?Smp6Q1hTODh6QTE0aFZISjZVWWl2cGhzNG94WnBseThVaEpqckFxWld6Vnlp?=
 =?utf-8?B?dUNUQzJPdWpmQXRabmhIZjJQRk1BOXhZdDBmTGprdUgveElhWWhtOUdhT3FQ?=
 =?utf-8?B?alVNUCtEbjd4ajNFNTZSR2JRaDVkT0xQMVhaWEJKVENVRVpjdUJjYTdZRjMx?=
 =?utf-8?Q?7S5dcKioXVcGeMwPXZtC30mrkvOwc7IodO67IJnpvA=3D?=
X-Microsoft-Antispam-Message-Info: zfJiTz3Kg9FHGaK2V88coKfuCfYhDt0WrzarJ3P8nyFXdJVjw0ePBVoJA8m984gleDPyKbrX2vfUh79IvkRU6JpQoUsdy30zy7SRYmTRKuJxQry7JZ58zF0zL6pz3FUdVYAMcWUfgnWe2eVTLoUFLKRaZ3OvN8RAmLf7KWxVoyIOLMG1iAvqrk9J/hnXMbKW
X-Microsoft-Exchange-Diagnostics: 1;HE1PR10MB0443;6:A3q231P+qqsyMok1s8JzuVpCBZwLrjprTSKdKitZCYXKJWoc6/Cym8jCfce8p1Uqh5DtksVASrWYfQGkHyk+0Ymz6VTUGzc5TaxTua7fPAoh0+BC6z8+3uZgAeFWaWKORgkBzMbL5odPGaFVO/pcaQRYqVWzTGbpybczxKDuvYQloZeNOiRfnQGL38/sHz2Xe7ojyq28WbE68MRZIkmh2c8AeOEuiyq+nImWiBOwIpURv4isZA0Lx+vT8NMkHZYmrfLDNHNjOzZbre9vc/ebNqJTalJ4OgpQ6WQQbUOPGh/hvSqXbA5/NiienREXp8thTdoYIP2hgjVu3P5jHWqR1HJ0hzJuM0NaJ905O+zBm32E3OykNuOqgkKCAme+ZLtmJj57XGBM5oyI/OTlYgycrYlbLSeSSUwaxWt70iIzWkEwQu6ZcAeoJkyb1tf1idbssXUSQm7pcSwaplm0VKEDvA==;5:slYVB2bZDMOtqQ/VTvXc7NvgIVna3c0E/MKYKiZBdpGIehreNM+6/Ty+XqgMcu35ma8BWDl3/RmmsD9Fm26RSxHsddbviEgYzNyHltZQJml22kELDRaNix1Pn3/DRjg6TOFzHuXnZRz4i0iz8N5/2dQ6loURX5728hxZGMQXcS8=;24:u3zJb0JCRVlKfygpOz4byCdEVLfWGnPFIR0afU+8doe+4QAB/45Z9OFbrqB5QuFbDAYYqH0ddQnaGHGVMnDiO4bTUlLVCg03HSrckFtIaR0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR10MB0443;7:/cOrHz8MgrJA4ddUBZcRn3eS6ga0AWqLmZ37saU1edbrjOtQH+mqq3QfkNio/uDaKU5q9F7Ebhi7HM6jVDUngI98ZjvOniN8hrxeEeCcdUJZHFCeJ4HvfSTuBk3kLnqEBMIe7skIL+8GtTU5VHA0oo5Q6ykqBdXhFX770xYYzNxJozH9axpHoo2jmwXoN5FgnzboYEw1Z5kwLEXaj1p0c5MdoLhzTiWm3O1Abb60YhQToJu3XI3i9vUN+B43BlrQ
X-MS-Office365-Filtering-Correlation-Id: 43a261c1-dbf8-4e61-1719-08d5b192dd59
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 07:44:27.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a261c1-dbf8-4e61-1719-08d5b192dd59
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB0443
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-01 13:16, Thomas Gleixner wrote:
> On Fri, 23 Feb 2018, Rasmus Villemoes wrote:
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/of.h>
> 
> of.h is already included from of_irq.h and of_address.h

Yes. But if we're ever going to have a chance of reducing the median
header bloat factor from the current ~200x [1], one must stop relying on
headers pulling in other headers, so I much prefer including the headers
that declare the interfaces I use. And now that I look closer, I don't
actually use anything from of_irq.h, so that's gone. But I'll keep both
of.h and of_address.h.

>> +#include <linux/of_irq.h>
>> +#include <linux/of_address.h>

>> +static int
>> +ls_extirq_set_type(struct irq_data *data, unsigned int type)
>> +{
>> +	irq_hw_number_t hwirq = data->hwirq;
>> +	struct extirq_chip_data *chip_data = data->chip_data;
>> +	u32 value, mask;
> 
> Please order local variables in reverse fir tree fashion whenever
> possible. That's way simpler to read:
> 
> 	struct extirq_chip_data *chip_data = data->chip_data;
> 	irq_hw_number_t hwirq = data->hwirq;
> 	u32 value, mask;

Fixed, thanks.

Rasmus

[1] https://wildmoose.dk/header-bloat/
