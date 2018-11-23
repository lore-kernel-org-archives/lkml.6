Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8622C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736F320824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736F320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436855AbeKXDnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:43:43 -0500
Received: from muru.com ([72.249.23.125]:54878 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393482AbeKXDnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:43:43 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0804680D4;
        Fri, 23 Nov 2018 16:58:42 +0000 (UTC)
Date:   Fri, 23 Nov 2018 08:58:38 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] phy: mapphone-mdm6600: Improve phy related runtime
 PM calls
Message-ID: <20181123165838.GF53235@atomide.com>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-3-tony@atomide.com>
 <ac3a7cdd-4f03-069f-844a-072e99759c83@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3a7cdd-4f03-069f-844a-072e99759c83@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [181123 07:59]:
> On 17/11/18 7:07 PM, Tony Lindgren wrote:
> > +	/* Allow aggressive PM for USB, it's only needed for n_gsm port */
> > +	if (phy_pm_runtime_enabled(ddata->generic_phy))
> > +		phy_pm_runtime_put(ddata->generic_phy);
> 
> phy_*() API's are generally added to be used by the consumer driver. I guess in
> this case we can directly use pm_runtime_enabled(x).

OK sure that works for me too.

Regards,

Tony
