Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D31C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C8920645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H/MSZXFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C8920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIKGpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45574 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeIKGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id p52-v6so17947252eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FIen88DQrp9YO6LPAI3wQiJtJTAng1p+YKYVEWXs6eM=;
        b=H/MSZXFeyNF8Bl8qg13wnKwnJ2CGCzHvsB4SqbJzndqRnvCTC3pAMHUZMhki1dcOEL
         MTRKnoVaLPOp+SpDDPcyKMNH6L6Gv4YfDWlWZvr0S2ptGpYqTjh9nQjgETXG3Az45KBA
         Zgoxv+SKQ/3KlnY/7rLFLx7Q/PHJOUOSLRK3gsjUyvEk0yDO/Qmvvrq8mUFbWmVhAvru
         pkwEmkPshGbIZ24evrJ/BCzMWKYRiRcXt5El2XwxdvioRBtO9uzlDEDQYtgJYMrAJ4DL
         17Uti1OfxhQMMREucdHewclCxm94YfhVI5EQvHY/dEVVdZ45SkX9UBXoaf8DwRyBp9AI
         /cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIen88DQrp9YO6LPAI3wQiJtJTAng1p+YKYVEWXs6eM=;
        b=NwUFUKNiI5XJMlkVrq4MgSy4HdkREuDnZln1u1POJfIb6UtRzOl673C5Xe4yVEswjo
         C9n9LHpiB4/XgGgnI/1CzggQrJufPD8dN7SBgMdboZiKqwBKPUdsDqgZwbz1hWEShbjp
         TAHMJxl5NqLAB0bhGUOBIvQjpwgODIT5k5loWsOksXRvWDTQdhSFUVCWOAzrHf+9sMJX
         rtKDYPyDp0rxrlbljYhB3CopyOAP5X63orzP/0qrTcoTZzlUEkUehdaPMSWSQ4ZnNRG8
         dky2PYTYfYSRXHykkhyb+pCQnwKE0H8eezL53XqhsJ9C1bdVoCpGvKLDctymskZpVYzH
         /Jow==
X-Gm-Message-State: APzg51AGsCOAbedcMy+pDEgSvzomRFnwR/aZDwBEwPoRUK+0DXiq5cSu
        X6ugKhOC6nPrdosO+GA+qJnVIEpRPiI=
X-Google-Smtp-Source: ANB0VdZCOd39CWkKnC/xbEiv+lVBUDW7SKCBS8IEYmdAUwsBqYGDGAcG72F+it46cirAUpEPUln08w==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr25728538edr.38.1536630510339;
        Mon, 10 Sep 2018 18:48:30 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9171002edb.8.2018.09.10.18.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 18:48:29 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv3 5/6] tty: Simplify tty->count math in tty_reopen()
Date:   Tue, 11 Sep 2018 02:48:20 +0100
Message-Id: <20180911014821.26286-6-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180911014821.26286-1-dima@arista.com>
References: <20180911014821.26286-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As notted by Jiri, tty_ldisc_reinit() shouldn't rely on tty counter.
Simplify math by increasing the counter after reinit success.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Link: lkml.kernel.org/r/<20180829022353.23568-2-dima@arista.com>
Suggested-by: Jiri Slaby <jslaby@suse.com>
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a947719b4626..7f968ac14bbd 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1268,17 +1268,13 @@ static int tty_reopen(struct tty_struct *tty)
 		return -EBUSY;
 
 	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
+	if (!tty->ldisc)
+		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	tty_ldisc_unlock(tty);
 
-	tty->count++;
-	if (tty->ldisc)
-		goto out_unlock;
+	if (retval == 0)
+		tty->count++;
 
-	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	if (retval)
-		tty->count--;
-
-out_unlock:
-	tty_ldisc_unlock(tty);
 	return retval;
 }
 
-- 
2.13.6

