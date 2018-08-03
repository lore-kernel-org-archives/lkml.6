Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA94121717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA94121717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeHCLRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:17:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732374AbeHCLRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:17:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86B6A81663FE;
        Fri,  3 Aug 2018 09:21:55 +0000 (UTC)
Received: from localhost (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D9137C3E;
        Fri,  3 Aug 2018 09:21:54 +0000 (UTC)
Date:   Fri, 3 Aug 2018 11:21:54 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the
 wireless-drivers-next tree
Message-ID: <20180803092152.GC10284@redhat.com>
References: <20180803182942.4de98df2@canb.auug.org.au>
 <20180803091140.GA10284@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803091140.GA10284@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 09:21:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 09:21:55 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgruszka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 11:11:40AM +0200, Stanislaw Gruszka wrote:
> Hi
> 
> On Fri, Aug 03, 2018 at 06:29:42PM +1000, Stephen Rothwell wrote:
> > After merging the wireless-drivers-next tree, today's linux-next build
> > (powerpc allyesconfig) failed like this:
> [snip]
> > diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
> > index 850611ad347a..ad56b3ed2be2 100644
> > --- a/drivers/net/wireless/mediatek/mt76/Kconfig
> > +++ b/drivers/net/wireless/mediatek/mt76/Kconfig
> > @@ -13,6 +13,7 @@ config MT76x0U
> >  	tristate "MediaTek MT76x0U (USB) support"
> >  	depends on MAC80211
> >  	depends on USB
> > +	depends on BROKEN
> Would be better to limit driver to be build as module.
> Hopefully that will fix the issue. I'll post patch in a moment.

Ok, I made config allyesconfig and .config file looks like this:

CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=y
CONFIG_MT76_CORE=y
CONFIG_MT76_USB=y
CONFIG_MT76x2_COMMON=y
CONFIG_MT76x0U=m

However I still not sure if kernel will build this way.
Because there can be conflict between kernel symbols
and module symbols. So looks as part of quick fix
mt7601u should be build also as module. And slower
fix will be to rename symbosl names in mt76x0 driver.

Regards
Stanislaw
