Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771012145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5Zl+Jz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771012145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeKNPRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:17:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeKNPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7SUe+/ehpmiimTUc9XjOTWu23hFD2utQUNrOSNT3kog=; b=Q5Zl+Jz7Bx75hqs83/E/f8DVv
        EnHEc7gX/6bj5Z3gc+Orw7tb99OJeCCNtak0AsFHPYWtCtQsu8KFqchB9ucg9lGe6cLxxisS1TDAX
        s+w0hdWK6AtnUwif4IYUOnM2bs5rBEQVKVENZBkyXgEXW1UxETx9NAi5xjYnkXmU/Wd7UyyOFdoOz
        AzJkcvd0EhwR0/jbOMEdpUvtLinPU/yiPWcLLbTQaqQX6bLyzLxo2KftdiD6Z1WwjxmoF5eTBU4Cy
        /ULVF6rI1XeWj9kL3RHnjkq5hCjpKyUdYIvZC8eShXN4p2EUEv1/3Pohe/2dlBq0TVhcuyco1O3da
        CeOAw4EIg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMnX2-0007zd-HW; Wed, 14 Nov 2018 05:16:04 +0000
Date:   Tue, 13 Nov 2018 21:16:03 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Loic WEI YU NENG <loic.wyn@gmail.com>
Cc:     andy.shevchenko@gmail.com, ike.pan@canonical.com,
        andy@infradead.org, trivial@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ideapad-laptop: Add Lenovo Yoga 2 13 to the no_hw_rfkill
 DMI list
Message-ID: <20181114051603.GF7890@fedora.eng.vmware.com>
References: <20181114022245.5798-1-loic.wyn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114022245.5798-1-loic.wyn@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 06:22:45PM -0800, Loic WEI YU NENG wrote:
> Some Lenovo ideapad models lack a physical rfkill switch.
> On Lenovo models Yoga 2 13, ideapad-laptop would wrongly report all
> radios as blocked by hardware which caused wireless network connections
> to fail.
> Add these models without an rfkill switch to the no_hw_rfkill list.
> 
> Signed-off-by: Loic WEI YU NENG <loic.wyn@gmail.com>

Thank you for the patch.

In the future, please be sure to check MAINTAINERS and include the
relevant lists, now Cc'd.

I see this in the context of your patch, but can you confirm the current
driver fails to match your system? It contains the following, which I
would expect to match:

               .ident = "Lenovo Yoga 2 11 / 13 / Pro",
                .matches = {
                        DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
                        DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
                },

If it doesn't match, what does dmidecode report for SYS_VENDOR and
BOARD_NAME on your system? Perhaps we need to make the above more
generic.

> ---
>  drivers/platform/x86/ideapad-laptop.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index b6489cba2985..1589dffab9fa 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1188,6 +1188,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
>  			DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
>  		},
>  	},
> +	{
> +		.ident = "Lenovo Yoga 2 13",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga 2 13"),
> +		},
> +	},
>  	{
>  		.ident = "Lenovo Yoga 3 1170 / 1470",
>  		.matches = {
> -- 
> 2.17.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
