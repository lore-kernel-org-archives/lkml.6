Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E315C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA33F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jb9qFfYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBKETP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:19:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfBKETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2oENOwP+LYlvxvmqQYAtRiYVLnhAoljggFzfdA7LADs=; b=jb9qFfYWN2o5cwOgd+qrFUEHD
        j30ZI/Mgc0LzqKeweQw4XkJBVTNGm7xh6YV6+M4T3xG2BwoliLLzIaAW35AY51oLxkPDsvhKYYgvy
        LD74eGijIOeKp83omTqri4XUj320nhdhOwLbnFZy5JtLkT2ppNz6Jc7hIjxuRhYQXqkZN9KKcWM7Y
        Eb+kdiOyFyDXzaG3zXgwGADek9Z2fH7Z8Ko1LdOfPcctyvNqWq9y+vvWiva+3JdwxqoAC3FRNpvtb
        rKHql6/Wf9k68iKtVu+WZKC0dOq7zBv4vbGSnXm7IVuGDZHffEvp0O3Q8N1vwW7+0pSvjKqb90a1/
        yWDpZzXgQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt33o-0003lr-4K; Mon, 11 Feb 2019 04:19:12 +0000
Date:   Sun, 10 Feb 2019 20:19:11 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFhBcnJh?= =?utf-8?Q?y?= tests:
 allocation has to be GFP_ATOMIC under rcu_read_lock
Message-ID: <20190211041911.GA12668@bombadil.infradead.org>
References: <1548760122-13000-1-git-send-email-lirongqing@baidu.com>
 <20190202231944.GB13285@bombadil.infradead.org>
 <0626e4dd96a345b6bf5b12c7e7b1319d@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0626e4dd96a345b6bf5b12c7e7b1319d@baidu.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:55:53AM +0000, Li,Rongqing wrote:
> Could you send this patch?

I put it in
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray
which is included in linux-next.
