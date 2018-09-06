Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A01220652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A01220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeIFRK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:10:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeIFRK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:10:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D17BADC2;
        Thu,  6 Sep 2018 12:35:40 +0000 (UTC)
Date:   Thu, 6 Sep 2018 14:35:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V2 1/4] mm: Export alloc_migrate_huge_page
Message-ID: <20180906123539.GV14951@dhcp22.suse.cz>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906123111.GC26069@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906123111.GC26069@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 14:31:11, Michal Hocko wrote:
> On Thu 06-09-18 11:13:39, Aneesh Kumar K.V wrote:
> > We want to use this to support customized huge page migration.
> 
> Please be much more specific. Ideally including the user. Btw. why do
> you want to skip the hugetlb pools? In other words alloc_huge_page_node*
> which are intended to an external use?

Ups, I have now found http://lkml.kernel.org/r/20180906054342.25094-2-aneesh.kumar@linux.ibm.com
which ended up in a different email folder so I have missed it. It would
be much better to merge those two to make the user immediately obvious.
There is a good reason to keep newly added functions closer to their
users.
-- 
Michal Hocko
SUSE Labs
