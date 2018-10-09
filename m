Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0191C65BD7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA53214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA53214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJJFgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:36:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:36:45 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6718DB30;
        Tue,  9 Oct 2018 22:17:41 +0000 (UTC)
Date:   Tue, 9 Oct 2018 15:17:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] mm: zero-seek shrinkers
Message-Id: <20181009151740.eaa1e07b111b4f4d90d0172c@linux-foundation.org>
In-Reply-To: <20181009151556.5b0a3c9ae270b7551b3d12e6@linux-foundation.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
        <20181009184732.762-5-hannes@cmpxchg.org>
        <20181009151556.5b0a3c9ae270b7551b3d12e6@linux-foundation.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 15:15:56 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> Seems sane, but I'm somewhat worried about unexpected effects on other
> workloads.  So I think I'll hold this over for 4.20.  Or shouldn't I?

Meant 4.21.  But on reflection this is perhaps excessively cautious.
