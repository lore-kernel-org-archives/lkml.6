Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EB3D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945BB208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nruy2jfg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nruy2jfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945BB208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeFLMcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:32:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754123AbeFLMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:32:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E40BA607BB; Tue, 12 Jun 2018 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528806768;
        bh=3jgg9wjV4evhljJ5ApJI1AZTBRFzKbuPSAMDLOXDxtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nruy2jfgC1zv5FBG86+SyImauqPKYftdMMP7QkYpgYx0++zVR0HQd4xRExKYna8bh
         u0ngboNjVxoAM1ISR5FgokJM0uuLPZh69rrV9W6hrudu0XDmJpDzfQ6A+q7yi63QAX
         GyAZzIRxHn19lzE6749rbRE1W6uV8x4b12IXNWEQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1FDDD607BB;
        Tue, 12 Jun 2018 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528806768;
        bh=3jgg9wjV4evhljJ5ApJI1AZTBRFzKbuPSAMDLOXDxtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nruy2jfgC1zv5FBG86+SyImauqPKYftdMMP7QkYpgYx0++zVR0HQd4xRExKYna8bh
         u0ngboNjVxoAM1ISR5FgokJM0uuLPZh69rrV9W6hrudu0XDmJpDzfQ6A+q7yi63QAX
         GyAZzIRxHn19lzE6749rbRE1W6uV8x4b12IXNWEQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Jun 2018 18:02:48 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     niklas.cassel@linaro.org, kvalo@codeaurora.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: FW: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
In-Reply-To: <7058492257914633b55fcd423e4c0b59@aphydexm01b.ap.qualcomm.com>
References: <20180612113907.15043-1-niklas.cassel@linaro.org>
 <20180612113907.15043-2-niklas.cassel@linaro.org>
 <7058492257914633b55fcd423e4c0b59@aphydexm01b.ap.qualcomm.com>
Message-ID: <47cf8ec1b11d727ea928a307a431d4a2@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 17:45, Govind Singh wrote:
> -----Original Message-----
> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Niklas 
> Cassel
> Sent: Tuesday, June 12, 2018 5:09 PM
> To: Kalle Valo <kvalo@codeaurora.org>; David S. Miller 
> <davem@davemloft.net>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>; netdev@vger.kernel.org;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> ath10k@lists.infradead.org
> Subject: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
> 
> ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/net/wireless/ath/ath10k/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig
> b/drivers/net/wireless/ath/ath10k/Kconfig
> index 54ff5930126c..6572a43590a8 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -42,7 +42,8 @@ config ATH10K_USB
> 
>  config ATH10K_SNOC
>  	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
> -	depends on ATH10K && ARCH_QCOM
> +	depends on ATH10K
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	---help---
>  	  This module adds support for integrated WCN3990 chip connected
>  	  to system NOC(SNOC). Currently work in progress and will not

Thanks Niklas for enabling COMPILE_TEST. With QMI set of 
changes(https://patchwork.kernel.org/patch/10448183/), we need to enable 
COMPILE_TEST for
QCOM_SCM/QMI_HELPERS which seems broken today. Are you planning to fix 
the same.

  config QCOM_SCM
  	bool
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || COMPILE_TEST
  	select RESET_CONTROLLER


  config QCOM_SCM_64
  	def_bool y
-	depends on QCOM_SCM && ARM64
+	depends on QCOM_SCM && ARM64 || COMPILE_TEST

  config QCOM_QMI_HELPERS
  	tristate
-	depends on ARCH_QCOM && NET
+	depends on (ARCH_QCOM || COMPILE_TEST) && NET

-obj-$(CONFIG_ARCH_QCOM)		+= qcom/
+obj-y				+= qcom/

__qcom_scm_init/qcom_scm_call wrapper to support COMPILE_TEST.



BR,
Govind
