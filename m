Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7ECC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE8A208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JJlE5ylB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE8A208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeHVVGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:06:08 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:52356 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbeHVVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1534959618;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=KJTR3Jo7rVyL7hfNcnkeovCunVAMKEjMf0sAlGTWQQg=;
        b=JJlE5ylBCOeNMKdpRX7xPs8RSpJr2sbdn3gIiRyo1yTELr/DnCZap67Yx3ngsW6j
        22l1EJbqtOe4A2lVyE3xUWYva86KO7KIu4bFrONzqEVpEEW7zHFvlt5oVMwXvaZCqVw
        XqBi2KxjA25ed7WFftPGJ2b9+1lcFAElWuFPlAGA=
Date:   Wed, 22 Aug 2018 17:40:18 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] XArray for 4.19
In-Reply-To: <20180813161357.GB1199@bombadil.infradead.org>
Message-ID: <0100016562b90938-02b97bb7-eddd-412d-8162-7519a70d4103-000000@email.amazonses.com>
References: <20180813161357.GB1199@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.08.22-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018, Matthew Wilcox wrote:

> Please consider pulling the XArray patch set.  The XArray provides an
> improved interface to the radix tree data structure, providing locking
> as part of the API, specifying GFP flags at allocation time, eliminating
> preloading, less re-walking the tree, more efficient iterations and not
> exposing RCU-protected pointers to its users.

Is this going in this cycle? I have a bunch of stuff on top of this to
enable slab object migration.
