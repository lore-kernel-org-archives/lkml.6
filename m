Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF74C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44C420879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hOn+7cxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfAUVvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:51:49 -0500
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:32926 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbfAUVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548107507;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=ItNSaKDGxoD1aSyvb0fxyYSFutq6GEdD+caS/lRflm8=;
        b=hOn+7cxxXuEjteiGeR7rdjymEElIZfAkaGPapPeOkKf8NsmyUvGUt9gqwIgp/uql
        zqPGBTEEyNSwyH+GQbJxkdXhR+I+w1WTzr2+NsCagVOfsoXdxp6uIRHtTBeMXvdfUYJ
        MxDf0DpzxNX5drf9dZ5lRsapvxqxa3tfhYO4Imhk=
Date:   Mon, 21 Jan 2019 21:51:47 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     akpm@linux-foundation.org, dledford@redhat.com, jgg@mellanox.com,
        jack@suse.de, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/6] mm: make mm->pinned_vm an atomic64 counter
In-Reply-To: <20190121174220.10583-2-dave@stgolabs.net>
Message-ID: <010001687265e644-49af6f45-e29b-41a7-9cd4-50ff8d64b9f9-000000@email.amazonses.com>
References: <20190121174220.10583-1-dave@stgolabs.net> <20190121174220.10583-2-dave@stgolabs.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.21-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Davidlohr Bueso wrote
> Taking a sleeping lock to _only_ increment a variable is quite the
> overkill, and pretty much all users do this. Furthermore, some drivers
> (ie: infiniband and scif) that need pinned semantics can go to quite
> some trouble to actually delay via workqueue (un)accounting for pinned
> pages when not possible to acquire it.

Reviewed-by: Christoph Lameter <cl@linux.com>

