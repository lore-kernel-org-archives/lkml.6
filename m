Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeBHQE6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:04:58 -0500
Received: from mail-ve1eur01on0098.outbound.protection.outlook.com ([104.47.1.98]:59552
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752275AbeBHQEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:04:55 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] UBSAN: support __ubsan_handle_type_mismatch_v1
To: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
References: <20180208154636.21320-1-mark.rutland@arm.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e1561019-21c2-04f9-5db7-1c27c327a8db@virtuozzo.com>
Date: Thu, 8 Feb 2018 19:05:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208154636.21320-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::32) To DB6PR08MB2822.eurprd08.prod.outlook.com
 (2603:10a6:6:1d::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ff29c3-9891-4ed8-50d7-08d56f0dafdb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR08MB2822;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2822;3:AzHEsWNiOqv2XSQNcaZJ+j2Il48VTaN66vQ8xo0vqa4e3SDKP88EzcjLv4Vliqz4mhpZI66sWp/IY9UwVdBOk0reRteIuiAyHWQcQnR4gNziauiaW9xucOs3laxJjk+yS9mn8FaS+q39xwrkT2+JMvWHLa4802B4b8xTad5iJOpNKpXuXG3Ig5dxEM4BwrnPPs72ltvDHQVDY/LXKHwNm3WN3WSPAcB1BaVRE6yniPZpsrAHEJYra47NiYylN4cc;25:4yWZZSWMjYXNjwzZLunma3MAo6wHR+MfTGi3onYvn2f/4OM3TNXtgW2WcEgh9vCJLzFnq+P7r3RmlF5VbK81haqbPEM9LiuNrvNDqZ7OSG16rGuHcpOuiwsOlx+ahzrbDpzJo2eDUWaS7dyWq7xbgwH4mp6iPkZbkF5vkWdlQ8JOvWzOKCBpVse1z/V3/EHVKHAyJftlJXWbyiA2b7KHLpIASj3MLB1wkgGM4Bf3U69yfgPvQpTqWNe8vDtGb8Sss6wJ1ZhU7A8OHglS/nCaMR6P8eX51KaZBgJjZOyAeApj1DBRst0ZhsLgpiTNesGSCqY7Ck1SQHG/cW3EFhKkZQ==;31:SRJv4NoovWcrjc6PaCijRFuv4UX9UaXj+pDf+csuXohg+OdECldrNJEHMT7w9S1khbuUT62IbjPxKuVmF/19rEYbvEdgXYdT/n0cMypciFNhiV+Ah4jTdLTC6cnOV1/BlAn43a7gvgd6X+t1yszL4oxQ9hK9AIJ147HS60Ze8/YmTaBt8oGbPhRJIdhsK+INUPkxur0P1aDYmPGRhmYV3efOY4N37kIWpaPhVhafboo=
X-MS-TrafficTypeDiagnostic: DB6PR08MB2822:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2822;20:ruvm+wOTONRJi5xky+f1AKahII6CC7HIjXotPdlEr8zq8wU4M0nMXYBJfk2/8TgtMFQQ+IZLGuDdwkhK5vIS2liVFxv3BWjitGNdZ7DQA+ulT2rbHjOS6l9seMIvsOSkSoqJe7qD4iNYxBLp/UoG4KWOfcHZUUxI/2/XSUBbAn2LbJsG+uEArq+fn+kKPlOQ35deadCG3EpiD6l07HRYM8BcMUZVMItp87iG2lA4ZsVBPOABI+bpneIFkra2kYgBvB85lm9uWfi34i4m8C6s+ATFGGxw3FGLR8WWPZ8MMwpX9YsWGQo7dytbpr9TKVWAzSnOOuGoeQiYiQdEl/mbf5+aPxs7HiQxTrSfIRiAZ8d5vd2jlf1O3lJO2ODoBcJF60vqPM8CPss1BrxeaAPoMn9y/tvnpcHbNpg6Ld0Pi7U=;4:ZlWIq2qgI010iQVNK5J7sYFglB2ZOVEfpDlhge4ID4c5dKTk8i5IUB5BjbPKrrE9XneuJuo6vOl9A6dtGJtazQcsQq/4UL2BqvxHNahPTpJ6YF3hXuhKdQpnsqxrFmuf3Wp+jFZJkva2flOjo0S+6SUhS4jNxdFahrxYyuXAP9Q+cJlmiC4rJvuQ4JXWyWTmpsDN3nfdsGmHyb5EtUgMBl5CneOxdiKN5XU7eMZtExF5I0HRnik2q5fDYj7G1yZ4Y6OE1BjeF+qX+qFKvhyv/1zU9MbKzXov1Ckf35CvEi+KYrvQKbQRyOriHFIA0gCi9ACfsQEATwA5sbvDQmVWRA0EoayZy6YAr+sWrNDHRfg=
X-Microsoft-Antispam-PRVS: <DB6PR08MB28226F1BE4F22AACA229D14AB0F30@DB6PR08MB2822.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR08MB2822;BCL:0;PCL:0;RULEID:;SRVR:DB6PR08MB2822;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39380400002)(39840400004)(346002)(376002)(199004)(189003)(76176011)(23676004)(50466002)(8936002)(52146003)(64126003)(55236004)(25786009)(2486003)(6486002)(105586002)(52116002)(6246003)(81156014)(8676002)(16576012)(31686004)(53546011)(36756003)(26005)(83506002)(386003)(106356001)(186003)(5660300001)(230700001)(316002)(65826007)(81166006)(58126008)(53936002)(7736002)(305945005)(229853002)(68736007)(65806001)(65956001)(16526019)(66066001)(6666003)(4326008)(2906002)(47776003)(31696002)(77096007)(86362001)(575784001)(2950100002)(3846002)(97736004)(478600001)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR08MB2822;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4TUIyODIyOzIzOlk0ZFUzQjRzUk5meUQ2Qytod3ZCbFFvMHlu?=
 =?utf-8?B?VVgvc2ozc0ZxN2l0Z3JSNkpSYWhsMGY0aVpVVEc1R2dKVGxUSGpJcmxoRG1E?=
 =?utf-8?B?OHZpTUxzdEZmZXVjSTFBU0piWGdxaGl4U2NDZ3RmYnczV2tCcEgxcDdoTDhj?=
 =?utf-8?B?WTFGOG1BYUFIOEVRNUMraEhEZzdlS1pzT3hCUUgvbnNzRkdETWl0Y2FjTlBl?=
 =?utf-8?B?MUo2d2IvUTlmUUx4ck0zc0dESThzRkNQTWx0YXZyakx5aVhCRlhraWVvaU1W?=
 =?utf-8?B?S0ZxTTlBOTJGbkZZZ1llVVJmRloreHZZeWlkSXNTb216blRtdFVuSXUrSVl2?=
 =?utf-8?B?V1llQjI5OUtUV0FnZXdVckhwUTY0b3hnVHJ1UmJwUVVJVFYwWTI1ejlzNDEw?=
 =?utf-8?B?K1VFOVdvUWZ0Sjc0V3pWWWNXaEhqemlUK3ljQWt2VnoyZ1VKbHBYM2gzbSs5?=
 =?utf-8?B?ZnhHaXdFUW5QMytLaUlxTmtSaFJrSzRkQ0JtY2FwQTZMVTlwa2JXN1VFdjNr?=
 =?utf-8?B?WTdkWS9zbFdoM3JhR2ZzQzc0dVZ1aGpzWkFzRU82QUJTRUZnRDFYUWxZUXNa?=
 =?utf-8?B?Wm9mSUJCRFYvYXJ1eHMwZk5IakVwUVRlWE1mOFgxVVNGV3ppd3c0MzRITTk0?=
 =?utf-8?B?ZmRZeWN5Ly80c1N4MTVQUG81bjh4cTRBYVpxdU1XN2tsZkdFL0QxaTVteE8r?=
 =?utf-8?B?RkZ1R0t3bE1EeHVqZVdkNXB5MEthdXhuZUNPZmQrT3ZlcThZK0EwZ2NWK0M2?=
 =?utf-8?B?YVZRV2sxK2IvN2xHL0xlclU4cHR5V3VYL2dYZ1l1SUJyQXJ1TUk1eHZJeGU5?=
 =?utf-8?B?Z3lQbEVmc0RteWVCM09nS0ZaNStCaTZaUEkxRWFUMVF5RG16NU5Ka3k3S3g4?=
 =?utf-8?B?SWFIMHRBcFhYUVJaU2Y1VlhzTnhHU2ltQTlqdThVaGhDYUtoQUVUWWtIRHI3?=
 =?utf-8?B?R21JankxSlhqVjVBZ1VWMFMxWkxwZlk2N0xrVjJhTzNlZlNVQVBQR1lDNFRw?=
 =?utf-8?B?MTZJZG03Y1hka0YzK3RISHdHSjVHQ0U0VnBWeDJuclFkcUphVkNIZGwwVnZM?=
 =?utf-8?B?U1dQL3E5WEFuSmZjaWNrb2NUTFlKMjhoLzYwVmtBUTAvYzg2cHdQQ1BEdEpm?=
 =?utf-8?B?dExhYUkyRmQ0OWlLVlF6UkQ3bGFuMzNML2kwR3hxb3NFR0dSaWVjb0J6YU5D?=
 =?utf-8?B?SjJnbG44dUQ2WmRaMUJrMk10QU8yUytvL0sydHYxdVZVekZzSm5HZ3NTL0tD?=
 =?utf-8?B?MWUxVG9lYWdKeWNpOHZnRlR3R3hOUVFsUnNPdE5aM1BtTzloS3FCdmxrY2hJ?=
 =?utf-8?B?Z1ZHTTlROHlwclc5SWhKVzU5dFpERVBQSzU5blF0NHZUY2gvbEhiT2M2Y3Nq?=
 =?utf-8?B?RHNCbEo1Nk01N1Y0VWtETys0Q1U1MUt0YjluVUd2QVVoSXJHOWpQVWNReVli?=
 =?utf-8?B?WHFkdVFsYk1MMnM2MitQbkREMUlZelQrNGtmSE4vaTJOREYrUkt0MGlSQzVL?=
 =?utf-8?B?ZVpDWlBPWFMyaHpJZitYNVFDVElYV09maEdaZFhrNkhqdTlYT20vNkRHSDlz?=
 =?utf-8?B?d1krckVmVU91MjAvMmk2UlJIUnIyOUVmaTg2V0lPOWgrSGxEcjAvS05aMDFK?=
 =?utf-8?B?V2tNdHl0cFhrNDlMTmxWdjdFQnhNTmNsWGx3VGFDbjlTQXVaYVFCMC9wcFc2?=
 =?utf-8?B?WHdYZjNqSVFsem1naGtCYUhWSjhwUkFzcnJMMWQ4ckhXZDQvLzBjSFM2OERP?=
 =?utf-8?B?M21BYXNoSEtZcyttUzRVcFUxcmt4bHk0WEUwNFZTOGFUVFpNRlhTcHRnYmFj?=
 =?utf-8?B?ZWF4LzBWaVpjcEZHSzlKVW5OT1p4NTZEcTZkSHFtRmIwcTBMRXJEaitxdUZs?=
 =?utf-8?Q?qZZGeopwGhE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2822;6:uFNpejiixfBJCM63WyI+LYskU2FQApdPh6qtrdIpzG6tyUTgCu0+/pMSf/taPzNB2YsBHD3YE2blqs45UwlMrxTi+LBcdV0AWtuCdGWKsFTvj3kedTKCjN9BciJHypyj8QJqN+5b1P81pdgeJ9JoIACNFTDjF9ygoCW84r7JnFByMJixU0dsHtuH/Gjy14DAw/CRpi9+eqx4thYPkmtOjSX1npIVhs2iU3ickRxyTxyOEv7zpVapsm0hECiniTcznNbsOz1c8T5Ek522jifSvmEl99h9a8MpAAAJbcjct2inGbk0r4ffl5JIyFhtvgs4fKKeq5B2qMbEyjczp14Efj2G8ltnfnt2Tb0eSMRg2yI=;5:3mQpkbRJJERrr+IhK9NxveKzmqcJ31p/pofpd1YHOOlVhY621mNaEG8d+e+njiQqBEWmBsylVfA1mv3A/PWG+F9rrdyHB4zjtJY8pcrSXmErSOTffeBIMfs5QUXjzD7QodMQTat/wQVh+TQJygvBCguXuEUBRPdo8aN9tOBPsss=;24:E3ARTqk02fYS5mEzmYOI5ljdflL1xoi7+Ri/g3eiyVVZDtE02j9kyXZv8bWEpLR1SEDeqtYo0ckN+lucw/eEI/MiikjEoBgS4j9/l+oxEhk=;7:laUgllNZPJUXrpnTKEujdoImENuhb4GXjnQ7q34EFxPaIZ1vi0cQMFyFUfhiXq40pidn0LC+MlV+bEgwQ7t0yDs0DiyqBBqBuCdBleTHCFSbPJvHnyGk9Ch1FFT8G6LyBOcmqqwbwdr3zRr15SasdKwsFbX4sVCha+Dgk5ojmjRQfgN+YF6kjz9MjeakJVbmHGxDs/9YaLe4Hd8KhwyDNq7CglCmjzXfcxUrNesRj3rV4MdZF3ybkEdwac5EyiAc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2822;20:wgUk49qLCiZ203W0R0TxviKKhAtsWxRECO2ns0klIhxXoKErdo4RiSjQsbF3Q7fbDkJsW8pXp6lAKA5wkAA+fzmFze9tuoJL7Xl6kGz91l/gBCu2HC60/hlR60zHnx573+XgSfPaoskqchCsT8MsLiU3BFsrXZTT+GrFgQ+xQZg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 16:04:51.4687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ff29c3-9891-4ed8-50d7-08d56f0dafdb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2822
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 06:46 PM, Mark Rutland wrote:
> Originally, UBSAN's __ubsan_handle_type_mismatch took a struct
> type_mismatch_data, as defined in lib/ubsan.h. This has an unsigned long
> alignment field.
> 
> New versions of UBSAN call __ubsan_handle_type_mismatch_v1, which is
> similar to __ubsan_handle_type_mismatch, but takes a different struct
> where the alignment is stored in an unsigned char (as log2 of the
> alignment). All other fields are unchanged.
> 
> As we don't implement __ubsan_handle_type_mismatch_v1, the kernel will
> fail to link when compiled with compilers using the new ABI (e.g. clang
> form the LLVM 5.0.0 release).
> 
> This patch adds support for the new ABI. To keep things simple, we
> simply convert the new data format into the old format, and hand it on
> to the existing handlers.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
>  lib/ubsan.c | 14 ++++++++++++++
>  lib/ubsan.h |  7 +++++++
>  2 files changed, 21 insertions(+)
> 
> Andrey, does this look correct to you?

Almost.
Commit 42440c1f9911b4b7b8ba3dc4e90c1197bc561211 looks correct to me ;)

Copying ->location is wrong, because we use bit in location struct to suppress multiple
reports of the same location, see was_reported(). So in you case REPORTED_BIT will be set
on stack and original source_location remain unchanged.


> Are there any other new ABI bits that need to be plumbed in?
> 

ABI of __ubsan_handle_nonnull_return() changed as well, but it's never used in the kernel
and probably never will be. Thus I removed it, see bac7a1fff7926fb9891a18fe33650884b0e13e4
