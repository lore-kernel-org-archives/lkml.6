Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEE6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0557C21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NrLRPKBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeLRQbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:31:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeLRQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qPYrdqYdZUH7CkWqsSctH9cyoyL92kU8BBAZ11lWVdw=; b=NrLRPKBSEK+YD92ncXpK6S58X
        kIJBBDpcbdN/1kxNJTCjpcIUpW87Hs7dJ8Xlb0enbBONU1QOZa4qTGNpY6iIxzV1GOSJFZheHs4y4
        pzpl2Uf2gg5yGsIu9GpUtgIfEuX80iPQHwY043w8E4tvWyf/heYptc7npqQFCQtCw0wZBNixyhlXu
        TdioSA5hqSAK40nypyfA5YHOkoIzp3gL2hGSefcNPId0gdwoe2uo9FD5fuqR4lYVP5ewv7lqCXlV7
        iz6gzWwWFwQuX8sc5GYHcMXmt1yImPdCAa5d5zjXhyFOmr2NMpkddaLmgCXIpOkYRaLq2SJotc7Jl
        R9M7+6VOg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZIH4-0003ST-Sx; Tue, 18 Dec 2018 16:31:14 +0000
Date:   Tue, 18 Dec 2018 08:31:14 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     gchen chen <gchen.guomin@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        gchen <guominchen@tencent.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Fix mm->owner point to a tsk that has been free
Message-ID: <20181218163114.GV10600@bombadil.infradead.org>
References: <1545110684-8730-1-git-send-email-gchen.guomin@gmail.com>
 <20181218095226.GD17870@dhcp22.suse.cz>
 <CAEEwsfRb-FDCLp-b3-n2+vvgWttv6FQhjkLxpJwA==_+89iY=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEwsfRb-FDCLp-b3-n2+vvgWttv6FQhjkLxpJwA==_+89iY=w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:21:27AM +0800, gchen chen wrote:
> Oh, yes, the patch 39af176 has been skip the kthread
> on mm_update_next_owner .

Actually f87fb599ae4
