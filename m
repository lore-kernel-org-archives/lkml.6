Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83E2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FF220865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhK6tiGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FF220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIIK2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 06:28:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42137 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeIIK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 06:28:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so8867459pgp.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=acp4CPFPVdU4dENC18UllOpvp1Ys7Qzn8tJAUDcSWxk=;
        b=vhK6tiGe7ozCQ+3+U9bK1v8NTjaxugd/h+1wHMnmmT0RDO/8tnuBSCvJ3wJlF7OoTz
         s2X8RwTxh0CK2lRLpGt6ju1LdsRiZobYfE1MKIBnRP15m6p9+iXpWLs+plaXLpIQXN2y
         Zin/hhuytBLCvP6Jvs4fq6BxhHoqUPOQ0/VBHPfl2SahNQxzeU0lAVA0QwhbkDAe9Q5X
         WL1Z41X7gutzjUMfA049tuTqOfatM3qbGhYW1sXLOurfRJkTAmMnVxjNItDhvG0NlhHL
         vJPveKXz9zZ3pK0cVAHUq7mib2cAYZ9ai80NPPxJfTZ26bt5JJ+JCrB3uk+5lf7EsY8J
         evOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=acp4CPFPVdU4dENC18UllOpvp1Ys7Qzn8tJAUDcSWxk=;
        b=ZGroG8USnXoEEGlvOXT6h5+WS5ZY7GVFAS+VU7mKtV/bC+FQwkrCIHv0OuNlnqvSqw
         UjeAW279H1LnlaEUwu/4Gbb7W5TcAKoBDQuWjOgFXWubzj/dTgyTvLmDxsmPu+r4Mck0
         oER7W8ScVkQF0XIfcFEzD5mqkFIxuPExxRhrIcZcWR4R5VB9TR6cJEqUeQ3FMsIsiT/k
         HWvFnVg6iiE3eduqs59kXj89ae7sPIyrXoH0c1L2m2LXXm2K6cQYAIlqHeA9nFfomHbL
         Ym7NiElBTaISd28Xqd9TZo/RPoIZ2vBZXHoVLQXBtHNwwNBVTLB+sczeuK7i7hFT9rOn
         HiRg==
X-Gm-Message-State: APzg51CX3GPcCXak5rQCd+qqzSh4rfVh7Gwv39Zjt9Py65YVVXg2JYtD
        8wHpwg9c1YAU52PE2qMVg+0=
X-Google-Smtp-Source: ANB0VdYEAbh7fDODugtCKbqnE1zdLQ+FGOUy/Crqb1ch+CrBBKWOI1WBOKjliyRmH6DC0FSmHr1gMg==
X-Received: by 2002:a62:ba0b:: with SMTP id k11-v6mr16961136pff.171.1536471580026;
        Sat, 08 Sep 2018 22:39:40 -0700 (PDT)
Received: from roar.au.ibm.com (115-64-249-220.tpgi.com.au. [115.64.249.220])
        by smtp.gmail.com with ESMTPSA id 186-v6sm6491034pgg.56.2018.09.08.22.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 22:39:39 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH v2 3/3] tty: hvc: hvc_write() fix break condition
Date:   Sun,  9 Sep 2018 15:39:16 +1000
Message-Id: <20180909053916.14139-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180909053916.14139-1-npiggin@gmail.com>
References: <20180909053916.14139-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 550ddadcc758 ("tty: hvc: hvc_write() may sleep") broke the
termination condition in case the driver stops accepting characters.
This can result in unnecessary polling of the busy driver.

Restore it by testing the hvc_push return code.

Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index bacf9b73ec98..27284a2dcd2b 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -522,6 +522,8 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		return -EIO;
 
 	while (count > 0) {
+		int ret = 0;
+
 		spin_lock_irqsave(&hp->lock, flags);
 
 		rsize = hp->outbuf_size - hp->n_outbuf;
@@ -537,10 +539,13 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		}
 
 		if (hp->n_outbuf > 0)
-			hvc_push(hp);
+			ret = hvc_push(hp);
 
 		spin_unlock_irqrestore(&hp->lock, flags);
 
+		if (!ret)
+			break;
+
 		if (count) {
 			if (hp->n_outbuf > 0)
 				hvc_flush(hp);
-- 
2.18.0

