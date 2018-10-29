Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63930C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307FC2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307FC2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeJ3Euj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeJ3Eui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:50:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 168C8307DAA0;
        Mon, 29 Oct 2018 20:00:28 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-27.brq.redhat.com [10.40.200.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83CA310018FB;
        Mon, 29 Oct 2018 20:00:25 +0000 (UTC)
Date:   Mon, 29 Oct 2018 21:00:54 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] drivers/md/raid5.c: use the new spelling of
 RWH_WRITE_LIFE_NOT_SET
Message-ID: <8ff5ae0a7b9dad90cac71ce468ec6856a80388b4.1540843065.git.esyr@redhat.com>
References: <cdbbf807-4df6-58c9-7d9c-2aeb1727c157@kernel.dk>
 <cover.1540843065.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540843065.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Oct 2018 20:00:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is consistent with prefixes of other write life time hints.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 drivers/md/raid5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e4e98f4..0bcfbd3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1139,7 +1139,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			bi->bi_iter.bi_size = STRIPE_SIZE;
 			bi->bi_write_hint = sh->dev[i].write_hint;
 			if (!rrdev)
-				sh->dev[i].write_hint = RWF_WRITE_LIFE_NOT_SET;
+				sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
 			/*
 			 * If this is discard request, set bi_vcnt 0. We don't
 			 * want to confuse SCSI because SCSI will replace payload
@@ -1192,7 +1192,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			rbi->bi_io_vec[0].bv_offset = 0;
 			rbi->bi_iter.bi_size = STRIPE_SIZE;
 			rbi->bi_write_hint = sh->dev[i].write_hint;
-			sh->dev[i].write_hint = RWF_WRITE_LIFE_NOT_SET;
+			sh->dev[i].write_hint = RWH_WRITE_LIFE_NOT_SET;
 			/*
 			 * If this is discard request, set bi_vcnt 0. We don't
 			 * want to confuse SCSI because SCSI will replace payload
-- 
2.1.4

