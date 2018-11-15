Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DF3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F242082A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t+J8Nuot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F242082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbeKPAFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:05:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbeKPAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lv3KDJJ4735A98C+qu8tUwqG7ME2lcOUmquG7PrRZ2c=; b=t+J8NuotawshzGhVnl5Owx6XE
        z+dz0GZWk8vqcBsY8IvzDc8ufeZQPat4VZW5ZVgLGjVwgLmGCdsw9yRUWSD5boVtT3tZCGUUxl5Xi
        jJZGX7tBWsRwWV0ibQd1sl71U/o8TT30APN/ZCdFAblFBmaodC68+lWhqzhkeFMpewcRr0gKJzR6s
        lHSXiAh0wCG4OqTT+JWgKQeocyERCcDN5Sl6I9f7zOdNShfPYl0ItM1l4+AMqv4b3ryYefy7O3xLn
        RITL/NTQjmqYSnuJEIVpuIOVbTK7at5TG+0Oj19V5NSo7bySX//5115np4itn1Le2BduI6X5gq7lb
        bONcz+6PA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNI8s-0003bo-Py; Thu, 15 Nov 2018 13:57:10 +0000
Date:   Thu, 15 Nov 2018 05:57:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Message-ID: <20181115135710.GD19286@bombadil.infradead.org>
References: <20181114224921.12123-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114224921.12123-2-keith.busch@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
> Memory-only nodes will often have affinity to a compute node, and
> platforms have ways to express that locality relationship.
> 
> A node containing CPUs or other DMA devices that can initiate memory
> access are referred to as "memory iniators". A "memory target" is a
> node that provides at least one phyiscal address range accessible to a
> memory initiator.

I think I may be confused here.  If there is _no_ link from node X to
node Y, does that mean that node X's CPUs cannot access the memory on
node Y?  In my mind, all nodes can access all memory in the system,
just not with uniform bandwidth/latency.

