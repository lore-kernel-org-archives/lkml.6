Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F12CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087D5208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087D5208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934267AbeFQLeg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:34:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38305 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934142AbeFQLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:34:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so10709203wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 04:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ysAvXYIYk8VzRy31asWUpaP9FoBG2TmLtbmwZhiLM8=;
        b=HC2Q6/OWqTAKzMowSo9LGC5JRJF8pLG1xT54R1CQpeDBYrsGQJtGK4DRHmlNJ+D1Q3
         gQBy0AdJBiJPCVUnfA1/9G+ERMvH5EP6r153Y/VqTq5CJdBIKEsB+E9iKWnRrBR4EzrW
         gM3Fxts8uvI+LY0Th5lh+z0z+MdO+tjwLbiF3pCo/kr0LXHM+F2pRC5mY0MjnedTjtXO
         DdmifFo+tPIA8vmhMYBS1VyjMcTYFsBSOHOICC/qPhRTjZ/cY5Mqf1W5Rr4gbEO/CARq
         LguzFIC2Lf1XkNoEn9mKh+C/3HPK/uoqgGCmtIaIVrWCFWm4aGApcKBGEuweD+bRbEoc
         DP2g==
X-Gm-Message-State: APt69E2Lkm2Oi3uY8unBlaggbyFQdsv7X+bMCMYt778wytF1MlWVEXe6
        oHWJCKCkeraf7KrSsTfpqH++3w==
X-Google-Smtp-Source: ADUXVKINL+RUIpiB2LVT+O+1XVYlN25U73VY65/30PoAKvoNrKk0mCtuyhAOJjfGzP0Vx6lTSRBLow==
X-Received: by 2002:a50:d00a:: with SMTP id j10-v6mr7759265edf.15.1529235272893;
        Sun, 17 Jun 2018 04:34:32 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i38-v6sm6612103ede.41.2018.06.17.04.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 04:34:31 -0700 (PDT)
Subject: Re: [PATCH v1] platform/x86: silead_dmi: Add touchscreen info for the
 Onda V891w V3 tablet
To:     youling257 <youling257@gmail.com>, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        andy@infradead.org, dvhart@infradead.org
References: <20180617103736.1162-1-youling257@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a299b26c-f8ff-8a22-ed1e-a79777996fe7@redhat.com>
Date:   Sun, 17 Jun 2018 13:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617103736.1162-1-youling257@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for this patch.

Please rebase this patch on top of:

http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy

Where the entries have been sorted alphabetically and
the file has been renamed to touchscreen_dmi.c

On 17-06-18 12:37, youling257 wrote:
> Signed-off-by: youling257 <youling257@gmail.com>
> ---
>   drivers/platform/x86/silead_dmi.c | 35 +++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
> index 853a7ce4601c..9e61182c8aff 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -326,6 +326,23 @@ static const struct silead_ts_dmi_data onda_v891w_v1_data = {
>   	.properties	= onda_v891w_v1_props,
>   };
>   
> +static const struct property_entry onda_v891w_v3_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 35),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1625),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1135),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name", "FW_I89_GSL3676B_19201200_.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct silead_ts_dmi_data onda_v891w_v3_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= onda_v891w_v3_props,
> +};
> +
>   static const struct dmi_system_id silead_ts_dmi_table[] = {
>   	{
>   		/* CUBE iwork8 Air */
> @@ -554,6 +571,24 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
>   			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
>   		},
>   	},
> +	{
> +		/* ONDA V891w Dual OS P891DCF2V1A01274 64GB */
> +		.driver_data = (void *)&onda_v891w_v3_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
> +			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.D890HBBNR0A"),
> +		},
> +	},

This entry is using the V1 BIOS data, so it needs to be dropped. I know
some V3 tablets ship with the V1 BIOS, I plan to add the possibility to
directly select a set of ts_dmi_data from the kernel commandline. This
will also be useful to select the right data for the many rebrands of
various tablets with a Silead touchscreen.

Regards,

Hans




> +	{
> +		/* ONDA V891w P891WBECV3A02121 32GB */
> +		.driver_data = (void *)&onda_v891w_v3_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ONDA Tablet"),
> +			DMI_MATCH(DMI_BIOS_VERSION, "ONDA.W89EBBN08"),
> +		},
> +	},
>   	{ },
>   };
>   
> 
