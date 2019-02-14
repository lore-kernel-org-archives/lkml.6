Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49357C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40D5222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550158851;
	bh=Ys/JRlUwInZ//YAw6El2Lwes7mXQ4kudZsgFUBiWoZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=swl1sviq75CVDnGKsOudA/6+VUvpp6/zMUhM+uTGrfwSxv93WsFHNKSPL58LzN/by
	 dgwfIu2PfqUelYIZgYkAdubWvDRpGtSTK/rPqsfOG7VoHD/zbNMghp7jusedzj504S
	 D7l7032TKhhefEq4NlPO/NR2LToz4DXLkZUSSS/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502192AbfBNPkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:40:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40372 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502131AbfBNPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:40:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so11179656oth.7;
        Thu, 14 Feb 2019 07:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O4zx6lrYhss9eCTlwtAU8uUGC7JqXAu3X2XWpyIStrA=;
        b=kgSJPBsy6PzTkCibqTpznt3Nchoe6Gxg94neMWEPGfB41b1uA3G8KI3FteXJWuo2qe
         8Pn+XJyKkWzF+HPuc0vO3n/0BhaMs1vX5slj+NzlKYwJOfVGwOD8cxHpB28fhmSnvV6v
         lE6x8tVkBAjPtstIvecv9zkeJmsGvuIDJhZa4mIyxcG738/6jn+PzGQ9nEJsBkE7H7zx
         BbYbRfLmIoUu4srk9i+cX/n7VK6zgizYhT3ZScQ1iOqPRIM2WaEcCR+BZziSSWM1pf8s
         XeEcaoSfI9LmwnnShbJLGu/HBNu3m1S/iE8R1QJSGNic3JQsAICnVBLSwbft7/3e1bKq
         DU/Q==
X-Gm-Message-State: AHQUAuZkbbnqr2EuXC0ZOxaTqV185DezJMd7qR33GJBGHpvvlkqzzQal
        0hXTNJt6/g9EaqU/7U3HgA==
X-Google-Smtp-Source: AHgI3IbMxyveziC/tEx8GowAMgjC9lsH5AcHJ7ee86h6TwAY6I+SlimJoM2mc+XwsCmFRg9QMOXf+w==
X-Received: by 2002:a9d:6255:: with SMTP id i21mr925985otk.158.1550158848197;
        Thu, 14 Feb 2019 07:40:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f25sm1067625otl.75.2019.02.14.07.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 07:40:47 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:40:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, m.szyprowski@samsung.com,
        krzk@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: drm: panel: Add Samsung s6e63m0
 panel documentation
Message-ID: <20190214154047.GA17978@bogus>
References: <20190202142748.6830-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190202142748.6830-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Feb 2019 15:27:47 +0100, =?UTF-8?q?Pawe=C5=82=20Chmiel?= wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> This commit adds documentation for Samsung s6e63m0 AMOLED LCD panel
> driver.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Add missing subject prefix
>   - Rename reset-gpio to reset-gpios
>   - Add link to spi properites documentation. They're required
>     for driver to work
>   - Removed delay properties, which are now hardcoded in driver
>   - Removed display timings, which are now hardcoded in driver
> ---
>  .../display/panel/samsung,s6e63m0.txt         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
