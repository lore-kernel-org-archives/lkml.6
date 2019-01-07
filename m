Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E6AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C82721736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867376;
	bh=FcOEr8xkYzEgbzUCKdvGvKX+0d3ZJgBYuKgvVRfms9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5He7HktFGPNWk2ysTXbHsteeAdRW6+C0LwuxjsiMf6wQ1rCCPO55k8HHdYVyo73R
	 3kzEa/Y4Z2DWLorQxDzMRlNQp82NRFoZ8XPoaqYbtI/NlmUzfd08EomJZazSpSnsiP
	 ZlVmwHaJOUEE/I8hWm1fJfsP9mZfnyTNHMJlcng4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfAGNWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfAGMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FA720449;
        Mon,  7 Jan 2019 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865010;
        bh=FcOEr8xkYzEgbzUCKdvGvKX+0d3ZJgBYuKgvVRfms9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjCR8Dy62er7K/XlP91FClk043aDQyHFjrZRwURD6QBFGN69zp5vWIAg20fs4NEq8
         fdM6Vpe1RWJ9iWiDJ1Rxw7hXolyvAQN+t536fLwkP3PiZMkpw8PVnW9BGdXRrW+ebC
         jm+/l+9XNcnoon9WIHIfyYY9+j+qy/R7Ll7Ao9wI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+ccf0a61ed12f2a7313ee@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 117/145] media: v4l2-tpg: array index could become negative
Date:   Mon,  7 Jan 2019 13:32:34 +0100
Message-Id: <20190107104452.539596382@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1769,7 +1769,7 @@ typedef struct { u16 __; u8 _; } __packe
 		unsigned s;	\
 	\
 		for (s = 0; s < len; s++) {	\
-			u8 chr = font8x16[text[s] * 16 + line];	\
+			u8 chr = font8x16[(u8)text[s] * 16 + line];	\
 	\
 			if (hdiv == 2 && tpg->hflip) { \
 				pos[3] = (chr & (0x01 << 6) ? fg : bg);	\


