Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8742184E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeL1Xlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:41:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeL1Xlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:41:39 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9832FB49;
        Fri, 28 Dec 2018 23:41:38 +0000 (UTC)
Date:   Fri, 28 Dec 2018 15:41:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        ynorov@caviumnetworks.com, arnd@arndb.de, courbet@google.com,
        osandov@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: Add bitmap_valloc(), bitmap_vzalloc() and
 bitmap_vfree()
Message-Id: <20181228154137.c161e699e2293a07458580d3@linux-foundation.org>
In-Reply-To: <20181227161829.32177-1-rocking@whu.edu.cn>
References: <20181227161829.32177-1-rocking@whu.edu.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 00:18:29 +0800 Peng Wang <rocking@whu.edu.cn> wrote:

> Introduce bitmap alloc/free helpers when contiguous
> memory is not necessary.

That's a large bitmap you have there.  What code needs this?
