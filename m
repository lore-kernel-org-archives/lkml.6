Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B530C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7AA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n5bvZTWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeLQLdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:33:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeLQLdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IgBet/flz8JBQ7h5+wAM0+yqyOn3JoDsnV2NTkIVWFc=; b=n5bvZTWj2XoPx8bLbfsgqG8lx
        ZjwY6s4+YlRpgba0+7qyl8SZFks4o2G6nwOMniilLBZYyoTu1trmO+qmycTNz/4qehP24zCu0NzVQ
        s263a6/7oBIWwiGj1KAJVfHU2+KUmLEeHXtdOzsCY6lpv7yQxoaqm2WQ2qiBS5pKIXZ13Tt9Z/xtP
        U5X95jZzIsBEIANjavloPqd+IBzjLkyRYemwxm4jWV2fHZIERovwI0CBmWo3vhjQKr4geJzZFSbC9
        r9PkXGHfu3i8sHZu4rgKqY9Xgg5LuCZN6TbmWdEV6CFpUqA8LEzNiK+Zayjhw+XgiIb79Q8VOYcMS
        z+ONwqncA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYr8o-0007Bg-MO; Mon, 17 Dec 2018 11:32:54 +0000
Date:   Mon, 17 Dec 2018 03:32:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     gchen.guomin@gmail.com
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, guominchen@tencent.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH]  Export mm_update_next_owner function for vhost-net
Message-ID: <20181217113254.GA6971@infradead.org>
References: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems like an issue all the unuse_mm users (at least those
outside of swapfile.c) have, so it should be solved in the core.

Bonus points for moving the set_fs magic into use_mm()..
