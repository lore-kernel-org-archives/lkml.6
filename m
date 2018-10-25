Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B992C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE61D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE61D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJZG2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeJZG2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 999267F6B2;
        Thu, 25 Oct 2018 21:54:29 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-21.brq.redhat.com [10.40.200.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 408415DD6C;
        Thu, 25 Oct 2018 21:54:26 +0000 (UTC)
Date:   Thu, 25 Oct 2018 23:54:52 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND 2/2] drivers/md/raid5.c: use the new spelling of
 RWH_WRITE_LIFE_NOT_SET
Message-ID: <effee6298f42c044a512864bc306bb8510e0ee9d.1540504380.git.evgsyr@gmail.com>
References: <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
 <cover.1540504380.git.evgsyr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540504380.git.evgsyr@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 25 Oct 2018 21:54:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is consistent with prefixes of other write life time hints.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>
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

