Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9A525543
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9A525543
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934034AbeGBJcu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:32:50 -0400
Received: from muru.com ([72.249.23.125]:49452 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933423AbeGBJcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:32:46 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0EB768047;
        Mon,  2 Jul 2018 09:35:40 +0000 (UTC)
Date:   Mon, 2 Jul 2018 02:32:43 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Samuel Morris <samorris@lexmark.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Tejun Heo <tj@kernel.org>, linux-omap@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Message-ID: <20180702093243.GO112168@atomide.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com>
 <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
 <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
 <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
 <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Roger Quadros <rogerq@ti.com> [180621 14:56]:
> On 21/06/18 17:31, Samuel Morris wrote:
> > On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wrote:
> >> +Rafael
> >>
> >> On 20/06/18 18:30, Samuel Morris wrote:
> >>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:
> >>>> Tony,
> >>>>
> >>>> On 20/06/18 13:29, Tony Lindgren wrote:
> >>>>> Hi,
> >>>>>
> >>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:
> >>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.
> >>>>>
> >>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
> >>>>> hotplug to save power").
> >>>>>
> >>>>> Reverting the patch makes things work again. Any ideas what
> >>>>> might be going wrong here? Things clearly idle but then there
> >>>>> seems to be some register access with clocks disabled.

So this issue is still happening as of next-20180702. Can you guys
please revert the commit above while working on a better solution?

Regards,

Tony
