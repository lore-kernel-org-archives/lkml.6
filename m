Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB9ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90892083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90892083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeIPAtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:49:03 -0400
Received: from baldur.buserror.net ([165.227.176.147]:49762 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeIPAtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:49:03 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1g1GB6-0004Bv-AO; Sat, 15 Sep 2018 14:24:25 -0500
Message-ID: <4fa10f679ad4b1b619daa521a8641c145cf8537e.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Tang Yuantian <andy.tang@nxp.com>
Date:   Sat, 15 Sep 2018 14:24:21 -0500
In-Reply-To: <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
         <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: vabhav.sharma@nxp.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com, linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com, yogeshnarayan.gaur@nxp.com, andy.tang@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2 3/5] drivers: clk-qoriq: Add clockgen support for
 lx2160a
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-14 at 02:07 +0530, Vabhav Sharma wrote:
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 3a1812f..e9ae70b 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -79,7 +79,7 @@ struct clockgen_chipinfo {
>  	const struct clockgen_muxinfo *cmux_groups[2];
>  	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
>  	void (*init_periph)(struct clockgen *cg);
> -	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than
> NUM_CMUX */
> +	int cmux_to_group[NUM_CMUX+1]; /* -1 terminate if fewer to
> NUM_CMUX+1 */

You need to add the -1 terminator to p4080, and remove the "if fewer" comment
since the whole point of this is that every array gets -1 terminated.

Why did you change "terminates" to "terminate" and "than" to "to"?

This +1 change should be a separate patch from lx2160a support.

-Scott

