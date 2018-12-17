Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930C7217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SkBZcWGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbeLQTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:31:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57202 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeLQTb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q+elOYgRvazqECl07VGKLpltxBfqxd15d9smJwD8no8=; b=SkBZcWGCIugC5dJJL8laXA+PX
        QTknPgn1gwRku1WqvKhA1TZxd2IqY891TgUJeFDvJUAO1XFyA8yBsOBiF4HWYyV8ez+1um/TUGRbZ
        qGNvGykzaBDek5f9gayminNtAaR5UD/B3wRZgCejsuRBnliI80xcOwWghTi40pykjyzcF6qx0+YZc
        H5kOmWOut6ScXJ47i/6tHzAwvdNV9FvuKlg5Qs16GGN19h7RrsapkDuiV6nZDz/YaY6hVI8khcPKM
        xoBDWKOLfbz7LO/o8mJlUPSSXWzZevvMlsueFZG4s8GwszEfFku/HiEo3QHBIjAak+rOQJAXczplH
        B5mCKYXDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYybh-0003P1-6Q; Mon, 17 Dec 2018 19:31:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D49EF2027DA91; Mon, 17 Dec 2018 20:31:10 +0100 (CET)
Date:   Mon, 17 Dec 2018 20:31:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181217193110.GG2218@hirez.programming.kicks-ass.net>
References: <1544738377-3848-1-git-send-email-longman@redhat.com>
 <20181217181712.GA5114@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217181712.GA5114@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 07:17:12PM +0100, Ingo Molnar wrote:

> and rename early_printk() to printk(), and be done with this.

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git debug/experimental

:-)
