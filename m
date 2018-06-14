Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CDEF0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E33208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QMTfMRAQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WgP5DQZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E33208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965422AbeFNOJR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:09:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965329AbeFNOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:09:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 71CAD608FD; Thu, 14 Jun 2018 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528985350;
        bh=WMpAi+8HJqJ+WpXz9aJyCpVWrvp2eaFXBBUTAQrAYK0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QMTfMRAQ3dtcQu/DdOkk06+YzMpQF+boXEeBPeEdq4PQK6tTcj0Z8BsL/a/2MTU03
         eoae3O3akn1xjmNus6aKU5eZRygY3nNdvdgYC+egkgXOZjs46BH6jyvbSgV3CpRmlB
         6KvzF2PVMZWS84lu+U7XWSHWBWboM8QWJ+8E50BY=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82F34608CD;
        Thu, 14 Jun 2018 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528985349;
        bh=WMpAi+8HJqJ+WpXz9aJyCpVWrvp2eaFXBBUTAQrAYK0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WgP5DQZuo5vMXfgCAs/Ai35m5V0tL9tICy/YUnHC4PkD5D4Ab866Oiasw/ku5nEl6
         Gp5Y89kno9TEZKloBhY13vjb50CVo4VmHp0A/egOXnDwTPAdKlL9C4b/+3CvOEdN1Y
         68xBoDTFAxPuPfrnjokKLlun0g1YcGF4+j/1AH+I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82F34608CD
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
        <20180613132819.GA12603@centauri.ideon.se>
Date:   Thu, 14 Jun 2018 17:09:04 +0300
In-Reply-To: <20180613132819.GA12603@centauri.ideon.se> (Niklas Cassel's
        message of "Wed, 13 Jun 2018 15:28:19 +0200")
Message-ID: <878t7ha29r.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> writes:

> On Tue, Jun 12, 2018 at 02:44:03PM +0200, Niklas Cassel wrote:
>> On Tue, Jun 12, 2018 at 06:02:48PM +0530, Govind Singh wrote:
>> > On 2018-06-12 17:45, Govind Singh wrote:
>> > > 
>> > > ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
>> > > 
>> > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> > > ---
>> > >  drivers/net/wireless/ath/ath10k/Kconfig | 3 ++-
>> > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > > 
>> > > diff --git a/drivers/net/wireless/ath/ath10k/Kconfig
>> > > b/drivers/net/wireless/ath/ath10k/Kconfig
>> > > index 54ff5930126c..6572a43590a8 100644
>> > > --- a/drivers/net/wireless/ath/ath10k/Kconfig
>> > > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
>> > > @@ -42,7 +42,8 @@ config ATH10K_USB
>> > > 
>> > >  config ATH10K_SNOC
>> > >  	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
>> > > -	depends on ATH10K && ARCH_QCOM
>> > > +	depends on ATH10K
>> > > +	depends on ARCH_QCOM || COMPILE_TEST
>> > >  	---help---
>> > >  	  This module adds support for integrated WCN3990 chip connected
>> > >  	  to system NOC(SNOC). Currently work in progress and will not
>> > 
>> > Thanks Niklas for enabling COMPILE_TEST. With QMI set of
>> > changes(https://patchwork.kernel.org/patch/10448183/), we need to enable
>> > COMPILE_TEST for
>> > QCOM_SCM/QMI_HELPERS which seems broken today. Are you planning to fix the
>> > same.
>
> This patch is good as is.
>
> However, Govind's QMI patch set together with this patch
> resulted in build errors.
>
> FTR, these are fixed by:
> https://marc.info/?l=linux-kernel&m=152880985402356
> https://marc.info/?l=linux-kernel&m=152889452326350

So the problem is that if I apply this patch I can't apply Govind's QMI
patchset (due to the build problems) until Niklas' fixes to qcom and
rpmsg subsystems propogate back to my tree and that might take weeks, or
even months. But I really would like to apply the QMI patchset ASAP so
that we can complete the wcn3990 support and not unnecessarily delay it.

So what I propose is that I put this patch 2 as 'Awaiting Upstream' in
patchwork and apply it once Niklas' patches get to my tree. Does that
sound good?

-- 
Kalle Valo
