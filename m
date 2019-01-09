Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADE5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1F20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAICiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:38:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfAICiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:38:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FD5DC056797;
        Wed,  9 Jan 2019 02:38:15 +0000 (UTC)
Received: from sky.random (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3C7A600C8;
        Wed,  9 Jan 2019 02:38:14 +0000 (UTC)
Date:   Tue, 8 Jan 2019 21:38:12 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V6 1/4] mm/cma: Add PF flag to force non cma alloc
Message-ID: <20190109023812.GF20586@redhat.com>
References: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
 <20190108045110.28597-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108045110.28597-2-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 02:38:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:21:07AM +0530, Aneesh Kumar K.V wrote:
> This patch add PF_MEMALLOC_NOCMA which make sure any allocation in that context
> is marked non movable and hence cannot be satisfied by CMA region.
> 
> This is useful with get_user_pages_cma_migrate where we take a page pin by
> migrating pages from CMA region. Marking the section PF_MEMALLOC_NOCMA ensures
> that we avoid uncessary page migration later.
> 
> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
