Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbeBQA2L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:28:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeBQA2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:28:10 -0500
Date: Fri, 16 Feb 2018 16:28:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Oleksiy.Avramchenko@sony.com
Subject: Re: [PATCH] z3fold: limit use of stale list for allocation
Message-Id: <20180216162809.30b2278f0cacefa66c95c1aa@linux-foundation.org>
In-Reply-To: <47ab51e7-e9c1-d30e-ab17-f734dbc3abce@gmail.com>
References: <47ab51e7-e9c1-d30e-ab17-f734dbc3abce@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018 12:02:52 +0100 Vitaly Wool <vitalywool@gmail.com> wrote:

> Currently if z3fold couldn't find an unbuddied page it would first
> try to pull a page off the stale list. The problem with this
> approach is that we can't 100% guarantee that the page is not
> processed by the workqueue thread at the same time unless we run
> cancel_work_sync() on it, which we can't do if we're in an atomic
> context. So let's just limit stale list usage to non-atomic
> contexts only.

This smells like a bugfix.  What are the end-user visible effects of
the bug?
