Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757CDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387CD208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387CD208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeGQG5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:57:09 -0400
Received: from muru.com ([72.249.23.125]:51694 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbeGQG5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:57:09 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A466A80C5;
        Tue, 17 Jul 2018 06:29:21 +0000 (UTC)
Date:   Mon, 16 Jul 2018 23:26:08 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: v4.18-rc2 on droid4: screen turns red
Message-ID: <20180717062608.GY99251@atomide.com>
References: <20180630131812.GA549@amd>
 <20180711102655.GA6864@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711102655.GA6864@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180711 10:30]:
> Hi!
> 
> > After longer inactivity, attempt to wake up the screen results in
> > screen being completely red. Not too useful. I can still connect over
> > ssh.
> 
> Still there in -rc4 :-(. But happens only once in a few days for me...
> 
> When X is shut down, text console works ok.

FYI, I've been chasing an occasional hang with lapdock and it might
be related to the usb phy switching between usb and uart mode
spontaneously. And then the usb traffic can cause a sysrq trigger
potentially when the glitch happens. Not sure yet why it happens, it
might be related to lost cpcap interrupts still.

Anyways, so far looks like doing the following may have prevented
it. Well at least for about four days of uptime now:

# echo 0 > /proc/sys/kernel/sysrq

And no red screens here yet either. Care to check if this might
somehow also prevent your red screen issue?

Regards,

Tony



