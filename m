Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823ABC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F79206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfBVRVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:21:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVRVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:21:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFAE3C057F4F;
        Fri, 22 Feb 2019 17:21:43 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E97F85C647;
        Fri, 22 Feb 2019 17:21:42 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] libnvdimm/pfn: Fix 'start_pad' implementation
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
        <155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com>
        <x49ftsgsnzp.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4h9s1jYROGqkMfKk0MNBUedP=vQ1nJObLRwFiTB405nOg@mail.gmail.com>
        <x49imxbx22d.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jweuVTm6D2OTaAMGvUXfxqZMDPfaASJ=QL9=8SdGUZqg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 22 Feb 2019 12:21:41 -0500
In-Reply-To: <CAPcyv4jweuVTm6D2OTaAMGvUXfxqZMDPfaASJ=QL9=8SdGUZqg@mail.gmail.com>
        (Dan Williams's message of "Fri, 22 Feb 2019 09:12:37 -0800")
Message-ID: <x49a7inwxga.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 22 Feb 2019 17:21:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

>> Great!  Now let's create another one.
>>
>> # ndctl create-namespace -m fsdax -s 132m
>> libndctl: ndctl_pfn_enable: pfn1.1: failed to enable
>>   Error: namespace1.2: failed to enable
>>
>> failed to create namespace: No such device or address
>>
>> (along with a kernel warning spew)
>
> I assume you're seeing this on the libnvdimm-pending branch?

Yes, but also on linus' master branch.  Things have been operating in
this manner for some time.

>> I understand the desire for expediency.  At some point, though, we have
>> to address the root of the problem.
>
> Well, you've defibrillated me back to reality. We've suffered the
> incomplete broken hacks for 2 years, what's another 10 weeks? I'll
> dust off the sub-section patches and take another run at it.

OK, thanks.  Let me know if I can help at all.

Cheers,
Jeff
