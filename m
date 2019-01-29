Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066FDC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4A720882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762189;
	bh=6vzAzK6D5Ii4xEdrZFRzGQDv238EOI6deG9KwK/nvFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rOYS8r/k77/ydmFeKZYPmBV9oMbc9IBEwCi+XkrGAFcY9Mut9FsaXKY9lgb61u+ga
	 6WHT6RHwvz5kbjFJfTW6Y/XU8b/jaXUGWy18y69V/GeCH4VeSTPyt9Bhe118jl2Yoo
	 em8+n7ZMMqAkTxujxI8mndXIHmnNXWE0MYO6m22g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfA2LnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:32914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfA2LnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771EA20856;
        Tue, 29 Jan 2019 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762185;
        bh=6vzAzK6D5Ii4xEdrZFRzGQDv238EOI6deG9KwK/nvFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXz4ivSx19r2cyhhTHC/C5gLCQ6wZJ1JryL0Uf4A/7XXcMSqzX6Dm9UmCbcaviKug
         xC1u89JhHX3Wd3KcCWXux/JbtFxT53BauSZU/wtZp0+0vNvqNNLrdMBoh0/EvSN3B0
         epF5FOfi6pVCZuH+lNGcjJW57+emZ9O0HRlRnoD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 020/103] ip6_gre: update version related info when changing link
Date:   Tue, 29 Jan 2019 12:34:57 +0100
Message-Id: <20190129113200.753523317@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 80b3671e9377916bf2b02e56113fa7377ce5705a ]

We forgot to update ip6erspan version related info when changing link,
which will cause setting new hwid failed.

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: 94d7d8f292870 ("ip6_gre: add erspan v2 support")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1187,6 +1187,10 @@ static void ip6gre_tnl_copy_tnl_parm(str
 	t->parms.i_flags = p->i_flags;
 	t->parms.o_flags = p->o_flags;
 	t->parms.fwmark = p->fwmark;
+	t->parms.erspan_ver = p->erspan_ver;
+	t->parms.index = p->index;
+	t->parms.dir = p->dir;
+	t->parms.hwid = p->hwid;
 	dst_cache_reset(&t->dst_cache);
 }
 


