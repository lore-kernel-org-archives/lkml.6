Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B48CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D190821582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D190821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeKNFcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:32:32 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40829 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeKNFcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:32:32 -0500
Received: by mail-ed1-f46.google.com with SMTP id d3so10953322edx.7;
        Tue, 13 Nov 2018 11:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CuEyhJnfCipbJuI0teaSCMq/UF7cmMmFP+xEs39AEIk=;
        b=mFrcS2FeVMS7DDjGM7iOH1RafYycs8Y/j13huCv4Pmfy0qYlDR+HWAGEekvFRK4Hib
         jHzTH+/aKzFYdw1ZZ6Ec1xF98XW1b+rcqsFAT5nxmpT5xxT10a3shRENv8j9fqOjzQBS
         7Xoruq9fAbgwzn94teRXODpV3y8f+BtBbKHaJRNWFaV9UO9RwlL8GfykouyrevBMIsZz
         aUnXh3Se70swJfN5VfaLpZ9BtPnXKl7o98W42Hc0WE8iY8S95qPy92DbZegjFOPDQfKt
         KnuaJeUB+RxMi2k8KDI2b6Hoh5WFmx1kRl9I3PRkJR08EHDyQCNHkJsWEo42sB9ct7Fn
         fnFw==
X-Gm-Message-State: AGRZ1gK6JTXu+CcE4lbHgp8qhLTBHg8SRUgdM77rrxbJ6h9xPVcb+p2U
        lL7MjWbdAjRFSraqG/5A77p2ajyi
X-Google-Smtp-Source: AJdET5ffv2QeFT0r4UEPQFYkSD4xuwnq8sE2pCTZFCSadFsulafyrOGKQ5nAP80+O6iO/4hCzN8//g==
X-Received: by 2002:a05:6402:3d1:: with SMTP id t17mr2444023edw.21.1542137577182;
        Tue, 13 Nov 2018 11:32:57 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id s3-v6sm1114785ejq.37.2018.11.13.11.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:32:56 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:32:54 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCHv5 2/6] ARM: dts: exynos: fix regulator min values of
 LDO13 for Odroid XU3/XU4
Message-ID: <20181113193254.GC2418@kozik-lap>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-3-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927140738.1006-3-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:07:34PM +0000, Anand Moon wrote:
> Looking at the schematic sd_2 min/max range from 1.8V/2.8V so fix the
> regulator min value to 1.8V. Without these changes sdcard will failed
> to detect on booting when UHS-I tuning is enabled.
> 

Thanks, applied.

Best regards,
Krzysztof

