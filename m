Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F936C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C1C20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Mf/qPalz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfBEAUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:20:24 -0500
Received: from vern.gendns.com ([98.142.107.122]:58966 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfBEAUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bQJwCPwRuCTQSo9mQctEi0X/I+I2GRQgR7Nl0ve1TRQ=; b=Mf/qPalzFR0iRDZ4WE82VKaevq
        1U4HaHJchPIbDh160tc5hsaTgbnQdfrWz+Lvon5YE5yW5yBX7lTiZ8I5C5E76ots/QSqepUxVEUIS
        cg2ea0ncln3otDvDObACOunyUJ+Efya1It0BDx7KVkPY+v6dSWCxU13xh1l588CgN8KtIrY44nL3R
        LM86vMENm66cnSupFV47tSz+doJjgqskTYCuObr91BRYeAsi0YJSeSiiB9K26H+yxwhaT3qO+rK1F
        BEGGl1tt6Sv16bZ9k0SXCz+mWNxPJekWMJDQnOuDHPaRP7EtLcJxpNnuPk396XQfNk2uDCicF7Tde
        A+BVnG/g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60228 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqoPt-0006vT-2h; Mon, 04 Feb 2019 19:16:45 -0500
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from
 default_priorites
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-6-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <28694e1b-415a-d53f-f2e5-ba2a407fa88c@lechnology.com>
Date:   Mon, 4 Feb 2019 18:20:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to select SPARSE_IRQ we need to make the interrupt numbers
> dynamic (at least at build-time for the top-level controller). The
> interrupt numbers are used as array indexes for irq priorities.
> 
> Drop the defines and just initialize the arrays in a linear manner.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/da830.c  | 107 ++++--------------------------
>   arch/arm/mach-davinci/da850.c  | 118 +++++----------------------------
>   arch/arm/mach-davinci/dm355.c  |  74 +++------------------
>   arch/arm/mach-davinci/dm365.c  |  76 +++------------------
>   arch/arm/mach-davinci/dm644x.c |  76 +++------------------
>   arch/arm/mach-davinci/dm646x.c |  76 +++------------------
>   6 files changed, 69 insertions(+), 458 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 9e18b245266b..f1e7b6c644e5 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -624,98 +624,19 @@ const short da830_eqep1_pins[] __initconst = {
>   };
>   
>   /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
> -static u8 da830_default_priorities[DA830_N_CP_INTC_IRQ] = {
> -	[IRQ_DA8XX_COMMTX]		= 7,
> -	[IRQ_DA8XX_COMMRX]		= 7,
> -	[IRQ_DA8XX_NINT]		= 7,
> -	[IRQ_DA8XX_EVTOUT0]		= 7,
> -	[IRQ_DA8XX_EVTOUT1]		= 7,
> -	[IRQ_DA8XX_EVTOUT2]		= 7,
> -	[IRQ_DA8XX_EVTOUT3]		= 7,
> -	[IRQ_DA8XX_EVTOUT4]		= 7,
> -	[IRQ_DA8XX_EVTOUT5]		= 7,
> -	[IRQ_DA8XX_EVTOUT6]		= 7,
> -	[IRQ_DA8XX_EVTOUT7]		= 7,
> -	[IRQ_DA8XX_CCINT0]		= 7,
> -	[IRQ_DA8XX_CCERRINT]		= 7,
> -	[IRQ_DA8XX_TCERRINT0]		= 7,
> -	[IRQ_DA8XX_AEMIFINT]		= 7,
> -	[IRQ_DA8XX_I2CINT0]		= 7,
> -	[IRQ_DA8XX_MMCSDINT0]		= 7,
> -	[IRQ_DA8XX_MMCSDINT1]		= 7,
> -	[IRQ_DA8XX_ALLINT0]		= 7,
> -	[IRQ_DA8XX_RTC]			= 7,
> -	[IRQ_DA8XX_SPINT0]		= 7,
> -	[IRQ_DA8XX_TINT12_0]		= 7,
> -	[IRQ_DA8XX_TINT34_0]		= 7,
> -	[IRQ_DA8XX_TINT12_1]		= 7,
> -	[IRQ_DA8XX_TINT34_1]		= 7,
> -	[IRQ_DA8XX_UARTINT0]		= 7,
> -	[IRQ_DA8XX_KEYMGRINT]		= 7,
> -	[IRQ_DA830_MPUERR]		= 7,
> -	[IRQ_DA8XX_CHIPINT0]		= 7,
> -	[IRQ_DA8XX_CHIPINT1]		= 7,
> -	[IRQ_DA8XX_CHIPINT2]		= 7,
> -	[IRQ_DA8XX_CHIPINT3]		= 7,
> -	[IRQ_DA8XX_TCERRINT1]		= 7,
> -	[IRQ_DA8XX_C0_RX_THRESH_PULSE]	= 7,
> -	[IRQ_DA8XX_C0_RX_PULSE]		= 7,
> -	[IRQ_DA8XX_C0_TX_PULSE]		= 7,
> -	[IRQ_DA8XX_C0_MISC_PULSE]	= 7,
> -	[IRQ_DA8XX_C1_RX_THRESH_PULSE]	= 7,
> -	[IRQ_DA8XX_C1_RX_PULSE]		= 7,
> -	[IRQ_DA8XX_C1_TX_PULSE]		= 7,
> -	[IRQ_DA8XX_C1_MISC_PULSE]	= 7,
> -	[IRQ_DA8XX_MEMERR]		= 7,
> -	[IRQ_DA8XX_GPIO0]		= 7,
> -	[IRQ_DA8XX_GPIO1]		= 7,
> -	[IRQ_DA8XX_GPIO2]		= 7,
> -	[IRQ_DA8XX_GPIO3]		= 7,
> -	[IRQ_DA8XX_GPIO4]		= 7,
> -	[IRQ_DA8XX_GPIO5]		= 7,
> -	[IRQ_DA8XX_GPIO6]		= 7,
> -	[IRQ_DA8XX_GPIO7]		= 7,
> -	[IRQ_DA8XX_GPIO8]		= 7,
> -	[IRQ_DA8XX_I2CINT1]		= 7,
> -	[IRQ_DA8XX_LCDINT]		= 7,
> -	[IRQ_DA8XX_UARTINT1]		= 7,
> -	[IRQ_DA8XX_MCASPINT]		= 7,
> -	[IRQ_DA8XX_ALLINT1]		= 7,
> -	[IRQ_DA8XX_SPINT1]		= 7,
> -	[IRQ_DA8XX_UHPI_INT1]		= 7,
> -	[IRQ_DA8XX_USB_INT]		= 7,
> -	[IRQ_DA8XX_IRQN]		= 7,
> -	[IRQ_DA8XX_RWAKEUP]		= 7,
> -	[IRQ_DA8XX_UARTINT2]		= 7,
> -	[IRQ_DA8XX_DFTSSINT]		= 7,
> -	[IRQ_DA8XX_EHRPWM0]		= 7,
> -	[IRQ_DA8XX_EHRPWM0TZ]		= 7,
> -	[IRQ_DA8XX_EHRPWM1]		= 7,
> -	[IRQ_DA8XX_EHRPWM1TZ]		= 7,
> -	[IRQ_DA830_EHRPWM2]		= 7,
> -	[IRQ_DA830_EHRPWM2TZ]		= 7,
> -	[IRQ_DA8XX_ECAP0]		= 7,
> -	[IRQ_DA8XX_ECAP1]		= 7,
> -	[IRQ_DA8XX_ECAP2]		= 7,
> -	[IRQ_DA830_EQEP0]		= 7,
> -	[IRQ_DA830_EQEP1]		= 7,
> -	[IRQ_DA830_T12CMPINT0_0]	= 7,
> -	[IRQ_DA830_T12CMPINT1_0]	= 7,
> -	[IRQ_DA830_T12CMPINT2_0]	= 7,
> -	[IRQ_DA830_T12CMPINT3_0]	= 7,
> -	[IRQ_DA830_T12CMPINT4_0]	= 7,
> -	[IRQ_DA830_T12CMPINT5_0]	= 7,
> -	[IRQ_DA830_T12CMPINT6_0]	= 7,
> -	[IRQ_DA830_T12CMPINT7_0]	= 7,
> -	[IRQ_DA830_T12CMPINT0_1]	= 7,
> -	[IRQ_DA830_T12CMPINT1_1]	= 7,
> -	[IRQ_DA830_T12CMPINT2_1]	= 7,
> -	[IRQ_DA830_T12CMPINT3_1]	= 7,
> -	[IRQ_DA830_T12CMPINT4_1]	= 7,
> -	[IRQ_DA830_T12CMPINT5_1]	= 7,
> -	[IRQ_DA830_T12CMPINT6_1]	= 7,
> -	[IRQ_DA830_T12CMPINT7_1]	= 7,
> -	[IRQ_DA8XX_ARMCLKSTOPREQ]	= 7,
> +static u8 da830_cp_intc_prios[] = {
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
> +	7, 7, 7, 7, 7, 7, 7, 7,
>   };
>  

Technically, any holes in the array that are being deleted
here have a default priority of 15 assigned in the cp_intc
driver instead of 7. I don't think this is a problem, but it
might be worth mentioning in the commit message. Same goes
for DA850.

