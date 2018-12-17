Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B10EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A11720874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M8mTiHAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbeLQO6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:58:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54774 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733112AbeLQO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zgswlOL0Z7zZLXeaLuuRwh49voJotlcz14ISMgP0uR4=; b=M8mTiHARUZd3NYq8v22Dx+iAh
        cp6yCkrxK0ooOVnNfugF5ib49vuIHzMiMkE3jrJ0oLChFH2Pn7K08WyPBpaHroLO4dQJU2xpKOR4b
        OtEf4e3xkqBDgRuGLGUsv7mGCBjFn/BEGjMXYVnyL+4eLG3/uHRFSMZK/YtBOmGLD4MN984Yz03Mi
        IT2KeszNtK8yc7EdHlOtnDw5bip8plUz/462TxIXYdV7JR04Q3D/FfLYh9GkF3+f9235eK/G5v4dT
        107jpxyJPz/PsAcMxj1Wt4L0aIqU9wi/3zP9U5LL5J31bwrDn6dZseP42zJz1k4XBIDPVXym0BtNO
        ykwTLtp4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYuLG-000213-4y; Mon, 17 Dec 2018 14:57:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3716A2027DA91; Mon, 17 Dec 2018 15:57:54 +0100 (CET)
Date:   Mon, 17 Dec 2018 15:57:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 3/6] psi: eliminate lazy clock mode
Message-ID: <20181217145754.GB2218@hirez.programming.kicks-ass.net>
References: <20181214171508.7791-1-surenb@google.com>
 <20181214171508.7791-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214171508.7791-4-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:15:05AM -0800, Suren Baghdasaryan wrote:
> Eliminate the idle mode and keep the worker doing 2s update intervals
> at all times.

That sounds like a bad deal.. esp. so for battery powered devices like
say Andoird.

In general the push has been to always idle everything, see NOHZ and
NOHZ_FULL and all the work that's being put into getting rid of any and
all period work.


