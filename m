Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B3C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7666208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeloNKmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7666208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeJSEFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:05:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55773 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJSEFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:05:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so1487171wmb.5;
        Thu, 18 Oct 2018 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHANdbt58Pg39Mvd/rmz7T+V58uMxnBnOS2JESWX7aA=;
        b=JeloNKmnx/UO6bAenygRK4eS4oKz8NZ3RRIfZ87VLsxI31CLIFnuq7CbqAxi5Ja4Kv
         EtQxnrHGzbKyadOBbbdbCRHoEAvoQE/fj+dTkPom/69vH7VphgOGI0L9ljk82vJoQj11
         d58JuUHgSeGLGGjMXqWc8DEVIB2K0jOgL6h4wnZqhfr8E8wgz/Lm/ZahC70PtZFrqqho
         DYkQYdHA+rhNjn8YKxp56kiy5aHRGOlc/EkLcLb6ESY8kXIc7bAexbKzuTMTAH/86bxT
         y3Q9QagtOOWyXlGSr7ZBOo+GmgV4cqz+R5r+SxIIwTAtxAN6zZCzP+wrqMzfwdMbNPDC
         mS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHANdbt58Pg39Mvd/rmz7T+V58uMxnBnOS2JESWX7aA=;
        b=iELQqMyptC6lZ9GwROMbBYZI+ZxixlMlhHy1PeKMDBUoUAxCnwgabK2cgbGYoDxuIK
         cl7dpbyNvTL9lt9kyEhC+wIIeMzAYQt9f83HVwcDYEwTiwrFP1ObeuwAdq2QpuSaLjvw
         DAcAQ72v5jUNtF++3JxJOPs2Te1yNuzApN2hb5aGBd4Q3jMm8QYKRFrNrAtnM3+gyKd9
         KpiYFuQubnnUH4yp7NJz17zZerAIJZ6hOnsuh4wSsJ11shW/bQG/zXDcvAu+AOgjDYHn
         WbTMYD95XphBjJlAVagvrido/Z3n7L1ebHxTN5ZL/sQ9Po/4rI2wXCOcSPZtXqzAF/Hm
         kHfw==
X-Gm-Message-State: ABuFfogHRVqe85tcFHySfSBUOMgEgGMmgWV3K4uh7wElxgY4amd8j78g
        lQBkzAkPMz6/qU+3i1wjseEMv/XGRkTPmQ==
X-Google-Smtp-Source: ACcGV60VGJ0m9/NeVUkBb5UFMMFxvDwkqLeN7BT6NY7YlUXtQjJyTEmgkiim1X60Hd5CM1lq7FA4oQ==
X-Received: by 2002:a1c:f010:: with SMTP id a16-v6mr1702682wmb.5.1539892997055;
        Thu, 18 Oct 2018 13:03:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m2-v6sm13196049wrj.80.2018.10.18.13.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 13:03:16 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] media: firewire: Fix app_info parameter type in avc_ca{,_app}_info
Date:   Thu, 18 Oct 2018 13:03:06 -0700
Message-Id: <20181018200306.14307-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/media/firewire/firedtv-avc.c:999:45: warning: implicit
conversion from 'int' to 'char' changes value from 159 to -97
[-Wconstant-conversion]
        app_info[0] = (EN50221_TAG_APP_INFO >> 16) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/media/firewire/firedtv-avc.c:1000:45: warning: implicit
conversion from 'int' to 'char' changes value from 128 to -128
[-Wconstant-conversion]
        app_info[1] = (EN50221_TAG_APP_INFO >>  8) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/media/firewire/firedtv-avc.c:1040:44: warning: implicit
conversion from 'int' to 'char' changes value from 159 to -97
[-Wconstant-conversion]
        app_info[0] = (EN50221_TAG_CA_INFO >> 16) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
drivers/media/firewire/firedtv-avc.c:1041:44: warning: implicit
conversion from 'int' to 'char' changes value from 128 to -128
[-Wconstant-conversion]
        app_info[1] = (EN50221_TAG_CA_INFO >>  8) & 0xff;
                    ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
4 warnings generated.

Change app_info's type to unsigned char to match the type of the
member msg in struct ca_msg, which is the only thing passed into the
app_info parameter in this function.

Link: https://github.com/ClangBuiltLinux/linux/issues/105
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/media/firewire/firedtv-avc.c | 6 ++++--
 drivers/media/firewire/firedtv.h     | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/firewire/firedtv-avc.c b/drivers/media/firewire/firedtv-avc.c
index 1c933b2cf760..3ef5df1648d7 100644
--- a/drivers/media/firewire/firedtv-avc.c
+++ b/drivers/media/firewire/firedtv-avc.c
@@ -968,7 +968,8 @@ static int get_ca_object_length(struct avc_response_frame *r)
 	return r->operand[7];
 }
 
-int avc_ca_app_info(struct firedtv *fdtv, char *app_info, unsigned int *len)
+int avc_ca_app_info(struct firedtv *fdtv, unsigned char *app_info,
+		    unsigned int *len)
 {
 	struct avc_command_frame *c = (void *)fdtv->avc_data;
 	struct avc_response_frame *r = (void *)fdtv->avc_data;
@@ -1009,7 +1010,8 @@ int avc_ca_app_info(struct firedtv *fdtv, char *app_info, unsigned int *len)
 	return ret;
 }
 
-int avc_ca_info(struct firedtv *fdtv, char *app_info, unsigned int *len)
+int avc_ca_info(struct firedtv *fdtv, unsigned char *app_info,
+		unsigned int *len)
 {
 	struct avc_command_frame *c = (void *)fdtv->avc_data;
 	struct avc_response_frame *r = (void *)fdtv->avc_data;
diff --git a/drivers/media/firewire/firedtv.h b/drivers/media/firewire/firedtv.h
index 876cdec8329b..009905a19947 100644
--- a/drivers/media/firewire/firedtv.h
+++ b/drivers/media/firewire/firedtv.h
@@ -124,8 +124,10 @@ int avc_lnb_control(struct firedtv *fdtv, char voltage, char burst,
 		    struct dvb_diseqc_master_cmd *diseqcmd);
 void avc_remote_ctrl_work(struct work_struct *work);
 int avc_register_remote_control(struct firedtv *fdtv);
-int avc_ca_app_info(struct firedtv *fdtv, char *app_info, unsigned int *len);
-int avc_ca_info(struct firedtv *fdtv, char *app_info, unsigned int *len);
+int avc_ca_app_info(struct firedtv *fdtv, unsigned char *app_info,
+		    unsigned int *len);
+int avc_ca_info(struct firedtv *fdtv, unsigned char *app_info,
+		unsigned int *len);
 int avc_ca_reset(struct firedtv *fdtv);
 int avc_ca_pmt(struct firedtv *fdtv, char *app_info, int length);
 int avc_ca_get_time_date(struct firedtv *fdtv, int *interval);
-- 
2.19.1

