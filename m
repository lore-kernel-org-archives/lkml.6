Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB77C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C445D20868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfAQV5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:57:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfAQV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:57:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A727AA7875;
        Thu, 17 Jan 2019 21:57:20 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDA6061B6C;
        Thu, 17 Jan 2019 21:57:18 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, thomas.lendacky@amd.com,
        fengguang.wu@intel.com, dave@sr71.net, linux-nvdimm@lists.01.org,
        tiwai@suse.de, zwisler@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        baiyaowei@cmss.chinamobile.com, ying.huang@intel.com,
        bhelgaas@google.com, akpm@linux-foundation.org, bp@suse.de
Subject: Re: [PATCH 0/4] Allow persistent memory to be used like normal RAM
References: <20190116181859.D1504459@viggo.jf.intel.com>
        <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
        <20190117164736.GC31543@localhost.localdomain>
        <x49pnsv8am1.fsf@segfault.boston.devel.redhat.com>
        <20190117193403.GD31543@localhost.localdomain>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 17 Jan 2019 16:57:17 -0500
In-Reply-To: <20190117193403.GD31543@localhost.localdomain> (Keith Busch's
        message of "Thu, 17 Jan 2019 12:34:03 -0700")
Message-ID: <x49ef9b6j7m.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 17 Jan 2019 21:57:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Busch <keith.busch@intel.com> writes:

>> Keith, you seem to be implying that there are platforms that won't
>> support memory mode.  Do you also have some insight into how customers
>> want to use this, beyond my speculation?  It's really frustrating to see
>> patch sets like this go by without any real use cases provided.
>
> Right, most NFIT reporting platforms today don't have memory mode, and
> the kernel currently only supports the persistent DAX mode with these.
> This series adds another option for those platforms.

All NFIT reporting platforms today are shipping NVDIMM-Ns, where it
makes absolutely no sense to use them as regular DRAM.  I don't think
that's a good argument to make.

> I think numactl as you mentioned is the first consideration for how
> customers may make use. Dave or Dan might have other use cases in mind.

Well, it sure looks like this took a lot of work, so I thought there
were known use cases or users asking for this functionality.

Cheers,
Jeff
