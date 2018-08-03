Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A32C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAE22173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAE22173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeHCLXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:23:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728122AbeHCLXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:23:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53F488198B00;
        Fri,  3 Aug 2018 09:28:25 +0000 (UTC)
Received: from localhost (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE072142F20;
        Fri,  3 Aug 2018 09:28:24 +0000 (UTC)
Date:   Fri, 3 Aug 2018 11:28:23 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mt76x0: build driver only as module
Message-ID: <20180803092822.GD10284@redhat.com>
References: <20180803091401.GB10284@redhat.com>
 <87zhy36c4n.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhy36c4n.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 09:28:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 09:28:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgruszka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 12:19:20PM +0300, Kalle Valo wrote:
> Stanislaw Gruszka <sgruszka@redhat.com> writes:
> 
> > There are various symbols that conflicts with mt7601u.
> > Due to that kernel will not build with allyesconfig.
> > For now limit the driver to be build only as module.
> >
> > Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> 
> Thanks for the quick patch!
> 
> > --- a/drivers/net/wireless/mediatek/mt76/Kconfig
> > +++ b/drivers/net/wireless/mediatek/mt76/Kconfig
> > @@ -11,7 +11,7 @@ config MT76x2_COMMON
> >  
> >  config MT76x0U
> >  	tristate "MediaTek MT76x0U (USB) support"
> > -	depends on MAC80211
> > +	depends on MAC80211 && m
> 
> But this feels like an ugly hack to me. Isn't there a better way to fix
> this? (I don't have time to investigate the error in detail right now.)

Yes, rename symbols names. And I will do this, just wanted to provide
quick fix for the problem. 

Moreover seems the same thing should be done for mt7601u to avoid build
errors and perhaps with mt76 :-( 

So I'm going to rename functions.

Regards
Stanislaw 
