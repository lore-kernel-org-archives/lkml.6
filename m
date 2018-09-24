Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7162145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7162145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbeIXWVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:21:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36133 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeIXWVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:21:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id b7-v6so1813272pfo.3;
        Mon, 24 Sep 2018 09:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnBbz8Pjk2ZAawy3AJf5RIjkr5/NQEzBnwhpfoCAwIY=;
        b=eysEixqyF8CCgg/YomQK+Xlr+c/KJKqgDDQ5R5spuR+7fM/bn1aytzkaoFLZer7tMW
         sQ/ESHlrCghz9R+sdPimevaK0lv8uqLYYncMq8XVcDBkZ5TK+imfWWAC4D65uX3goVQG
         r8q/L2vx6Lk92WUA6URVKWL5CR0zMLSJkBWIuBOlVnd6WeTHaRhtjhOanCoR4Odw1FMR
         BEhSVrpsB26kwWw1k//zC7Oxih3wedUEeIWHVvQA3Yrhg9IQQopkvHsmaVFHg2QLJVGl
         AcpY0wf/2OfABANTqzOfy0HGNpnJlAdo87WwbF3LX9jjkZmSdM2xOtXz9tm6Kg802185
         EzKw==
X-Gm-Message-State: ABuFfoiaZjjngSttKv6w46w9UUvrie9DNrUFdxRWzP+/kLxxJtM8NokW
        UI4JIEAcfKJuQeAvNyg/DA==
X-Google-Smtp-Source: ACcGV62JWp58Oou4BN/VHTtwC2L3P2suZ0/eqUsrMpYv2pufp32zZ2vzc1DV8DanBYlhxESct+zKmA==
X-Received: by 2002:a63:5c10:: with SMTP id q16-v6mr10074507pgb.452.1537805926286;
        Mon, 24 Sep 2018 09:18:46 -0700 (PDT)
Received: from localhost (S01069050caa8e733.vc.shawcable.net. [24.85.230.93])
        by smtp.gmail.com with ESMTPSA id l10-v6sm75470913pfj.179.2018.09.24.09.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 09:18:45 -0700 (PDT)
Date:   Mon, 24 Sep 2018 09:18:44 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
Message-ID: <20180924161844.GA29028@bogus>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911170825.17789-4-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:08:22PM -0500, Dan Murphy wrote:
> Add the device tree bindings for the lm3697
> LED driver for backlighting and display.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v7 - Fix compatible from 3967 to 3697, and other comments. - https://lore.kernel.org/patchwork/patch/982550/
> 
> v6 - Fix minor issues - https://lore.kernel.org/patchwork/patch/975387/
> v5 - Fix the comment for the example - https://lore.kernel.org/patchwork/patch/975060/
> v4 - Removed HVLED definition in favor of HVLED place definition - https://lore.kernel.org/patchwork/patch/974812/
> v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
> 
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt

Reviewed-by: Rob Herring <robh@kernel.org>
