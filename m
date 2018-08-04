Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB0C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094672175E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094672175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeHDEjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 00:39:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:33782 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeHDEjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 00:39:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w741LQMO023472;
        Fri, 3 Aug 2018 20:21:27 -0500
Message-ID: <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        mpe@ellerman.id.au, hch@infradead.org, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com
Date:   Fri, 03 Aug 2018 20:21:26 -0500
In-Reply-To: <20180803220812-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
         <20180802235332-mutt-send-email-mst@kernel.org>
         <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
         <20180803220812-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
> > > > Please go through these patches and review whether this approach broadly
> > > > makes sense. I will appreciate suggestions, inputs, comments regarding
> > > > the patches or the approach in general. Thank you.
> > > 
> > > Jason did some work on profiling this. Unfortunately he reports
> > > about 4% extra overhead from this switch on x86 with no vIOMMU.
> > 
> > The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
> > guest and measure PPS on tap on host.
> > 
> > Thanks
> 
> Could you supply host configuration involved please?

I wonder how much of that could be caused by Spectre mitigations
blowing up indirect function calls...

Cheers,
Ben.


