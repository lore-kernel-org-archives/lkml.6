Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54248C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579920645
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866745;
	bh=zK+AYwJmVpysIuJ2lwppN+trx9FLy/0R2hjWuo8xexA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ii9NcboT2xjKJjLz6tPUQrkC3vLl1+deHSeLann7ln9bhayyQL4bx1zoxpTEZ3Kko
	 CZGegOOgn0e0SZjaLIWWoKK0hA1AD5m4b5nrTt0pdd/Wuzp0Mk0JF9R6WY9jrzyihl
	 byQ+vsRI9D8WacY4c14D3qF6dYUFUQhtHiq1VxVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfAGNMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbfAGNEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4836021855;
        Mon,  7 Jan 2019 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866282;
        bh=zK+AYwJmVpysIuJ2lwppN+trx9FLy/0R2hjWuo8xexA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1j36HCZ8UHN1YOkr/nAho1HSqgIBtncvEDgivHCQ3EuFJRXFq+UwJx/JZj6YZZx5e
         SIdCi2MVBxk0hun1WLAAsFRnex49xwMzF3/GnEMba6dMyqP95LBhLSTClXoPcj+uao
         cMr8gwopVL6bMswf2v0pQUArzojlthB9huH2sTVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+ccf0a61ed12f2a7313ee@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 088/101] media: v4l2-tpg: array index could become negative
Date:   Mon,  7 Jan 2019 13:33:16 +0100
Message-Id: <20190107105337.702427111@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit e5f71a27fa12c1a1b02ad478a568e76260f1815e upstream.

text[s] is a signed char, so using that as index into the font8x16 array
can result in negative indices. Cast it to u8 to be safe.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+ccf0a61ed12f2a7313ee@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>      # for v4.7 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -1733,7 +1733,7 @@ typedef struct { u16 __; u8 _; } __packe
 		unsigned s;	\
 	\
 		for (s = 0; s < len; s++) {	\
-			u8 chr = font8x16[text[s] * 16 + line];	\
+			u8 chr = font8x16[(u8)text[s] * 16 + line];	\
 	\
 			if (hdiv == 2 && tpg->hflip) { \
 				pos[3] = (chr & (0x01 << 6) ? fg : bg);	\


