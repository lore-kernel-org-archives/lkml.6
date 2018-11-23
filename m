Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732C3206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5wJBHb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732C3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440564AbeKXDWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:22:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436563AbeKXDWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:22:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so3260758pgp.13;
        Fri, 23 Nov 2018 08:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2OO9JLCiv0QQ2YHUJhV0LGmC+1FSc6oMK9jk9A/Jxo=;
        b=n5wJBHb8QpfaNnlzAphJPypyRp3EAFePrXseUwaQl2r7Onj+3BF2dVyXxBlr3Dsl6I
         Eg1j+bAGPxtAlefEUZ3nwumuys9+VhWr/bnEVyiU0FLZPqHfi42uGDZuluMHbhDaqz85
         rIAWcp6etbvRrVNeq4ROsWV7+qMPfVOkZlbrhLTFHJrlfe9US078QQ0f05zg9+bR9MU9
         GCQYCLcukosO1phljqWXktq1GzQHqCo4wN3WNCQZS6cMWybXyj0LxqD8rQrhREl+BIbd
         KLb6J+AKjrr6TJsvYak1+O+zLbfTu0kEDeYye9yy0Smkn+x1SCytbrYrzUFKU54KItHH
         jxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2OO9JLCiv0QQ2YHUJhV0LGmC+1FSc6oMK9jk9A/Jxo=;
        b=oHFbFpnYZktb58b52KDzgez4GhpyLZZ3YQz4ppBBQM0EHyvWh9V3gpgfMuLH9wbHyO
         Fg+6IneLX0pS3nsTfLTYuy/HUOQ2n4IS0/YFJ1QoDrsMf3cfcHFnPfpLor8O8woAVY3W
         3e3HgQ0nvKRF57sTQB26dHtmcYPRSBB5CttkCjkh8w3njrkNS7OomVmyqXBHh72ToWF7
         Qu626Q4kOCn7OnCyYNRaIX00A1/Pfil/IRdf4EnGAuWinGH+R7a4UpYXsqXMcUj/MnqB
         cW4ybV2xn0YEWD11ky8doJZ941KdUHZNLdMrriOBooeBglE1icBu0FhJ2MDMgTg96NW6
         ezIQ==
X-Gm-Message-State: AA+aEWa7aVAigWdR3s7zXd3yPUHLBEm/1uvxJZBOWVbnQCD44u9PtsLf
        T+aUxh1coFNb0gdsrrgRucBLDW1y
X-Google-Smtp-Source: AFSGD/Ur4Hod/aH1bLVD8N79a+pCSUONBQGBdx6Jbnuymv5r1q1i2nZ2F6cWf0whS0sgh3H0WTg/Yg==
X-Received: by 2002:a62:1d4c:: with SMTP id d73mr2768571pfd.90.1542991037020;
        Fri, 23 Nov 2018 08:37:17 -0800 (PST)
Received: from localhost (c-24-4-232-171.hsd1.ca.comcast.net. [24.4.232.171])
        by smtp.gmail.com with ESMTPSA id z186sm15146765pfz.119.2018.11.23.08.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 08:37:16 -0800 (PST)
Date:   Fri, 23 Nov 2018 08:37:14 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ptp: Fix pass zero to ERR_PTR() in
 ptp_clock_register
Message-ID: <20181123163714.rxp766mx63bnx4tb@localhost>
References: <20181123015455.24228-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123015455.24228-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:54:55AM +0800, YueHaibing wrote:
> @@ -264,6 +266,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  		pps.owner = info->owner;
>  		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
>  		if (!ptp->pps_source) {
> +			err = -EINVAL;

Bonus points:  The function, pps_register_source(), keeps error codes
in a local variable, but it does not make use of the code.  There are
only five callers of that function, and so it would be nice to let
pps_register_source() return the error code.

For the present patch:

Acked-by: Richard Cochran <richardcochran@gmail.com>
