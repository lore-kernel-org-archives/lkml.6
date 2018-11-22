Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7369DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3650D2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lgc03b/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3650D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395537AbeKWBGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:06:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbeKWBGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:06:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so9329202wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tldtn2RJ0zk4GMwH1e+zkp94u0Tc4YdrU+VsSXeOlX0=;
        b=Lgc03b/+627DpgtouN7mvnpK9lxuv21k38RP4NQmdqKNtfS9Fr1y5dMvxmAUEeXDdt
         je56jZ+y5A5k+sEntJ/Da3ll+f4YzyKYw5o5btDFlLz8FnRND1IfmC9DoO2bYHSQH4O+
         060RgSGdijz6d8sktaHlCxy2FE8VkhziBITws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tldtn2RJ0zk4GMwH1e+zkp94u0Tc4YdrU+VsSXeOlX0=;
        b=VlduUGTpqVF3RJk0iPuH1g06FFf0qVCHMK4Fi/Qpb+ZmzZ4H/oLSra8+T47BFwwlaC
         PRjs7AhOrxpnoajfnS/yl+3jztcQZND5mZraPysL8pH/mvUaulPDdkKcFtybmazNkwaU
         lMC0JPOL16XJQbgV8IRPrNom9sm0Sn87vfnjk4Pfl3f7Z2AuZAgb8sP8bL8pRlFGHVkH
         uW+/Y+H+xpufd9YJI6GfYn+CrFa0azFWuBACOeg4LxvtLzW/b3Bd0KZQxeI/ya8fIC3d
         KnQu69nlucsBHkI+wQwSoKb6Gpp0OuPBVlEGA9rcyOwyzzlpoDJVwdr+N6cukLgAnJuF
         VD5w==
X-Gm-Message-State: AGRZ1gI7b+cHHDxrtQtqP4ZBxtC1krAB3cm6VRd6l2D7gtNwKl9UARO6
        IMuDgzb6vzVCdeR8Pqrm+DjuBeX4ztU=
X-Google-Smtp-Source: AFSGD/XRwUywCijkQWNGdyGvI2wAyXDvC+pDfGhdRi35h0cHXdCvSYQvkiYy0lGIWunmJohA4+JimA==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr9699412wmd.15.1542896801806;
        Thu, 22 Nov 2018 06:26:41 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id 125-v6sm4994492wmm.25.2018.11.22.06.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:26:41 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
Date:   Thu, 22 Nov 2018 15:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120131853.19710-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2018 14:18, Yangtao Li wrote:
> use of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied, thanks!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

