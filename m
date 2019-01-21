Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC12C37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8B220870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548112907;
	bh=2jR+Vk9WDKTq8PVTy30ZMUU1zjb78dqnEhTUDI4o1tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3lVeV0+8MfyAD6GuUo5OQ5GQtLdMdx8aEQ4uxj7Fh1pA/IttfTbs7rw/3TaaE0Ev
	 HAq62zBd7AC/OM8Fk9AoMfdNXTbs6h2NtcAE0s3xGOo4fHIG9CCYB5MnmSmjIBPq/Q
	 mFdIe4RMMYISKmKoMaK09/XDua96bFWIr43y4gEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfAUXVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:21:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39367 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfAUXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:21:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so22017513otl.6;
        Mon, 21 Jan 2019 15:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3aLepOCF+uotwf95clQAHFs7byia4fwLMbBrIPabVdg=;
        b=TqXnw51Hd/1B8G0cH68PBQGLlhjaF9AQwddJ3sS1kw3Fe/jqMH+rJKPTLH11Uqrzyt
         6gNSAITQQnNgDBRfOSyiHrMMM2CBT7DKTWiijeFkVvh8X/tq93d2l7csROO1bT38Z+bj
         /hIiywCG0wlGo44HJErHk2/4xcdCwkjT59tWQjqTgvcD+aID9R0neb861jtPE2Yib7cD
         y+/kKz2liSzvUkCU5k8HOH5etwxIFsanpXKDLSBCTrYyf9Bk9Ajl1WikeRfEENjok3zh
         HgkYRdkL/4x36LVXbJ7nblkv9KD5gdhAV9M683UbPYb43NrV08hz+p9edTFAGbh+DwXY
         0+Yw==
X-Gm-Message-State: AJcUukdqtpBzqHfviip2IyNVpiDx/TdIPi1FwFj45dot9svt3xVFaojQ
        mlFHtzigbky9k2q9MFS1pUaHXYkL4w==
X-Google-Smtp-Source: ALg8bN4nXtTccKyPwjt9CFEgJScjwyfO/cIUzI++WPW4qIVy+ExJ6xUFxRaOJzK8icC+clM5jEUPKA==
X-Received: by 2002:a9d:2184:: with SMTP id s4mr22077094otb.46.1548112904624;
        Mon, 21 Jan 2019 15:21:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 31sm9936552otw.55.2019.01.21.15.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 15:21:44 -0800 (PST)
Date:   Mon, 21 Jan 2019 17:21:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, zhang.chunyan@linaro.org, kishon@ti.com,
        adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, faiz_abbas@ti.com
Subject: Re: [PATCH 6/7] dt-bindings: sdhci-omap: Add am335x and am437x
 specific bindings
Message-ID: <20190121232143.GA15655@bogus>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-7-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111110851.6805-7-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 16:38:50 +0530, Faiz Abbas wrote:
> Add binding for the TI's sdhci-omap controller present in am335x and
> am437x devices.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
