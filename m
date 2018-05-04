Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeEDOfs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:35:48 -0400
Received: from mail-eopbgr10138.outbound.protection.outlook.com ([40.107.1.138]:12257
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750820AbeEDOfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:35:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH 2/3] kcov: prefault the kcov_area
To: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org
References: <20180504135535.53744-1-mark.rutland@arm.com>
 <20180504135535.53744-3-mark.rutland@arm.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <2389e204-1b78-00a8-d69d-0ca4969be1fd@virtuozzo.com>
Date: Fri, 4 May 2018 17:36:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504135535.53744-3-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:15::32) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:oaAN/8tvT2JvlKuUoTE4PSKnIWvDtYJBz3/yYSGAW28KHLPGZCg5LehfuYY/c7qp8pyyMxVsFXVgInvYVY0AbRBAfW0CK8jO4yPXptfNoLS1s0wd6KNAaJjiVV344DfT1Oo/9MYoJ401GeGnMku9kfcgWsdN+N7PAMDjIqAj94Jc1Y9JUx4O2Q064GPgU2B/qo74jeQMJZU0cCFiDLUXwsd0ImR6+cbqZVOn2NYw+RhxnM84V+rtoj+dgE+8wR7U;25:r9XRmypSTHVz3wkKgGBo3X/wHQfUtPour1fgaYNeYcu5b/VnVDJvb6eWikP3RCFWR+ZwA/2uqTl3v2oBzCfkzXjNRildtUco7knIukvKnPP0Wytsaus79pxQqpdwPpEtd/n0AW75yFjWQ7FmYyvv5SHD8hQUPia0Um5zv/iodsUa839FdbL7WErFJmTupeUpEx4jZlpRb+1PcV7PhG9lsqgcWAbqGB9NFi0G6eGmgI8cyk4a/0Da/G/7nsjXQzpo9vBU2wLtBX40FBqb693mV0m5YF/SJbFseUB1f2K3W5EgL5L5Q69faJlk+WBlF4O423jYaB4nSmMEiFDc+9IHmw==;31:sgvfAT0syg7wb2B2ILAyxkMlDCRRlHqySexI8jlun8ZV1Db5lWIShxOGgtrJyUhohFmW4EcsPk4RviBHI3qtfQP99oCK0R2UgsyXqOrduBysmuvkrM3YElfEsLOESy+6QFbHiqV8Gbjla4t0hBwo0l/BheLZkg7/QBc3/1J8JRhVf8AnhChXVKEHUdXKheRctMYLKSjck7uy+3HkJ/bbZd2CgjDp1EWddjqi+nzuXOo=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:694QJLi6ZrgVge8A1EVYvVMyoom5QlqlBakvWo+rRjYwbfGHotoaGjNYtw1976K6A3jBy1YaHIAuOKPJppMYFw49Gi+v9vj1KW7l8lfzCHbh205fo5PdxhQd61l/YxHq9tfub4YtdLja4j9Q6JZq3xY7hbXw1qQhHU5g3yhFih23j+dRRPKSvRMnleDI3N4tvZeLPUFKK+IUtWTJxT0JPSJo8CNfO2hi39a1cX5f0fAgF3sAmXKgP5pvQUatHi79Lg7Sy1Dp804UBZfUB18YxTahmTK62/AFSnghuGy0R9iLVzN7YaDRqS0Z05XeDZ419aU1n1c4IWapgU8bNvH1FTOPcXq/g85ZEKRx/sRbuLeV7C6FTlW/aVrB51iTf6PhOlV6uvhyg+b0Tob+R+/H63hQH2cBr3EKzkaBdRkQjFadf2VzHsT3H0VkBrgirV4s6mBtce3ylRiouDL3oG867syRvRQmqDzEoW0z3FlcHmo+0ChsqP8TqPKltconsuU6;4:V73teBJqT21zhnuEqgYP3KnmSISwV7qhKd/KcpePBhwkEsB1c1cSsYG74RGN/LXrbCzFXW/ci+AERH5oE4kBgX6Mh6kuHxeD6Cb8aOdXR9skSG9oOVC3EsxlGwhpBymDgTMdODxX/S57tOyjSfboKpOaQZsKcSTDQwN0r/roPr8FTmLcji80C+48v2JMHAxLm+f8pfHVof/6MMKbnuteOKgZamLORZLxciW/yM0yGvr+XDvhSSnzJrkKUEEv0TdC7qtYIIcCt90DnnHhj41FUQ==
X-Microsoft-Antispam-PRVS: <AM0PR08MB325130DCE0F2D87E0DA8D497B0860@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(346002)(39380400002)(376002)(366004)(396003)(189003)(199004)(31696002)(105586002)(230700001)(53546011)(65956001)(26005)(4326008)(76176011)(65806001)(446003)(229853002)(55236004)(386003)(6246003)(106356001)(11346002)(53936002)(66066001)(6486002)(316002)(7736002)(86362001)(486006)(2486003)(23676004)(2906002)(52146003)(956004)(2616005)(47776003)(16576012)(68736007)(476003)(31686004)(81156014)(77096007)(50466002)(81166006)(5660300001)(6116002)(64126003)(8936002)(52116002)(97736004)(8676002)(478600001)(3846002)(36756003)(25786009)(186003)(58126008)(16526019)(305945005)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUxOzIzOjNXaFVRaGxRODZsZnoyYXJodS9OU2M0cUVu?=
 =?utf-8?B?b0p6UWc5Y1FaUzhtOG9aTG8reU9qdWZBb29XNGU0SlhjdUVDRWpXcjJuSzBt?=
 =?utf-8?B?bmV1ME92MHkreHZhVi8wV1JsUk5QaWtFRnRPNzZlZUw2U25HdStyKytJVkpt?=
 =?utf-8?B?QUtpOU1oNlRMUjE0c0pjOTNJMUlLcGpTS1VadmFYamVYYzNCd290UjFaTnJ1?=
 =?utf-8?B?OFhGRUpmUmwzU09uWUczYzJyV0dmQXU5RzVjdThQNjdwUnhXUVc1NVczVjY2?=
 =?utf-8?B?Vms0cC8rdnVEZVZBcDVCSnlNaWdMNG5XcEo3M1ZCZU82Z2VHMjRhWFJEbkJ5?=
 =?utf-8?B?QlEwMGM1T2JxblhtTmpBZThldWRhRk0veDJzaEI2NkwxTEpNSHh1K3JJZmhM?=
 =?utf-8?B?c3pPYWJpdmxYU2ZmTytNOGxJMVNrSmZtbkhzVlp5dXBsenAwd2hSeEppOVll?=
 =?utf-8?B?N1dNaHZ4dEFHNHUrd3pGSGNNRFJ6WjIzTmMvMXhCditpSjdtSUw3ZEN2bk0r?=
 =?utf-8?B?RklESnQ2a1oxREN4TkcrTkpxd2tYajRYeVBYR2xjZ2x1YVp2T0N1WXJmODZK?=
 =?utf-8?B?SzIxQ2dQeEV2b2hnZlZHbFVSU3M4WGlIQ0NOSzczT0ZxMUtybm1JRk04ZG1S?=
 =?utf-8?B?SnhmVzFhWWJLMGN5Q3VGWTcxNHdhSGlpdEd5OFNSeThPemFjQitoQy9YZUIz?=
 =?utf-8?B?M1JaOE5zL045WHZpRlpiVmtOZEJ2U1JZWmhGQUZHS1Q5VnJkbFFmNlhUTnNn?=
 =?utf-8?B?NDFpWUxLdFRQMlFJZW1ES0k5NWg1ME9lVHRlL0hibng0dXJjdmhIYWRpeUM2?=
 =?utf-8?B?WUp5VWxyZHhxRG1Xc0RCbjdhbUQ3UFRsU3R1czVTZmJnQ0tBRC83L1loQyt5?=
 =?utf-8?B?clpRS2VZamRkNUlhRmo4RVVwUy9uck1mOGI5MFhHc09CYmEydHl2Wk5aTkd2?=
 =?utf-8?B?WWhHcW5nVklESjNyQzJWT09Lam1CcjB0QVB4WHh6VGtwakhYQUVDeS93eGNp?=
 =?utf-8?B?VTByQStzbkdXYkRCRVFGOEdqMlg4QmI5NUo4dTZGb2g2VkpETFVZSGtuRTdn?=
 =?utf-8?B?TGozTXdIU0Q2Y0dhQVMyclBPUkU3cUtVNDRaVzNzM2ZjSHNUeER6MU9ZbkFM?=
 =?utf-8?B?RFR1cWpzZHk0OWZGUlI3cW04RUVjc1RiS0RzWU5SaytLZTVlRTh4NDRhRWNU?=
 =?utf-8?B?RU5tMGljeFpvMTlQc2pqc2N6c1pxRnFvV1VtbU1OUHBSb1RBMGNxNlRFWVBW?=
 =?utf-8?B?TkpReGJleDUyTGhRV2ZnTGg3RkNOUjdVWDhhQ3c1d2ZMOTdBNFV0dGI3d3Zr?=
 =?utf-8?B?ZTFqNGNyK3ZkOTZHVDc1ZE5RY0dTVDdmeU9VMEdUeTF5M2p4WiszRlhsdHBS?=
 =?utf-8?B?TDFub1pqNzZxMkRZd2oxSmJrWnlOMSsrWkZLZERmdmpmbTNOVXJ4MGg0d0hj?=
 =?utf-8?B?S1p6ZXFiWlNQV1UyWXlxNU5ILzRyMndUQ0plaU9uUlJnWjNvcXpGNWNFVDM1?=
 =?utf-8?B?TG51K2ZVNnN4eWlpVDdqV2xPUlUzYXRlRnF1NW9TVEJPajBZY3c2YS8wNmlI?=
 =?utf-8?B?eXlkOUJqYzU4OXk0bnpBOGJHcjNGMmdEQ0h1R2RFSjI5N3o5cEtldSt6Wktx?=
 =?utf-8?B?REY1SDNuQ1pwUlZ2OEZRM2ZjT3RZOWl5dE5nRUhGd1FHbmN3MGRjVkN3ZHdK?=
 =?utf-8?B?KzIwTEhIbU1PcEt5TzdFeEhuUkQ5SjdDUW41MktqSU5LY2NxMGFMVThmRm9l?=
 =?utf-8?B?dkEvMkM0NWxWQWcwSnFMMlB0NkM4Zjg2akt3dmY3VDljYis1aE95NFBxNnhY?=
 =?utf-8?B?YXpCT2lyWGF1aWVISDFTZ3V5bFNGZE9ZOWxlaFplRE0rc1kxYnhxcnJQT3h0?=
 =?utf-8?Q?IxWIfuUu82cLi1+lm4CpurDtlCBK3qUI?=
X-Microsoft-Antispam-Message-Info: gUU1N9m3HjV3ZjpyzPThP9HgnAF+WsTZ52fa1v6xFkhyk/H7NaHlFng1M9Vz6reMY2lArFjT0ClcWDxlSnkGkp94r1Fll/W3bTvojke2490MmToin5aBr8Mn5sQZtPxLLul1vlNE5SxEAniVEJRvlCQWDniXWxngOAmN5XrTcMpAceEqilBuXWdXSx0mEpN6
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:O1Npm5viE8HwfeyuDrbwCdU+k9nDmriPE70uVhH+hwNSuA8WNSQjsRMlAU9jHT9b469y2YP4TwCz/H8b2B2fpGi7Nmn7j93oQ1CKcjwxIve+6WIoMF0A4l/DYjU1cRy73guGU+/geb2nVq+/kke4zyXv4/sXLFuEBabCkKtnkZ2LdM4h7qoSSvsZnD2geSd2ZCip+P2Nx9TNaoQCu4nDI1XdZYc4zP5+yjnJuSTgBlowycYrAVOyJgs3IQ87SOEwk0IStalTD/DzQU2PvIo+uLgd5Q9v3SGCWXoqikWScU1zVpzD1uXtZuknnGVxwFgRsc1jIVbfD8T7ZrPQ1Dd1H4eF1VawDY8l19anlfhr5DnJmL25EcPKoMJMZEnEZvpOoctCN0y/gIwooq6gvZs5y4KvI8ULL7t5wJCVOeGCDL+eGdBhCn0Ec4APBrU+kp8yE4c677MLn+7pKLZN0zUbOQ==;5:n/vJFQR+2+KurdpMc+Vbp8P7AoFIkTTlSCDxW1e5msr6CdHSNcBThNKr+TRcOlml7paIoy1FfbHDJX5LopaP/fQckFl0s87p/mcNawWY/zwOHUTkqIxtK3rGyx573kzSLK6FSlD6fmRWAtdQUhdto29se4LStpphdv3U1WqxcSU=;24:detpGPEJrQ7NJUqaOOWF7xi8L107Iloi/++G/9A9mG9f7RRXxUAr1wnJlMVJLefOnx1t66aNWgeU8BXrjr6Mzm6GiwltucvBXOlptoRrths=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;7:AlSH0j10IDDX6mBA1WFFl+jvqqRhBZfqTPXXJ1aTfps7a7AWTaV3pfM1h1M5qhibMmHddZiwaAUh2LbSIDRLKxC/SDZRRxealtMDB31T1f4Jhoa8bHX0GtGhROOW/7+pqYCCoDtIh4n0QK4ll5bEqRpN8YY5od1ikkI6QncVrP5mb7kCaZ+qOinpj90GC2yt6EBx/st5DUKMb1z15KTgdQqa+XmNNx+YJ5NdJ+l2L0sucMkQ+rggZUwtUgv615Vc;20:Tr2YM35wc0+eO1PTVkRa7In7Anuz+fkGTvho3R221s8O5m02sdN6c/x1biGlyxaTuOJrioOAZkCLNUf4EOYZdEJduY2js8wSF9jrL4lrvCmKDQ1ir1gSN/baXwP6bbhWgW0Y+gJ1+CEjCiEepHYD8iKa0C+iPUTwU6zbQ6BXDGI=
X-MS-Office365-Filtering-Correlation-Id: c7e8feb5-122e-48fa-68af-08d5b1cc5118
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 14:35:42.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e8feb5-122e-48fa-68af-08d5b1cc5118
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 04:55 PM, Mark Rutland wrote:

>  
> +static void kcov_fault_in_area(struct kcov *kcov)
> +{
> +	unsigned long stride = PAGE_SIZE / sizeof(unsigned long);
> +	unsigned long *area = kcov->area;
> +	unsigned long offset;
> +
> +	for (offset = 0; offset < kcov->size; offset += stride) {
> +		READ_ONCE(area[offset]);
> +	}

Usually we don't use {} for a single statement blocks.

> +}
> +
