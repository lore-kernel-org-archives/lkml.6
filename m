Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B194C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0020815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C0020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeKSAcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:32:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36875 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeKSAca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:32:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so15071984wru.4;
        Sun, 18 Nov 2018 06:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DP+V6Y+qyZ4As50VwfhpTwciZMciM8XQ8mUlbv2/yVQ=;
        b=R/8UoQf2A98fXK9hz2eTt169+qImI645nNLMSTV2kYkVLBzpWOFI+MVZsvd2RwM+GB
         aL+iByqJTxP69ag+z0XYgHXZF1WEmNfkehDEYQKAcYmGBYJR4UdWD2OSlmwc8HHYRjUY
         3LFaI0cuqZTkSOxVhSd/JptdzELUfrVy/JF+4dG4dH5hnKQ4u1sz4FBJlC0S9tWbRcEi
         dn0neULJId77i/DmVbn4tJ32kjTvZQh5MNcstJYYKjDkFZ9zGCQUI1VzAJpdgerZ1AZ3
         WzeCHAscesFNWRUyXAqVhfm2ovxHMqb0u1h2IvKTwezmM9BJLOW5PxCs4k72ayICAjMZ
         lz2Q==
X-Gm-Message-State: AGRZ1gK0nrnw5VoTb5yHlkwmvFFBwZb3oPWQNbxor0afIUfVX7+P+6lA
        Kg9Wdj4hQgpI4oHHx0o+m5Y=
X-Google-Smtp-Source: AJdET5e3OoCf0tfR0yLh81FKVyUarj6WAQB2RIaxnSi7FITb35RGeDSDv3LEI4vYQiawgSKJ9j853g==
X-Received: by 2002:adf:e08c:: with SMTP id c12mr14448906wri.199.1542550323901;
        Sun, 18 Nov 2018 06:12:03 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id l79-v6sm55257750wma.26.2018.11.18.06.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 06:12:03 -0800 (PST)
Date:   Sun, 18 Nov 2018 15:12:01 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
Message-ID: <20181118141201.GA18926@kozik-lap>
References: <CGME20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e@eucas1p1.samsung.com>
 <f38311a0-ed37-49e6-cae1-62dfb30c7325@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f38311a0-ed37-49e6-cae1-62dfb30c7325@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 04:30:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
> config option) is not working properly (debug messages are not
> displayed after resume) on Exynos platforms because GPIOs restore
> code is not implemented.
> 
> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
> Then convert Exynos code to not require <plat/pm-common.h>
> header (use pr_debug() directly instead of S3C_PMDBG() macro and
> remove redundant s3c_pm_*() calls).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v4:
> - rebased on top of next-20181114

Thanks, applied.

Best regards,
Krzysztof

