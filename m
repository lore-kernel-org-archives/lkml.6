Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91E47C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D92D208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EfOWUmBZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GM3Z1D2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D92D208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934920AbeFMIri (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:47:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbeFMIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:47:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BDD1660717; Wed, 13 Jun 2018 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528879654;
        bh=neL9P2Gg6akSs002R1vITZFPgP+UJ8ozeRvVXtosxaU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EfOWUmBZYTX7q96u8xtfPtGHxcjum13JrwULHFhMeDxDiPFcjEGMPUeRwlT390bV6
         Giv1jksJtDSLVG06FSL9HLWuMxZcmPRHpTQS1J61KaYhBYeO1IzkRhDsw9Ki0E6lqJ
         IO0MYi6jMgGjagKb5bJZVxaWuZ3IpbsCLgTYBows=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89BE060351;
        Wed, 13 Jun 2018 08:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528879653;
        bh=neL9P2Gg6akSs002R1vITZFPgP+UJ8ozeRvVXtosxaU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GM3Z1D2oqKddMXmnSORoCfJOlUevnNJu98XPUsc+CvN3kQdq09jYm6UABiNJY3B+E
         M8N8CVtRD0oMUZrzRA8hiQZFUrpOvBrUkoWT7TFsu6kG+1rs7CjlHjKBkWAJo5eZbi
         MiJn7dOxOczWyiwJIKPd97efc8DcOLwaGECKHSj8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89BE060351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Govind Singh <govinds@codeaurora.org>, bjorn.andersson@linaro.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: FW: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
References: <20180612113907.15043-1-niklas.cassel@linaro.org>
        <20180612113907.15043-2-niklas.cassel@linaro.org>
        <7058492257914633b55fcd423e4c0b59@aphydexm01b.ap.qualcomm.com>
        <47cf8ec1b11d727ea928a307a431d4a2@codeaurora.org>
        <20180612124403.GA26986@centauri.lan>
Date:   Wed, 13 Jun 2018 11:47:29 +0300
In-Reply-To: <20180612124403.GA26986@centauri.lan> (Niklas Cassel's message of
        "Tue, 12 Jun 2018 14:44:03 +0200")
Message-ID: <87a7rzax9a.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> writes:

> On Tue, Jun 12, 2018 at 06:02:48PM +0530, Govind Singh wrote:
>> On 2018-06-12 17:45, Govind Singh wrote:
>> > -----Original Message-----
>> > From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Niklas
>> > Cassel
>> > Sent: Tuesday, June 12, 2018 5:09 PM
>> > To: Kalle Valo <kvalo@codeaurora.org>; David S. Miller
>> > <davem@davemloft.net>
>> > Cc: Niklas Cassel <niklas.cassel@linaro.org>; netdev@vger.kernel.org;
>> > linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>> > ath10k@lists.infradead.org
>> > Subject: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
>> > 
>> > ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
>> > 
>> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> > ---
>> >  drivers/net/wireless/ath/ath10k/Kconfig | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/net/wireless/ath/ath10k/Kconfig
>> > b/drivers/net/wireless/ath/ath10k/Kconfig
>> > index 54ff5930126c..6572a43590a8 100644
>> > --- a/drivers/net/wireless/ath/ath10k/Kconfig
>> > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
>> > @@ -42,7 +42,8 @@ config ATH10K_USB
>> > 
>> >  config ATH10K_SNOC
>> >  	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
>> > -	depends on ATH10K && ARCH_QCOM
>> > +	depends on ATH10K
>> > +	depends on ARCH_QCOM || COMPILE_TEST
>> >  	---help---
>> >  	  This module adds support for integrated WCN3990 chip connected
>> >  	  to system NOC(SNOC). Currently work in progress and will not
>> 
>> Thanks Niklas for enabling COMPILE_TEST. With QMI set of
>> changes(https://patchwork.kernel.org/patch/10448183/), we need to enable
>> COMPILE_TEST for
>> QCOM_SCM/QMI_HELPERS which seems broken today. Are you planning to fix the
>> same.
>
>
> Argh..
>
> qcom_scm seems fine, it is just missing a single definition in the
> #else clause of include/linux/qcom_scm.h.
>
> +++ b/include/linux/qcom_scm.h
> @@ -89,6 +89,10 @@ static inline int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,                                     
>  static inline int
>  qcom_scm_pas_auth_and_reset(u32 peripheral) { return -ENODEV; }
>  static inline int qcom_scm_pas_shutdown(u32 peripheral) { return -ENODEV; }                                                      
> +static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,                                                       
> +                                     unsigned int *src,
> +                                     struct qcom_scm_vmperm *newvm,                                                              
> +                                     int dest_cnt) { return -ENODEV; }                                                           
>  static inline void qcom_scm_cpu_power_down(u32 flags) {}
>  static inline u32 qcom_scm_get_version(void) { return 0; }
>
>
>
> include/linux/soc/qcom/qmi.h on the other hand doesn't have any
> dummy defintions at all.
> I think that it makes sense to be able to compile test
> the QMI helpers also on other archs..
>
> Bjorn, any opinion?

Please don't drop ath10k list, adding it back.

-- 
Kalle Valo
