Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC847ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691A520874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oRwxsVwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691A520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbeGWIR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:17:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbeGWIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iDjqOt76yFHHmjMCxgX5DmAwJJV8hrhIBswSeq5aj/k=; b=oRwxsVwU8fs3ar4pymxHIElpn
        p90uX0Vff0+O7Ict9ZuWCWfGasdE7CZAv5eVgFYw7dsjQ+h7qaVQXP+zwRvJTzf+nfzQZHPjPm4DC
        0HWNFHjQlIH7FiJOtkv5OUgnyruEJzKovvZHoEdDmEldF9YDPieD2ZR6ImycVPboutn8ec6G4V2Tp
        TtskiXCXaa0UNkvfMA5QLgK0aEw2desgqbGJ0HdqbS2EJ34gbqZGcf0Nj251SAnv/iJFBUxsNFHV0
        rO+zcP2IAOLA60uztoJr8dWX23THwyCYdKCJwPkNrJ8/YTEuFosYu98RyiM3n2eK610fG56MriEZH
        Uf8/CULjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhV6a-000143-G2; Mon, 23 Jul 2018 07:18:04 +0000
Date:   Mon, 23 Jul 2018 00:18:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in
 set_task_ioprio()
Message-ID: <20180723071803.GA30817@infradead.org>
References: <20180723022116.6919-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723022116.6919-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

But to me it seems that btrfs and maybe ext4 as well would be much
better off just setting a per-IO priority in the bio.

Any chance yo could look into that?
