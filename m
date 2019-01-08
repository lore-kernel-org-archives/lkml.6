Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C43EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DF220883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfAHV0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:26:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfAHV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:26:51 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD1DA9BA;
        Tue,  8 Jan 2019 21:26:50 +0000 (UTC)
Date:   Tue, 8 Jan 2019 13:26:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove redundant test from find_get_pages_contig
Message-Id: <20190108132649.8f25386d966f04b0bccd6d77@linux-foundation.org>
In-Reply-To: <20190108202635.GE6310@bombadil.infradead.org>
References: <20190107200224.13260-1-willy@infradead.org>
        <20190107143319.c74593a70c86441b80e7cccc@linux-foundation.org>
        <20190107223935.GC6310@bombadil.infradead.org>
        <20190107150904.09e56f51acaf417ed21f13a3@linux-foundation.org>
        <20190108202635.GE6310@bombadil.infradead.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 12:26:35 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> > Would it be excessively cautious to put a WARN_ON_ONCE() in there for a
> > while?
> 
> I think it would ... it'd get in the way of a subsequent patch to store
> only head pages in the page cache.

OK, shall grab.  Perhaps the changelog could gain a few words
explaining the history, etc.
