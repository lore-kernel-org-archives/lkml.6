Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EA1C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AC820834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AC820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeK2XJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:09:08 -0500
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:10148
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbeK2XJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:09:07 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2018 18:09:05 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AEAADu0v9b/zXSMGcNWBoBAQEBAQI?=
 =?us-ascii?q?BAQEBBwIBAQEBgVIEAQEBAQsBhBKDeZRsAQEBAQEBBoEILXyIIokthHeBeoR?=
 =?us-ascii?q?5AoNTNQgNAQMBAQEBAQEChlIBAQEDIxVBEAsNCwICJgICVwYBDAYCAQGDHYF?=
 =?us-ascii?q?1pT9wgS8ahSaEbYELgXOJL3iBB4ERJ4I2NYgFglcCj2qQOQgBkSweiXwDhx0?=
 =?us-ascii?q?siEyRHAOCCDMaCCgIgyeQbWCOPwEB?=
X-IPAS-Result: =?us-ascii?q?A2AEAADu0v9b/zXSMGcNWBoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?VIEAQEBAQsBhBKDeZRsAQEBAQEBBoEILXyIIokthHeBeoR5AoNTNQgNAQMBA?=
 =?us-ascii?q?QEBAQEChlIBAQEDIxVBEAsNCwICJgICVwYBDAYCAQGDHYF1pT9wgS8ahSaEb?=
 =?us-ascii?q?YELgXOJL3iBB4ERJ4I2NYgFglcCj2qQOQgBkSweiXwDhx0siEyRHAOCCDMaC?=
 =?us-ascii?q?CgIgyeQbWCOPwEB?=
X-IronPort-AV: E=Sophos;i="5.56,294,1539619200"; 
   d="scan'208";a="175387555"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 29 Nov 2018 19:54:39 +0800
Subject: Re: [PATCH v6 3/6] m68k: coldfire: Add clk_get_optional() function
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-4-phil.edworthy@renesas.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <bcb0278b-a4f5-068b-324f-7be3ca963102@linux-m68k.org>
Date:   Thu, 29 Nov 2018 21:54:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116145937.27660-4-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On 17/11/18 12:59 am, Phil Edworthy wrote:
> clk_get_optional() returns NULL if not found instead of -ENOENT,
> otherwise the behaviour is the same as clk_get().
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Greg Ungerer <gerg@@linux-m68k.org>

Looks good. Do you want me to take this in the m68knommu git tree?
Or is the whole series going through some other tree?

Regards
Greg



> ---
>   arch/m68k/coldfire/clk.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index 7bc666e482eb..b221cabc7f54 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -87,6 +87,17 @@ struct clk *clk_get(struct device *dev, const char *id)
>   }
>   EXPORT_SYMBOL(clk_get);
>   
> +struct clk *clk_get_optional(struct device *dev, const char *id)
> +{
> +	struct clk *clk = clk_get(dev, id);
> +
> +	if (clk == ERR_PTR(-ENOENT))
> +		clk = NULL;
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL(clk_get_optional);
> +
>   int clk_enable(struct clk *clk)
>   {
>   	unsigned long flags;
> 
