Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9BAC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB9222D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083344;
	bh=PITCl3HssLuX8C8OltNOCp1/oZgQK6SExtyq9jw2R/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uuTHw2REmTpaexc2GyEGyusaLn3BJ28yVBszMULs2wqriCVfqbduYb6LCE1sqPL9k
	 A1WiN3Bp7IP1QcMBN+9BICsAYbRmOovkICP5j4nj/497PreJWL+l2zMNHdbKV9Z4F4
	 zrFCbrfU5Pqdp5tlJdXqp0xFwh9pMcUIzj36tw1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405647AbfBMSmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403891AbfBMSmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7345222D8;
        Wed, 13 Feb 2019 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083340;
        bh=PITCl3HssLuX8C8OltNOCp1/oZgQK6SExtyq9jw2R/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfgBTaHOR9qcU1+ZOTZawTxzqDt33fga5qX17b0pza3Mu2cgvFuLlC/nAN+EMpLBw
         SQWy74sIihtJr+WHIJZGLWlU5i3yC5de55Jz2CkBbgq9z76pNH5TztzTPT5sr63kSD
         xH6XFh7jjdAFBwGPkEh6n9wkuL+wb4MF5EN+7isM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.14 07/35] samples: mei: use /dev/mei0 instead of /dev/mei
Date:   Wed, 13 Feb 2019 19:38:02 +0100
Message-Id: <20190213183706.528340331@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit c4a46acf1db3ce547d290c29e55b3476c78dd76c upstream.

The device was moved from misc device to character devices
to support multiple mei devices.

Cc: <stable@vger.kernel.org> #v4.9+
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 samples/mei/mei-amt-version.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -117,7 +117,7 @@ static bool mei_init(struct mei *me, con
 
 	me->verbose = verbose;
 
-	me->fd = open("/dev/mei", O_RDWR);
+	me->fd = open("/dev/mei0", O_RDWR);
 	if (me->fd == -1) {
 		mei_err(me, "Cannot establish a handle to the Intel MEI driver\n");
 		goto err;


