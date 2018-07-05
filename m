Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0D7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A0B241AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A0B241AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeGEGnO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:43:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:51078 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753248AbeGEGnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:43:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="64298896"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2018 23:43:08 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 23:43:08 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.17]) with mapi id 14.03.0319.002;
 Thu, 5 Jul 2018 14:43:06 +0800
From:   "Tian, Baofeng" <baofeng.tian@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: add NMI handler for iTCO watchdog
Thread-Topic: [PATCH] watchdog: add NMI handler for iTCO watchdog
Thread-Index: AdQR2Ga3hra1U24uToWFq6FmcIVt/gABEckg///UZgD/+zkeUA==
Date:   Thu, 5 Jul 2018 06:43:06 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D57@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE7E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C063@shsmsx102.ccr.corp.intel.com>
 <cf1a7c57-4b65-eba1-a420-103ab40f7103@roeck-us.net>
In-Reply-To: <cf1a7c57-4b65-eba1-a420-103ab40f7103@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDI1ZGFkZDQtYzQ3Ny00N2M1LWIwNTctMzUzMzllYTcwMjEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia2dtU3NTSlROMkdZU0FTS08wMFlVT1RtMUgxVEp3NTkzZ3hEWGxpUlwvb1h5NEM1VXVxYVZOUWpORmpEUVRHS3cifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roeck

Yes, as long as NMI interrupt generated, this handler will be called before reboot.
We have another patch to handle NMI generation on X86 platform, it use perf event to generate NMI in TCO WDT driver. 
Will submit later.

Thanks
Tim

-----Original Message-----
From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
Sent: Monday, July 2, 2018 9:38 PM
To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add NMI handler for iTCO watchdog

On 07/02/2018 01:15 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com 
> <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: add NMI handler for iTCO watchdog
> 
> Add a NMI handler in iTCO watchdog driver probe.
> When iTCO watchdog timeout, it gernerate a NMI interrupt.

generate

Does it always do that ? My understanding is that it has to be configured to do so.

> The NMI handler will be called when iTCO NMI interrupt triggered.
> 
> In the NMI handler, it will dump all cpu backtraces and call panic to 
> continue reboot.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com 
> <mailto:baofeng.tian@intel.com>>

As with other patches, the e-mail address is messed up.

If I recall correctly, we already had a similar patch trying to introduce MNI handling to the driver a long time ago. I don't recall why it did not make it in, but there must be some caveat. Someone will have to look that up and explain why this submission is different and works. It would be great if you can do that; otherwise I'll have to do it. Given my time constraints, that may take a while.

> ---
>   drivers/watchdog/iTCO_wdt.c | 53 
> +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c 
> index 347f038..7a79d0f 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -68,6 +68,8 @@
>   #include <linux/io.h>              /* For inb/outb/... */
>   #include <linux/platform_data/itco_wdt.h>
> 
> +#include <linux/nmi.h>
> +#include <asm/nmi.h>
>   #include "iTCO_vendor.h"
> 
>   /* Address definitions for the TCO */ @@ -86,6 +88,11 @@
>   #define TCO2_CNT(p)    (TCOBASE(p) + 0x0a) /* TCO2 Control Register    
> */
>   #define TCOv2_TMR(p)   (TCOBASE(p) + 0x12) /* TCOv2 Timer Initial 
> Value*/
> 
> +#define TCO_RLD_sub(base)    (base + 0x00) /* TCO Timer Reload/Curr. 
> +Value */ #define TCO1_STS_sub(base)   (base + 0x04) /* TCO1 Status 
> +Register     */ #define TCOv2_TMR_sub(base)  (base + 0x12) /* TCOv2 
> +Timer Initial Value*/
> +
> +
>   /* internal variables */
>   struct iTCO_wdt_private {
>        struct watchdog_device wddev;
> @@ -112,6 +119,14 @@ struct iTCO_wdt_private {
>        int (*update_no_reboot_bit)(void *p, bool set);
>   };
> 
> +static struct {
> +     resource_size_t tco_base_address;
> +     unsigned int iTCO_version;

Where is this variable used ?

> +     bool pretimeout_occurred;
> +     unsigned int second_to_ticks;

What is the point of this variable ? It is used as constant.

> +} iTCO_wdt_sub;
> +
> +

Checkpatch should tell you to avoid more than one empty line.

>   /* module parameters */
>   #define WATCHDOG_TIMEOUT 30  /* 30 sec default heartbeat */
>   static int heartbeat = WATCHDOG_TIMEOUT;  /* in seconds */ @@ -422,6 
> +437,33 @@ static const struct watchdog_ops iTCO_wdt_ops = {
>        .get_timeleft =         iTCO_wdt_get_timeleft,
>   };
> 
> +static int iTCO_pretimeout(unsigned int cmd, struct pt_regs 
> +*unused_regs) {
> +     resource_size_t tco_base_address;

What is the point of this variable ?

> +
> +     /* Prevent re-entrance */
> +     if (iTCO_wdt_sub.pretimeout_occurred)
> +           return NMI_HANDLED;
> +

This is odd and suggests that something may be wrong. There should not be more than one NMI.

> +           tco_base_address = iTCO_wdt_sub.tco_base_address;

At the very least column alignment is wrong.

> +
> +     /* Check the NMI is from the TCO first expiration */
> +     if (inw(TCO1_STS_sub(tco_base_address)) & 0x8) {
> +           iTCO_wdt_sub.pretimeout_occurred = true;
> +
> +           /* Forward next expiration */
> +           outw(iTCO_wdt_sub.second_to_ticks, 
> +TCOv2_TMR_sub(tco_base_address));
> +           outw(0x01, TCO_RLD_sub(tco_base_address));
> +
> +           trigger_all_cpu_backtrace();

A wild guess is that arch_trigger_cpumask_backtrace() is not exported.
That means you can not call that function from here, and it strongly suggests that the function is not supposed to be called from drivers, including watchdog_drivers. Besides, panic() already triggers a backtrace.

> +           panic_timeout = 0;
> +           panic("Kernel Watchdog");
> +           return NMI_HANDLED;
> +     }
> +
> +     return NMI_DONE;
> +}
> +
>   /*
>    *   Init & exit routines
>    */
> @@ -555,6 +597,17 @@ static int iTCO_wdt_probe(struct platform_device 
> *pdev)
>              return ret;
>        }
> 
> +    /* init vars that used for nmi handler */
> +     iTCO_wdt_sub.iTCO_version = p->iTCO_version;
> +     iTCO_wdt_sub.second_to_ticks = seconds_to_ticks(p, 10);

Where does the 10 come from ? What is the rationale ?

> +     iTCO_wdt_sub.tco_base_address = TCOBASE(p);
> +
> +     ret = register_nmi_handler(NMI_LOCAL, iTCO_pretimeout, 0, 
> +"iTCO_wdt");
> +     if (ret != 0) {
> +           pr_err("cannot register nmi handler (err=%d)\n", ret);
> +           return ret;

Return an error and leave the watchdog driver registered ? That will cause some nice crashes.

> +     }
> +
>        pr_info("initialized. heartbeat=%d sec (nowayout=%d)\n",
>              heartbeat, nowayout);
> 
> --
> 2.7.4
> 

