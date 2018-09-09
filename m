Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F26CC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C5720865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSybMdkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C5720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeIIK14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 06:27:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46006 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeIIK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 06:27:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so8865706pge.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XM2bEjP2l6mAKBckMIHQpAlR1oQczo6/YDJmHp6Oek=;
        b=lSybMdkJ2d3BEs7dnoQMXNJQbSSaHiFmeuKOVq5Tn1WOGHPYLkJRor/kuH3bzRibYg
         jXpototJNce9477W/Hg72zz9G5RV7wPD/iTlZtMM9ry9dvHv2WpAM+w5z/qXafFiegiH
         cwJx+ov+VrGl/tGyBfNgSqmyg2Md98+LpBacNpNsh5iZu6/WfoQAmqQOdRgimibIZMsQ
         XgBTxyIudTMywPVHMRVSl6xgE+dDduMMMWaPmbbugQtUhQP5XPVQeOAj8Hy/g5Fa7/tP
         mA97n1reiP1o453UhRUZBr4igacbeXa0Ds1T6qSPFJVDIC8rA8GgDItsAFv0ICPUwX/E
         qvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XM2bEjP2l6mAKBckMIHQpAlR1oQczo6/YDJmHp6Oek=;
        b=hcvM/IT9szHQf8pVfZ4I5nguKjwMv8YqcdZwmprnAtirGe77j4LVeygMdGDkGSFLI7
         Z0PbmMIdM9ily/kF6uZpsqbDhOYPgH5dttlchDgtm7xSAV+AvdcC6pu0rODxId0d7cxp
         BFZjviGyrQxFAuVoUsLzEPhdhfCTLWnDfQNl20hUCuy5KP9rzmRIGVlR9ENzGCksCfL+
         EQztwX+Fy4M1lrXwQLSaK4iZdKu1+RlRjHv0tv0wl2MMNYMLnf7Vr51yKAWSh2Fhbze2
         Awrh2RRbqT4l+ao3zvXPLKsXT+DfaSjQrhMulHfOwdWU/AyNxR6LYGtL8qsKhH9rD7Vx
         mgQA==
X-Gm-Message-State: APzg51CHCGUGfU8ngx+FjdcE8ZTDIedi4cnqlcjx9CTych3/LZZv34ej
        pJQ496Dz/6kdrGaLsTHbh5Y=
X-Google-Smtp-Source: ANB0VdZD+P/XLubPK8Pf6Gh1XC244PzMoG1Tiaj01UTZmYo6jVlPvtsrIjqR+/zL469R0bL9m/gNcg==
X-Received: by 2002:a63:f14d:: with SMTP id o13-v6mr16000602pgk.236.1536471571186;
        Sat, 08 Sep 2018 22:39:31 -0700 (PDT)
Received: from roar.au.ibm.com (115-64-249-220.tpgi.com.au. [115.64.249.220])
        by smtp.gmail.com with ESMTPSA id 186-v6sm6491034pgg.56.2018.09.08.22.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 22:39:30 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH v2 1/3] tty: hvc: hvc_poll() fix read loop hang
Date:   Sun,  9 Sep 2018 15:39:14 +1000
Message-Id: <20180909053916.14139-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180909053916.14139-1-npiggin@gmail.com>
References: <20180909053916.14139-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop") causes
the virtio console to hang at times (e.g., if you paste a bunch of
characters to it.

The reason is that get_chars must return 0 before we can be sure the
driver will kick or poll input again, but this change only scheduled a
poll if get_chars had returned a full count. Change this to poll on
any > 0 count.

Reported-by: Matteo Croce <mcroce@redhat.com>
Reported-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a87bea..c917749708d2 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -717,10 +717,13 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	if (n == count)
-		poll_mask |= HVC_POLL_READ;
 	read_total = n;
 
+	/*
+	 * Latency break, schedule another poll immediately.
+	 */
+	poll_mask |= HVC_POLL_READ;
+
  out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
-- 
2.18.0

