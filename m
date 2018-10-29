Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37991C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42B520851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42B520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeJ2SFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:05:45 -0400
Received: from foss.arm.com ([217.140.101.70]:36974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbeJ2SFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:05:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B48341;
        Mon, 29 Oct 2018 02:17:58 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 893CF3F557;
        Mon, 29 Oct 2018 02:17:58 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id D86CD681DFC; Mon, 29 Oct 2018 09:17:56 +0000 (GMT)
Date:   Mon, 29 Oct 2018 09:17:56 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] ARM: vexpress/spc: constify clk_ops structure
Message-ID: <20181029091756.GA1167@e110455-lin.cambridge.arm.com>
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540619262-22681-3-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540619262-22681-3-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 07:47:36AM +0200, Julia Lawall wrote:
> The clk_ops structure is only stored in the ops field of a
> clk_init_data structure.  This field is const, so the clk_ops
> structure can be const as well.
> 
> Identified and transformed using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Are you going to send the series to the arm-soc maintainers directly or
you want us to cherry-pick this patch into the Versatile tree?

Best regards,
Liviu

> 
> ---
>  arch/arm/mach-vexpress/spc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index 0f5381d13494..611f22de48cb 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -521,7 +521,7 @@ static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return ve_spc_set_performance(spc->cluster, rate / 1000);
>  }
>  
> -static struct clk_ops clk_spc_ops = {
> +static const struct clk_ops clk_spc_ops = {
>  	.recalc_rate = spc_recalc_rate,
>  	.round_rate = spc_round_rate,
>  	.set_rate = spc_set_rate,
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
