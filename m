Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA219C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799BB207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfBVFhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:37:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfBVFhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:37:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 845233097076;
        Fri, 22 Feb 2019 05:37:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16A5F600C2;
        Fri, 22 Feb 2019 05:37:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 160E211AAB; Fri, 22 Feb 2019 06:37:47 +0100 (CET)
Date:   Fri, 22 Feb 2019 06:37:47 +0100
From:   "kraxel@redhat.com" <kraxel@redhat.com>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] drm/bochs: Fix the ID mismatch error
Message-ID: <20190222053747.rhed6j6nyi6tmg4l@sirius.home.kraxel.org>
References: <20190221003231.31625-1-alistair.francis@wdc.com>
 <20190221115227.ipwjpn3xm4q7jfg2@sirius.home.kraxel.org>
 <CAKmqyKM_pb-riJ+jO65eT0SsVDxrstPOgurPuDf92Fd4C8k1Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKM_pb-riJ+jO65eT0SsVDxrstPOgurPuDf92Fd4C8k1Ug@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 22 Feb 2019 05:37:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:44:06AM -0800, Alistair Francis wrote:
> On Thu, Feb 21, 2019 at 3:52 AM kraxel@redhat.com <kraxel@redhat.com> wrote:
> >
> > On Thu, Feb 21, 2019 at 12:33:03AM +0000, Alistair Francis wrote:
> > > When running RISC-V QEMU with the Bochs device attached via PCIe the
> > > probe of the Bochs device fails with:
> > >     [drm:bochs_hw_init] *ERROR* ID mismatch
> > >
> > > This was introduced by this commit:
> > >     7780eb9ce8 bochs: convert to drm_dev_register
> > >
> > > To fix the error we ensure that pci_enable_device() is called before
> > > bochs_load().
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> >
> > Pushed to drm-misc-fixes.
> 
> Thanks. Any chance this will make it into 5.0?

Hmm, we are damn close to the release, not sure there will be one more
drm-fixes pull req.  But I've added a proper Fixes: tag, so even if the
patch misses the boat it should land in the stable branches shortly
thereafter.

cheers,
  Gerd

