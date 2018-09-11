Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01438C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D302086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcnPOVnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D302086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeIKXOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:14:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33707 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeIKXOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:14:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so27077066wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wWaWE4RVwEVgDTMYn9y7Utj0IhGI1E3Ilk/8NF0lMI0=;
        b=UcnPOVnEGIgBsYf250Px/BTX3aWV0X7Z12W+K4v1kILMceiooLC4WkamM6a3IU8PfW
         iUa5TuEfK711JsnhfGzhE5FAFkVglCTVRlx5OHvtOAzTIFHa3rxOWzVyTJlUhvmRy7a9
         vgjPehEHUTK2npx8ZgG3sBNdcC+/0M44gil2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wWaWE4RVwEVgDTMYn9y7Utj0IhGI1E3Ilk/8NF0lMI0=;
        b=gVVlONtxw5cvbLh4+aSu69ZzswVEYtOg75kn7xb2XBfO1pE5mgCzTIvyykqH3g4U3a
         BK2pwUuKJC+AagHMO/QxC7aN3a5ikzdzT0/12yrQa+z2B++yUKOxcMleGA6Df2XvdAto
         zgDbI/cD5fkCRHR1bbuVnRA0rdA6G6v2dNtd3bUYOAspAeL7NgD2jlRhmIe99Jv5C4sD
         YKUWOLGwIpWR6ySZMtD3zlywRmgR5EfimG/NNAQVOIPz6/JmT+No+aEbCjl7sD0TzG+N
         ZaC1vTcwtAYjYU05jAAR0OnkZR36DgEAs96QWVLElXeQkB/sxFzJz18EfyviSxlDWZ+Q
         2s8w==
X-Gm-Message-State: APzg51A6QNRTknGHTykXQlnJEf5KUhl/M05CcA0sIkU9mu3J8aiwT2eM
        kpHynrSravdNxC9tg4z9AFhBhg==
X-Google-Smtp-Source: ANB0VdZ0rAh/jim6lTDxJCl0i1xQUzfHkvKMxwaaA1QdzYDpAhrkmEaMHHlvvQYFijwAbvJLCWwOhg==
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr18809802wrv.194.1536689658977;
        Tue, 11 Sep 2018 11:14:18 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id u40-v6sm33710666wrc.43.2018.09.11.11.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:14:18 -0700 (PDT)
Date:   Tue, 11 Sep 2018 19:14:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20180911181415.GH4185@dell>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911170825.17789-2-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Dan Murphy wrote:

> Remove support for the LM3697 LED device
> from the ti-lmu.  The LM3697 will be supported
> via a stand alone LED driver.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v7 - New change for the series based on the comments in https://lore.kernel.org/patchwork/patch/982550/
> 
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
