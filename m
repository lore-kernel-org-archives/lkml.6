Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9331C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B40D2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B40D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeKHTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:48:59 -0500
Received: from foss.arm.com ([217.140.101.70]:37618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeKHTs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:48:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F5BF80D;
        Thu,  8 Nov 2018 02:14:14 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97BFA3F5CF;
        Thu,  8 Nov 2018 02:14:13 -0800 (PST)
Date:   Thu, 8 Nov 2018 10:14:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
Message-ID: <20181108101410.ir3tws7wduxtdsay@salmiak>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <ddf4d390-c631-c5ef-03dc-a0579a21d484@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf4d390-c631-c5ef-03dc-a0579a21d484@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 09:15:29PM +0100, Marc Gonzalez wrote:
> Commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Again, please describe things in the commit message, e.g.

  CONFIG_NF_CONNTRACK_IPV4 and CONFIG_NF_CONNTRACK_IPV6 haven't existed since
  commit:

    a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")

  ... so we can remove them from the arm64 defconfig.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

For the rest of this series, please update the commit messages to describe why
the cited commit means it's safe to drop the option.

Thanks,
Mark.

> ---
>  arch/arm64/configs/defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8d6878c1e794..58741c07a6ef 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -156,14 +156,12 @@ CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
>  CONFIG_NETFILTER_XT_TARGET_LOG=m
>  CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>  CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> -CONFIG_NF_CONNTRACK_IPV4=m
>  CONFIG_IP_NF_IPTABLES=m
>  CONFIG_IP_NF_FILTER=m
>  CONFIG_IP_NF_TARGET_REJECT=m
>  CONFIG_IP_NF_NAT=m
>  CONFIG_IP_NF_TARGET_MASQUERADE=m
>  CONFIG_IP_NF_MANGLE=m
> -CONFIG_NF_CONNTRACK_IPV6=m
>  CONFIG_IP6_NF_IPTABLES=m
>  CONFIG_IP6_NF_FILTER=m
>  CONFIG_IP6_NF_TARGET_REJECT=m
> -- 
> 2.17.1
