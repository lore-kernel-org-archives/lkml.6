Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeDLPKJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:10:09 -0400
Received: from mail-db5eur01on0112.outbound.protection.outlook.com ([104.47.2.112]:22448
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753773AbeDLPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:09:12 -0400
Subject: Re: [PATCH v2 0/3] eeprom: at24: last bits of the big refactoring
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180411143828.1046-1-brgl@bgdev.pl>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <fe2654fb-8c46-0a29-541a-71850c01b64b@axentia.se>
Date: Thu, 12 Apr 2018 17:08:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411143828.1046-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0057.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::28) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:wkeedawv5Xkvguc+5Wq7Jem68T56dZs5Hc2rdKMahUVfOju5hiVtJezTKhzokglXGzCWxgsXcSQKgbgBBRE278a9jJZ279OblGIxEjFJDnYF/1WNGY9Wqb/kEjg/hWvpCN6GGuh7fVDxYNFU8szECSmoq828MDhCvzEZYlgmBSmvZnkNRKZAlT6x3zhbXo63EsRWFfgp/Tg70WsroLxJKqgwMAy6gxYjyf3AL1UgMR62f0A7qjVElviO5oJtV66k;25:7f0x8l3DqTI05FcoJeQ283BVN8H6GJ1KOkZH38k1lDJuh5TroKr3/LhKUJs02so3gtAB6vHGn8wNQY6YhM+N7edgo5+4IT1Cqk6767qvzGXfErGPsQW2PD8CgcsDw8vOhRJdWylxEQKAK79cWVcY7+xLI0hhJyZekl2pjP0EnAf8g3Fh0BcgLzz31bjXYHCLJfb4ZnNJ8NyTlfamUZ3nSNdjwqIkF4LaLSSlza4m7hJMqQJlKnn8RnpEDDTDEFFnPpzmFFouxMoC/Cb/kCudS0R/kTW/FlpX8fV/ck7v5BOk1Tju30ttJTwQChazLPPFYg6mkDV9XaE17qF3DZQs2w==;31:EGZYgcHUTVFv7ctoO45QPjjSd5+YxCJer1m2PiVoiBb8R89K+yK+vR2tG2jdNBuc6R/mu5QnBLgF4OEUW30uBJcWdMDuVd0shz5exJqVrnWBMQBTh+Qb/hQSCB5e7uU/i7My+uNFEtzHnJql3/Cr2DAMvX41pzWpgBq7TsHXtLjmclzPYYq9KM31NQIzL2ket60nEx2j/i2kBxrZ0xMob34+rZjOU0DWOb0g+BkvO78=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27769597B285424711971B4DBCBC0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:hzqbQHn8ZdD3E4FvPRqM1uWBMcLr289L/KAIayykZeQiUUXlgpse2NmVpEULo6HbmzRcdmPJAraaawEKTl07F827kgNO1O5rcYK+PCCPVm3EYe8+OCP3mDSzDT0SaOQDXpOBLWCSoxmKnvYiQifH8+uhXYVwmvCzJ7GI1gPJlUx6DtBwcxrAnfpZ1LZsLIrdyKRj0iCF+aavLjTcIw+jEQu5jWLmpECjVuT1L6fScu/VOfdhxTuopfJIYnYAV2cRcDzBtalCx8JKxe9M82RNAQ==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39380400002)(39830400003)(376002)(346002)(377424004)(199004)(189003)(2486003)(230700001)(81156014)(53936002)(86362001)(8936002)(6246003)(36756003)(81166006)(52146003)(4326008)(31686004)(31696002)(50466002)(68736007)(106356001)(105586002)(64126003)(229853002)(47776003)(65956001)(66066001)(65806001)(316002)(97736004)(58126008)(110136005)(16576012)(39060400002)(446003)(6486002)(7736002)(26005)(2906002)(6346003)(186003)(6116002)(305945005)(11346002)(476003)(486006)(956004)(74482002)(3846002)(2616005)(16526019)(3260700006)(25786009)(76176011)(117156002)(36916002)(386003)(478600001)(52116002)(77096007)(5660300001)(65826007)(23676004)(6666003)(8676002)(53546011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6V0RLUjNTTEdkUHVadlBIMEJiVGxPODNh?=
 =?utf-8?B?NmlDbkJmb3ZyUElOc3dwNnJRaVlmenJCN1gvdktxTXdMY2hGZkJpbzJyZzFq?=
 =?utf-8?B?VEpERkZYOGpzMFJnd1VGMzVZZk9pRTNpK3lzWS9yU2l5SDI5bzJTdHpHMVlq?=
 =?utf-8?B?MGFZcXU1SmFEU1BHVFRyaCtubFNodlcwL2ppT1U2a0JBRTVWaC9FMU11WkRZ?=
 =?utf-8?B?N3RNRFFQa3BMcU4yZlp1S05kQTVpR2Fkb05HdjhDb0l0U1NLdXVIS1Z4NXQ1?=
 =?utf-8?B?anFydVZsUGVuYUZtcXdLZzlEekhUWWJTY1dFTjJrMUJmYTRrK2lBWWNFTmlr?=
 =?utf-8?B?REpocWxla2JEWW0wNUhOdmplQXhlZGlDU0dHZWxDZHFROG5BVjNxVDlsdlpl?=
 =?utf-8?B?bExKakJpZHFhNDdUSkZ0MGhLVjFQMmx2SnIzbm5xY3pyMnNmYUJXdkV4em5s?=
 =?utf-8?B?ejBYMEpQbXh6WHIvQXJSdDloSS93bnJ4YTRxdkR4ZFdSc3hHK1J6N2lIMGhP?=
 =?utf-8?B?R1NSb2FTQ0hnSUc2OVA5OW10RTl1SkN6N2Uwa2tPMlYzd3FHTFhKVzVyUTdZ?=
 =?utf-8?B?VDdsejFKMy9haGV5ZmVKeTJFU2pRTVkzbmlMUEdpbzZHaGhubGlaNURNM3pT?=
 =?utf-8?B?QXZXVnc0cjRFZmZYcXo4WldLV283LzMxV2FDSFVuT3g4cGNNejIwcWZOK3kz?=
 =?utf-8?B?NW1IRjFIN2ZVRHpWZnRRYUxGSjVVb2M0djZiY0REMlhDSWhaUWNFdHplRHZu?=
 =?utf-8?B?SjBkcGhsdDY0eWRQbUNHaU52YWsvWlUzWTN6VDlrY1VIVXdROHJZNWlQM1pU?=
 =?utf-8?B?RUZQYzEzVWt2SmxnUkdObVFsSmRISFUzMkZrNnZEelhaT2FrTzd0ZlhGTW1G?=
 =?utf-8?B?OGZydzFKanh1OFFxM3RwK3Z2bWpOY1NQRisrVytGTGtjUDZnVU1VZk5WblF4?=
 =?utf-8?B?UXNZaVNXZndBUHUzSzdpemxGN1JVd1dxVmFhc2s2dEREUjhzUjhhd1pWMnhn?=
 =?utf-8?B?MG42a2NvcmhTbjBvSHJvWFN3d1pGaktzMWpXOTlISGJKWEFVbnJ0dUJsWG5I?=
 =?utf-8?B?d3E1Kzg1dmdCUERPRjE3NkNEa1FzZHlyWVFnNk1aNUNaL3JnRUV6Y0hjNERy?=
 =?utf-8?B?OWxKSHpOMkNMSmJ5Skx0ZGJNbmJDK1RjTGNnTzIxamkvNlYvOW5nR0R0RTNI?=
 =?utf-8?B?SjlKbHUrZmtIS1N0NEFPYlRrOWwwMFlzTmE0bVVoMU1XQjRsM0hIYS9lM3N3?=
 =?utf-8?B?ZCtUYUJiZy9mckFOejlYNDFnR0daU3FmeGJ0a2ZMWFNnZ3dnWXpIdjNCMVJp?=
 =?utf-8?B?bUYxMCtNcDF4dXhBUHNQcCt0VXVJandRakpMR0YveGRHNmN0d0lkN0RZRGg5?=
 =?utf-8?B?S3JIVXlUMkhNUDZVY2xyakU0UGFwa0R2Kzhzc09Sd1ZJakdxbFZRbFNXS1BE?=
 =?utf-8?B?eTIwbHdmVFU4RHFnRG1SeGNZbG5mSnNKRlFucktYU05KK1RiendaQTBmQlh0?=
 =?utf-8?B?YzJ4a3RvWkUxR0UwUnR0N2VLdnNMT01pTGkvZHJoZmM5MDVqS0J2MytXSjhM?=
 =?utf-8?B?WmE0VEhsYnFqazV5SGJBV3NPeXQxK0dNZDJ2RGRXM3dDRzJzcW1VKzdUd01a?=
 =?utf-8?B?RGhoSzAwVHQwWDU2K1NjRjdyZmlTWi9COW5naTJxK1FMV0NCa1p1Y2lTbStQ?=
 =?utf-8?B?T2cwSmFiZGNKZEhoL0s2MXFhMnVDRVNvemY5QnhNVFdRTWhPRjI1bGdEdi9T?=
 =?utf-8?B?QjRlVGdZVUJOeW1BZ1VaSWlVLzhESk15akJUOTY0TjZ6Sm5nV2UzdVB5MGRP?=
 =?utf-8?B?VE9JUkk5LzR4SGhka0FlMjlxdXRKOW5kNkdzdks2WWxxSlhDb05uYWdoY005?=
 =?utf-8?B?OG1VQ2lkV3VBNlZGajZyOWs5VmdqQWpkMTFwQ3B0czRPYTJ1aGkxcHNJeWNn?=
 =?utf-8?B?T2JkOGZVam5idVoxbzNUVG1MZnloYTlpNjNodms5N1NGZGVNako4OXVQVTls?=
 =?utf-8?B?NjF1WW9IYzU1ZUtRcnlmMDk1NVI3b2l0ZW1TZkczTUxpMXRESE5mNHFqYUJk?=
 =?utf-8?B?Q09jMTdlYWl4UENZWXVlYU5venVvMDVxdzFKRGZ3a1JzMUgvMWRFK3U3NXFr?=
 =?utf-8?Q?wKfQPm04VssP2KAslnPN+bfmfA/bKLOJWtdKv6WtP5A78Q?=
X-Microsoft-Antispam-Message-Info: jPVADMEqxrFX2JfDL4GSFRYL+Y4iLUP06oBIWBPh4+5Vywgl1gtxobpe4FbNFRJRM0lqadXQNXCBUE6ImE0if0JW+pNhzSU37xTIPQit+Vl8Fw7Xvlb98Rq3Np0VfOjlAW98deDzF0NHqutNfc/lXL2rqXD3dCXlcX60ajt9Pa5iO4NRCB7xl3qB+WZ4t95N
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:8PbJbXI238ToB1gHq3sW7QEb+1NV78KHqhR1/LmXSWGtHoAVUZUG9rrMpK8b/1USaXewZDailR6XG+MnQOPg0ib6kT/pLd+wfazHSQk3zXjnabjm6mXktDU6KenZ+rh6NBd2mfeHqQ0vVinh6AHFZR0CIa+SZs/1aFY7KYCx1/P6qaHWprjn6j+XbPylUbo/5DHLChW7bfafDiMdfXWP1gTtyBZ4IOf+x0hPhnNab+fraO4ozaiFvYFZRzZ+fN0GFvsyb7djIkVFMff2aVZCIBwjy29kDWNK6bVNZ57xpMxOtuP6G8LeZUAuBux+0xcfdivxTRvlx9knSi+PKV1slz/wvxxA6p/2D/v4jkM1764WjPqFuuc6FK7rXotSe8DOCg7PTZxeVfJBP2kgNarOu4RAyRTEOMLF0dEVFlKY2eOiJ413kl5CKRF/9G9NMe+1suVHBkGdZ0vcHNYCDPnZ3A==;5:Z00A4uKLR1zSyxDIsLaThwE1VWBiU5rAH58g16Ko0Ne0EiG8ubvfCIbBs65Vv+TFMPJViQH387h19RxhH7Y8srHJXkAa9EaZeueXga7N/tm8JmaisUNTWPlW/9Tglqg/FNLZY4FX5tiz75ZQQZ6aViqEKgi68xWR3rinsAeQoq0=;24:+6QhsOa2sTOCwVV8R2uYSZnRoBl57AcdsSV8ONAM+fJgxGcvzCoeinKiEKa+ECGvygS9oWciGn5BeGVB8LEyoJ2XKNidwl/5na+ebFGjIpE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:/1j74Y2uqG4AL6um1X4lHS+mysghvyD4JyANYUFGAYui3BMarSrwiVn68tGuZnzKzrrpK7NSDj17J5xJPTb4QSmqd7m7uPrM2b/KhsLk1wFPwXHPhIbKa+A3pVflN65otoeBDDVjpKGdho3uYFJEWjswNFy62UCnXHdoDB88GFmqLpw2uGex8f9Z8qk8LX/WL3RwQf1HP/ydo4k0EtiJC/UV0Sth4okwLtf9n1vJlESlhsRB9tIEthOgQ7mSz6N8
X-MS-Office365-Filtering-Correlation-Id: a3a76562-2033-4738-0f58-08d5a0875762
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 15:09:08.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a76562-2033-4738-0f58-08d5a0875762
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-11 16:38, Bartosz Golaszewski wrote:
> This is a follow-up to the big series merged for 4.17. The patches
> contain some bits and pieces that were missing in the last submission
> or depend on some new features merged this merge window.
> 
> v1 -> v2:
> - dropped patch 1/4 because id_table is still needed as pointed out by
>   Peter Rosin
> - fixed patch 3/3: we need to free the dummy client if regmap_init fails
> 
> Bartosz Golaszewski (3):
>   eeprom: at24: use devm_nvmem_register()
>   eeprom: at24: provide and use a helper for releasing dummy i2c clients
>   eeprom: at24: provide a separate routine for creating dummy i2c
>     clients

For all three:

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
