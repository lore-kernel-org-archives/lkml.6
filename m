Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3EDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1392154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCtwkN3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1392154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388608AbeIUHLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:11:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37759 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeIUHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:11:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so5255180pgo.4;
        Thu, 20 Sep 2018 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LRNsEDpcWAtbNeodn/XRt21Et1GRIC3bDa4EWWSfFTc=;
        b=dCtwkN3ek2YJodxWnaSck0rFi/KKO6GGvXukKo4JP81CZgPjXm+y0X64zo/FM8mLNa
         GXcGoJE+CB3Kg5fjjZPt1Qv7SOeiba7FsTY4vONuVavDGmFMiqdcZGhMAYh2737qWxdF
         TqedycqEf5zfzuvBM1ip1onVR6WmV+X9iDx0QZp1ZyoNWb4XAMsg0wnxNpRs2FFSY5bq
         4tc+buuYvNwmg8dbG/c9ts4Y6jxwzUSgndshd9ibF+MIkjS+5tDpWyk0fbyDOIL1HWl8
         hR8J62BCFIrs6bnhzXSebZUIg709iwtnQflpL1EOiVtk4GJboX2x635bVzw1qqVJJyLw
         F9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRNsEDpcWAtbNeodn/XRt21Et1GRIC3bDa4EWWSfFTc=;
        b=A4/PyGPKQRWyTJvS1sh5d1eFy0D4ykgq30Y+9VkzJuU9HRd2z4PmEIRFW4S5TYhoPZ
         8a8CsnvPmUd4dMvbpXJr5egoMxolNRKxFcqn1Z2HQvdEzNeAT9aL3aQEBEudc97mwf13
         StPMbpY8mZTeuz25YoHZ3Ny/g338kPujoNM5GbefXqYvxutHavEXqhH4UzTz0awmsGNj
         G/JXk/kk+QWz4Bi72psxSHb+Jb3mjBqu7rLUVnvZuQhyet4vNZPFtCOoE3fxO0kMyI/k
         HbifoBtdFLWtqHrnmmlb4mfbRC7JYS3GRZjrsN2fncOZSlhJxS48gcCWAjvoxC0vMKon
         E67Q==
X-Gm-Message-State: APzg51C7T/eNjChPK5zha5WoU0yYOWXDcDU1GVXmHlVVRO+eaMkvnYKx
        x5rxgZv3AUS/oZyY+P9xcqs=
X-Google-Smtp-Source: ANB0Vdb0SKZeuhuyE6wHd6sdtqqdceIu8bc9/ao91DfZJV6edV+W73qCeJoPTryfzZOcaqlCUaTgWw==
X-Received: by 2002:a62:9bc9:: with SMTP id e70-v6mr42990647pfk.95.1537493090873;
        Thu, 20 Sep 2018 18:24:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n26-v6sm8167093pgd.45.2018.09.20.18.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 18:24:50 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:24:48 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180921012447.GB23354@Asurada-Nvidia.nvidia.com>
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
 <20180921000753.21846-2-nicoleotsuka@gmail.com>
 <d744da89-ebd3-6059-31bf-e65e4c3d2ea4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d744da89-ebd3-6059-31bf-e65e4c3d2ea4@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 05:45:07PM -0700, Guenter Roeck wrote:
> On 09/20/2018 05:07 PM, Nicolin Chen wrote:
> > +- ti,channel1-name:
> > +- ti,channel2-name:
> > +- ti,channel3-name:
> > +	The names of the input sources (described in the schematics)
> > +	Set the names with "NC" to indicate not-connected channels
> > +
> 
> I don't really think this is a good idea - first to specify sensor
> names this way, and much less specifying that "NC" means that a sensor
> shall be disconnected/disabled.

I will replace the NC with a bool property for disconnection.

> Also, if we define devicetree support for this chip, it should include
> all configuration options required to configure it. This should at
> the very least include shunt resistor values.

I plan to add them too but am doing it incrementally. I can
try to include them in the next version.

Thanks
Nicolin
