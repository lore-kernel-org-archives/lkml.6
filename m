Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbeBTC5s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 21:57:48 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:38857
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S932352AbeBTC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 21:57:47 -0500
X-ASG-Debug-ID: 1519095458-093b7e4b5084190001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "joe@perches.com" <joe@perches.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "andriy.shevchenko@linux.intel.com"
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "me@tobin.cc" <me@tobin.cc>, "pmladek@suse.com" <pmladek@suse.com>
CC: "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: =?utf-8?B?UmU6IFvmraTpgq7ku7blj6/og73lrZjlnKjpo47pmaldICBbUEFUQ0ggdjIg?=
 =?utf-8?B?Ny85XSBsaWIvdnNwcmludGY6IFJlcGxhY2Ugc3BhY2Ugd2l0aCAnXycgYmVm?=
 =?utf-8?Q?ore_crng_is_ready?=
Thread-Topic: =?utf-8?B?W+atpOmCruS7tuWPr+iDveWtmOWcqOmjjumZqV0gIFtQQVRDSCB2MiA3Lzld?=
 =?utf-8?B?IGxpYi92c3ByaW50ZjogUmVwbGFjZSBzcGFjZSB3aXRoICdfJyBiZWZvcmUg?=
 =?utf-8?Q?crng_is_ready?=
X-ASG-Orig-Subj: =?utf-8?B?UmU6IFvmraTpgq7ku7blj6/og73lrZjlnKjpo47pmaldICBbUEFUQ0ggdjIg?=
 =?utf-8?B?Ny85XSBsaWIvdnNwcmludGY6IFJlcGxhY2Ugc3BhY2Ugd2l0aCAnXycgYmVm?=
 =?utf-8?Q?ore_crng_is_ready?=
Thread-Index: AQHTp2ouQOd5OPbJyUybKlZnoH4zHaOsGBkA
Date: Tue, 20 Feb 2018 02:57:19 +0000
Message-ID: <1519095438.2772.13.camel@hxt-semitech.com>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180216210711.79901-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180216210711.79901-7-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.127.0.10]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E62FE53B5743F7488606A62503E2F002@hxt-semitech.com>
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1519095458
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4963 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_MV0113c
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.48101
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MV0113c        BSF_SC0_MV0113c
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1K2vrww018572

Hi, Andy,

Many thanks for the change. I am on Chinese New Year travel and slow
response. :-)

Thanks.
Shunyong.

On Fri, 2018-02-16 at 23:07 +0200, Andy Shevchenko wrote:
> From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> 
> Before crng is ready, output of "%p" composes of "(ptrval)" and
> left padding spaces for alignment as no random address can be
> generated. This seems a little strange when default string width
> is larger than strlen("(ptrval)").
> 
> For example, when irq domain names are built with "%p", the nodes
> under /sys/kernel/debug/irq/domains like this on AArch64 system,
> 
> [root@y irq]# ls domains/
> default                   irqchip@        (ptrval)-2
> irqchip@        (ptrval)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
> irqchip@        (ptrval)  irqchip@        (ptrval)-3
> \_SB_.TCS0.QIC0             \_SB_.TCS0.QIC2
> 
> The name "irqchip@        (ptrval)-2" is not so readable in console
> output.
> 
> This patch replaces space with readable "_" when output needs
> padding.
> Following is the output after applying the patch,
> 
> [root@y domains]# ls
> default                   irqchip@(____ptrval____)-2
> irqchip@(____ptrval____)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
> irqchip@(____ptrval____)  irqchip@(____ptrval____)-3  \_SB_.TCS0.QIC0
> \_SB_.TCS0.QIC2
> 
> There is same problem in some subsystem's dmesg output. Moreover,
> someone may call "%p" in a similar case. In addition, the timing of
> crng initialization done may vary on different system. So, the change
> is made in vsprintf.c.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 9004bbb3d84d..97be2d07297a 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1681,12 +1681,13 @@ early_initcall(initialize_ptr_random);
>  /* Maps a pointer to a 32 bit unique identifier. */
>  static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> printf_spec spec)
>  {
> +	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" :
> "(ptrval)";
>  	unsigned long hashval;
>  
>  	if (unlikely(!have_filled_random_ptr_key)) {
>  		spec.field_width = 2 * sizeof(ptr);
>  		/* string length must be less than default_width */
> -		return string(buf, end, "(ptrval)", spec);
> +		return string(buf, end, str, spec);
>  	}
>  
>  #ifdef CONFIG_64BIT
