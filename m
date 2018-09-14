Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C6ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1200220671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1200220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeINTbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:31:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINTbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:31:02 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C756D80466;
        Fri, 14 Sep 2018 14:16:20 +0000 (UTC)
Received: from redhat.com (ovpn-125-82.rdu2.redhat.com [10.10.125.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC4ED3091330;
        Fri, 14 Sep 2018 14:16:19 +0000 (UTC)
Date:   Fri, 14 Sep 2018 10:16:17 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org,
        Logan Gunthorpe <logang@deltatee.com>,
        alexander.h.duyck@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] mm, hmm: Use devm semantics for hmm_devmem_{add,
 remove}
Message-ID: <20180914141617.GC3826@redhat.com>
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680534781.453305.3660438915028111950.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180914131838.GF27141@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180914131838.GF27141@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 14 Sep 2018 14:16:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 03:18:38PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 12, 2018 at 07:22:27PM -0700, Dan Williams wrote:
> > devm semantics arrange for resources to be torn down when
> > device-driver-probe fails or when device-driver-release completes.
> > Similar to devm_memremap_pages() there is no need to support an explicit
> > remove operation when the users properly adhere to devm semantics.
> > 
> > Note that devm_kzalloc() automatically handles allocating node-local
> > memory.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Given that we have no single user of these function I still think we
> should just remove them.

It is in the process of being upstreamed:

https://cgit.freedesktop.org/~glisse/linux/log/?h=nouveau-hmm-v01

and more users are coming for other devices.

Yes it is taking time ... things never goes as planed.

Cheers,
Jérôme
