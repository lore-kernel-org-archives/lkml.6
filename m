Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB1C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2D62082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2D62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLBVYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:24:50 -0500
Received: from www17.your-server.de ([213.133.104.17]:60456 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBVYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:24:49 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYls-00016j-4U; Sun, 02 Dec 2018 21:55:20 +0100
Received: from [2a02:908:4c28:3f60:fff6:43c5:695c:41d6] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYlr-0002qq-V9; Sun, 02 Dec 2018 21:55:20 +0100
Subject: [PATCH] dlm: NULL check before some freeing functions is not
 needed.
From:   Thomas Meyer <thomas@m3y3r.de>
To:     ccaulfie@redhat.com, teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1543760930052-876371194-16-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 16
Date:   Sun, 02 Dec 2018 21:52:11 +0100
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25173/Sun Dec  2 15:13:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -681,8 +681,7 @@ static int new_lockspace(const char *nam
  out_lkbidr:
 	idr_destroy(&ls->ls_lkbidr);
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++) {
-		if (ls->ls_remove_names[i])
-			kfree(ls->ls_remove_names[i]);
+		kfree(ls->ls_remove_names[i]);
 	}
  out_rsbtbl:
 	vfree(ls->ls_rsbtbl);
