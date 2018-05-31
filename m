Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeEaIwd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:52:33 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:4448
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754052AbeEaIw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:52:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ivan.djelic@parrot.com;
Date: Thu, 31 May 2018 10:52:21 +0200
From: Ivan Djelic <ivan.djelic@parrot.com>
To: Kees Cook <keescook@chromium.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lib/bch: Remove VLA usage
Message-ID: <20180531085221.GA29786@parrot.com>
References: <20180530212206.GA36883@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530212206.GA36883@beast>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [62.23.167.188]
X-ClientProxiedBy: PR2P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::30) To DB6PR10MB1736.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:6:39::26)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR10MB1736;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;3:tEQJyK7WO7FzULj1K2yaI8r5V40J8Wy62vqxiG4lHNWGk7B7iBa2FJLacUL2llLPb710d+Ls5uDdvMAd9RC4YO4jAs1KzZ8dy7PPCXCquDjEh2ZLmZcZvPEgtLT/FNQF1Wl9dfcol8ZjOLI3nZCV3bLw1ujDJ0spUaueHs4V0w3yJB+rZPhBfCdtPwCfPVV/23DOlTaQnB4fbkGmeqSDnMprmXzCS7WPiCRel65rP39iFKtsKRLmGL26corKN6tH;25:JJByM2TF96WmhtQFyqwWfxW64KKKgFwSylXC7NvceYTFaBPPRQQ5DcF04k4ZlHPzKPQDR3XCyDA43lWkKkc8Ns0nNncEBurfroXkAfDMfCNst6oIzzbgFRHIl+25V3OsUMM2EuS4a7ItO4I7p/6YCKUzA0W8dth89vIgCaN0JhfILKUS6G7VbuFkNMKOA2tp6NkuBzOEAeogB9akukiBo8135yGTE73fiHti8OTbdS5xTiELHUkrYIFWnwT+VAmhYtpbD0Z6HYNMd3XbRwpZ2FfzECtHxbHrNdl/j1KIppK6v3Dgyw/UsPmbMVdU6Cno/bxYkLBqaQHIOGzY+Jk3hQ==;31:QKGORGvJMUlMecx65bn/0Zo9ChJtxpDYrD2xTFVqvHEkRwoWoJDru+WKz7qi6Tii+VjyUBtebaap+lZTPTaXFZL/gnFCZ745h7rETdpvCm3HMeH3kEsWrBBMPkjP5O9qFtk4w1zWK2yjqhuMnaLmtZeE+OlPhABqEgHIgVhegrCLUAwP6StYDPLTOsR4I+VDeSIb4b5fx19GOSK8U2gC1iyRdeumw7eUOvwKZ9xhLrw=
X-MS-TrafficTypeDiagnostic: DB6PR10MB1736:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;20:jQ4x8lgYGvhoaQMAYjdXSj9DVYZ01SrlgQQtFqpKfSDIMRqoQpE6U64IJsZCwLX4synL3jXPZNbveoOa98JruNe/zXp3NvtOo7Rxb+NlcmzeMpZvYcl1PKRWoB/fShtJF2gMhQlA2dKko9RbCDODXc49fovEZ7kLoCAgbWEghmZ0oclkNQjKfADLlpAvikThezgWFZARe7BepAb0RfKr/KxR2aK+Wsbl4LrTQu243LRUqSns1fwGgXpGVNgTnU9ayBHXAw9MJNAMT6zOBrPGqQavXAOJbbHenKhSLGOSZWiYfWvOMxV4MbFLJVcU/UNTYnQveS9V3xS7TZ4lh8WTCmnLmMquqPltFKmNNWy+xB0=;4:Cyi/ZZJHqIrTARrPG0smLCOC2OcEE0mNeeaxzXXBeD617kPwRsdBEvJkXOC81cmzt5YGOoUZV0wVnvJ3s2EnI73tX6J+myNh9ALmiTaQ8xWWO5fou3FRSQz1AN8M5CGgGLwf42mVsuTwSwukf46VwqSlHJjKYsRCwfiJ3l0a8bPUrF0eEZPimi8fc+XInqXMpltiIHLoIwzMhsdTkkWYPXHGRCVIS56jdc23DdNG2UdWE06KwnIm78GPCgPiJh0ELbqy0rwZWPAEN8c4QiaOBOrlJad5113O6UlK2fH/cZCCSpcDhkRbhpQSVkja38g5Yul/JtTJXYGFD1tlTegPtCrb05vFN8xt07rPgNUW43c=
X-Microsoft-Antispam-PRVS: <DB6PR10MB173605DCF5735DACDF2610818C630@DB6PR10MB1736.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR10MB1736;BCL:0;PCL:0;RULEID:;SRVR:DB6PR10MB1736;
X-Forefront-PRVS: 06891E23FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39380400002)(39850400004)(396003)(189003)(199004)(446003)(33656002)(39060400002)(1076002)(6306002)(4326008)(105586002)(86362001)(186003)(478600001)(53936002)(6666003)(6246003)(6916009)(966005)(11346002)(21086003)(486006)(476003)(50466002)(956004)(36756003)(2616005)(44832011)(229853002)(386003)(5660300001)(55016002)(81166006)(69596002)(2870700001)(33026002)(52146003)(52116002)(7696005)(23676004)(76176011)(2486003)(54906003)(59450400001)(305945005)(58126008)(8676002)(26005)(7736002)(3846002)(55236004)(6116002)(81156014)(2906002)(16526019)(8936002)(66066001)(97736004)(68736007)(316002)(47776003)(25786009)(106356001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR10MB1736;H:parrot.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwTUIxNzM2OzIzOmd2UHVjeTA5VFY3NHg4NEZ3OWQ4bGhxeFV3?=
 =?utf-8?B?VmpqeTZacU82TlgwNmpuRTBLNllxRmZKblFvbXRnWkZzZWxsYmF2WTUrRnlC?=
 =?utf-8?B?ejZkYzJZaWJHVnNEZjNNRzRJNHFYL0xNb05nZkt6K0tBRVF4Y054MHpTWkZN?=
 =?utf-8?B?MFFZRUoycFpRaU9JdUU5TlBya3p2NjdkN25lMXVROVBQb0RaMWRFT0MzT0w0?=
 =?utf-8?B?M1NFRy9HM0NITFdJRDJMM2ZiVldKNHZQK25QK1hQcUt3U3R6UzVYL1VRZjl0?=
 =?utf-8?B?TzF1VDlWNTBpQXVTcEZNd1hUQ1RxalM1SitVdk54ODJwdXBVWFpHZFdTUWh5?=
 =?utf-8?B?NVFJVUtxUFMyemEyT3VVNXNPbzN3Q21EcTFUaHdvc2Q5bVI3VmVuOEFoQXli?=
 =?utf-8?B?M2h0MTEvWUsxR3lnY0xwNlR1S0U3QXNxdWdxem9ZTWRycFBnS2NBMEw5ZW9p?=
 =?utf-8?B?bi84ZHA2cVBQMytIbGg2SzE1ZWZ2NDR1aXBDRm1IZCs1L29pQnBnbUxkVGhl?=
 =?utf-8?B?WVl6dlRIaGVXMEZaN0szYi9BSmdyaExGNndpUUs1Y1hwYmFKUW1VMHBKUVBO?=
 =?utf-8?B?UHFVZHhEYWF5cm1ZeHgzOGk2VDF3OG5Id0JpMkN4WTcxL0s5NHVueFkyZnB4?=
 =?utf-8?B?VXNvSXBtc1VPRjU1alBtWTJ6ZE9qYWQ4Q0VWZnJNQytIaExBdEJDQzNMZzZi?=
 =?utf-8?B?U1VldXpZWTAwYzlWZVduU3RnZmZXVWZOblkvZXZNYUlJWUg4UTFDSW9heVRJ?=
 =?utf-8?B?b05uQlhWVm83N2Y0RWhiZ2lqNmdhb05kcDRVQkFvL3FpOG8vV01XZnFEUVQv?=
 =?utf-8?B?TjliMUdzNkVmTC9kd29XcGxOcW9nYS9ZN0RFbG0xWVNUSTg1QlpSQUNnWC9q?=
 =?utf-8?B?ZFkwTFJUTkM2VUltdGtYRVI3eXFCSjY3bnl3VXhLdC9Fd3dkZFY0RjNlNzFw?=
 =?utf-8?B?alEyUTg4L3pGaEVMVHJ6ajUvQ2xDeS9XT3ZsWmRrRU9JK21nbzAvLzdDSWpM?=
 =?utf-8?B?eC90OUpHVnpGamdXMjgrSW15ZFVZUEQyYW0zT283NWh3VGZPMUZ4Z0lFQUN1?=
 =?utf-8?B?UHN1c2c1Wnk1K0poWkdzelFIYzc3TkszWlIwNUxMa2hOemFSMFdUVGtkemto?=
 =?utf-8?B?bUpRcW5jMTVzTEcyZmp3ejFZY2I2RGtPVmVBWkRNZncvdHhTUllJd2RyT0xI?=
 =?utf-8?B?UldSZ2hDL29jVExwb0loVEgvNVEraDBJblRBaWlmNk5hS21XRG1PclJuMk9z?=
 =?utf-8?B?RGZ5RGlXTU9jdjFBNnNKS3VSc0w0cUgza28yODAyKzZhcUYvS0I2S2pvaEhG?=
 =?utf-8?B?WjNDOEpxSy9aaWhqcU10bmM1L3FNZXZTV0FlZUoya3lXY1BaUDlzRC96OTEz?=
 =?utf-8?B?K0lrOGkvaUpEYlZyNzY5c0hmKzZzTEdab1d3a3Ayc2RNN3NrM1kvS3FCQy9V?=
 =?utf-8?B?K2hSTlgxNW90TFdlbFN5VW5hZFN0OGNtdFhETlZxWE5jSi9vTmtPN2UvQlFh?=
 =?utf-8?B?V1c1NHp3KzB0VDlra242czAzdFN0QzIxSktERzIvaDBCeDdXaVpuVUtDYjNE?=
 =?utf-8?B?SWpTTzJYR0xmU29wUERRb1NrakowTUdSMnhmcHJFdkQxb1FhcmxwbnJjcmJh?=
 =?utf-8?B?SFJwdkVCTTJlQkwzcFhKbUpDUDVVSWg4cEd3TVBCU1BnOVNLTWcwQXliMFZN?=
 =?utf-8?B?cGVFdGt6aDR1azk2M2ZyUkJ2S2ZPSzZIcWlPc0EvbGxONmszdGpiQXByWEJl?=
 =?utf-8?B?UENJSjhWbTVudVZsanRtQ0pyZGVlZjBXRkxDaTZGT2FXQ0ZrUGVwcFFUUFRC?=
 =?utf-8?B?Vm1SSkNyTU1LZElRNE1sNzgxZnRnZXFqcmFvSVRjYTloM0crdSsvUUZGaWVo?=
 =?utf-8?B?dWJuVnI2YjN2YTNHb3RIMC9YZXhuS0ZYZ0g2d3M4ZGZiNkdBbUtGR2ZnYytX?=
 =?utf-8?B?RDNDMXg2bW1icjhLWndhSjE0dXdJRndWSHFJV1lxcG90V2FuVTFSMjNFNzcr?=
 =?utf-8?B?SGJKK1A0SHRsendZMGZmNkpielEzYnhKY1QzQmtGd0s4NFljS0NxRlRxNU1F?=
 =?utf-8?Q?oRls=3D?=
X-Microsoft-Antispam-Message-Info: hPsIEyrtY6IBkzs4JlxhmChQq2bLvTZiDNRvG6m1fIzc8l6x1Tf8NLB1RQy/YS8bTloYunMJP965QQ1/n4XrNSPvpFBpiP0Y9wqHoNtfjdxk9vojljkxQtNR5c+eKgyoyeDBQFS4CO5TSS4S5cFah1nz2KjT/SqF5UjXnDQ1GBbFJaq9mC56MXtLjL4onSai
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;6:SODBYRaqvwwD/00861mp4ShYPN1TZv4oO7DLBrLE81BdaNKRu52nzIaMJwm03NgwaENi/4lSHssdVmIbuslynHjs1rP31MkNYHNFjw4rVc4692ctnEzz3zURuRzQBpyADO3+Urzroi04gYkZVXyf7YGS4d4gUXfLbfZZrMhcbQtqFa1/NkuMOlu80cKtsvbXO6NSdYerXqDoFbyYW5+1DetpORRsrftTlVSGH4sNB8kNppF4TA3Tsnu8FBchdQXjvdTgMG3igmoXSQWHBBrWlh22nhdAbJVu2W8T+2f9MFle+kFakxJOCjHkAG9O9OEms0mcgzJAttoLYr+7jqXImvifEGhhhZqtYtMBvLXWp2mte8no6gUtTaj5iFOWFUVAgwHGfrwwWBoa8lc34JPVx7wrQ41KvyTM+iYb906LflB0pEsr+DjRcW+11I1fR747mU92CTAV3Ol58dIsKutxMA==;5:kM1lekaf7BsSfw/K4+bhzNIfTxoK6IU80BNNasYHrFUhlfOPXt+NiDe6lJepZ4bojyK/rgDzhtvAnKJ98DqMdddUGGgRznbHYM9zdnRPV3rvYpk7IKazSEXbXgCkf96mWreJ2sDLyx0KfCvDfqyhBsB/S5TQQ4a8m9PY7SS9Ais=;24:cWsKMprqT1Whm/G4b+9QwDujhJcnMoVO+XBPhPaQg/Ke3ew4RckGH34yQOK4CfLhudDfEPcmyVVMjs485uMXtw9WM/S0lZHx19CFQI0IpBg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB1736;7:DS/QhsSaLH6QTgYefr1HDL9MBiQ/BG6lhx34DTKTp9jWvDb71V8pMXrRsndKC1CQ+5sg+1R2Uy5Yi3eGXM08JDE+g2J8C0qef8ZPRKavatisTQ5m3+HPX1pkjXp9TBnJAt9dKLANeTz5ANtShe78HuIeVTI2Y7vN+wAiKkCCQkj+YLiRGZdo10xQtw+M0gCfUGwyEZf8w5g3z6H11pyA110tqIksORetN2Bd3t1KThiMkfdBY2xheyasVix1rRLZ
X-MS-Office365-Filtering-Correlation-Id: de297983-366f-4c3b-4704-08d5c6d3d457
X-OriginatorOrg: parrot.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2018 08:52:24.3650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de297983-366f-4c3b-4704-08d5c6d3d457
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff7d991b-3922-4803-8418-ab806a3414a6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1736
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 02:22:06PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates a fixed size stack array to cover the range needed for
> bch. This was done instead of a preallocation on the SLAB due to
> performance reasons, shown by Ivan Djelic:
> 
>  little-endian, type sizes: int=4 long=8 longlong=8
>  cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
>  calibration: iter=4.9143µs niter=2034 nsamples=200 m=13 t=4
> 
>    Buffer allocation |  Encoding throughput (Mbit/s)
>  ---------------------------------------------------
>   on-stack, VLA      |   3988
>   on-stack, fixed    |   4494
>   kmalloc            |   1967
> 
> So this change actually improves performance too, it seems.
> 
> The resulting stack allocation can get rather large; without
> CONFIG_BCH_CONST_PARAMS, it will allocate 4096 bytes, which
> trips the stack size checking:
> 
> lib/bch.c: In function ‘encode_bch’:
> lib/bch.c:261:1: warning: the frame size of 4432 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Even the default case for "allmodconfig" (with CONFIG_BCH_CONST_M=14 and
> CONFIG_BCH_CONST_T=4) would have started throwing a warning:
> 
> lib/bch.c: In function ‘encode_bch’:
> lib/bch.c:261:1: warning: the frame size of 2288 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> But this is how large it's always been; it was just hidden from
> the checker because it was a VLA. So the Makefile has been adjusted to
> silence this warning for anything smaller than 4500 bytes, which should
> provide room for normal cases, but still low enough to catch any future
> pathological situations.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: switch to fixed-size stack array
> ---

(...)

>  #define BCH_ECC_WORDS(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 32)
>  #define BCH_ECC_BYTES(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 8)
>  
> +#define BCH_ECC_MAX_WORDS      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 32)
> +#define BCH_ECC_MAX_BYTES      DIV_ROUND_UP(BCH_MAX_M * BCH_MAX_T, 8)
> +
>  #ifndef dbg
>  #define dbg(_fmt, args...)     do {} while (0)
>  #endif
> @@ -187,7 +194,8 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
>  	const unsigned int l = BCH_ECC_WORDS(bch)-1;
>  	unsigned int i, mlen;
>  	unsigned long m;
> -	uint32_t w, r[l+1];
> +	uint32_t w, r[BCH_ECC_MAX_WORDS];
> +	const size_t r_bytes = BCH_ECC_BYTES(bch);

Here 'r_bytes' is too small, because BCH_ECC_BYTES(bch) != BCH_ECC_WORDS(bch)*sizeof(uint32_t).

It should be:

const size_t r_bytes = BCH_ECC_WORDS(bch)*sizeof(uint32_t);

or an equivalent like:

const size_t r_bytes = (l+1)*sizeof(*bch->ecc_buf);

The rest of the patch seems fine to me.

BR,
--
Ivan
