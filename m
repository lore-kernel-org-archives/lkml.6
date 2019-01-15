Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51422C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD4720657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWPn4Vcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfAOMkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:40:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33670 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfAOMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:40:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so2835138wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvo2A1J+jR4ya7hyU8VK1xd5DbGgYfdWfD20nJ0t9xQ=;
        b=gWPn4VcfxeOhN1w4WMvw7yxrzVEj0yLYm823AxmR1IA8l4HC36X4mLkgEHVWkWgD6T
         8gvx18aAXy0pXsbPdur1zO36k+Pq4nVgm3MQ19g2eO4LkSY+PFwcFkDEqEg/I6X9hQ1u
         SPog5AO+T+pDroxDbqKtwrWNug8ausLCrjz+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvo2A1J+jR4ya7hyU8VK1xd5DbGgYfdWfD20nJ0t9xQ=;
        b=l8NVuCcpg9waIBWysuArwqkmW932MHZmSQ+WKGAU7oVP2D/zdR77QfvqLVxi3cQX3/
         FeE6k4Itnyugdtgr7887FMIJPLPSu2M/Jea8xj0tbG9hT3pH07emiTVd0nF9V7NpmJdx
         IycWokbXEWq5UkmPG5+jkKxbm7Ujhu+SrhylC7bsMpj4LmBhYhucaIgjlL46DMxG77L8
         MNoG8/7omqi7tXAcX6h2Pk7Y9AIFOJ+lIbl9hdRhzqMthTAx53xAZJ0ffA2TVOv/j87J
         V+DZXF9Yw5TeOZ02GX5vXE+MZn1ro8uLNgIzj4YZ+Mhimti/ZBA3gFskHe7EPPGNAzht
         wxhA==
X-Gm-Message-State: AJcUukcmKs+l2DFr3XJw3zEqhHptWMLFMQe2nGazLdA9Eo+1AkSsprFF
        0E8RscI3+4WsM8tGelwN+ipMI3Ntjj0=
X-Google-Smtp-Source: ALg8bN7pjQsttZCBxZCuxokp6nkNrC+VhK6im+KPulQC1XXk5cXLwi+cAN/dJANIc1WGXpFE0CJ5Gg==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr2855433wrj.91.1547556039027;
        Tue, 15 Jan 2019 04:40:39 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o81sm53102759wmd.10.2019.01.15.04.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 04:40:38 -0800 (PST)
Subject: Re: [PATCH 0/8] nvmem: Various small fixes and improvements
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-kernel@vger.kernel.org
References: <20190106192820.12558-1-albeu@free.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <de2ef429-0e9a-0104-93d4-502836fbe0b9@linaro.org>
Date:   Tue, 15 Jan 2019 12:40:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190106192820.12558-1-albeu@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2019 19:28, Alban Bedel wrote:
> Hi,
> 
> this series is mostly small bug fixes, but also add a new API
> to make things simpler in drivers that need to request an optional cell.
> 
> Alban Bedel (8):
>    nvmem: core: Set the provider read-only when no write callback is
>      given
>    nvmem: core: Fix of_nvmem_cell_get() for optional cells
>    nvmem: Add nvmem_cell_get_optional and devm_nvmem_cell_get_optional
>    nvmem: core: Fix cell lookup when no cell is found
>    nvmem: core: Properly handle connection ID in of_nvmem_device_get()
>    nvmem: core: Always reference the device returned by
>      nvmem_device_get()
>    nvmem: core: Fix device reference leak
>    nvmem: core: Avoid useless iterations in nvmem_cell_get_from_lookup()
> 
>   drivers/nvmem/core.c           | 86 +++++++++++++++++++++++++++-------
>   include/linux/nvmem-consumer.h | 16 +++++++
>   2 files changed, 86 insertions(+), 16 deletions(-)
> 

Thanks Alban for the work!
Most of the patches look good to me except nvmem_cell_get_optional()!

Will send out comments on that patch separately!

-srini
