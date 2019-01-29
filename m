Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAFAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724002083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfA2Qoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:44:46 -0500
Received: from opengridcomputing.com ([72.48.214.68]:34958 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfA2Qoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:44:46 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id B9D0122666;
        Tue, 29 Jan 2019 10:44:45 -0600 (CST)
Subject: Re: [PATCH 0/5] RDMA: reg_remote_mr
To:     Joel Nider <joeln@il.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <8cdb77b6-c160-81d0-62be-5bbf84a98d69@opengridcomputing.com>
Date:   Tue, 29 Jan 2019 10:44:48 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/29/2019 7:26 AM, Joel Nider wrote:
> As discussed at LPC'18, there is a need to be able to register a memory
> region (MR) on behalf of another process. One example is the case of
> post-copy container migration, in which CRIU is responsible for setting
> up the migration, but the contents of the memory are from the migrating
> process. In this case, we want all RDMA READ requests to be served by
> the address space of the migration process directly (not by CRIU). This
> patchset implements a new uverbs command which allows an application to
> register a memory region in the address space of another process.

Hey Joel,

Dumb question:

Doesn't this open a security hole by allowing any process to register
memory in any other process?

Steve.


