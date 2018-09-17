Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C83ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCD5214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCD5214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeIQVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:48:50 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:59568 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727124AbeIQVsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:48:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 58C81100E86C5;
        Mon, 17 Sep 2018 16:20:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: juice17_2342588161703
X-Filterd-Recvd-Size: 3848
Received: from XPS-9350 (mc15636d0.tmodns.net [208.54.86.193])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Sep 2018 16:20:41 +0000 (UTC)
Message-ID: <fcec8bb6dd5bb0d9c18dc4d839dee9782ec8ac9d.camel@perches.com>
Subject: Re: [PATCH] staging: mt7621-mmc: Remove do {} while (0) loop for
 single statement macro
From:   Joe Perches <joe@perches.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?ISO-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 17 Sep 2018 09:20:39 -0700
In-Reply-To: <20180915131748.GA19661@nishad>
References: <20180915131748.GA19661@nishad>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-09-15 at 18:47 +0530, Nishad Kamdar wrote:
> This patch removes do {} while (0) loop for single statement macros.
> Issue found by checkpatch.

Some or all of this code is not used and should be deleted instead.

> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 7474f9ed7b5b..ec12a3a5a926 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -104,14 +104,10 @@ static int cd_active_low = 1;
>  /* gate means clock power down */
>  static int g_clk_gate = 0;
>  #define msdc_gate_clock(id) \
> -	do {					       \
> -		g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));	\
> -	} while (0)
> +	(g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN)))
>  /* not like power down register. 1 means clock on. */
>  #define msdc_ungate_clock(id) \
> -	do {					    \
> -		g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);	\
> -	} while (0)
> +	(g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN))
>  
>  // do we need sync object or not
>  void msdc_clk_status(int *status)
> @@ -170,9 +166,7 @@ static void msdc_clr_fifo(struct msdc_host *host)
>  	} while (0)
>  
>  #define msdc_irq_restore(val) \
> -	do {					\
> -		sdr_set_bits(host->base + MSDC_INTEN, val);	\
> -	} while (0)
> +	(sdr_set_bits(host->base + MSDC_INTEN, val))
>  
>  /* clock source for host: global */
>  #if defined(CONFIG_SOC_MT7620)
> @@ -186,26 +180,18 @@ static u32 hclks[] = {50000000}; /* +/- by chhung */
>  //    always keep the VMC on.
>  //============================================
>  #define msdc_vcore_on(host) \
> -	do {								\
> -		(void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD");	\
> -	} while (0)
> +	((void)hwPowerOn(MT65XX_POWER_LDO_VMC, VOL_3300, "SD"))
>  #define msdc_vcore_off(host) \
> -	do {								\
> -		(void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD");		\
> -	} while (0)
> +	((void)hwPowerDown(MT65XX_POWER_LDO_VMC, "SD"))
>  
>  //====================================
>  // the vdd output for card: global
>  //   always keep the VMCH on.
>  //====================================
>  #define msdc_vdd_on(host) \
> -	do {								\
> -		(void)hwPowerOn(MT65XX_POWER_LDO_VMCH, VOL_3300, "SD"); \
> -	} while (0)
> +	((void)hwPowerOn(MT65XX_POWER_LDO_VMCH, VOL_3300, "SD"))
>  #define msdc_vdd_off(host) \
> -	do {							\
> -		(void)hwPowerDown(MT65XX_POWER_LDO_VMCH, "SD"); \
> -	} while (0)
> +	((void)hwPowerDown(MT65XX_POWER_LDO_VMCH, "SD"))
>  
>  #define sdc_is_busy()          (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
>  #define sdc_is_cmd_busy()      (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
