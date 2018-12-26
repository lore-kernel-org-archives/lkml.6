Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D851C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258492171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJ7w5JsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeLZTLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:11:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeLZTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qjKl81CCdAvyQI0mBXih9GTVpy7J1zakJUQfLlxKDDc=; b=TJ7w5JsJZhW5Sg7cAmsRRE7Q+
        OYFgSl3So8x8+pnRx7U0qlv8g1eMqKL2m4B4AERTVUsm6Atdygw+7d1OsUMWTPKdcpw0uE/5oj49n
        gtjwDM6p3U55W9RyM4yQkGBVDeHCFY3QiVHNsPFMtCU2xje3GDYZrJPhEimHDfPuFW5q/8WAmnswl
        Rvf+ylLidVuaxwqpwq5Xh39enAmc2I2wpsec0o3JBuHnZTKB2fDlT9X3QKJL9IMey7cagaufspsQO
        O46lifQiMzYDJVCQQZspNiDdHas0s8CvRufOaSGWuMV7xErys1waEcQPhfrd5Z4tvzerTS9JdT5Zo
        5Lsr8tVBQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcEaM-0001de-M7; Wed, 26 Dec 2018 19:11:18 +0000
Date:   Wed, 26 Dec 2018 11:11:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction.c: Propagate return value upstream
Message-ID: <20181226191118.GB20878@bombadil.infradead.org>
References: <20181226190750.9820-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226190750.9820-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 01:07:49PM -0600, Aditya Pakki wrote:
>  {
> +	return
>  	proc_dointvec_minmax(table, write, buffer, length, ppos);
> -
> -	return 0;

Don't do this.  If you're going to return something, it should be on the same
line as the return statement.

ie:

+	return proc_dointvec_minmax(table, write, buffer, length, ppos);

