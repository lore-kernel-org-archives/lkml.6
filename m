Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF5C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3117720869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfA3Ho3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:44:29 -0500
Received: from verein.lst.de ([213.95.11.211]:50668 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfA3Ho3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:44:29 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9623068CEC; Wed, 30 Jan 2019 08:44:27 +0100 (CET)
Date:   Wed, 30 Jan 2019 08:44:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is
 encrypted
Message-ID: <20190130074427.GA29516@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain> <87womn8inf.fsf@morokweng.localdomain> <20190129134750-mutt-send-email-mst@kernel.org> <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com> <20190129213137-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129213137-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> This has been discussed ad nauseum. virtio is all about compatibility.
> Losing a couple of lines of code isn't worth breaking working setups.
> People that want "just use DMA API no tricks" now have the option.
> Setting a flag in a feature bit map is literally a single line
> of code in the hypervisor. So stop pushing for breaking working
> legacy setups and just fix it in the right place.

I agree with the legacy aspect.  What I am missing is an extremely
strong wording that says you SHOULD always set this flag for new
hosts, including an explanation why.
