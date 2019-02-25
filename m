Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AA121734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129359;
	bh=mcNHz84GPAYmBooTu7laonl2FeFmgZAy08InvX3IYD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TYynlEh8HbUlMJBbYuWNM7FXqezir+FQtlEtf4cGHaHgakJ7L+M6exfDYGvHpZZbE
	 zPw7XPG7giuYghGboDnei75/H3GPNGWByTKQ/oNOfHIfUPK6Fgza9P0ffeS9FC27Ae
	 XY82zH+M0F9CGXzZAIcQnbxW0yadZfClaALwB8bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfBYVP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbfBYVPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0DC621734;
        Mon, 25 Feb 2019 21:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129352;
        bh=mcNHz84GPAYmBooTu7laonl2FeFmgZAy08InvX3IYD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwDaoTfPadaNMb4I4V9KgcPdP10rYXZ+OpqKMrmtmaRfIo3dNoqDPL/dNMVgmpHGC
         bR3vOzO9Ew57zk3xO1Nu8iNqomtElqrSbXTlJbssmSrv2DTEb8Z/mLeJW5iB25nCSz
         8ay5W6IQ5kyeWkDQ/u7GHQ+tKqbVZ94OuZoUCfqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 56/63] mm/zsmalloc.c: change stat type parameter to int
Date:   Mon, 25 Feb 2019 22:11:56 +0100
Message-Id: <20190225195040.103806388@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 3eb95feac113d8ebad5b7b5189a65efcbd95a749 upstream.

zs_stat_inc/dec/get() uses enum zs_stat_type for the stat type, however
some callers pass an enum fullness_group value.  Change the type to int to
reflect the actual use of the functions and get rid of 'enum-conversion'
warnings

Link: http://lkml.kernel.org/r/20170731175000.56538-1-mka@chromium.org
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zsmalloc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -558,20 +558,23 @@ static int get_size_class_index(int size
 	return min(zs_size_classes - 1, idx);
 }
 
+/* type can be of enum type zs_stat_type or fullness_group */
 static inline void zs_stat_inc(struct size_class *class,
-				enum zs_stat_type type, unsigned long cnt)
+				int type, unsigned long cnt)
 {
 	class->stats.objs[type] += cnt;
 }
 
+/* type can be of enum type zs_stat_type or fullness_group */
 static inline void zs_stat_dec(struct size_class *class,
-				enum zs_stat_type type, unsigned long cnt)
+				int type, unsigned long cnt)
 {
 	class->stats.objs[type] -= cnt;
 }
 
+/* type can be of enum type zs_stat_type or fullness_group */
 static inline unsigned long zs_stat_get(struct size_class *class,
-				enum zs_stat_type type)
+				int type)
 {
 	return class->stats.objs[type];
 }


