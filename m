Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeBAQYc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:24:32 -0500
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:27948
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752088AbeBAQY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:24:26 -0500
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] Input: adp5520-keys: Delete an error message for a failed
 memory allocation in adp5520_keys_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <9d0729d2-59ab-f116-aa12-0457ebde0041@users.sourceforge.net>
From: Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <4e9d8aa4-3e01-4fb3-d0b5-42b02522a15e@analog.com>
Date: Thu, 1 Feb 2018 17:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9d0729d2-59ab-f116-aa12-0457ebde0041@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(36916002)(72206003)(31696002)(23676004)(2486003)(83506002)(6246003)(8676002)(478600001)(76176011)(59450400001)(53546011)(110136005)(54906003)(316002)(106002)(58126008)(4326008)(8936002)(3450700001)(15650500001)(106466001)(36756003)(356003)(305945005)(5660300001)(229853002)(336011)(39060400002)(246002)(64126003)(2906002)(77096007)(575784001)(230700001)(7636002)(65826007)(2950100002)(43066004)(65956001)(67846002)(26005)(15760500003)(50466002)(31686004)(47776003)(86362001)(186003)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2713;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD029;1:MuuvWNnrbCtsP6LPZmigbq1TTj04ZXTdmyAnYGCT4TKBW3SFQQXkQMV8UIbbjApSkDf8+iXWZZGfG5snOEjpaAfPZtdXve4s64KNNG6h9kVMZ4swZAIDbj19ZWuH5/Wy
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5723806-fc64-4f30-50d3-08d5699041ac
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM5PR03MB2713;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2713;3:OzhhInSBXylWAO5NAeM7n/DvfVlfIFiE5G295AHtS1opGn6BbPHKwr60M4dEWRfZoNW48QLNCgY6R4SG9POFLl8hDO3MaogHaomFKShmK46exHY8v4bS8QdZnUmv9wqrB5N+QbmXEFkHe7XNFSY16r5tTHQzgeK7rsck8ituf9Kyl2ANz1kyP7gxlRm8xlIlhsRGb+bf3yD6IT3K7zjCz03vr/FN2gsU6rGyH0WaPdM/kW6mTgx0DwMnSVEJvvQk8wT3NL+E3sLmEFu8MbFmGUxxVxVx6eFCq/QdQnvsVPMkZwfNvEvWTpE3pb1XEuy4eiILZ9FPMyEhtscGlKcfAiC64MNQ0Z6TdctucEtxtS8=;25:rcPOG7KhW8YQRji3MZUd8j2q4FR5ptnLOGidb5uJtMsZUKoec+KBHN27d9z3Z6N7KGFEESeZVse4iCeRp1vD/VPyj3LA7AZC4zj7z+aXQBPaMWoStrD9ZRYGwBuuEweQeauwsDPcvyxm5VRsJieCbk3T+iqbtvtNrvbgVQtuFybymKz+FkI13Sn5Ia2vFb4U/DFdyqYdGBHp52oklgFWZGaM0wjoEibnqJMaFRQcxxXwErkwmQaV0Lo0mKlTD1z8KC708YIh/VmevdkK8+8bTUCsUVZnmI9+LXxb6xC/VTbQ/3LKNO2JXazXdv4j/XxAtN8AKpJU4ALVrlqFmlbkYw==
X-MS-TrafficTypeDiagnostic: DM5PR03MB2713:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2713;31:TkUFMgfD9I/oPwqWgh8NxL843G4tqQVio9ilGN+po+OczE3TuKvsRuCeC1pb4FC4U6KOwnK8ydlLttFAKsPVTXHbdRFkfpcCM2R9KA3nw11YOlaL49vQ4bRDFQPARspvzt/Ht7AxTmYV3cdK0Piqp+DU3OsXnCqrPT7i/HJ7dwLHboKWNYcpLfG/t/pMBUIbF1O16iafDxv7QU+xEYg5gz9zc0wH/4rTIZQRb5Kb7cA=;20:ROlVkqfiTpiYjhVOGoMltBFA4qVOb0bBxtE25J84l12aEZMjbcahNFjbn4f9PoEmfQSxePUL5WLfh3k+usyPUARi/xbE9Vy+prgum1HdNms3pno0UB3rDodB2BYluQmieSjgb0rf4Tn56ecMY7LBfMqXEsNSZVqudPK5fUpy37eYv0rpmv5I8dTOa8rLld1jGx13QegQzEHS0l0jcKNKMzaVuCJjClocH3Xf2raJaP2oYZP8DV811kw3eqqYqcTlMiYm+Tc2qnTCQ1t1VKDq7QDYVk0Xlqugy5MPaJHh5dRX3OsyCyABiZ7dXZqEWTdRWpSyTo7wsBTmTUPphN+uHbnXaybngKSFjM7W+WLQ7O9/I7ytHNQRScZydA+6vz5pkCt8kAXYWaPdKo1btG93DSyAVrNzth0hktLTE1xo+8D294xHGNwffC+10Acz1B6D6i1ys9Ya/Fvgre6YIcftH278+6nSD9Qi++dFlvM60y4y9v0esmGqzXrOA9b696D4
X-Microsoft-Antispam-PRVS: <DM5PR03MB271347FB6495704AA3CC12578EFA0@DM5PR03MB2713.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93004095)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB2713;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2713;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2713;4:DBkAcisvPw2jfwa8YOZ7sydZzbaA/UAD6MYZhlzMzDhNoK7N3wNJvktXJpEwPALm0X5wanF1jtAus+2fkYSFAxsfnXl+gKoLyyXkvfOu3f8fBg49sreitLSt5+yayRbZqMuNEH5sXRcU95TUEAkFgV6ZbEbxB3Ojqvpc/jCJWezrg8l5bBobLIXzRRiEwaI4GFH0VENyZ9LcpgH0JdJwg2ltiuifVUsK/jSY4h8eF02ds1zyTUShfnScC1/R4MiMVr+XAQeJXKOnAaOcTW9fJXGNm+hFGEkOmPUYGkD+69b3rcpTkEWJmrpl/dnWW9AXduql88fe0p/zafxzwIkeLZKiRWT/j6hiUUbdXzxA76g=
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIyNzEzOzIzOnFQaXJQMC9WRW0vOTdPanlRSE5FOVllTEF3?=
 =?utf-8?B?YnBScDAvQWFGZ0s4YnZHTnlVd0UxdS82a3VMaDVralVmOVNSNzhQUldscHJR?=
 =?utf-8?B?VGRzY3VIOXNSa2Nka083UjEyU0RYSnNKb3FzZlF6QUhNVE5GM041YmNPTEFv?=
 =?utf-8?B?cjI5bzVYVmtZa0VmcmZmU0M3K2tMc2ltZ3BnN0s0NEpxck9BdE0zdTBPQUFO?=
 =?utf-8?B?Q1RnT0hsUDRrYVVwQzNybVFvRUFSeXJWaThSTDk2OXBmUDJSaDlmUnRUcHRt?=
 =?utf-8?B?elZQUmZySUwzdWJiK1FlZ3FiaWgwWU9YekVsaC80c016NkRMM245eEM3c1dU?=
 =?utf-8?B?aTBCWFVBbllSZC9odXErWWUrQ2Fob2hXT2FxR1Z2SGx0eWNabFhUeEhYdnJW?=
 =?utf-8?B?TDMwREk4YTZDWncyckljUHYvK3d0YU5YV0N0MThOVldiY2pnYkNjU2xDUGlZ?=
 =?utf-8?B?SjA4U0V4b25hZGcwSXpqYlVhVzhUZ1F1eWxjU1kxeENUMy8xRUZxU1RzRG82?=
 =?utf-8?B?YWJFVXBzQ2Vuak81c2FsakpSZlhwRDNrdUlNcHNXZjl4VW9mRFIzcHU2Y0o3?=
 =?utf-8?B?OTM3YTQ3Q3hDU0g0enBOSWIxQVhMQzdGenFWU1d0ZnozV3lQUVVzR3NBZ2Nl?=
 =?utf-8?B?UmNCZUtvVEJHY2IxdjlxQ0FrRmdWdlBtZlhxNGNaSVZwYXMwMm5HS0Z0T3M3?=
 =?utf-8?B?NnlHRWIvcmRXcXRvVEdHY2FUeWJYRStDNTIvQUdpN2pPQ0phWkgyNjB4VFVt?=
 =?utf-8?B?VndPTlRJN2lwZkMzSTI0R2YrMWJSL0JBeFdRdWZQMGVOOVhzcUVZSlo1Tkp0?=
 =?utf-8?B?eDlSQzc5NEx2WktpVDBQYjYxb3VuMk5XWUxpZFI2M2tXaGFkUWE5TVhaWC9R?=
 =?utf-8?B?WkFPdEtwQXAwUDBPUnh0dXd6bnNrN1ZueDNIaGtSOUpIYllkYnNFcmx1ak81?=
 =?utf-8?B?Zk5BdkpGSXY3V1pkUkZ5aVZnV05zckxuZ0dycTdSQi91YjRIcVB6bEpKbzFm?=
 =?utf-8?B?NmhLWUgzWDQ4aVVoOEJkUU1ha1M1SVlQNG1paDE4VHZkOGtVbVFVZ0xZdEVu?=
 =?utf-8?B?OURwdmNpWkkwKzN0a2VQcjVDbXc1NHEwRndRSmF0RDVIb3JWbzk3V3dwMkJ2?=
 =?utf-8?B?eGVvdXd2azRmdzhyM09oRnZEMGtPVnJhb3VFS0Zxbkp3Z0hNR2JKU1hKa1dt?=
 =?utf-8?B?cC8wMjVuNzhTdVU4dmxvZWFuN3lIRWRDZm4ycHllU01weWxFU2RIQVMvUHdD?=
 =?utf-8?B?S2o2U20reGMvMFF5c2tsUTJnd1VJSHJGMlUydG92bXBvbTBONFNZOXBPc3hI?=
 =?utf-8?B?d1RrRmpJaHRsZWpWa25ZcjdzWW9Eb1h4Y2FOZEUyVU41Q3J3UzVQelUzSG95?=
 =?utf-8?B?S1MvMjBLbU9maUJDbHBkbE1TMkJKNlJmeld5ODZhWnVqWkxiTmdzNWM4eC9U?=
 =?utf-8?B?VXZTSVBwSjh6c1ozbXBKa0xIajhScE5KcFFCUE12VCtwQ1VMZlZ2aU1uSTUz?=
 =?utf-8?B?KzBQSUVjZWRZcWorN3J0Nk5DVkMyMGc5d0VwbWhxNU5LVStzbUZkQ2tlbUZa?=
 =?utf-8?B?emxUUDRIMFB5eTJpYTVXaWVrREFoNmdJaTZqZkpTUzJZUWg3VnhhR0JEdXJQ?=
 =?utf-8?B?SkxtYkw2SXNzQ29QT3BJUzRzZi9GM0hMM0JDZUlNcWMvQ3R4dnl0WThyQ1I0?=
 =?utf-8?B?Q1c4a1VSVmErcWphSXgyMnhQMFY5NUExZHVsbkNDZ0VPKzZ4ZGxyalNZM0E4?=
 =?utf-8?B?SVlITEhYSVpFbmUrZUJRSC9LRUhvM1hhcnNtbzZORXI2ZWxOelhCWk1vblpC?=
 =?utf-8?B?RGFsRExLS1dlQWZxUEI5clRUZFhQaWR1STZ4eWVVTnBqc2c9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2713;6:J0AJopY1WTbLtLCVxzA9e8id1aCqK3Ag+x15ac/BAmTfXbnOLNa/DooqE2hzVofGQSnbClAgXodl/hQjSEjCmeF5gTcz5d2tKanxCqYdDZCHryqiDZXzTy/N09E20/3/GgMZgqgDPupcpScRPLVlkm8wD9xzAhRNvuH4zsDXcLGiDVcz+mxP96YYT36iHudibrtQEO3MNCtJ4NoocTwr38p/jI+RprNV9f2z/kgBpGkWQI3Q6Xcg280kwe5R/CeLk8Ft2Nlseado7NUshr5EmB/ZX+7XuuI6gch8P4qGOqBlVUc+aD+yVch5wEC8KUMMelt4qeagdp8fOb9PDTAJ70cAPix3NmHvOQAWhjhJsqg=;5:FGSJvX5CuZT79z4nhpweOVrno5NqyqmmSPl805v9sseC9aUNp4oMKzYOARvZGbZPt9MyMuWATNSulDP6r8d76Hd3czfhMdqvSf09Q6F9zZivXGqOW3bmP2S6pktSg7kd4X9UGYy2mTeYcLFktgYPsZFyLedJc3nOuW3HprsVA44=;24:HWd6rtf7scaXi5I+v2aopfa8hUCLaONWapiUmrLxh5H0t4Xk/4qup5UBN1ovUboA0iyfH9upFF8Gfwqbn5WqLQPZSujXGw20AxDq+Ceg2Gw=;7:xmxst/IatFDXC4ertUj8ke4h/cUMk4JbOGZOlF4hirsK27v3zldgMr/Z8d4rSeziVa3vOH4o51vMu6Xo5beyRCVfRy812UjGIT7WHIu+Noat1CqOC+bS0HsD5Ym4paQVMo7PIwXCPLjZSZCqIGfgytvOT5PkffFA9FBw1OgoYbjwwOfd32cxqqBiBjUXVcuLslFXHtShFpBmUhVasJ8y8468qbIWlppFP+5wcSGiBQPgoUJU/ncfl2bYzNqnKS2S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 16:24:23.9564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5723806-fc64-4f30-50d3-08d5699041ac
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2713
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.2018 15:20, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2018 15:15:52 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/input/keyboard/adp5520-keys.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
> index f0b9b37bde58..72e01cb77881 100644
> --- a/drivers/input/keyboard/adp5520-keys.c
> +++ b/drivers/input/keyboard/adp5520-keys.c
> @@ -91,10 +91,8 @@ static int adp5520_keys_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   
>   	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> -	if (!dev) {
> -		dev_err(&pdev->dev, "failed to alloc memory\n");
> +	if (!dev)
>   		return -ENOMEM;
> -	}
>   
>   	input = devm_input_allocate_device(&pdev->dev);
>   	if (!input)
> 
