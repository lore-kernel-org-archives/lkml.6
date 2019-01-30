Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D94C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B1720882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1dIpshB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfA3JYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:24:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33642 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:24:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so16897090lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a6wuYAzUKJFK17sFW5IvyQfSur/oHfCkaT4dffnoCek=;
        b=I1dIpshBNVhV/iBrdyWW2LhtIYVP4sAETBUIw4/H4EIhbWMFJaLrgH+Snjlji1ZgJm
         TmASN1P05uw1OTrp/ien+32Wh2NunCFmfN6Gk8W6mVf+0mFDj526Oug5IHm81m18DIAk
         ygvSzEG3G9X8P0kzRqBubDRD2biqlklohValo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a6wuYAzUKJFK17sFW5IvyQfSur/oHfCkaT4dffnoCek=;
        b=BnLJGw7AFA8n/In94cT1qSDh2V+AKaRLCntVoC1+Jkkw8K8ooAp3hHMkjgjaihdXvY
         aszJI6KndghKdXmdIfFPbB8JGWQ0YmqqmAbT//P1hUq4l4qvxFlWw4dEsHUiv3UuQaK1
         1c2iCx9fY5wJr+NpumlTaj/29BjFe3YnI0ktMmRSnAWxLCC30ohjoJwddIJQ+Gnmb2hE
         IKKz6Gjklcd5xeVb2qCewyxLU3+HKw0CZ/vUpJXked6hskz4DMMmpjy2vTQN+rxU4Soi
         UI4hXekhDX/73q1OKxmd3CG8I8WJiPtw03zk/lOeJ/yJ+9qvcU7CQVLBV3OnfTXKfjHG
         hLNA==
X-Gm-Message-State: AJcUukeJ0wjgmlmIBCZq3vGSePLeua4TwMC/0IDyD0ruNlciAcEBH4Ou
        bj2v0nviEkGZJMy7C9mOssDA3g==
X-Google-Smtp-Source: ALg8bN7vglkBkAPnDzc77h69eDlPk288seMZyirG8ade+BplyFtwnNBG3rvOJV+1qcCFSAk/cU8saA==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr22400987lfh.74.1548840285704;
        Wed, 30 Jan 2019 01:24:45 -0800 (PST)
Received: from localhost.localdomain (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id q20sm189864lfj.20.2019.01.30.01.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:24:44 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:43:21 +0100
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
Message-ID: <20190130084321.GB3369@localhost.localdomain>
References: <20190115191839.13823-1-anders.roxell@linaro.org>
 <20190125143215.GE25901@arrakis.emea.arm.com>
 <1548431829.28802.50.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548431829.28802.50.camel@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-25 16:57, Lucas Stach wrote:
> Am Freitag, den 25.01.2019, 14:32 +0000 schrieb Catalin Marinas:
> > On Tue, Jan 15, 2019 at 08:18:39PM +0100, Anders Roxell wrote:
> > > When ARCH_MXC get enabled, ARM64_ERRATUM_845719 will be selected and
> > > this warning will happen when COMPAT isn't set.
> > > 
> > > WARNING: unmet direct dependencies detected for ARM64_ERRATUM_845719
> > >   Depends on [n]: COMPAT [=n]
> > >   Selected by [y]:
> > >   - ARCH_MXC [=y]
> > > 
> > > Rework to add 'if COMPAT' before ARM64_ERRATUM_845719 gets selected,
> > > since ARM64_ERRATUM_845719 depends on COMPAT.
> > > 
> > > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > >  arch/arm64/Kconfig.platforms | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > > index 251ecf34cb02..d4faca775d9c 100644
> > > --- a/arch/arm64/Kconfig.platforms
> > > +++ b/arch/arm64/Kconfig.platforms
> > > @@ -145,7 +145,7 @@ config ARCH_MVEBU
> > >  config ARCH_MXC
> > > > >  	bool "ARMv8 based NXP i.MX SoC family"
> > > > >  	select ARM64_ERRATUM_843419
> > > > > -	select ARM64_ERRATUM_845719
> > > > > +	select ARM64_ERRATUM_845719 if COMPAT
> > > > >  	help
> > > > >  	  This enables support for the ARMv8 based SoCs in the
> > >  	  NXP i.MX family.
> > 
> > Actually, do we need to select the errata workarounds explicitly? That
> > seems to be the only case where we do it (commit 930507c18304, "arm64:
> > add basic Kconfig symbols for i.MX8"). They are default y, so we
> > shouldn't need to force them on.
> 
> This is based on past experience. We've had a lot of cases were people
> did not enable the necessary CPU errata workaround, which then usually
> lead to very hard to debug system failures. It is on our list of things
> to look out for now, but I would feel much better if there is just no
> chance for a user to misconfigure the kernel in this way.
> 

Would a better approach be to remove the 'depends on COMPAT' in the
Kconfig and move it into the src files instead see below.

Cheers,
Anders


diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d9ab8ff3f7e5..04b11806e2d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -430,7 +430,6 @@ config ARM64_ERRATUM_834220
 
 config ARM64_ERRATUM_845719
 	bool "Cortex-A53: 845719: a load might read incorrect data"
-	depends on COMPAT
 	default y
 	help
 	  This option adds an alternative code sequence to work around ARM
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9950bb0cbd52..43b14a5fc8c1 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -641,7 +641,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_FIXED(0x4, BIT(8)),
 	},
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_845719
+#if defined(CONFIG_ARM64_ERRATUM_845719) && defined(CONFIG_COMPAT)
 	{
 	/* Cortex-A53 r0p[01234] */
 		.desc = "ARM erratum 845719",
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0ec0c46b2c0c..e2be37ee5615 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -311,7 +311,7 @@ alternative_else_nop_endif
 	tst	x22, #PSR_MODE32_BIT		// native task?
 	b.eq	3f
 
-#ifdef CONFIG_ARM64_ERRATUM_845719
+#if defined(CONFIG_ARM64_ERRATUM_845719) && defined(CONFIG_COMPAT)
 alternative_if ARM64_WORKAROUND_845719
 #ifdef CONFIG_PID_IN_CONTEXTIDR
 	mrs	x29, contextidr_el1
