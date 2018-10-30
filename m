Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8882080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRelWKgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8882080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJaBO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:14:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41947 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeJaBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:14:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so13270947wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ruAu2s3XI3wC9qVttcspc//rcQncDe3bvOsBtuKXO2A=;
        b=ZRelWKghgOiU/5Mz2NrcdikDsgCMehbYDd84og5plBR/df782uN9+UgxhRVX5sr3ev
         l5ZhzAhXXO6EtcXif1TIGv6wB6qvGtuu6xHs1VfkQHpo4uuiB/oh0jCuGM4zv8MK+R0a
         11DMePWPjCToge95BIHZIrlF4FSa4wZEsXecY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ruAu2s3XI3wC9qVttcspc//rcQncDe3bvOsBtuKXO2A=;
        b=BpTozu9DoRp5aThZakoZW/UC31AIgNee/KXXz25/784i2Z5RSdDRNRS882WCA+JrRg
         A26RQ7IbVrgq1QsJVCTeLL8ywtPTvWbiJTbW8VtKPxEBlL3fzN2gnSLVlA9RYc5QIJK3
         WniTWX7BVQqPAhvZzJHw2u5/p+2Z5NYrzVDVTJ0T61uSqDNuZpTFuiV0oho14xCLAMyT
         aXVSCg87hxyC6QvMSWGRfvaAd2O5yxl5Hk+0iHKYNt4rvJuoXqfk6XjwBWbV4R4YkKKW
         xOQ1x4p7iAdMVAKBIlfiC4l+v7ehp0ZTP82IL/GyskH2t22Bt7bszaVD/vxAznJg6cwy
         2New==
X-Gm-Message-State: AGRZ1gJog+gkM9jGIWcs7uDeL0wPzfZOmom/ETW3MqL7MSDbmQ83Nx4w
        2ugwhQ3ljzUlA9SU/FoLukyugIZPpjQ=
X-Google-Smtp-Source: AJdET5fyuFAsrDDkbh+qnKxgHi0S42yX2f98NicpkW1MVJV/IH79qxu63fo9BnjW48QP+1uYqvgqTg==
X-Received: by 2002:adf:c389:: with SMTP id p9-v6mr19834105wrf.68.1540916446238;
        Tue, 30 Oct 2018 09:20:46 -0700 (PDT)
Received: from [192.168.0.40] (12.152.88.92.rev.sfr.net. [92.88.152.12])
        by smtp.googlemail.com with ESMTPSA id t143-v6sm13882771wmt.2.2018.10.30.09.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:20:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: armada: constify thermal_zone_of_device_ops
 structure
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     kernel-janitors@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540912500-21941-2-git-send-email-Julia.Lawall@lip6.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a7cdde4f-6d50-b01c-7dd3-5360b8d0e8cf@linaro.org>
Date:   Tue, 30 Oct 2018 17:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540912500-21941-2-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 16:14, Julia Lawall wrote:
> The thermal_zone_of_device_ops structure can be const as it is only
> passed as the last argument of devm_thermal_zone_of_sensor_register
> and the corresponding parameter is declared as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/thermal/armada_thermal.c |    2 +-

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

