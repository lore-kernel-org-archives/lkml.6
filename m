Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A06C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9805020879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfAVPJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:27 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49272 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfAVPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:25 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 10:09:23 EST
Received: from localhost.localdomain (unknown [10.50.122.29])
        by mail (Coremail) with SMTP id QMiowPBxSOXaMEdc4YB4AA--.40673S2;
        Tue, 22 Jan 2019 23:04:03 +0800 (CST)
From:   qiaochong <qiaochong@loongson.cn>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, QiaoChong <qiaochong@loongson.cn>
Subject: [PATCH] parport_pc: fix find_superio io compare code, should use equal test.
Date:   Tue, 22 Jan 2019 23:03:44 +0800
Message-Id: <20190122150344.8072-1-qiaochong@loongson.cn>
X-Mailer: git-send-email 2.17.0
X-CM-TRANSID: QMiowPBxSOXaMEdc4YB4AA--.40673S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr47Ary7XryDuryDtFy5urg_yoW8CF4xpF
        45tr48Z34vqF17Cw48J3W3GFs3u3ySkF1kGFWxG34avw1Utr4DCF4UArWFkr9xWFs5GF13
        Xr1rtFsxCF4Iqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4x0x7Aq67IIx4CE
        Vc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_
        JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UV6wAUUUUU=
X-CM-SenderInfo: 5tld0upkrqwqxorr0wxvrqhubq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: QiaoChong <qiaochong@loongson.cn>

git blame drivers/parport/parport_pc.c

181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1376) static struct superio_struct *find_superio(struct parport *p)
^1da177e4c3f4 (Linus Torvalds            2005-04-16 15:20:36 -0700 1377) {
181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1378)        int i;
181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1379)        for (i = 0; i < NR_SUPERIOS; i++)
181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1380)                if (superios[i].io != p->base)
181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1381)                        return &superios[i];
181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1382)        return NULL;
181bf1e815a2a (Alan Cox                  2009-06-11 13:08:10 +0100 1383) }
73e0d48b8c28f (Michael Buesch            2009-06-11 13:06:31 +0100 1384)

git log -1 -p 181bf1e815a2a

-static int get_superio_dma(struct parport *p)
+static struct superio_struct *find_superio(struct parport *p)
 {
-       int i = 0;
+       int i;
+       for (i = 0; i < NR_SUPERIOS; i++)
+               if (superios[i].io != p->base)
+                       return &superios[i];
+       return NULL;
+}

-       while ((i < NR_SUPERIOS) && (superios[i].io != p->base))
-               i++;
-       if (i != NR_SUPERIOS)
-               return superios[i].dma;

the code before 181bf1e815a2a  also mean superio[i].io == p->base, fixup it.

Signed-off-by: QiaoChong <qiaochong@loongson.cn>
---
 drivers/parport/parport_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 9c8249f744792..6296dbb83d470 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -1377,7 +1377,7 @@ static struct superio_struct *find_superio(struct parport *p)
 {
 	int i;
 	for (i = 0; i < NR_SUPERIOS; i++)
-		if (superios[i].io != p->base)
+		if (superios[i].io == p->base)
 			return &superios[i];
 	return NULL;
 }
-- 
2.17.1


