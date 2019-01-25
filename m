Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72296C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420092084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="yRDAgGEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfAYHpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:45:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40692 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAYHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:45:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so7549854lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L0lEpHFLUwZmc696tCbiA8DFSiVWc0cPrLdAUUT72so=;
        b=yRDAgGEX4MZXJ9xsugpkN5oXil1gMBARSbvV0bYpgKEkzVIdi+xYDJt88NlPWSvpVc
         R35XLX+9UkY7DPDyP8/+VB4SH35BS2WOnBtp0SUwdFNkAUsBV0WFZG1OroJ9XInp7dgw
         5LqlpsH+aUYOy8AZEJ+T3RbyivyvMpYPqNQ3nIHUpyq51FeTq2TrbSrFaHg1GvzgTCrd
         tNBL8ajVX0hhSSyiDq5P0XZKXQpSqK296T1X/JHtekKify4CX+AcfFg/7Ognu6HjL1zB
         WY6VuRrDJpGLuTK0wUF3DE2Q8wjSM0GuvtZOfQlOe/KHbOwaUy25jzYchn29QgFIKy3W
         Q3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L0lEpHFLUwZmc696tCbiA8DFSiVWc0cPrLdAUUT72so=;
        b=CbxIBDwCCjBOy1DJRBqBycvwSfhkG5846GAEjHe+7MF7NlasZusyAz6r87fNORxlwG
         YsIx88JV5xEm4+kE3vR4hdWZgGYzr6afQox8DE6YhWX185t4VAGNKVnGKpItGIxRjqGw
         IuQ5w1tuOlSufHtsV5kqH/3OD7CN+vOwyJPU/fAcZVjCfWwxcWXurQxYiqCvjzYz5Pkw
         UOeRgJGqTcaIZuAsknrZAefoIhKKTYtp2owLMft61E0b5xQKTpb/FFAk3LPAgAHO+lD6
         1IDm4JWSfIXpXrPS2bAUMHPc4eMcAF/Ri2MJLeQhrRBELPwJcVLKFNnN1xF4/WLaPfI1
         d81Q==
X-Gm-Message-State: AJcUukfio8fFQ8qZYxqN6ij0u3ybK6g3oWVXTMQIBziTCL7BKphzpo44
        qGmZkZ/tuxChmSnyLTVQExXunQ==
X-Google-Smtp-Source: ALg8bN7UJkt4hsqlHF4Y4QRPrZubEPmH5pskXbqZ+ZuothJGHreE7chU7qYKeZCaLyejb1TbOhBvCQ==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr8627818ljg.64.1548402346650;
        Thu, 24 Jan 2019 23:45:46 -0800 (PST)
Received: from [192.168.0.199] ([31.173.83.7])
        by smtp.gmail.com with ESMTPSA id z6sm1327304lfa.87.2019.01.24.23.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 23:45:45 -0800 (PST)
Subject: Re: [v4] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to the
 list
To:     Peng Ma <peng.ma@nxp.com>, shawnguo@kernel.org, axboe@kernel.dk
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.tang@nxp.com
References: <20190125033221.30333-1-peng.ma@nxp.com>
 <20190125033221.30333-2-peng.ma@nxp.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <7c0ed8e1-7d41-8594-fd9d-9e220cbb2ab1@cogentembedded.com>
Date:   Fri, 25 Jan 2019 10:45:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125033221.30333-2-peng.ma@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 25.01.2019 6:32, Peng Ma wrote:

> Add lxx2160a compatible to bindings documentation.

    lx2160a?

> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V4:
> 	- add lx2160a compatible to bindings doc
> 
>   .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> index 7c3ca0e..9ecc019 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> @@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
>   Required properties:
>     - reg: Physical base address and size of the controller's register area.
>     - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
> -    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a etc.
> +    chip could be ls1021a, ls1043a, ls1046a, ls1088a, ls2080a, lx2160a, etc.
>     - clocks: Input clock specifier. Refer to common clock bindings.
>     - interrupts: Interrupt specifier. Refer to interrupt binding.
>   

MBR, Sergei
