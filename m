Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4648C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E2720815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hmkt4vu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfBDTVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:21:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43767 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfBDTVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:21:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so868744eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kzGRJtxQgK9WS2qYOnuTXhDcWNhvPQyv0q1Gu0u7f5Y=;
        b=hmkt4vu90gSLxeJctU9ndSdrVpx+r6D36ZE6T7YEaYwqPHJnAuLq0N/eHPqYRxLrDA
         +BPGDe4hwwYcUJwBjcWqeHlE6FO7tz9wp0oVNe7lH9y03yMhQR+zEZy43uYT6T9SzbDt
         kTV0vzVq/3+n5DXRhAd3FwM17vRfnFDfHgryw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kzGRJtxQgK9WS2qYOnuTXhDcWNhvPQyv0q1Gu0u7f5Y=;
        b=IINmVsn+Oqz7TwNWp+FnKHQKfWape8QuXLU4ps1t5mbI0bbJVp2OI2z6G+p+5Ew3yW
         CImuiYVrw4th00wNP4pr98fKLk5VY6ojfh5Yso8sN7ZwwKffVDwZmJUQTggEX0uM53vs
         rvjyuZI6QCzFZvfvFUeFGbEJQgoAbwLcUmXGNQuO28IXSOZ0CoUArjHIMM27yEyMdq6W
         tQLCUAbNq5TkzbrJBHIsBW5Qyw+EchYn16o9WENisCYOc6OSmFumPhdm2BPaiItjRaT2
         2VgatTzZWtmGD+5SimpekoSSyFoZcp6cH/q+UQEDEjhyCrWOOcp0CvTygb/wiYBJEQEY
         bZag==
X-Gm-Message-State: AHQUAuapYFOMDrVlqNJkgyVocpZ2yMK38OabNSLBxPVBF/Lmik4R3Jv+
        DcaKivPn+qBqRlXT3CTwU9CeqRD5sYpUNw==
X-Google-Smtp-Source: AHgI3IZq61IN5m86dVQc408ea2ktRaKMZM761jfw4vTb3bsFxO5ETBbEBKPAHtZVejPCAZ6dmu7GLw==
X-Received: by 2002:a50:a622:: with SMTP id d31mr806956edc.228.1549308112645;
        Mon, 04 Feb 2019 11:21:52 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p7sm2713039ejb.15.2019.02.04.11.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 11:21:51 -0800 (PST)
Subject: Re: [PATCH] phy: bcm-sr-pcie: Change operation when PIPEMUX=1
To:     Ray Jui <ray.jui@broadcom.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Qingmin Liu <qingmin.liu@broadcom.com>
References: <20190204190745.93170-1-ray.jui@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <ff198f05-41bb-2c4e-6d28-7a4c0960646e@broadcom.com>
Date:   Mon, 4 Feb 2019 11:21:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204190745.93170-1-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

On 2019-02-04 11:07 a.m., Ray Jui wrote:
> From: Qingmin Liu <qingmin.liu@broadcom.com>
>
> When PIPEMIX=1, change the operation from 2x8 EP to 1x8 EP + 1x8 RC.
>
> Signed-off-by: Qingmin Liu <qingmin.liu@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/phy/broadcom/phy-bcm-sr-pcie.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
> index c10e95f86de5..96a3af126a78 100644
> --- a/drivers/phy/broadcom/phy-bcm-sr-pcie.c
> +++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
> @@ -78,8 +78,8 @@ struct sr_pcie_phy_core {
>   static const u8 pipemux_table[] = {
>   	/* PIPEMUX = 0, EP 1x16 */
>   	0x00,
> -	/* PIPEMUX = 1, EP 2x8 */
> -	0x00,
> +	/* PIPEMUX = 1, EP 1x8 + RC 1x8, core 7 */
> +	0x80,
>   	/* PIPEMUX = 2, EP 4x4 */
>   	0x00,
>   	/* PIPEMUX = 3, RC 2x8, cores 0, 7 */
