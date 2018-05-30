Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeE3Nq6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:46:58 -0400
Received: from mail-ve1eur01on0071.outbound.protection.outlook.com ([104.47.1.71]:51264
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbeE3Nqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:46:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ivan.djelic@parrot.com;
Date: Wed, 30 May 2018 15:46:46 +0200
From: Ivan Djelic <ivan.djelic@parrot.com>
To: Kees Cook <keescook@chromium.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bch: Remove VLA usage
Message-ID: <20180530134645.GA31844@parrot.com>
References: <20180529224207.GA13354@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180529224207.GA13354@beast>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [62.23.167.188]
X-ClientProxiedBy: PR2P264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::27) To VI1PR10MB1743.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:802:33::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1743;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR10MB1743;3:/H2zAANnBe9FSnYx5AdenkUsBh5ASMoUIXwUiWjiaJaWOGb76hOOVwsgcSTVrKsmiSpdcvEOVPLMNg+nrFWZMWhp+sCRj1KKWrrBON6qsbhfcHxD9gfi3bxhL3p9L+8YyMSVBKiQ719hYC9t96e8MjKay7nX58DfDhaQCUFFB87m/vW+T2iIIZp7DIqbJHvVAQwqiiURXloAGQzLkgOj+dyVm21BVLErgwYB843ps0heoEiRc3Fl+37d19n35ycn;25:ubArcxvW/jaIf5S6wj/6Mn9eF933pQ0vUnIONoqJXLMiWTyavgvzUDoeUyB4Vgr+jjhaJL4NEkaRHkylDsIop6H+IaFSYVpLgyyUP0aFXZr5fPTZLIuWdOcDGrhBiVcFS5jAjzJyF8dwep2Qg3IbNWfnNLaRVxhyPlfDvT09tVa6/oO8rrvA/N2Tvn2YI0lNGalTZky739YJkIZTyp003ZqII+wdH5I9twplftLzBV0NsJF1NpbMy6lVIsMGxxZm7vM0ojJHDzP2Nqbc6p5AUbuVm4t+4ZrSNnTJrRR1+P5OIdCn7WrY7qnWjJ6CW/3v5WSsazqbqCgNZNQRxnN5rQ==;31:0fl1gr/FGb3F3Uou2Dbwzb34ASQafUQBchJSDNnY7bqYdlvIxsJtYab0ZkHVUKYoixXOATtoiMITQ2xPAfQnqJL/rd1v6CJo7h+rtFQcEbQrDyPZaNsm9r2y5Kn1Gclj8PLbXHWEheQB0fWrJJTL3Wvjgg00F6Jl4v9d1lyO6LijtW/CsQ/Kavyf1E0CXXIcuCkPU0VK2SEkseuKDcWtBailmSVqwe8uOYEIoK6wMQQ=
X-MS-TrafficTypeDiagnostic: VI1PR10MB1743:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR10MB1743;20:nPKXovrPq0+oSWbIVnoi4KqtRfQBlPN4q30lg6FJMIjTYxKPJUBgnEqkB/uZEAoE/jnyWDSaifzfKFYKh6UBKmom0EAd6V9tfizvF2XQhs8e0O0vrRRRivHnsmJ6vxgbVA2dTD4fmZpZpz5w+qkQtns8sg3ZFPonFbjnTTfDgozX+qSTJGyeeDZzCthmyxz3e/ZV2Pa6FRWK0TZ+AiMJOU721MAjhVTL4TIlHpftc+pHoWKXnmf6IFyjbJ8TIvhK1hiqiX13nwweJwLKAIF824pxuXr02BLu8dmYL5Za4+rN3zJJ0XPH2Kd5k4jXTsTlwFS/dvonB0c1e3vsbT7v8zk+c7jWkfLmYHxbIu1ag8Q=;4:BMdG0hSYBeeHTcDdlKyqwGE8VoZmTR2m43v7OAlIDvupmHgkhBg5eoa58ofKBWyUgYNN1iG+KbiFqYvG8HI32UhvOEWTlLfUjRsck3Qo82nsIYyDuFKm3pmBHOB6knh/r92VOWMRi6hmIe7SYluNbOrF3vbXF0MCZpAyF/e0QhZuDoPa0+45N+LEOTrbwfzwNsEnDn7vZlSwk6zK3mGR7jqmpqa5v5fJOIitoOEx57ilj/2G9mQTkWuGmW/vd9oWXgcoVcmM9tfbzQFJxOwKPSrJTRkfC0/OvGlg7Y77BxxTpHaLFssOLXUO4ZudpPCmHqMI2tNqf75rumnbHZ86NDEYho+wvLzoiKLJBsjWIFPL3a+EGTyuLbhNH6SYfXTsafbTJGPCPxVmnocCR/LAbsTCyea8nsywKGO66UhSMfDkKb/523fhVTqQAu0cFlMI
X-Microsoft-Antispam-PRVS: <VI1PR10MB17438DA51D666C46D945FF718C6C0@VI1PR10MB1743.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(85827821059158)(788757137089)(42068640409301)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR10MB1743;BCL:0;PCL:0;RULEID:;SRVR:VI1PR10MB1743;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(366004)(376002)(346002)(39380400002)(189003)(199004)(2616005)(956004)(54906003)(55236004)(5660300001)(33026002)(11346002)(36756003)(81156014)(8676002)(81166006)(69596002)(86362001)(68736007)(44832011)(446003)(305945005)(6916009)(486006)(26005)(476003)(2870700001)(58126008)(66066001)(33656002)(478600001)(186003)(386003)(2906002)(59450400001)(966005)(316002)(47776003)(39060400002)(52116002)(23676004)(2486003)(52146003)(7696005)(76176011)(25786009)(21086003)(16526019)(105586002)(106356001)(53936002)(6246003)(4326008)(8936002)(6306002)(3846002)(7736002)(229853002)(1076002)(6116002)(55016002)(50466002)(97736004)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1743;H:parrot.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjEwTUIxNzQzOzIzOlNUbmt2SmNzdHMvcGprUU5UUlRqVytJQ0dy?=
 =?utf-8?B?ditQTTgySVptbnJzeXlNNklyakl4RjkwQlorUkZRQXJ2TCtXU0U5QXFRMHFn?=
 =?utf-8?B?NjFpQTVURU15U3puOC9ralZ0TXJBVVUybE9DQ2NuaUljNlNrU3ZGSjB1U0NM?=
 =?utf-8?B?OG9nT3Vua01mTCt6Z3NVVk8xdFZ3STNqcjY0R2dsWWdxOGZoejFtUU42bmtN?=
 =?utf-8?B?bUt0OVh2bG1tcElaL0ZGSjNEeFhTRjVyR3F4WmltUVBrQUJzRk4vemNvOTE3?=
 =?utf-8?B?eUpiOFR3eWU2bDd6aGp2WkI1OVdleHFuQW1sWTM5ckNVNWZzbkF1L0M0QjR3?=
 =?utf-8?B?b2psOGw0UVVaVENoRm9EOFRCb013TUFwbTVEdDlmQUpScHEzcG9pSHZ5MzJH?=
 =?utf-8?B?YlEvS3FITnhjSVExM2ZNdHF5Q0lodzNJZ2pSRWp6LzExSDdQbzZTZVRJOThn?=
 =?utf-8?B?RTI0TXpxd0NaNGRMZzA4VzRLbzNveGNRcFUxRXMxcEV6dXk4WXllZ0xyTnUv?=
 =?utf-8?B?RHJjWUZwR1ZhMENIV01UaU1zNW1FcWtsYkZqZ1pubUpuRExqSXRuYjlmcUl4?=
 =?utf-8?B?cUN6Q3N0ZFNzQjBVWkdRSCtEL1c2eE9ESU5FNVB6YlFuOUFibVhsS3htdFMy?=
 =?utf-8?B?OUdUYnVuOUU0VWlrU2hDMFNXQmlvNXJCS0dROWtBUWhOUnM1SmRuYTNMbTRS?=
 =?utf-8?B?RXoySXpPVmNIdWV0UURYYmFpOCtFNkp6a2lZM1BXaXdrYVNtZlp3VzBCaWJH?=
 =?utf-8?B?dU4xWkN6WGo1eDdLWFFxOUJleWFNOWdzRTRQNFg5N0JSSlJLMUh5T01aRWpl?=
 =?utf-8?B?UE13M0d5QlB6eWtWcncvc3lXdUpMdURCMW1iVThRY05TaEQ5ZTBlamlYQXN0?=
 =?utf-8?B?cXFLTG93WXBRZEE1K0dwdjYwQ0tidGRWUWw0STJFZTlkODVqem8rWVYvcVpK?=
 =?utf-8?B?QWxVVnNZWXQxSExJQXpXbnRsNzlQWUV4WEtNRklCb3p6M2psTkN2Y3Bsbisy?=
 =?utf-8?B?RGRLNmlvSFA1Zm9zR1hINzhYWHBtUGU1dHl1eGJLZjZaOWdlVjAyeGdQT0o1?=
 =?utf-8?B?eFZNZGN1NVp5WStseExSZm90bDBNaGNhdUdXRXNMSktObjFOWjdYU0l4U1pC?=
 =?utf-8?B?L3NWWkJPMFpKYkNySEt4RGJsRUo5c3hlVkhsdDhGUnZBTjhGcEhtUGtqOTVF?=
 =?utf-8?B?bStQc0VzVVBYakVZNXo3RWkyZ1o2UDVKbjVuZzMwL2s4TlRpS1dCTTB4cGIv?=
 =?utf-8?B?MVRVeWVJaHpxaFVnYm1NOGtFaHdnWitKQ1pId0VtZlE2SWdXRlBsOTJaWTJp?=
 =?utf-8?B?MC9Pa3NKN29GV3kzMzFYUTNEK2Q0V2RlMXFyMzA0dnNuYTdNUGZmODQvNnQy?=
 =?utf-8?B?UTIrRFNyUzVEcFBjaFg4WHAxY0RNVDRDVzVIMm4vM1AwTCt2bEIvRU1nM043?=
 =?utf-8?B?SDg5a0ZKUlBsTEp5eXdVUUlKSDR2NjFHeGZtYXBuckpCaEhmWjNXRWlqaDVC?=
 =?utf-8?B?eVRQRnlQeWV6d0t3TTlZOEdkaHlCSDcxUTdLaUlCV3J5M1JSL082aGxRcmtQ?=
 =?utf-8?B?NDVlM01nZjd5RERoSG5BVXBqSHRJdGJzWEliQzZXalN4d3RvVmZrOFIrMm5w?=
 =?utf-8?B?WGNRNFhnOUlMbGxONXprWVlGdkQwdDcrZW8xRkVYRWp4bU5QdzlKdFppUUMz?=
 =?utf-8?B?TExvVVpSTExGYkxzUlVMK1E4MEVwRlJSams1REJHL2h1bGZvaDBFU2VWR0Jt?=
 =?utf-8?B?cjFMcStMS2dTb3lZMEZteXFzR0F0QWZXVW52MTY3bW9SZWRuQzd6bnFXVXRW?=
 =?utf-8?B?RW5WYnovdFhDTDFwZVY3aldxUk4wWTZqbFFFVUg3MXRLQ29mYUJ1RmVVUE9x?=
 =?utf-8?B?UlM4ME9kK1RnSi9iZEx3TmlFVzVqWkxIR0NaQWZxb2dmQzl0MGhHalpXSXMw?=
 =?utf-8?B?WGd4QWEwS0Uwa0lGWHlSRUozMWRVTG1aemY5SmpCNTJaRFpQdjRkcHJpRjhr?=
 =?utf-8?B?QlVSUlFsV08zUWVQL05pcnVZRU9TTDN4NDBwUT09?=
X-Microsoft-Antispam-Message-Info: Ff0VBxtrxM/QO9ykJXXZvVnHfqNZ/j+bCd1dJqSCsByufrc6uVqwnPx3eyE78gcdxwaojDB+74d5sjEEqiiUCt+DIpLSeVRDVhx2Er1t2KI2+c3g4vKOPUOZXMlZCEhBrM8YzgDp28KKbU5ileaH91RURPAxbWmydlS1CcNDmdlzlb/LVcnzxdsaCHp7+y7f
X-Microsoft-Exchange-Diagnostics: 1;VI1PR10MB1743;6:ykhB9EioPbql6Hb7hbTUY/z2zzgY8/3U3U/VeNKnlxr0Hya3xp26Ju1HjgiHkFb32kVPw7IC+yA5mOL9Cy+Ti+JPMhiYfPNikFcNcaYvYimSBXEgLk+ie9hyUsuPBDFt0iBXhcUe8qPK7h8SFsFczVi+lXAtS4Xy4uhWBJjpF4GfAGT/XFTzjZX2c0eXVnKoCzUgF+wraK8zwsuYWZYwHT5DMNY8Ye/FFGDuukU0vpjnTlrBqvGXE7eWfJy0bz+LtuoFHp3co9AJklJo+QIoTIztldO6zBxDJ9Y5bn5hznFkVMimzCPl9GGtIGXGdONTQQT4tKpoZFGxZh7K9LNvw/kX5UFqqUsmENa6vhNH3+Foy4Mk+gXHptXUXbZJByz9D0SP/zlszuaNrGWN+Oaou1G9WpgtK6LzIXIL04Y3jPF2hvTuf8O9TpFWZHhItKzYgkKDT7pw3TTwmlCdfnseLA==;5:ZXmL7nfe2FkhvakfDKPeRJQO7M4n/FFiRs77pk5UnYbKaXhDlntd5CqJQ7XyZKCTSis+5bMp0E1uAB+ibkNtQopoKAl83cezEJ4oIwI4263GFhvmE2XUkXQSe6mMXwy72iQgqluKvuFcPgddFSl3kN+SELYnKwDw11HAFHaJicM=;24:lRrOUkuQTi/u/8e5lizWcTHufJC6cyfMx0gI5UwxQHc/nsoNp/0NCj9HbR9RZgO2ij/lWZOlYFUWzEzPs/Lso8kAY264FajaXfIsetjFLeQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR10MB1743;7:9USSCTraLT3BKn+OSLIqBHKzG/+n3ZyUFQpfC3kInLenwPQOUaqEhNfVjMEbpK1d/QCqgrwum0A18GPP7Lze8O/R/pZ6P/cLNCWaJ4N7jy/qIGnz3pB4oydSBl2o6pfXLpAOhOjFVxtJL7H6J9P+O66szGpA8oCbDGtsVz5abNJ/l8NYYITA7uUZ64YBM9rnjfGNrRDPwko7zagt2FAfUeREUgSPUAkhanYMxD0hGiHMZq7ALMiZWZnO8uWyb36b
X-MS-Office365-Filtering-Correlation-Id: 225666ec-1568-4a0b-e786-08d5c633ca80
X-OriginatorOrg: parrot.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 13:46:48.3839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225666ec-1568-4a0b-e786-08d5c633ca80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff7d991b-3922-4803-8418-ab806a3414a6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1743
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:42:07PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this removes
> the on-stack working buffers in favor of pre-allocated working buffers
> (which were already used in other places). Since these routines must
> already be serialized (since they work on bch->ecc_buf), adding the usage
> of bch->ecc_work would be similarly safe. Additionally, since "max m" is
> only 15, this was adjusted to just use a fixed size array in those cases.

Hi Kees,

Using an on-stack buffer instead of a pre-allocated buffer was done initially
for performance reasons.  For "usual" (m,t) values (for instance m=13, t=4),
there is a huge performance difference between the on-stack buffer version and
the kmalloc version. I didn't investigate the reason for this, but I ran a
quick benchmark on my PC:

little-endian, type sizes: int=4 long=8 longlong=8
cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
calibration: iter=4.9143µs niter=2034 nsamples=200 m=13 t=4

  Buffer allocation |  Encoding throughput (Mbit/s)
---------------------------------------------------
 on-stack, VLA      |   3988
 on-stack, fixed    |   4494
 kmalloc            |   1967

The first line shows the performance of the current code, using a VLA.
The second line shows the performance when r[] is allocated on the stack with
a fixed, constant size (the maximum allowed value).
The third line shows the performance when r is a pre-allocated working buffer.

In fact, when using a pre-allocated buffer there is no need to introduce 'ecc_work':
you can directly point 'r' to bch->ecc_buf and remove memcpy() surrounding the
'while (mlen--)' loop. Everything happens inside the 'bch->ecc_buf' buffer.
But with a big performance penalty. Looks like declaring a temporary buffer on the
stack to store ECC values allows GCC to do a better job at optimizing the loop.

So rather than introducing 'ecc_work', I suggest we compute the maximum allowed
size for r[] and use that:

sizeof(r) = sizeof(uint32_t)*(l+1)
l+1 = BCH_ECC_WORDS(bch) = DIV_ROUND_UP(m*t, 32)

We also know that:

m*t < 2^m - 1 (ECC maximum size)

therefore:

l+1 < DIV_ROUND_UP(2^m - 1, 32) < 2^(m-5)

So instead of 'uint32_t r[l+1]' we could declare 'uint32_t r[1 << (BCH_MAX_M-5)]'.
And replace 'sizeof(r)' with 'sizeof(*bch->ecc_buf)*(l+1)' in memset/memcpy calls.
In practice the actual maximum size of r[] is (1 << (15-5))*sizeof(uint32_t) = 4096 bytes.

What do you think ?
--
Ivan
 




> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is directed at linux-mtd because it's the only user of this library
> and it's how it originally entered the kernel tree...
> ---
>  include/linux/bch.h |  4 ++--
>  lib/bch.c           | 27 +++++++++++++++------------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/bch.h b/include/linux/bch.h
> index 295b4ef153bb..4d46e6a73319 100644
> --- a/include/linux/bch.h
> +++ b/include/linux/bch.h
> @@ -39,7 +39,7 @@
>   * @a_log_tab:  Galois field GF(2^m) log lookup table
>   * @mod8_tab:   remainder generator polynomial lookup tables
>   * @ecc_buf:    ecc parity words buffer
> - * @ecc_buf2:   ecc parity words buffer
> + * @ecc_work:   ecc parity words working buffer
>   * @xi_tab:     GF(2^m) base for solving degree 2 polynomial roots
>   * @syn:        syndrome buffer
>   * @cache:      log-based polynomial representation buffer
> @@ -57,7 +57,7 @@ struct bch_control {
>  	uint16_t       *a_log_tab;
>  	uint32_t       *mod8_tab;
>  	uint32_t       *ecc_buf;
> -	uint32_t       *ecc_buf2;
> +	uint32_t       *ecc_work;
>  	unsigned int   *xi_tab;
>  	unsigned int   *syn;
>  	int            *cache;
> diff --git a/lib/bch.c b/lib/bch.c
> index bc89dfe4d1b3..f14eac93ecc4 100644
> --- a/lib/bch.c
> +++ b/lib/bch.c
> @@ -78,10 +78,12 @@
>  #define GF_M(_p)               (CONFIG_BCH_CONST_M)
>  #define GF_T(_p)               (CONFIG_BCH_CONST_T)
>  #define GF_N(_p)               ((1 << (CONFIG_BCH_CONST_M))-1)
> +#define BCH_MAX_M              (CONFIG_BCH_CONST_M)
>  #else
>  #define GF_M(_p)               ((_p)->m)
>  #define GF_T(_p)               ((_p)->t)
>  #define GF_N(_p)               ((_p)->n)
> +#define BCH_MAX_M              15
>  #endif
>  
>  #define BCH_ECC_WORDS(_p)      DIV_ROUND_UP(GF_M(_p)*GF_T(_p), 32)
> @@ -187,7 +189,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
>  	const unsigned int l = BCH_ECC_WORDS(bch)-1;
>  	unsigned int i, mlen;
>  	unsigned long m;
> -	uint32_t w, r[l+1];
> +	uint32_t w;
>  	const uint32_t * const tab0 = bch->mod8_tab;
>  	const uint32_t * const tab1 = tab0 + 256*(l+1);
>  	const uint32_t * const tab2 = tab1 + 256*(l+1);
> @@ -198,7 +200,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
>  		/* load ecc parity bytes into internal 32-bit buffer */
>  		load_ecc8(bch, bch->ecc_buf, ecc);
>  	} else {
> -		memset(bch->ecc_buf, 0, sizeof(r));
> +		memset(bch->ecc_work, 0, bch->ecc_bytes);
>  	}
>  
>  	/* process first unaligned data bytes */
> @@ -215,7 +217,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
>  	mlen  = len/4;
>  	data += 4*mlen;
>  	len  -= 4*mlen;
> -	memcpy(r, bch->ecc_buf, sizeof(r));
> +	memcpy(bch->ecc_work, bch->ecc_buf, bch->ecc_bytes);
>  
>  	/*
>  	 * split each 32-bit word into 4 polynomials of weight 8 as follows:
> @@ -229,6 +231,8 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
>  	 * xxxxxxxx  yyyyyyyy  zzzzzzzz  tttttttt  mod g = r0^r1^r2^r3
>  	 */
>  	while (mlen--) {
> +		uint32_t *r = bch->ecc_work;
> +
>  		/* input data is read in big-endian format */
>  		w = r[0]^cpu_to_be32(*pdata++);
>  		p0 = tab0 + (l+1)*((w >>  0) & 0xff);
> @@ -241,7 +245,7 @@ void encode_bch(struct bch_control *bch, const uint8_t *data,
>  
>  		r[l] = p0[l]^p1[l]^p2[l]^p3[l];
>  	}
> -	memcpy(bch->ecc_buf, r, sizeof(r));
> +	memcpy(bch->ecc_buf, bch->ecc_work, bch->ecc_bytes);
>  
>  	/* process last unaligned bytes */
>  	if (len)
> @@ -434,7 +438,7 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
>  {
>  	const int m = GF_M(bch);
>  	unsigned int tmp, mask;
> -	int rem, c, r, p, k, param[m];
> +	int rem, c, r, p, k, param[BCH_MAX_M];
>  
>  	k = 0;
>  	mask = 1 << m;
> @@ -1009,10 +1013,10 @@ int decode_bch(struct bch_control *bch, const uint8_t *data, unsigned int len,
>  		}
>  		/* load received ecc or assume it was XORed in calc_ecc */
>  		if (recv_ecc) {
> -			load_ecc8(bch, bch->ecc_buf2, recv_ecc);
> +			load_ecc8(bch, bch->ecc_work, recv_ecc);
>  			/* XOR received and calculated ecc */
>  			for (i = 0, sum = 0; i < (int)ecc_words; i++) {
> -				bch->ecc_buf[i] ^= bch->ecc_buf2[i];
> +				bch->ecc_buf[i] ^= bch->ecc_work[i];
>  				sum |= bch->ecc_buf[i];
>  			}
>  			if (!sum)
> @@ -1114,7 +1118,7 @@ static int build_deg2_base(struct bch_control *bch)
>  {
>  	const int m = GF_M(bch);
>  	int i, j, r;
> -	unsigned int sum, x, y, remaining, ak = 0, xi[m];
> +	unsigned int sum, x, y, remaining, ak = 0, xi[BCH_MAX_M];
>  
>  	/* find k s.t. Tr(a^k) = 1 and 0 <= k < m */
>  	for (i = 0; i < m; i++) {
> @@ -1254,7 +1258,6 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
>  	struct bch_control *bch = NULL;
>  
>  	const int min_m = 5;
> -	const int max_m = 15;
>  
>  	/* default primitive polynomials */
>  	static const unsigned int prim_poly_tab[] = {
> @@ -1270,7 +1273,7 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
>  		goto fail;
>  	}
>  #endif
> -	if ((m < min_m) || (m > max_m))
> +	if ((m < min_m) || (m > BCH_MAX_M))
>  		/*
>  		 * values of m greater than 15 are not currently supported;
>  		 * supporting m > 15 would require changing table base type
> @@ -1300,7 +1303,7 @@ struct bch_control *init_bch(int m, int t, unsigned int prim_poly)
>  	bch->a_log_tab = bch_alloc((1+bch->n)*sizeof(*bch->a_log_tab), &err);
>  	bch->mod8_tab  = bch_alloc(words*1024*sizeof(*bch->mod8_tab), &err);
>  	bch->ecc_buf   = bch_alloc(words*sizeof(*bch->ecc_buf), &err);
> -	bch->ecc_buf2  = bch_alloc(words*sizeof(*bch->ecc_buf2), &err);
> +	bch->ecc_work  = bch_alloc(words*sizeof(*bch->ecc_work), &err);
>  	bch->xi_tab    = bch_alloc(m*sizeof(*bch->xi_tab), &err);
>  	bch->syn       = bch_alloc(2*t*sizeof(*bch->syn), &err);
>  	bch->cache     = bch_alloc(2*t*sizeof(*bch->cache), &err);
> @@ -1349,7 +1352,7 @@ void free_bch(struct bch_control *bch)
>  		kfree(bch->a_log_tab);
>  		kfree(bch->mod8_tab);
>  		kfree(bch->ecc_buf);
> -		kfree(bch->ecc_buf2);
> +		kfree(bch->ecc_work);
>  		kfree(bch->xi_tab);
>  		kfree(bch->syn);
>  		kfree(bch->cache);
> -- 
> 2.17.0
> 
> 
> -- 
> Kees Cook
> Pixel Security
