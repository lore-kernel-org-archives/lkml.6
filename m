Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF58C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629982150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629982150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934174AbeGDKXU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:23:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63120 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbeGDKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:23:18 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 44b6ab2906fb0cc6; Wed, 4 Jul 2018 12:23:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer ordering in device_kset
Date:   Wed, 04 Jul 2018 12:21:52 +0200
Message-ID: <6281446.GoJLz6Hq6C@aspire.rjw.lan>
In-Reply-To: <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 4, 2018 4:47:07 AM CEST Pingfan Liu wrote:
> On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > places an assumption of supplier<-consumer order on the process of probe.
> > > But it turns out to break down the parent <- child order in some scene.
> > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > > have been probed. Then comes the bridge's module, which enables extra
> > > feature(such as hotplug) on this bridge.
> >
> > So what *exactly* does happen in that case?
> >
> I saw the  shpc_probe() is called on the bridge, although the probing
> failed on that bare-metal. But if it success, then it will enable the
> hotplug feature on the bridge.

I don't understand what you are saying here, sorry.

device_reorder_to_tail() walks the entire device hierarchy below the target
and moves all of the children in there *after* their parents.

How can it break "the parent <- child order" then?

Thanks,
Rafael

