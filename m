Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F2421486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2421486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeIXRlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbeIXRlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B33203082E24;
        Mon, 24 Sep 2018 11:40:12 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8267B5C20D;
        Mon, 24 Sep 2018 11:40:12 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3E4441808855;
        Mon, 24 Sep 2018 11:40:12 +0000 (UTC)
Date:   Mon, 24 Sep 2018 07:40:11 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ross Zwisler <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>
Message-ID: <247764824.15598220.1537789211903.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4jFimkVnVuzza5TCG=KvY88KZnXzH4GNEgUBbTouprzJA@mail.gmail.com>
References: <20180831133019.27579-1-pagupta@redhat.com> <20180831133019.27579-2-pagupta@redhat.com> <CAPcyv4jFimkVnVuzza5TCG=KvY88KZnXzH4GNEgUBbTouprzJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] nd: move nd_region to common header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.59, 10.4.195.16]
Thread-Topic: move nd_region to common header
Thread-Index: IsiqCHf2PcKye+jwo9EBjSvu5SaxSQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 24 Sep 2018 11:40:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH 1/3] nd: move nd_region to common header
> 
> On Fri, Aug 31, 2018 at 6:31 AM Pankaj Gupta <pagupta@redhat.com> wrote:
> >
> > This patch moves nd_region definition to common header
> > include/linux/nd.h file. This is required for flush callback
> > support for both virtio-pmem & pmem driver.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/nd.h | 39 ---------------------------------------
> >  include/linux/nd.h  | 40 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+), 39 deletions(-)
> 
> No, we need to find a way to do this without dumping all of these
> internal details to a public / global header.

This is required when virtio_pmem driver accesses fields of nd_region struct. 
Instead if we pass device pointer in place of nd_region, we don't need to put
this in global header. Thoughts?

e.g virtio_pmem_flush(struct device *dev)

Thanks,
Pankaj 
