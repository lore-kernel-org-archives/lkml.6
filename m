Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9144AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5FE20836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIN8SV5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfAKRbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:31:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfAKRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fv/dzw10XKK1jDNir5Z1CS6XX7bcJYa0STF0weBIOTc=; b=WIN8SV5BEy6gRWnqJj5am+bUG
        LJfMi12tf8Vs/7KZYea6ISQWiS3P6oXwSkb1lvqwYjB8JG16mG5ouH5jKiFgsBxSZYbNhM/rWFZhN
        C1hNe/pJ2VWd9rZiIzIH5xbfb5it3Ar8+BCPUHjDmDDqwFfvJKdJWJeGGgff3/M0VlxTljuykHyWq
        zrQfpF7GPzthEF6eTo21KRZqqD1jPX1BolPGZ+RE0c86/N2h7m0XHc1iP70Qm5kUaDH1qULDbrE+I
        UzaKW9k98akIGofAoDNC+09oljdbBfMt+ZC0okGz7tvASy9KNfA4/aS4pgveZXZwX8vmPLOEjpTOA
        Y6K//6fRQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gi0ea-0000MA-JC; Fri, 11 Jan 2019 17:31:32 +0000
Date:   Fri, 11 Jan 2019 09:31:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: fix the red root
Message-ID: <20190111173132.GH6310@bombadil.infradead.org>
References: <YrcPMrGmYbPe_xgNEV6Q0jqc5XuPYmL2AFSyeNmg1gW531bgZnBGfEUK5_ktqDBaNW37b-NP2VXvlliM7_PsBRhSfB649MaW1Ne7zT9lHc=@protonmail.ch>
 <20190111165145.23628-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111165145.23628-1-cai@lca.pw>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:51:45AM -0500, Qian Cai wrote:
> Reported-by: Esme <esploit@protonmail.ch>
> Signed-off-by: Qian Cai <cai@lca.pw>

What change introduced this bug?  We need a Fixes: line so the stable
people know how far to backport this fix.
