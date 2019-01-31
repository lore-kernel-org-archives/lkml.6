Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527B020881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfAaTzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:55:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfAaTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:55:38 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B13464860;
        Thu, 31 Jan 2019 19:55:36 +0000 (UTC)
Date:   Thu, 31 Jan 2019 11:55:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/9] mmu notifier provide context informations
Message-Id: <20190131115535.7eeecf501615f8bad2f139eb@linux-foundation.org>
In-Reply-To: <20190131161006.GA16593@redhat.com>
References: <20190123222315.1122-1-jglisse@redhat.com>
        <20190131161006.GA16593@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 11:10:06 -0500 Jerome Glisse <jglisse@redhat.com> wrote:

> Andrew what is your plan for this ? I had a discussion with Peter Xu
> and Andrea about change_pte() and kvm. Today the change_pte() kvm
> optimization is effectively disabled because of invalidate_range
> calls. With a minimal couple lines patch on top of this patchset
> we can bring back the kvm change_pte optimization and we can also
> optimize some other cases like for instance when write protecting
> after fork (but i am not sure this is something qemu does often so
> it might not help for real kvm workload).
> 
> I will be posting a the extra patch as an RFC, but in the meantime
> i wanted to know what was the status for this.

The various drm patches appear to be headed for collisions with drm
tree development so we'll need to figure out how to handle that and in
what order things happen.

It's quite unclear from the v4 patchset's changelogs that this has
anything to do with KVM and "the change_pte() kvm optimization" hasn't
been described anywhere(?).

So..  I expect the thing to do here is to get everything finished, get
the changelogs completed with this new information and do a resend.

Can we omit the drm and rdma patches for now?  Feed them in via the
subsystem maintainers when the dust has settled?

