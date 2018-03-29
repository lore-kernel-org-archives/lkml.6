Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeC2OXo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:23:44 -0400
Received: from mail-he1eur01on0092.outbound.protection.outlook.com ([104.47.0.92]:13008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750979AbeC2OXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:23:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc: "wenyouya@gmail.com" <wenyouya@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20180329131054.22506-1-peda@axentia.se>
 <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <12f7f95a-0e1d-14d0-b402-10d1172004b3@axentia.se>
Date: Thu, 29 Mar 2018 16:23:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0025.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::11) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93b863a8-be77-46b8-f61d-08d59580a949
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:JiyQCmeirk5nsOnKt7IazcIQl3dPu+XsCc1XmgYq0GZACL/NiXASaiHC9js9hxNYS6buVDXr54+t5RYtfwFb9eT9yn6UFzVWoRsFYFE8fop87mGNP+oLoC5aRT64Rv35z2VoqmzZfNf5pWCZw4Rg5+Oqkxcm5Jt+bMGYYqywfD/c2LOfr5Xin7qLvLYogBaMhSxCebSMNXUty3wJc0lAyQeEQp9/2RzDxWoqkYMVe5QSj30GtXBA8qpybAkc2DDy;25:IKDAVQJeMMxaiEL/Tz6bLYIpV0PfX63j1gpNutpsZ6y6oXBtVMa5+/rYwa2sDpslw5qszJYJh8VFzJoTWJ8Mzm7OOOR9CPsIg+PywpPcNQPo8X8fkXTlsmt19w9qI1Cw+BYFWhTHPeHaTNr/j4XQ3VMMbvKCI16UYIAX56zU88IoKRrzzaBZDQJHwcmdGOBJ3nuAMKk7A3fNCaSHbBDERUSqOK1Zd+vSEhgdS1KFle2b7+j75Yc48Y4RlE3xoHfdnLIWqUWfypaOx9pLeuYzQFI37rroCBElV/L5LOgh2rbFSwcAStKRAI3ea61Zc84EHOdN2B7faR7z+z0Kz2MZdA==;31:rf7KoVl1vrnGYlW2oGbR4fU1KRmKgtSY2F+Oe9foSnibAJzKKpS8k9p/5fDAyuQjJPA6H8vzLjiOkpca2gdtZFHz0Q/7yfc0aes9YsbP6VFNUOihZb0t668pf1e3AW7aqB4WvAygmAajFeZqPyfW/s/wyH+v9ulGPm481ne9FNT8JgfC5gyFynnK5T8tqGNSYTsLjtYmbOR9WBmwUu4SfNp+sVB3IPwhKyJx8LMHCJM=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27846CF445019CEEF99A952CBCA20@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:UFhiWhuRVQoT9O0NcKW36wfTxrgtSyiC5CZet5v5yZbnl/sqmrngQwfhXk4QvWWhRx0HG58qakiwYeHzEPcl2u6yVM3NjS5x3UVDrzvcDQ9ku823AFaBZE6+R3wxSnrfx8Yki+U4fZhBnKIkUEgZthY1EFHH9uYykZW47NQg+al1EWuCuFhX7eUk46uv58MUCrKtWHR4FfMC5LnEwU4zaONCcVzRIel/HC3MS1YiL8WngtNBdxS/AvcRMluS9eHbreB1AnMKpatGsAJL14EAFA==
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39830400003)(396003)(346002)(39380400002)(377424004)(189003)(199004)(81156014)(31696002)(229853002)(77096007)(110136005)(74482002)(58126008)(26005)(8936002)(6666003)(97736004)(36756003)(59450400001)(16576012)(186003)(16526019)(956004)(2616005)(316002)(486005)(53546011)(386003)(31686004)(3846002)(6116002)(486005)(8676002)(81166006)(54906003)(86362001)(105586002)(50466002)(64126003)(23676004)(52116002)(52146003)(53936002)(6246003)(25786009)(7736002)(39060400002)(66066001)(305945005)(68736007)(47776003)(106356001)(476003)(65806001)(7416002)(5660300001)(2906002)(76176011)(478600001)(3260700006)(65826007)(6486002)(4326008)(230700001)(117156002)(11346002)(446003)(36916002)(2486003)(65956001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6WnBxYWVGc1dvY1F1SXNsVFlQVVBuYkpx?=
 =?utf-8?B?YmJTR1ovQTJqcm5rRUYxd3BwdFhsbUM5U1EweGFwR1FvMnE1dGxVcytQSHFG?=
 =?utf-8?B?dlVEZFArTkk2Rnk1NWdLSUYwT3pHTldoSThjYTZTNnFJRlJocVJDbXN4U1Vq?=
 =?utf-8?B?VXlBcnBJaTExZUJGRE11azdhdGxUSXJDMXNxcWxXRUUyNFFXU1JOQ1l6bmVz?=
 =?utf-8?B?RHI2YVRrMnZ2VHdXWHdqUmR2U0lNZFpsNUU1bmdjWVdJT3oranl2c01kN0Iw?=
 =?utf-8?B?NnhjQ2ZBSlI1T2hQN2FiZ0syNDlFN2tqWXlaQTVMcFdwcG1xR2k4T01YS0E4?=
 =?utf-8?B?dTNHVXV2dkNkYmltQlFRaDFhK01Ca1dyS2ppT3liYkpUUmJqVGNVRDRVdytv?=
 =?utf-8?B?dHMzMmFqZnN5VjJPOGw2T0ZDdDdvbC96Yi85Y2pkSHg2eW8xM1pzNU9OemY5?=
 =?utf-8?B?TEpJa05pSXlKMGI5R3A4Mk8zenV2MzNxT0VpQTU4SHRMQlR2aEtPcExMMEIz?=
 =?utf-8?B?UlFJQ09LZUFPVDNDclZaNldPdnZ0TndRR1VPSEJ5NC9CMUh6MFN6OHFMNVdR?=
 =?utf-8?B?Z2RKa2dZK3pyRW1Fay9IMnM3NEhSVmRWTEswM1VucWsrTHkzMFhnTzRYTmVV?=
 =?utf-8?B?NE1lMmRVNEErMERCSUNwY1Zkdjd4dG8yVDE4YjBsdS9sd3NRZzhMeUgxYWRj?=
 =?utf-8?B?RzE5d1hnWlpiL0o2NURRN3hXZ3hYMUwvZlhoWGdNbDdaMG9jMGhzQ2VIek9W?=
 =?utf-8?B?WXhZd2VnZVBwRWtsR1hXSWtQbEVvVFhvdFF1a21pZUwvcndwMWxXeitaUTV5?=
 =?utf-8?B?ZXRDTkxWb0FTU1pObzJ5WHZFaUdJcTFyQzlUVGlQcjIxZno2Z0NNUWZXdjBQ?=
 =?utf-8?B?UEZqbG5OUnBiclJleGthSFlycWFjemRMcTBHVmNMWjlYNm9lUytXWnJ4T0tN?=
 =?utf-8?B?OTdlUEhhZnZRQW1vOTRVclJvbUxCd29GY0d3SERMa1FUQmtXSDVSU3Z3NXVo?=
 =?utf-8?B?R21mVjdYUFhrVXQ2OUNjNUVMa05HODJBOTBUQ281bFkvdk5pSm82dkJlQUZj?=
 =?utf-8?B?aEpmd1BrRlMwSTJhY3ZpNGpranRXSnBNVTZyd2NnRnRpVzhYSVVKaEdLQmNt?=
 =?utf-8?B?WlU1SnlzaFhRSFh0dVNGUTlIbjRsYytXR3ErdTI4NDJSSWRGaDNaRldIMHhy?=
 =?utf-8?B?SWNZaXAwSkY2R1NSZ1NzbnFPcjR1aVQvSDhXVm1UTjRyZWhoN3ArNkFtclNP?=
 =?utf-8?B?b0xWY01rWitNMFdJSmYzYWtQc1cyNnVFNjZ5SFQrN0FScDFwU3JicWxLd0ZX?=
 =?utf-8?B?Vm9VMFh0ejVIM2RSN243UHo0NHdHNGFkSUxUTGhYVXJrTDUySzVJdDdxMEpM?=
 =?utf-8?B?MmMyQ3FUTzRiazZVYUNWbG40b29PRUJKYVhRV0dIM1k1eDVmOGh0dE1PVFVR?=
 =?utf-8?B?M1U5czA1bGVSNWk2aVczemQ2NzNPY3dNL1o0MDk1elNnRFF4OEIxaVFRUjQ5?=
 =?utf-8?B?aWFTOVB5L01uUnhpeFMxZ2cyVG95VjdialZTNkJXeDE0SEJwd1FMN2lFQno4?=
 =?utf-8?B?TWpSTU9VbHNPYVZLTFVHM01maWZPdnJNMTkyWUdKUVcvTERXV2JNdEtjdlFa?=
 =?utf-8?B?djJmSGR2bDY3TVZIUkV6RkxxZ2hsUUxPbzcraTFZMDdTSkF2VUt3aXBTejlV?=
 =?utf-8?B?bmdUNDZsbG9uQTZVL1hYUk1ucGUyUUNkT3lzejFia042bksvL1NaeGhPSXZQ?=
 =?utf-8?B?YlY0Z0ZSMncxTEpVcXpSU0o5UmpPd1hzUnBIbnI1RGZEQ1VlOWpscVJTSTBw?=
 =?utf-8?B?YlROTGhOaWlZQzBzZ3IzdmZtQXVaTnRtMzFMTzY2OXFvRVIwZ0I0RXo2eVFY?=
 =?utf-8?B?ZnEvaE9CdjBoTXU1SFVRbXBkRGtEWVlxMVo5TXlpZUo1cWVWcmJGd2J4cUd2?=
 =?utf-8?B?SmxubzJQUnFLYWJpV0tWbDYwcHNHU01YRVg1SDE4SFNWaHEweWxPd1doOERw?=
 =?utf-8?B?YnpvMW9XU0JXY0FWam4wRDEyREIzWVR0OHR5RjRkUEpVOHljc0VJMDIvUWhR?=
 =?utf-8?B?Z0FGM3FuS2FVVjQxeEpVRjhCQnR3RHBYeTRpV0l5RkloK0pPSjJ3eEJPa0Zu?=
 =?utf-8?B?eVVQT2FldUpObjhTbmp5d3FONW1nM25ucWgvV3ZtWTZQRlkxc1Aza2ZQVEor?=
 =?utf-8?B?MkwwNnF3VURYTHpKMVA5U21QTmlmNVVCakptclNxVjVMUXIvZ3F0NTlTbjhX?=
 =?utf-8?Q?MNle/NqQXJB+qzxqXcgG?=
X-Microsoft-Antispam-Message-Info: veWmmzm8vT7ox1bfrzGFEzTJc9bUAycSYBLVhLYKASt101+9alEOh67C5+13LQJGAfgsVd9vZAb3BUQavgLQC5oS/9a9+pgqS5UpnEeO5ZnUutcCgR5wMOpXm6VTq2KplenpPQObxM0sLPEur6IeceTjS94AhViZCVXHBiBAUOh+rySoAhvf5y2Mxn5bNEzd
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:0kQPRvTIt07yDduDFoTuVEr/UoDPqx0H0dOHHCawZznI3XcWBuDXLDmo9F/0j/Grr3jederNEjujKiFMiANlN1UzrVRuufwHcQxgQjdVSaPO5nwbL9tu4hFgi82LSjxK/pFq3ZgFMZByLfU8JIqGps2viK4sJlijaHHnNPnbnKgzZDc3AXva6bq+IU4sEk3Q8CQ9UKZaFUF5tmFrAf7gpOv+PmjZpnx7a+/C17oZgKeR4aJIbG/yduD+TTG+0WhL3z6e+9VXhMg92zEJyFQRceb4RxFTMpcb9QixrkUm9IRlq60NURPqIReUNi0vH0ooDPONsMlJCuGGkuAWs7wYNEVq5tLmaLZqBowny/+gyM+1sGlfB8bzjDqTORQah26Ts+vtFZOtgpczgXajdjEQ22JgP5FE36hsKe3qA68879HsboSxoLbfZTUP65L2/S90IG4Eqed9anjvkRoQ6uiLEg==;5:xHnEEtZ4i6M64qao915FrkMvI3GvDA186zHppvP7S2HNE4ckAtZ76RrVslpfqmcpPKL/Gz2FVve6D7m1QQ6QSTMV+v/KxpcIcZMfxDFmSEOIO86bL1w98e85Z0ZuC66dSnut7uXC5cuTsbjjRAdoizYVkH1bWSX66p42zDbIz3U=;24:GHIfdIQbg5EwH4YyAPJ3swX6r/QJxpLfulOjKZ9oDgVaOyJYoCj2oWxd1CS1bRSPOER0UqBxL6qZ+XLJ2orsHO52E44Wt7CkSYecWEJMFnA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:TEJIoPI4JHu+nRwfMbl8HR1OYIu9PmCysy8MaP031b1dhqTfIOUjePgIKrve/voQUHrMLvAm/itXS72WRLv8pOR6YL+W7Y+upobm3iO+eh4eOVyxUzXZpSJtcNvgYCYp/zboHPeVLthfQVgqnR+RcPhB3A5rk2M+TqUj9v3tldAJRb7FX/rVtqMMV3sqnERGKlONC5awTxZyB7BqpL7gMJyL5iaC1IHZVJvOZV7xPth+Q433auf8Z3hrJT49zAM2
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 14:23:35.8529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b863a8-be77-46b8-f61d-08d59580a949
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-29 16:20, Nicolas Ferre wrote:
> On 29/03/2018 at 15:10, Peter Rosin wrote:
>> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
>> flash accesses have a tendency to cause display disturbances. Add a
>> module param to disable DMA from the NAND controller, since that fixes
>> the display problem for me.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> index b2f00b398490..2ff7a77c7b8e 100644
>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>> @@ -129,6 +129,11 @@
>>   #define DEFAULT_TIMEOUT_MS			1000
>>   #define MIN_DMA_LEN				128
>>   
>> +static bool atmel_nand_avoid_dma __read_mostly;
>> +
>> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
>> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
> 
> We had the DT parameter "atmel,nand-has-dma" for this purpose and it was 
> associated with a module parameter as well (use_dma,).
> 
> Is it only managed by old DT binding?

Saw it, but I need the reverse. I.e. *not* using DMA.

And I didn't think this belonged in DT since in some sense it doesn't really
describe HW so I went with a module parameter.

Cheers,
Peter
