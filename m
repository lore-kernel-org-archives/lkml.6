Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0712080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="k9Wj1Ga6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0712080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeLMGve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41357 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeLMGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so691945lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sE4Z5OU4gaOrko8m/wFq96oa1vJFoTEj3lKqFuj+qR4=;
        b=k9Wj1Ga6Xy98cW4q6l5O5Kdqi3BlMMoVBstos1JvgNOZPvDnX33+fgG+3GN+LhDWEA
         tCPlFQ2D6Od8NWOwwttZPHN0qxQbrvshfKndW0VkCJ3RH3Rm63kduuRKN6qOShM+GAlx
         IncTIbOGS9Q3dLmW9U6o28vSAhS+TkDHZf500Rn1fiohLue2zraCsWwAvumr09sedUnY
         AD8x7OVaKhuGtuS/SHbgkD6690rIm5/IrMkTrs5sp2fh0INDnEAHFrOOnNesP1sTvcXj
         C9dvCMmQlPZCQnSsMn8s0VMuwZH//sk6+BGilb9kEgaAbeFTRuUXv3MlN9DaxvTWeeV8
         OXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sE4Z5OU4gaOrko8m/wFq96oa1vJFoTEj3lKqFuj+qR4=;
        b=Pu6OJnDjAf7kVYaIf9QyxsQgOqnbbI/RwZVx/DxgUbD2CMZz5yKUYpOW2BRDGyLlmv
         l6+tf79uAu72Wp4splWAxvMOLKgUnXS9DfWks9RJbvVtf8i/HWHuUvlZO7VMrb1e9UkF
         eS46SCKjLcWJHAuf/tqts15DcXuLcVZHDRHRqrMHfmDy6oQSr3BbpaNsTkrZDhDedi8K
         IfxQ7HbGVQ7Z4pyNgCd7Qw5+jRj/zRz77MdoeF83L0Q1MpW3hwvLue7+fcdwhwUgFlMG
         rhzLfEi1vy9RuAxGzv5HJcS9Xl8GZq4/RnP0p2W4COb1WA9W6kEtu2tRX+EETwmwDYTN
         AJeQ==
X-Gm-Message-State: AA+aEWbgsmK0Bg0lbF3FaD3Vq4JlFqGRuKFxkub92nQYYuvpb8XBEeNF
        3RbNT8fy3GYxn4NU4xM4cUtEKg==
X-Google-Smtp-Source: AFSGD/VLlqcEQhX9qCU3nPZBNtoDj6HHx3IuTrmydp7Sjr2ZYZIDZVyG/d5o8X4AiS79TN9wnHMPow==
X-Received: by 2002:a19:7111:: with SMTP id m17mr12886205lfc.64.1544683889839;
        Wed, 12 Dec 2018 22:51:29 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id j76-v6sm155849ljb.12.2018.12.12.22.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:28 -0800 (PST)
Date:   Wed, 12 Dec 2018 18:09:38 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
Message-ID: <20181213020938.oazz77dq4iat3ivc@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <281cd6fb-138a-956c-999b-58d9e04787c7@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <281cd6fb-138a-956c-999b-58d9e04787c7@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:00:28AM +0100, Marc Gonzalez wrote:
> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64, so remove it from
> the defconfig.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

No longer needed since patch 1 dropped it.


-Olof

