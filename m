Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B25C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7561D21CF8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7561D21CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeHINQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:16:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbeHINQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:16:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E90A7A7EB;
        Thu,  9 Aug 2018 10:51:54 +0000 (UTC)
Received: from localhost (unknown [10.43.2.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2647B10073B1;
        Thu,  9 Aug 2018 10:51:53 +0000 (UTC)
Date:   Thu, 9 Aug 2018 12:51:52 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     valdis.kletnieks@vt.edu
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] fix build for MediaTek MT7610U USB wireless dongle
Message-ID: <20180809105151.GB1955@redhat.com>
References: <145751.1533759414@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145751.1533759414@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 10:51:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 10:51:54 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgruszka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 04:16:54PM -0400, valdis.kletnieks@vt.edu wrote:
> The mt76x0 driver requires the mt76 core driver to actually function.
> So add a 'select' to avoid embarrassing 'symbol unknown' errors
> when attempting to modprobe it in a module tree that doesn't
> include mt76.ko
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> Still need to figure out why it totally fails to see the 5gz band,
> it works find on 2.4 but ends up locked at 72mbits/sec. Works
> OK otherwise...

This may depend on HW configuration written in the EEPROM. My dongle
Linksys AE6000 do not require various features that Mediatek driver has,
those are not implemented in mt76x0 driver and should be added. Your
hardware may require those features.

You can try version of the driver from:
https://github.com/sgruszka/wireless-drivers-next/commits/mt76x0-draft-v2
which include various fixes and possibly can make things better
(or worse, there can be regressions too)

Cheers
Stanislaw
