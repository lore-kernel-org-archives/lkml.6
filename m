Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297BECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3D2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fsid4hQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB3D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeKAJZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35871 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeKAJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so15195204eds.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ULrcMT5uKPuLdCU8vVAvTwBXq/D+pzzDFL372xkTj58=;
        b=fsid4hQbRPThKO/alpNFOUV9nnbk78ajSGJdat+OXkog/L45/PFstnaOFPLGGax9ZU
         BPjiisJEOUMGJv+acPEyeIT+zk4gY7XXj6hRw6aAkj/gXXzSXQyswBxD8U6WBMt3iOlI
         IDLf+Ajy04TNxB35uLkTTMKGYuaMVF/lJt2eR7hUv9ZcqgEPmj8dFVPV4Hx30V4m0rd4
         CFwLTA3qzqhG940MSW9FLJgx7JTeb58U0OVymk3c1fvLXfKht8xWo7hsIOPbjsSeWB+n
         liKrY7qAq1CcbqU66EHyr97xHSpwmsSs7JuO+7cD00fW431TTVqQva5MEYP6oOfiANDY
         SDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULrcMT5uKPuLdCU8vVAvTwBXq/D+pzzDFL372xkTj58=;
        b=OIJ+T1Z2sxqe/+eui9O5mnUqcKSQhXoo2dUOLIEqa/PH9Ndo9YjK/vW1M3kaufQyin
         zDKkyjf13taSINcZRwiiHCXclh6a/ocg49nMCcLuLJpcN3rJZ5Ow2i3k/HT/K1EO5xJt
         wTU0gX2AJhYYS0VOAetBrUhdi8MNDxN8FCObGsZXtHLqI4AzHDhjFSGt6N/pW5q47Myv
         SknATieb/4qS/vz4bj7/c4dNfqfNcDUNl/oN0NccOtL5lz6UBnRtoi2ZswhIu55+KX/m
         vRxVldK4R2yZoa9kwpnORElrwZbUGkcftL7YcPEFigl8x4leDMbU1CTorZwK7Mfqr1tO
         MVFg==
X-Gm-Message-State: AGRZ1gKJA8/AtICeNf0zJVb0qfyuRUFpHA/W5rZw6jC0u+eKu5f41UBF
        mCWtL2KDoOp7QcxzBrrw9ltYLfFgzYk=
X-Google-Smtp-Source: AJdET5dTDprHfXvkEyNWR7TgjyH+BLkhBBtfEz9fbjt5J9IJgahLuZtrtnO7/L4OnVDgiHpek9t/Xw==
X-Received: by 2002:a17:906:70c3:: with SMTP id g3-v6mr2749078ejk.194.1541031901534;
        Wed, 31 Oct 2018 17:25:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:25:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv6 4/7] tty: Simplify tty->count math in tty_reopen()
Date:   Thu,  1 Nov 2018 00:24:49 +0000
Message-Id: <20181101002452.5483-5-dima@arista.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f73d8fa7f02b..57d06eda5b2f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1272,16 +1272,13 @@ static int tty_reopen(struct tty_struct *tty)
 	if (retval)
 		return retval;
 
-	tty->count++;
-	if (tty->ldisc)
-		goto out_unlock;
+	if (!tty->ldisc)
+		retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	tty_ldisc_unlock(tty);
 
-	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
-	if (retval)
-		tty->count--;
+	if (retval == 0)
+		tty->count++;
 
-out_unlock:
-	tty_ldisc_unlock(tty);
 	return retval;
 }
 
-- 
2.19.1

