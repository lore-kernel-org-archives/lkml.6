Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C7C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B381A26323
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B381A26323
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933913AbeF0JBa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:01:30 -0400
Received: from te-l1mail2-out06a.puc.rediris.es ([130.206.19.88]:15703 "EHLO
        te-l1mail2-out06a.puc.rediris.es" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933529AbeF0JB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:01:28 -0400
X-IPAS-Result: =?us-ascii?q?A2HjAAAQUjNbly0YzoJcHAEBAQQBAQoBAYMqAQEBAQGCAYw?=
 =?us-ascii?q?lX4tlggeVFoF6C4RsAoMXITQYAQIBAQEBAQECAgIQAQEBAQEIFgZYhTkBAgM6P?=
 =?us-ascii?q?xALGAklD0gGgziBfwGvBYhNgRyIbYIVhB6ERoYKApkxCY8IjVWRc4EjHoILMxo?=
 =?us-ascii?q?IMDuCaoIwjiKRfwEB?=
X-IronPort-AV: E=Sophos;i="5.51,278,1526335200"; 
   d="scan'208";a="246574347"
Received: from mta-out03.sim.rediris.es ([130.206.24.45])
  by smtpout.puc.rediris.es with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 11:00:54 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out03.sim.rediris.es (Postfix) with ESMTP id ABA8999CEA;
        Wed, 27 Jun 2018 11:00:52 +0200 (CEST)
Received: from mta-out03.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out03.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uVhk20zTQkP1; Wed, 27 Jun 2018 11:00:46 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out03.sim.rediris.es (Postfix) with ESMTP id 80A2C99DA0;
        Wed, 27 Jun 2018 11:00:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from mta-out03.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out03.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QPyQsKYi8EKL; Wed, 27 Jun 2018 11:00:46 +0200 (CEST)
Received: from lt-gp.iram.es (dhcp-186.iram.es [150.214.224.186])
        by mta-out03.sim.rediris.es (Postfix) with ESMTPA id 0297999CEA;
        Wed, 27 Jun 2018 11:00:29 +0200 (CEST)
Date:   Wed, 27 Jun 2018 11:00:22 +0200
From:   Gabriel Paubert <paubert@iram.es>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
Message-ID: <20180627090022.rij2owx5durbc4e6@lt-gp.iram.es>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
 <874lhp6i4d.fsf@concordia.ellerman.id.au>
 <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
 <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 05:39:15PM +1200, Michael Schmitz wrote:
> Ben,
> 
> Am 27.06.2018 um 15:27 schrieb Benjamin Herrenschmidt:
> > On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
> > > > I will rewrite patch 10/12 after Arnd's fixes and this series have all
> > > > made their way through both powerpc and m68k trees, and submit it
> > > > separately.
> > > 
> > > drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
> > > series is high on his todo list.
> > 
> > We need at least to pull out a couple of powerbooks we have sitting in
> > drawers and try it out.
> 
> No need to root around in drawers - I'm sitting in front of one (G3
> Titanium) writing this. Let me know if that would help (I've forgotten most
> of what I knew about powerpc kernels).

A very rare model, all G3 I've seen were plastic, all Titanium were G4 :-)

	Cheers,
	Gabriel
	(still using my Pismo from time to time, but much less since
	sleep was broken)
