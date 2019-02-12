Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B5DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30F621773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayQegR8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfBLIFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:05:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfBLIFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:05:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so1607107wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eHJkSX0fZXk9ABC8wJBTZEetst3yQeVYI3nsA3YALSs=;
        b=ayQegR8oQ7EhljFSSaOU9zzHliIVjm15DnGnbc1m7oxEnKNo5BFG5ZpVeibVjxOdnq
         2rm3UgvVuKjsAz7kdVbTgX2vMBVQoTFhPu6oMx/Qdi26CSm6lJim5v1Td4IatH8GA2ol
         arJF3y6EyD1f2fgGf1HE6reNnwPwYsmC81HKTKsAHBqRLR24orNFaK4xCQRdx5/k7hK/
         GJaqfcuY0zXdGueo4VtZ8GGTtbPN8bmReT/LxJ8PrzQ5ZOMOsi7PP06jG3wy9Wc4WgPA
         FMhVP1gDDN2cCPGCuYwGh97C8yUHGEQ363fCfZNiy/YFLDP4OfhXlJQHTjdYljjXPoPj
         Q/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eHJkSX0fZXk9ABC8wJBTZEetst3yQeVYI3nsA3YALSs=;
        b=ZQSfZhqIWXYZxXzSF+IyPwFW7eudN8yW7o18NfIS3kOJl8N5KXIHkqAWypoId0Hd1O
         vUj2OWAnfCAn450HqE4Eh0LziFYrbsl9BH2uM1vPLTybAVFDH4zTZBN5OHp5So/CFYi2
         qfWiY7KfqzneSNIDba9tAyXlhNtyawiO96hSvvnHJ1gXayNj61vlhoLDjiczw8EWlxEj
         ssbqcxBnJmNbJgBwvMUh3tdG944zFTM4GopEg3W12xfhROu2GJ3GHOly4ZEhO1sAEx1M
         6rfPDiP6AEyJrS4Xkrcfrb9ArnPUXi62OuZCXe8K9/ij4V+lZyqgd/ynCQHYSOTh4fVK
         SgoQ==
X-Gm-Message-State: AHQUAuZdeDisdzc7Ac1F8qol5jRwZ4W2hSkGA55zmiq2YizXc/TLBrHQ
        sXcnwwAvlMwRoDcFJ5JDimD4zQ==
X-Google-Smtp-Source: AHgI3Iap4TlQ8ImoYJ0OHK6SshccZnUhgDBYMwpfcWJ5SmW5D9q3Kf7humz1T3CoxCkY4DZ5zavxHQ==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr1870350wrn.262.1549958700005;
        Tue, 12 Feb 2019 00:05:00 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id p6sm4271293wre.63.2019.02.12.00.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:04:59 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:04:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     blaws05@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add max77620 charging & low battery support
Message-ID: <20190212080457.GL20638@dell>
References: <20190129085531.32364-1-markz@nvidia.com>
 <20190207084836.GF4672@dell>
 <a43eb007-c984-a209-2b4e-6672807029aa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a43eb007-c984-a209-2b4e-6672807029aa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Mark Zhang wrote:

> On 2/7/2019 4:48 PM, Lee Jones wrote:
> > On Tue, 29 Jan 2019, Mark Zhang wrote:
> > 
> >> This patch set adds support for max77620 backup battery charging and
> >> low battery monitoring.
> >>
> >> Changes in v2:
> >> - Add devicetree binding documentation
> >>
> >> Mark Zhang (4):
> >>   mfd: max77620: Add backup battery charger support
> >>   mfd: max77620: add documentation for backup battery charging
> >>   mfd: max77620: Add low battery monitor support
> >>   mfd: max77620: add documentation for low battery monitoring
> >>
> >>  .../devicetree/bindings/mfd/max77620.txt      |  34 +++++
> >>  drivers/mfd/max77620.c                        | 137 +++++++++++++++++-
> > 
> > All of this needs moving out to the correct subsystem.
> > 
> > drivers/power/supply/max77620-battery.c looks right.
> 
> Actually max77620 is not a power supply device. This patch set adds 2
> features:
> - Backup battery charger. The RTC in max77620 is supplied from a backup
> battery and consumes 2.0uA when no other power sources are available. So
> basically this is not a system battery charger, it's just for RTC.
> - Low battery monitoring. This is for monitoring the system main battery
> voltage, so max77620 can shutdown or reset the SoC accordingly. But I
> think this doesn't conform the idea of "power supply" driver as well.

Most other battery handling seems to happen in
drivers/power/supply/*.battery*.  If that's not the right location,
then you need to find a place for it to go.  MFDs do not provide
useful functionality per say - that is the role of the child devices.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
