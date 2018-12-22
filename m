Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37951C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066D22173B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0/D9TdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbeLVDS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 22:18:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbeLVDS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 22:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uQIQKQNyxsO9JmOGBp1UE/bd9lE2BFsIh++l/kHbStg=; b=T0/D9TdX7vKElM8Bv6wrGSClS
        Ilo7iOYdppg2zCnZBWxbYQxSNJhpJs2wUNsZ3wOU+N1RpDneIZs3A56AsSRqOeziJYjZmP1a/Qx/1
        9WgNRoGtDj1t9ajmJJpvulAukUsk3d1cBG8wlNsg7OHWiwe+xMWkVMiigBZBMY0zOXxhjdCutrcCs
        URpTUvROfMVimfubneG8JhP6O0nuZ0F3W2IfR2ZdG2DJ+eqFfhr4OBZLKum8iDlm1/A5J9FWyqr4L
        YcIUCStkdCcq4064wKB0rt4nZmMq+7Tp9gf8qUkqC2wOVMGcCAPMiEzVtv5BJu8exbmJuXzEbVUeJ
        yvTkhCYFg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaXo2-0004GR-KP; Sat, 22 Dec 2018 03:18:26 +0000
Subject: Re: [PATCH v1 08/11] ASoC: Intel: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>, linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-9-okaya@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
Date:   Fri, 21 Dec 2018 19:18:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181222001452.7474-9-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 4:14 PM, Sinan Kaya wrote:
> IOSF_MBI driver depends on CONFIG_PCI set but this is not specified
> anywhere.

wrong patch description...?

> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  sound/soc/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..b0764b2fe001 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>  config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>  	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>  	default ACPI
> -	depends on X86 && ACPI
> +	depends on X86 && ACPI && PCI
>  	select SND_SST_IPC_ACPI
>  	select SND_SST_ATOM_HIFI2_PLATFORM
>  	select SND_SOC_ACPI_INTEL_MATCH
> 


-- 
~Randy
