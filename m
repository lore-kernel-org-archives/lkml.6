Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD921C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5363220854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5363220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeIIXu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:50:28 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:41738 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeIIXu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:50:27 -0400
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 7AA33200E1;
        Sun,  9 Sep 2018 21:59:45 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 152AA36C0F6; Sun,  9 Sep 2018 21:59:45 +0300 (EEST)
Date:   Sun, 9 Sep 2018 21:59:44 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, jgross@suse.com,
        Sinan Kaya <okaya@codeaurora.org>,
        Govinda Tatti <Govinda.Tatti@Oracle.COM>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        linux-pci@vger.kernel.org,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        linux-kernel@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        JBeulich@suse.com, Russell Currey <ruscur@russell.cc>,
        bhelgaas@google.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@Oracle.COM,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        roger.pau@citrix.com
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
Message-ID: <20180909185944.GC18222@reaktio.net>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
 <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
 <20171218122629.GA18423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218122629.GA18423@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2017 at 04:26:30AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 15, 2017 at 12:18:02PM -0600, Bjorn Helgaas wrote:
> > I think Christoph volunteered to do some restructuring, but I don't
> > know his timeframe.  If you can, I would probably wait for that
> > because there's so much overlap here.
> 
> I'll have some time over the holidays.  If you need it more urgent
> than that feel free to take over.
> 

Replying to an old thread..

I noticed pcie_has_flr() has been recently exported in upstream Linux:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d2917f7747805a1f4188672f308d82a8ba01700

Are there more changes / cleanups planned to these interfaces, as mentioned last year?

(context: xen-pciback reset/do_flr features upstreaming, which kind of stalled last year when pcie_has_flr() wasn't exported at the time)


Thanks,

-- Pasi

