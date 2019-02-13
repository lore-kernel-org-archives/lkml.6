Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7EDC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75D12190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbfBMDAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:00:11 -0500
Received: from shell.v3.sk ([90.176.6.54]:54268 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388321AbfBMC75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:59:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B719D409C4;
        Wed, 13 Feb 2019 03:59:53 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oVcoxlVxVAXB; Wed, 13 Feb 2019 03:59:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 391FF100D07;
        Wed, 13 Feb 2019 03:59:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U7lbksvLzpNw; Wed, 13 Feb 2019 03:59:49 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3D62A409C4;
        Wed, 13 Feb 2019 03:59:49 +0100 (CET)
Message-ID: <4333cdaab9f550c924e47440f02f74e1c9b634fd.camel@v3.sk>
Subject: Re: [PATCH 4.9 034/137] ARM: mmp/mmp2: dt: enable the clock
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Date:   Wed, 13 Feb 2019 03:59:47 +0100
In-Reply-To: <20190212181151.GB2723@amd>
References: <20190211141811.964925535@linuxfoundation.org>
         <20190211141815.120436242@linuxfoundation.org> <20190211205125.GB22473@amd>
         <20190212165036.GE69686@sasha-vm> <20190212181151.GB2723@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-12 at 19:11 +0100, Pavel Machek wrote:
> On Tue 2019-02-12 11:50:36, Sasha Levin wrote:
> > On Mon, Feb 11, 2019 at 09:51:25PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > [ Upstream commit f36797ee43802b367e59f0f9a9805304a4ff0c98 ]
> > > > 
> > > > The device-tree booted MMP2 needs to enable the timer clock, otherwise
> > > > it would stop ticking when the boot finishes.
> > > > 
> > > > It can also use the clock rate from the clk, the non-DT boards need to
> > > > keep using the hardcoded rates.
> > > > 
> > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > Signed-off-by: Olof Johansson <olof@lixom.net>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > 
> > > While I agree this is good idea for mainline (thus my ack), I don't
> > > think it is suitable for stable, as older kernels will not run on OLPC
> > > in useful way, anyway.
> > 
> > Interesting, so OLPC doesn't run on 4.20?
> 
> These are for OLPC-1.75 (arm based). I'd be surprised if it booted
> there...
> 									Pavel

Fairly certain it doesn't boot -- even the proper DT compatible string
is not there. If it were, until 5.0-rc6 the keyboard wouldn't work,
thus the laptop would be really of pretty limited useuflness.

Lubo

