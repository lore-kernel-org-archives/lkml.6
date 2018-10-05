Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F8520652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F8520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeJFEWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:22:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeJFEWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:22:16 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59379A6E;
        Fri,  5 Oct 2018 21:21:44 +0000 (UTC)
Date:   Fri, 5 Oct 2018 14:21:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, page_alloc: set num_movable in move_freepages()
Message-Id: <20181005142143.30032b7a4fb9dc2b587a8c21@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1810051355490.212229@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810051355490.212229@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 13:56:39 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> If move_freepages() returns 0 because zone_spans_pfn(), *num_movable can

     move_free_pages_block()?           !zone_spans_pfn()?

> hold the value from the stack because it does not get initialized in
> move_freepages().
> 
> Move the initialization to move_freepages_block() to guarantee the value
> actually makes sense.
> 
> This currently doesn't affect its only caller where num_movable != NULL,
> so no bug fix, but just more robust.
> 
> ...
