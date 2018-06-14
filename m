Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DD2E4C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CF8208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lg1vgwzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CF8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936054AbeFNSmz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:42:55 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46871 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeFNSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:42:53 -0400
Received: by mail-lf0-f66.google.com with SMTP id j13-v6so10925270lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Klm5MLJ1nNq1zQajau+Lae0tQIwt6sUldR0TdNfnpQA=;
        b=Lg1vgwzt8bCpZuKGi1h+FnKTnw+czEZGVgQ9nmcM2morAzIjFATA3Bk7QsOMQ83a77
         BVaoAIivNW619xahHj2ZdmfYSA45fjCXrbvlr/nXskoqGM0Z6wKrjHQfLx0YhFZMM9WX
         yKyIGusIkeLQWPfxD0AGMmTN78PfRn6Bz5LtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Klm5MLJ1nNq1zQajau+Lae0tQIwt6sUldR0TdNfnpQA=;
        b=n1QFA5udlf1+KFsO1/Gt4k8wH7X1RNaY4345CCNfHepF3Qign+6md+3Nibo29n12UP
         RVeC7LYjrOIj/butCvDZlBbBxZz4EwKFxbd44GnfZfcEErA10vFXcn8zTR+BIPefSCMr
         Rj1ioTAoyABFWR3WVLYt2gYnxgKEL7zRufXiq1ZG9bQC9K4dHNdrMgM8ASdGDlz+P+7/
         +49rdtUIXWu0JVKtGS8pnxPZsSyuaF3iBUIgcL9Cj5rUePTqfC/o7nlnYRyCuVSU+7Gx
         kRyb6b9Nfdu6noyE4gPWMjMxNF/FcA3Bi5BOlaUAIYO/t8wsBRIaGwR1P+/oD97ab/1+
         B9ww==
X-Gm-Message-State: APt69E06pSibh/eeY+2G5leoIQkaWupnm749wDvyG2FKM9Lc9Xo9s0h8
        eB8QgbYd2eiv1jh94YK4bCaO5Q==
X-Google-Smtp-Source: ADUXVKJHlLqggboqiUbRZwVOqQcq0W0brccn6Y/Ue3XQQyN9W8tdIj11/u9yGhwV4mewLrEk2v89CA==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr2635973ljd.138.1529001772166;
        Thu, 14 Jun 2018 11:42:52 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id x8-v6sm1055899ljj.54.2018.06.14.11.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 11:42:51 -0700 (PDT)
Date:   Thu, 14 Jun 2018 20:42:49 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, bjorn.andersson@linaro.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: FW: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
Message-ID: <20180614184249.GA31553@centauri.lan>
References: <20180612113907.15043-1-niklas.cassel@linaro.org>
 <20180612113907.15043-2-niklas.cassel@linaro.org>
 <7058492257914633b55fcd423e4c0b59@aphydexm01b.ap.qualcomm.com>
 <47cf8ec1b11d727ea928a307a431d4a2@codeaurora.org>
 <20180612124403.GA26986@centauri.lan>
 <20180613132819.GA12603@centauri.ideon.se>
 <878t7ha29r.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t7ha29r.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 05:09:04PM +0300, Kalle Valo wrote:
> Niklas Cassel <niklas.cassel@linaro.org> writes:
> 
> > On Tue, Jun 12, 2018 at 02:44:03PM +0200, Niklas Cassel wrote:
> >> On Tue, Jun 12, 2018 at 06:02:48PM +0530, Govind Singh wrote:
> >> > On 2018-06-12 17:45, Govind Singh wrote:
> >> > > 
> >> > > ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
> >> > > 
> >> > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> >> > > ---
> >> > >  drivers/net/wireless/ath/ath10k/Kconfig | 3 ++-
> >> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> > > 
> >> > > diff --git a/drivers/net/wireless/ath/ath10k/Kconfig
> >> > > b/drivers/net/wireless/ath/ath10k/Kconfig
> >> > > index 54ff5930126c..6572a43590a8 100644
> >> > > --- a/drivers/net/wireless/ath/ath10k/Kconfig
> >> > > +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> >> > > @@ -42,7 +42,8 @@ config ATH10K_USB
> >> > > 
> >> > >  config ATH10K_SNOC
> >> > >  	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
> >> > > -	depends on ATH10K && ARCH_QCOM
> >> > > +	depends on ATH10K
> >> > > +	depends on ARCH_QCOM || COMPILE_TEST
> >> > >  	---help---
> >> > >  	  This module adds support for integrated WCN3990 chip connected
> >> > >  	  to system NOC(SNOC). Currently work in progress and will not
> >> > 
> >> > Thanks Niklas for enabling COMPILE_TEST. With QMI set of
> >> > changes(https://patchwork.kernel.org/patch/10448183/), we need to enable
> >> > COMPILE_TEST for
> >> > QCOM_SCM/QMI_HELPERS which seems broken today. Are you planning to fix the
> >> > same.
> >
> > This patch is good as is.
> >
> > However, Govind's QMI patch set together with this patch
> > resulted in build errors.
> >
> > FTR, these are fixed by:
> > https://marc.info/?l=linux-kernel&m=152880985402356
> > https://marc.info/?l=linux-kernel&m=152889452326350
> 
> So the problem is that if I apply this patch I can't apply Govind's QMI
> patchset (due to the build problems) until Niklas' fixes to qcom and
> rpmsg subsystems propogate back to my tree and that might take weeks, or
> even months. But I really would like to apply the QMI patchset ASAP so
> that we can complete the wcn3990 support and not unnecessarily delay it.
> 
> So what I propose is that I put this patch 2 as 'Awaiting Upstream' in
> patchwork and apply it once Niklas' patches get to my tree. Does that
> sound good?

Absolutely.

I didn't realize this until after sending the patch.


Kind regards,
Niklas
