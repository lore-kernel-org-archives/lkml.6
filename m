Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CCCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6562080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6562080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeKRCA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:00:59 -0500
Received: from muru.com ([72.249.23.125]:54344 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeKRCA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:00:59 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A9D3C809F;
        Sat, 17 Nov 2018 15:43:57 +0000 (UTC)
Date:   Sat, 17 Nov 2018 07:43:53 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] phy: core: Add phy_pm_runtime_enabled
Message-ID: <20181117154353.GM53235@atomide.com>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-2-tony@atomide.com>
 <20181117153845.GU19900@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117153845.GU19900@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [181117 15:38]:
> On Sat, Nov 17, 2018 at 05:37:54AM -0800, Tony Lindgren wrote:
> > The phy driver may need to check phy_pm_runtime_enabled() in suspend as
> > PM runtime for phy may be already disabled when phy power_off() is called.
> > 
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/phy/phy-core.c  | 9 +++++++++
> >  include/linux/phy/phy.h | 6 ++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> 
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -158,6 +158,7 @@ int phy_pm_runtime_get(struct phy *phy);
> >  int phy_pm_runtime_get_sync(struct phy *phy);
> >  int phy_pm_runtime_put(struct phy *phy);
> >  int phy_pm_runtime_put_sync(struct phy *phy);
> > +bool phy_pm_runtime_enabled(struct phy *phy);
> >  void phy_pm_runtime_allow(struct phy *phy);
> >  void phy_pm_runtime_forbid(struct phy *phy);
> >  int phy_init(struct phy *phy);
> > @@ -240,6 +241,11 @@ static inline int phy_pm_runtime_put_sync(struct phy *phy)
> >  	return -ENOSYS;
> >  }
> >  
> > +static inline bool phy_pm_runtime_enabled(struct phy *phy)
> > +{
> > +	return false
> 
> Missing semicolon.

Oops thanks for catching that. I guess I did not try building
without CONFIG_GENERIC_PHY. Will fix and repost.

Regards,

Tony
