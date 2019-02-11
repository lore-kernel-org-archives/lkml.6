Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF8021B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfBKSyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:54:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKSyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:54:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59639804E4;
        Mon, 11 Feb 2019 18:54:49 +0000 (UTC)
Received: from redhat.com (ovpn-123-21.rdu2.redhat.com [10.10.123.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 389C55C21D;
        Mon, 11 Feb 2019 18:54:47 +0000 (UTC)
Date:   Mon, 11 Feb 2019 13:54:45 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/9] mmu notifier provide context informations
Message-ID: <20190211185445.GA3838@redhat.com>
References: <20190123222315.1122-1-jglisse@redhat.com>
 <20190131161006.GA16593@redhat.com>
 <20190201210230.GA11643@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190201210230.GA11643@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 11 Feb 2019 18:54:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:02:30PM +0100, Jan Kara wrote:
> On Thu 31-01-19 11:10:06, Jerome Glisse wrote:
> > 
> > Andrew what is your plan for this ? I had a discussion with Peter Xu
> > and Andrea about change_pte() and kvm. Today the change_pte() kvm
> > optimization is effectively disabled because of invalidate_range
> > calls. With a minimal couple lines patch on top of this patchset
> > we can bring back the kvm change_pte optimization and we can also
> > optimize some other cases like for instance when write protecting
> > after fork (but i am not sure this is something qemu does often so
> > it might not help for real kvm workload).
> > 
> > I will be posting a the extra patch as an RFC, but in the meantime
> > i wanted to know what was the status for this.
> > 
> > Jan, Christian does your previous ACK still holds for this ?
> 
> Yes, I still think the approach makes sense. Dan's concern about in tree
> users is valid but it seems you have those just not merged yet, right?

(Catching up on email)

This version included some of the first users for this but i do not
want to merge them through Andrew but through the individual driver
project tree. Also in the meantime i found a use for this with kvm
and i expect few others users of mmu notifier will leverage this
extra informations.

Cheers,
Jérôme
