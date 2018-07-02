Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C5FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DDC25DEC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2HtviZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DDC25DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeGBNi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:38:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34752 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeGBNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:38:24 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so4004747ois.1;
        Mon, 02 Jul 2018 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JnTvraTK0DXkU5l7VUmCoWk95sYShZjPH9F4JcBVF6k=;
        b=g2HtviZpuWzmc0PNgaQVveEWWox5dpw+9f3seI82eAyNBR2TUAqz09J9/zYa68fga9
         t3mLVAD2fIzWnIKA3hjaRsd9GsoHOMpoiGqNUIjlElYp5sruTDR9/SDmFeCJ6esbtVni
         xGENo5+eZkj2+Z+VKu1JWoPj/zfCWFETY23WxCDmtUugLR6JjD5rya6xwZXS3tHeawAN
         uoHDtXopqmBfQVrxLDnV0qe+wLzKDk34+RPFzJt+HW6Jh+ATwef+YDffEhj26jYZbwBF
         /ykYBya/4Lw7vaL/VbGj7KZEsQ6mZ7M3Bo17wQZQ0Dh525cJCgXhIutVoaRU+cLdgAQi
         /3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JnTvraTK0DXkU5l7VUmCoWk95sYShZjPH9F4JcBVF6k=;
        b=tz301JhQaWdtHDl8kBdX1JK4IMPQxhTKqCuklVl9PhOAaYqzD1UM6UBDx98mQkYkJk
         cVNp+S1JerKRrkPYh0lGuHAazOcYfZX1wuZ4K28t1rJn/EbvIFuLPCf1j4kYIF11+7sn
         Z3tOi1GKBWqo58AgG4CJ+ddePKwK/l93Tk5XHXmHKKYHVeZOVYEsIpbfVsehL7V0pljl
         Q+rkxS9Boe6U3Cwo/NgBZakLPWxzVm3CHoF2MegOrVknye67LlkQMeCO93oVDkm3lKtx
         KJIMtz8hw9tTIIuCRXQJdwQuNI68DFREDd4Hgo/YwIyZfm+8ThmdLA23XEa0c3l8YTT2
         zPvA==
X-Gm-Message-State: APt69E2LhSnr0jxYIuw4SHj3KR9JHPbn0yxrZHNMQV5gfFED/qigvtNc
        xQznRGnEoTwVQfx59CN5BLpAug==
X-Google-Smtp-Source: AAOMgpeix3NE8sefGuw9bNugByiV4U77MEzxcV8SftCpzY3kL7Gjj4o0DJT9KusDKzLQmlGCbYXYrA==
X-Received: by 2002:aca:c601:: with SMTP id w1-v6mr9861982oif.27.1530538702525;
        Mon, 02 Jul 2018 06:38:22 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y3-v6sm2785774oie.23.2018.07.02.06.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 06:38:21 -0700 (PDT)
Subject: Re: [PATCH] watchdog: add NMI handler for iTCO watchdog
To:     "Tian, Baofeng" <baofeng.tian@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0038B620BAC72941BCBF48AEB892976C02CADE7E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C063@shsmsx102.ccr.corp.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cf1a7c57-4b65-eba1-a420-103ab40f7103@roeck-us.net>
Date:   Mon, 2 Jul 2018 06:38:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1C063@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 01:15 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: add NMI handler for iTCO watchdog
> 
> Add a NMI handler in iTCO watchdog driver probe.
> When iTCO watchdog timeout, it gernerate a NMI interrupt.

generate

Does it always do that ? My understanding is that it has to be configured to do so.

> The NMI handler will be called when iTCO NMI interrupt triggered.
> 
> In the NMI handler, it will dump all cpu backtraces
> and call panic to continue reboot.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>

As with other patches, the e-mail address is messed up.

If I recall correctly, we already had a similar patch trying to introduce MNI handling
to the driver a long time ago. I don't recall why it did not make it in, but there
must be some caveat. Someone will have to look that up and explain why this submission
is different and works. It would be great if you can do that; otherwise I'll have to
do it. Given my time constraints, that may take a while.

> ---
>   drivers/watchdog/iTCO_wdt.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
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
>   /* Address definitions for the TCO */
> @@ -86,6 +88,11 @@
>   #define TCO2_CNT(p)    (TCOBASE(p) + 0x0a) /* TCO2 Control Register    */
>   #define TCOv2_TMR(p)   (TCOBASE(p) + 0x12) /* TCOv2 Timer Initial Value*/
> 
> +#define TCO_RLD_sub(base)    (base + 0x00) /* TCO Timer Reload/Curr. Value */
> +#define TCO1_STS_sub(base)   (base + 0x04) /* TCO1 Status Register     */
> +#define TCOv2_TMR_sub(base)  (base + 0x12) /* TCOv2 Timer Initial Value*/
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
>   static int heartbeat = WATCHDOG_TIMEOUT;  /* in seconds */
> @@ -422,6 +437,33 @@ static const struct watchdog_ops iTCO_wdt_ops = {
>        .get_timeleft =         iTCO_wdt_get_timeleft,
>   };
> 
> +static int iTCO_pretimeout(unsigned int cmd, struct pt_regs *unused_regs)
> +{
> +     resource_size_t tco_base_address;

What is the point of this variable ?

> +
> +     /* Prevent re-entrance */
> +     if (iTCO_wdt_sub.pretimeout_occurred)
> +           return NMI_HANDLED;
> +

This is odd and suggests that something may be wrong. There should
not be more than one NMI.

> +           tco_base_address = iTCO_wdt_sub.tco_base_address;

At the very least column alignment is wrong.

> +
> +     /* Check the NMI is from the TCO first expiration */
> +     if (inw(TCO1_STS_sub(tco_base_address)) & 0x8) {
> +           iTCO_wdt_sub.pretimeout_occurred = true;
> +
> +           /* Forward next expiration */
> +           outw(iTCO_wdt_sub.second_to_ticks, TCOv2_TMR_sub(tco_base_address));
> +           outw(0x01, TCO_RLD_sub(tco_base_address));
> +
> +           trigger_all_cpu_backtrace();

A wild guess is that arch_trigger_cpumask_backtrace() is not exported.
That means you can not call that function from here, and it strongly suggests
that the function is not supposed to be called from drivers, including
watchdog_drivers. Besides, panic() already triggers a backtrace.

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
> @@ -555,6 +597,17 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>              return ret;
>        }
> 
> +    /* init vars that used for nmi handler */
> +     iTCO_wdt_sub.iTCO_version = p->iTCO_version;
> +     iTCO_wdt_sub.second_to_ticks = seconds_to_ticks(p, 10);

Where does the 10 come from ? What is the rationale ?

> +     iTCO_wdt_sub.tco_base_address = TCOBASE(p);
> +
> +     ret = register_nmi_handler(NMI_LOCAL, iTCO_pretimeout, 0, "iTCO_wdt");
> +     if (ret != 0) {
> +           pr_err("cannot register nmi handler (err=%d)\n", ret);
> +           return ret;

Return an error and leave the watchdog driver registered ? That will cause some
nice crashes.

> +     }
> +
>        pr_info("initialized. heartbeat=%d sec (nowayout=%d)\n",
>              heartbeat, nowayout);
> 
> -- 
> 2.7.4
> 

