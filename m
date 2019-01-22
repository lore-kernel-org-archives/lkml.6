Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC27C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A62B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAVVww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:52:52 -0500
Received: from mail.windriver.com ([147.11.1.11]:64799 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfAVVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:52:52 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0MLp538017516
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 22 Jan 2019 13:51:06 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Tue, 22 Jan 2019 13:51:05 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 39E682E0699; Tue, 22 Jan 2019 16:51:05 -0500 (EST)
Date:   Tue, 22 Jan 2019 16:51:05 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Sven Van Asbroeck <thesven73@gmail.com>, <svendev@arcx.com>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <lee.jones@linaro.org>, <mark.rutland@arm.com>,
        <treding@nvidia.com>, <david@lechnology.com>, <noralf@tronnes.org>,
        <johan@kernel.org>, <monstr@monstr.eu>, <michal.vokac@ysoft.com>,
        <arnd@arndb.de>, <john.garry@huawei.com>,
        <geert+renesas@glider.be>, <robin.murphy@arm.com>,
        <sebastien.bourdelin@savoirfairelinux.com>, <icenowy@aosc.io>,
        <stuyoder@gmail.com>, <maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190122215104.GI26416@windriver.com>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
 <20190122165658.GH26416@windriver.com>
 <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
 <20190122185246.GA922@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190122185246.GA922@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.] On 22/01/2019 (Tue 19:52) Greg KH wrote:

> On Tue, Jan 22, 2019 at 06:12:31PM +0100, Andreas Färber wrote:
> > Am 22.01.19 um 17:56 schrieb Paul Gortmaker:
> > > [[PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.] On 22/01/2019 (Tue 10:21) Sven Van Asbroeck wrote:

[...]

> > >> diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
> > >> new file mode 100644
> > >> index 000000000000..5c2bef950d04
> > >> --- /dev/null
> > >> +++ b/drivers/fieldbus/Kconfig
> > >> @@ -0,0 +1,19 @@
> > >> +menuconfig FIELDBUS_DEV
> > >> +	bool "Fieldbus Device Support"
> > > 
> > > OK, so the core support is NOT tristate, ie not modular,
> > 
> > Is that intentional though, and if so, why?
> > 
> > If possible, I would much rather see it changed to tristate and leave
> > all the metadata below.

[...]

> And I thought when I made the comment about this code being a module,
> that would be the change, not this one forcing it not to be :(

Apologies Greg, I didn't see that earlier comment.

Conversion to tristate is of course perfectly fine as well; I'm just
against the inconsistency and addition of unused code.  But tristate
solves both, and I usually mention that (but not this time...<sigh>)

I just default to suggesting removing the unused stuff, since it doesn't
change the runtime or implicitly expand the use case beyond what the
original author(s) intended.  Many times (just as here with fieldbus)
I just don't know enough about it to say whether modular has a use case.

Paul.
--

> 
> thanks,
> 
> greg k-h
