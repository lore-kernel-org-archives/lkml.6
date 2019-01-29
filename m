Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E3C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DE120856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfA2Sec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:34:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:28595 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbfA2Sec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:34:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 10:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="120448958"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jan 2019 10:34:31 -0800
Date:   Tue, 29 Jan 2019 10:34:03 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Steve Wise <swise@opengridcomputing.com>
Cc:     Joel Nider <joeln@il.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] RDMA: reg_remote_mr
Message-ID: <20190129183402.GB10129@iweiny-DESK2.sc.intel.com>
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
 <8cdb77b6-c160-81d0-62be-5bbf84a98d69@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cdb77b6-c160-81d0-62be-5bbf84a98d69@opengridcomputing.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:44:48AM -0600, Steve Wise wrote:
> 
> On 1/29/2019 7:26 AM, Joel Nider wrote:
> > As discussed at LPC'18, there is a need to be able to register a memory
> > region (MR) on behalf of another process. One example is the case of
> > post-copy container migration, in which CRIU is responsible for setting
> > up the migration, but the contents of the memory are from the migrating
> > process. In this case, we want all RDMA READ requests to be served by
> > the address space of the migration process directly (not by CRIU). This
> > patchset implements a new uverbs command which allows an application to
> > register a memory region in the address space of another process.
> 
> Hey Joel,
> 
> Dumb question:
> 
> Doesn't this open a security hole by allowing any process to register
> memory in any other process?

I agree, Changing all MR to use FOLL_REMOTE seems wrong.

Ira

> 
> Steve.
> 
> 
