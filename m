Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF91FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9720C2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9720C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLDVJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:09:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45589 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:09:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id b141so15583644oii.12;
        Tue, 04 Dec 2018 13:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oWN0muPCxWEvdrrM7qCZgZE1sNt+tNjYLT1udMj1RS0=;
        b=Ffz/wETUgLKdSXAMXOlTmLt67YVzGQwV+4RVfNZ5MirufuaKIzch5DLL02lr455XVt
         syfVnsYrCFGDVIYkEMl2fAiIxCZlV4gws29VkAklCgz+5PO9dTUVgV05IvoXLHdjhCbH
         L+qhxcY0g+HlrzjGFZdBmuypHqDuD0Q+EVSSPZXFJk6PgAww1PDWgAkCeDKv3Ebrxb4F
         w14FsZrliLvv/F3U4wXvVXzwFMOLh5PJ5NBKdXht5dS2fMXwRPZIce/Tn9cRd337IImV
         2QKU4A33glbmSy/fPkk27D44qzdvXoLevi0ZdnbROfm2nSTfT4+XUjMd+gQkdcoKn+lL
         JMYg==
X-Gm-Message-State: AA+aEWY8jFEmK+zg+wV7OFfrQZHq6OXtcPhqlJbbX1ruRoBNgvkhzTAq
        ARVKCZ1ZKCpt8DxUJrckbg==
X-Google-Smtp-Source: AFSGD/UpkL0ktnW0OxLQzJM9/JbjHYPQjt7jbhab4f+1dcu9icNgzoPaGiwVGwcckc7tfNkfEMjwew==
X-Received: by 2002:aca:bcc6:: with SMTP id m189mr13943572oif.337.1543957773388;
        Tue, 04 Dec 2018 13:09:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm14179922otp.34.2018.12.04.13.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:09:32 -0800 (PST)
Date:   Tue, 4 Dec 2018 15:09:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: power: supply: Add nvmem properties to
 calibrate FGU
Message-ID: <20181204210932.GA26066@bogus>
References: <cover.1542185618.git.baolin.wang@linaro.org>
 <09143dca85a260cb6c3abc5efcf09075a8050265.1542185618.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09143dca85a260cb6c3abc5efcf09075a8050265.1542185618.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 17:07:04 +0800, Baolin Wang wrote:
> Add nvmem properties to calibrate FGU from eFuse controller.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
