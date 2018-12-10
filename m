Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C246DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889772082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889772082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeLJVmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:42:43 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLJVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:42:43 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkHIV-1hCQmt2ewD-00kfvI; Mon, 10 Dec 2018 22:42:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: speakup: change semaphore to completion
Date:   Mon, 10 Dec 2018 22:41:50 +0100
Message-Id: <20181210214225.1497552-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p0k/nIw7k0tY2MW1KRKA/Yj5hMBdiphv3HwUyonquexwTrPZArU
 JPzq84mGW44V/N+yU4EQjxaUqSTNC73WSH7VoB/unYHDi73ibNJltsGtxB0ElC0va3xGwZD
 CsjdlSEvmYpHg1ZhcnTecAjLw2WbtJUNZlncArMqTd5r8tBx/qVAH5bBDKHrQBlbAbPmAym
 UACJ5EBSGmaYydCbv5rwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ii1a6NuNR0A=:n//Fa2Zy49zgNcCT7KbsoB
 uU+WjdB3O+kQMoBQXXfH8tYH16rqzSzvT59jpbfBROdsTdGvIV7ttx9KrF6Q+vhvfyxEEzt4A
 vnOrTgrHWkhGLQGHzO7vAvM+5RX9IRjBmTbNw8kyj66zpYJwDqfOhJpv0p4Iqqvp1pvdyJoDO
 f+4YeUXUFpWzZLVzaWKnjYFbml7ddw4+0NsF+CAocQLM6kqqxXlRgAFLOpfDodibSXSPv45Zb
 WVH0jvXSkJb+tyFZc3KjA/g5Qke7vaRI5vBDBsUtFJPM0gi9qvoF5/oMIM3mEA7GAB4U4iJBO
 NRVrdUO5W/VlXD9dKj9xhRa4w5l+aBe2yGeGUgIm0aWB1zZ66hldzSHGTWa0BQOd8ytG3PB9S
 G+0VcCLwKAxXtwg5aN7BX8u58Dg0po2t9nj0OWpcdhtMN8LpXsWD7NXwn8jrTwplGFjkTpVgm
 nz9bvXTpMsDa9WvryXS5QwXKfHwQs0pIsDyQ+SFdQ/JSx0hl4rkHFyVM9oT5H0iMWMNrHTINa
 wPi+JQuRX7/HjDERFnoiOeQX10l8flEjopnH0mpr2EuZmTIvUP0Cz0LPEsW5B5QZkpf9XXmbj
 4Gcre3q8TPSz5pFmWndoxKzj8Zzo9pdJjpYCb/XBKFmYVopd0mCw9jXGTTwXmP63b4p9LvbLX
 ugImL2XX6eg+9+jq3GNHGOCYRtuP5AtoUur1oggH60DeySrHTDOMpFIS4muZd0GsWNKW9JYH3
 eH+krsds4y/D4B+pg11rzBnpQaS8Sv3pPVG5XA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver, both function the same way, but we want to eventually
kill off semaphores, so a completion is the better choice here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/speakup/spk_ttyio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/speakup/spk_ttyio.c b/drivers/staging/speakup/spk_ttyio.c
index 979e3ae249c1..c92bbd05516e 100644
--- a/drivers/staging/speakup/spk_ttyio.c
+++ b/drivers/staging/speakup/spk_ttyio.c
@@ -10,7 +10,7 @@
 
 struct spk_ldisc_data {
 	char buf;
-	struct semaphore sem;
+	struct completion completion;
 	bool buf_free;
 };
 
@@ -55,7 +55,7 @@ static int spk_ttyio_ldisc_open(struct tty_struct *tty)
 	if (!ldisc_data)
 		return -ENOMEM;
 
-	sema_init(&ldisc_data->sem, 0);
+	init_completion(&ldisc_data->completion);
 	ldisc_data->buf_free = true;
 	speakup_tty->disc_data = ldisc_data;
 
@@ -95,7 +95,7 @@ static int spk_ttyio_receive_buf2(struct tty_struct *tty,
 
 	ldisc_data->buf = cp[0];
 	ldisc_data->buf_free = false;
-	up(&ldisc_data->sem);
+	complete(&ldisc_data->completion);
 
 	return 1;
 }
@@ -286,7 +286,8 @@ static unsigned char ttyio_in(int timeout)
 	struct spk_ldisc_data *ldisc_data = speakup_tty->disc_data;
 	char rv;
 
-	if (down_timeout(&ldisc_data->sem, usecs_to_jiffies(timeout)) == -ETIME) {
+	if (wait_for_completion_timeout(&ldisc_data->completion,
+					usecs_to_jiffies(timeout)) == 0) {
 		if (timeout)
 			pr_warn("spk_ttyio: timeout (%d)  while waiting for input\n",
 				timeout);
-- 
2.20.0

