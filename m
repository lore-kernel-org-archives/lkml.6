Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECADC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1157720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeGYGLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeGYGLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:11:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C82A81DE7;
        Wed, 25 Jul 2018 05:01:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D45A5608F0;
        Wed, 25 Jul 2018 05:01:40 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 227464BB78;
        Wed, 25 Jul 2018 05:01:40 +0000 (UTC)
Date:   Wed, 25 Jul 2018 01:01:39 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        riel@surriel.com, niteshnarayanlal@hotmail.com, david@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com,
        hch@infradead.org, mst@redhat.com, stefanha@redhat.com,
        imammedo@redhat.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, nilal@redhat.com
Message-ID: <399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com>
In-Reply-To: <783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com> <20180713075232.9575-4-pagupta@redhat.com> <783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.58, 10.4.195.24]
Thread-Topic: qemu: Add virtio pmem device
Thread-Index: tzndw2ejgZ89fltK2iTGg78W32mpFA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 25 Jul 2018 05:01:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Eric,

> 
> On 07/13/2018 02:52 AM, Pankaj Gupta wrote:
> >   This patch adds virtio-pmem Qemu device.
> > 
> >   This device presents memory address range information to guest
> >   which is backed by file backend type. It acts like persistent
> >   memory device for KVM guest. Guest can perform read and persistent
> >   write operations on this memory range with the help of DAX capable
> >   filesystem.
> > 
> >   Persistent guest writes are assured with the help of virtio based
> >   flushing interface. When guest userspace space performs fsync on
> >   file fd on pmem device, a flush command is send to Qemu over VIRTIO
> >   and host side flush/sync is done on backing image file.
> > 
> > Changes from RFC v2:
> 
> This patch has no n/M in the subject line; but is included in a thread
> that also has a 0/2 cover letter, as well as 1/2 and 2/2 patches in
> separate mails.  Is that intentional?

Yes, kernel series has 0-2 patches and Qemu has this one. I thought its
good to keep separate numbering for both the sets.  
> 
> When sending revision notes on a specific patch, it's best to place them...

Sure.
> 
> > - Use aio_worker() to avoid Qemu from hanging with blocking fsync
> >    call - Stefan
> > - Use virtio_st*_p() for endianess - Stefan
> > - Correct indentation in qapi/misc.json - Eric
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> 
> ...here, after the --- separator. They are useful to reviewers on the
> list, but are stripped by 'git am' as they don't need to be part of the
> git history (a year from now, we won't care how many iterations the
> patch went through during review, only what actually landed).
> 
> 
> > +++ b/qapi/misc.json
> > @@ -2907,6 +2907,29 @@
> >             }
> >   }
> >   
> > +##
> > +# @VirtioPMemDeviceInfo:
> > +#
> > +# VirtioPMem state information
> > +#
> > +# @id: device's ID
> > +#
> > +# @start: physical address, where device is mapped
> > +#
> > +# @size: size of memory that the device provides
> > +#
> > +# @memdev: memory backend linked with device
> > +#
> > +# Since: 2.13
> 
> There is no 2.13 release, and you've missed the 3.0 window.  Please
> update this and any other version reference to 3.1.

okay.

Thanks,
Pankaj
