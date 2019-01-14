Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5449C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CB220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYepKJU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfANUlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:41:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44268 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfANUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:41:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so416492wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hq/o/PdI3/xbETUjxi0YvTGVwx/3sVuztIiDuqvD7bg=;
        b=hYepKJU2THV4p9cxO7oLWeanWpcEya+ejqEGcbK61OQD1JDxLftbcUgcVrt4M2w2Ny
         LK+mApCUXLlx0hDHW+lzZ/G0gOCyl75PJPEDhg/HGWHPq45YH9dC7W1H6GFksPYbuxHn
         XcZqOP1f9xhZrBhAcejWVg+Ug82Ep88zrmDhNZEtQy33km2ZkmVBengjQ2w2BElkOABJ
         ERgdRsnWbMOBEqMhvHHmFm80HMexZpHQMEOwqVdysklYzB5lQ50vhs58+Vot1EY62vBd
         EULVk6gZaaLt4WfOMxkk7NPhuVPHgcxdYZAdr6R8ipp1P0DHw8mkGMcChljImsapoYS3
         VmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hq/o/PdI3/xbETUjxi0YvTGVwx/3sVuztIiDuqvD7bg=;
        b=RaQxbKe4D7DS0QS76F2FzHfmYsAg2GpnDsqtlEzaXkXY4+LvZp3f2PUEDyN4HMGuh3
         1LeuMpz5G88Q4DGAEojjYvGyn3136vfNU4DRaOQehuumboTgYtX1AiO7CTRiH/MUe+VO
         Cu1r1EKSQuKjQ9Kv6dZPihlqJY8ake4z76Yt7+aebZJ0M4s7ozlj3q8PIqKPNBluH6Is
         f9+DkY5sZdvCVpif+ru2B0bSyaNeCk5IXpr46QorP5+tkYxB0IrasSmAsU1qp1zmZRZ8
         73cOTrx3+hp9XS7gSO+61tXPv+UXlSV6y424IRYWVGyUWikYYZIPqlCQW4RxNNkHOj9l
         HW0g==
X-Gm-Message-State: AJcUukcjUQnVL9k/zce4aI81W1tpYEYuwzG0XjNnoOtv/pVuYkVZRPkd
        ymZRBkdJD9nGncxvY3xqy2mwDZc3
X-Google-Smtp-Source: ALg8bN7p7fuTtzdHswKcvBYYKSK9A8/fe077OZCGEF/tpC2I186LmxlSD0huao+qd1O0LmfhjXRrAw==
X-Received: by 2002:adf:82a4:: with SMTP id 33mr217732wrc.252.1547498477430;
        Mon, 14 Jan 2019 12:41:17 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id y34sm203044974wrd.68.2019.01.14.12.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:41:16 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id AD50E11422AD; Mon, 14 Jan 2019 21:41:15 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vt: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:41:13 +0100
Message-Id: <20190114204114.20814-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warning:

  drivers/tty/vt/vt.c:2112:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/tty/vt/vt.c:2237:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 41ec8e5010f3..e4f8caed26af 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2111,6 +2111,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		lf(vc);
 		if (!is_kbd(vc, lnm))
 			return;
+		/* fall through */
 	case 13:
 		cr(vc);
 		return;
@@ -2236,6 +2237,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		vc->vc_ques = (c == '?');
 		if (vc->vc_ques)
 			return;
+		/* fall through */
 	case ESgetpars:
 		if (c == ';' && vc->vc_npar < NPAR - 1) {
 			vc->vc_npar++;
-- 
2.19.2

