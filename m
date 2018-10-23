Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5DD20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="G+eZ6SMr";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="G+eZ6SMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5DD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJWNdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:33:18 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:51064 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbeJWNdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:33:17 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id D761B20F29;
        Tue, 23 Oct 2018 08:11:31 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bfHUNgVcrI-BVI0A9ju;
        Tue, 23 Oct 2018 08:11:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1540271491; bh=A36DZiW5Y8mEoCxwxkdOEkt05TaKv+uqXh94oODi+GI=;
        h=Subject:To:References:From:Message-ID:Date:In-Reply-To;
        b=G+eZ6SMrZfYN+lB3gY6gzZdep1oIRYIdCSU2gzwx81G17Fu6Ff6FEHY0lwdCvYXvc
         v1OgTDPN+5Pxs2DRXc5KRfCK4ZLk7fzMglXR85aPg4sqezsEUg1Gq4UVjkFAfx7zdD
         iark9mwo+84HP4DNoTyV9QjVuwLIu4v+FhjGxSgk=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:2501:1cc0:44e4:e39a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id PYezhgoTGU-BVWaDWLX;
        Tue, 23 Oct 2018 08:11:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1540271491; bh=A36DZiW5Y8mEoCxwxkdOEkt05TaKv+uqXh94oODi+GI=;
        h=Subject:To:References:From:Message-ID:Date:In-Reply-To;
        b=G+eZ6SMrZfYN+lB3gY6gzZdep1oIRYIdCSU2gzwx81G17Fu6Ff6FEHY0lwdCvYXvc
         v1OgTDPN+5Pxs2DRXc5KRfCK4ZLk7fzMglXR85aPg4sqezsEUg1Gq4UVjkFAfx7zdD
         iark9mwo+84HP4DNoTyV9QjVuwLIu4v+FhjGxSgk=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
To:     Joe Perches <joe@perches.com>, Arun KS <arunks@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Arun Sudhilal <getarunks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <15247f54-53f3-83d4-6706-e9264b90ca7a@yandex-team.ru>
Date:   Tue, 23 Oct 2018 08:11:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.2018 7:15, Joe Perches wrote:> On Mon, 2018-10-22 at 22:53 +0530, Arun KS wrote:
 >> Remove managed_page_count_lock spinlock and instead use atomic
 >> variables.
 >
 > Perhaps better to define and use macros for the accesses
 > instead of specific uses of atomic_long_<inc/dec/read>
 >
 > Something like:
 >
 > #define totalram_pages()	(unsigned long)atomic_long_read(&_totalram_pages)

or proper static inline
this code isn't so low level for breaking include dependencies with macro

 > #define totalram_pages_inc()	(unsigned long)atomic_long_inc(&_totalram_pages)
 > #define totalram_pages_dec()	(unsigned long)atomic_long_dec(&_totalram_pages)

these are void


conversion zone->managed_pages should be split into separate patch


[dropped bloated cc - my server rejects this mess]
