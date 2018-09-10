Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE1C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E74204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1A3yde6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E74204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeIJUqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:46:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36237 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeIJUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:46:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so13441268wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lCsReFBE7ZC6cXwCAc0Ip/9iy8VbVO07xLTq0mmEJJo=;
        b=N1A3yde6nlvyxtmcNn2Go+sPWIcQwz4Ne4yY8v+M9enuSUVDNtYDcT3c/fQEsVXjMN
         Wu5WTm6xcQ28IUsV+o4rLNkBWS7Pq3TkorxeIl1OJGAVuVTB4DsXatm051Gfi9Ru1416
         eHFqXaiup0dMdW/CMN98Z4EWo6EKwldHFFZ3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lCsReFBE7ZC6cXwCAc0Ip/9iy8VbVO07xLTq0mmEJJo=;
        b=JchPqAZbonRDoj/AurVba3TPjji0nYpSzml7nFzBSBz8j3RCC2BuFPeVvUklVcWEGy
         L5IvXmt1QdmPet1NPq5lfeLDB8hU0OmxRPIfA+BAroWhaSORV7xw6e+cEubxbuXBqnAr
         SAyzBR8tjeJcPG97f/nRPjFkZFasZ08dny75Qm/BNOuWqLSK2JbiiZiPqrkUHUp4h0EL
         QH2iT0IVTI/QHIXJNtQ+okdQLNUE6qKxfbqdeS3pgqp59qA042IpiF3ologfMrpZmpL3
         eZJIFErl60nPufuBEnu27VydP7TBWlqAqgXb6ecQWkghGKjuhFSJqlz5pEyhEHS51cfB
         kBAg==
X-Gm-Message-State: APzg51DR9ddtrWm+TO2l50WZjOCF/VQevcflkqAim0unJbwCPmtWn3PU
        KZlTCGFb7y1v7jNVSYQMjY/C6A==
X-Google-Smtp-Source: ANB0VdbKyE1vnvjL/p92q8bHtcMj+O/t4BqO+h9fwRtbBQzB5iE8mLg7fZyFjUW2NrpiRbu6/3507g==
X-Received: by 2002:adf:ce06:: with SMTP id p6-v6mr16560058wrn.118.1536594696757;
        Mon, 10 Sep 2018 08:51:36 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id z141-v6sm14868051wmc.3.2018.09.10.08.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:51:35 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:51:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 4/7] mfd: intel_soc_pmic_bxtwc: Chain power button
 IRQs as well
Message-ID: <20180910155134.GJ28860@dell>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
 <20180830165255.43114-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830165255.43114-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Andy Shevchenko wrote:

> Power button IRQ actually has a second level of interrupts to
> distinguish between UI and POWER buttons. Moreover, current
> implementation looks awkward in approach to handle second level IRQs by
> first level related IRQ chip.
> 
> To address above issues, split power button IRQ to be chained as well.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 41 ++++++++++++++++++++++--------
>  include/linux/mfd/intel_soc_pmic.h |  1 +
>  2 files changed, 32 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
