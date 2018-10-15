Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FDBC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626AD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626AD20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeJPC72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:59:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36874 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeJPC71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:59:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so15997950oib.4;
        Mon, 15 Oct 2018 12:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tdmUhqPzFmnNBdbFHQ/pEi2xWR92/8l7IDiMtZdpJI0=;
        b=Ve9Dn8yaNkiHRioMsLSlzKU4Is5zF0RPfEgpaTI5K2lSQjKue4yqQRd0pGtfaXzhmV
         Ys3c1VW+b/YMiGEclmL1UOGKkzaqAVuZzLRUAk9yIv5Jiu+1elunBAyfJosF2d8UgMQ2
         J7vweaeeZa46UqZ0TG//uNwthTEdXjYYLyzZf7VCCshDKYMUZkmDMDsRAASxKebWn3hC
         gUeLJj/jaXNhkJ/hy30zXM4MMfjim1ATpyyfhygmTGKAxb8YhiW4ad70APxWzgtA1rQb
         Qc9h4tHHJ9XWZOOo8yV+Ta3P6+bYhMwRAV3aZWLttFpYygUOu1lfHM29pbuVfl3ox+Q2
         yvZg==
X-Gm-Message-State: ABuFfohUqydutTY4DjWzfHQCr8kY5EKVKeuaur09ttuJ4nbzM3K1XnK9
        BAUKOrxobd3UdzUwcRp+4w==
X-Google-Smtp-Source: ACcGV62HCcu9MfiUX0A10aMJrWidsE9aqD4DJFLT3jfcLT2qnrUUupKdkL9PlTKidPjolH5y7ZwjZQ==
X-Received: by 2002:aca:ab89:: with SMTP id u131-v6mr9353707oie.316.1539630773195;
        Mon, 15 Oct 2018 12:12:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u21sm3958450ota.81.2018.10.15.12.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 12:12:52 -0700 (PDT)
Date:   Mon, 15 Oct 2018 14:12:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh R <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: tiecap: Add TI AM654 SoC specific
 compatible
Message-ID: <20181015191251.GA8949@bogus>
References: <20181003170658.3835-1-vigneshr@ti.com>
 <20181003170658.3835-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003170658.3835-2-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 22:36:57 +0530, Vignesh R wrote:
> Add a new compatible string "ti,am654-ecap" to support PWM ECAP IP of
> TI AM654 SoC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
