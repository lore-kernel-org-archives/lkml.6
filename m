Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75552C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509D92087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfB0LaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:30:01 -0500
Received: from ozlabs.org ([203.11.71.1]:49093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfB0LaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:30:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 448YPg3cY8z9s21;
        Wed, 27 Feb 2019 22:29:59 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V7 0/4] mm/kvm/vfio/ppc64: Migrate compound pages out of CMA region
In-Reply-To: <87mumhtxxx.fsf@linux.ibm.com>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com> <20190226155324.e99d5200cc6293138ac5c6fa@linux-foundation.org> <87mumhtxxx.fsf@linux.ibm.com>
Date:   Wed, 27 Feb 2019 22:29:59 +1100
Message-ID: <878sy1h3k8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> [patch 1/4]: OK.  I guess.  Was this worth consuming our last PF_ flag?
>
> That was done based on request from Andrea and it also helps in avoiding
> allocating pages from CMA region where we know we are anyway going to
> migrate them out. So yes, this helps. 
>
>> [patch 2/4]: unreviewed
>> [patch 3/4]: unreviewed, mpe still unhappy, I expect?
>
> I did reply to that email. I guess mpe is ok with that?

It would be nice to fold your explanation about DAX into the change log,
so it's there for people to see.

And I think my comment about initialising ret still stands.

cheers
