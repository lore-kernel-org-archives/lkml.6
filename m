Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADE6BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561B2208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSVb7Ord"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561B2208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754770AbeFNJXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:23:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40547 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754571AbeFNJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:23:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id l2-v6so2641882pgc.7;
        Thu, 14 Jun 2018 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5CWUE+DJQk737A80kvtUR0W5C/zN0zB8ULk15CCzUE=;
        b=nSVb7OrdyQkf19aj4F9badYh7pBANXjeWPSd1c/jLg0QFB7IGbfCt/r1DHOx4cEm3D
         dEmK1vWAV3BzfMfvFCLa41yTMMS/e/dDxxKs0pKa3WKXg211BqL5JjNjj0RajMqH84Dz
         pyA8QGNLrsggcaoJqWXVHvDib0HgrzO1i+LhS0buhobzMVzZMyYwN5u1t7MKgPojBpEU
         AipXt3kTWCiy48mCjDBpKYDwadyai4rYlDTsgk+zSCbberuOm49M0nyAXiV77UX927rW
         R5gLYe1piauVTRjeTE9YpgPsGXRf3U6Rwf4QYNP/Y/fyLyO6uuThVwgFOhZgCv3l5e36
         aLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5CWUE+DJQk737A80kvtUR0W5C/zN0zB8ULk15CCzUE=;
        b=aCZ1FN054Uv8mTdSggSMfqcPcfbdFs/0x0q2hZ3Xxc0sjI9cb3NB3QWkkphV2OvWJS
         DvJl4pq6HdUbr+NM1n6+NW6McL0eRA/7N0wyjcXCqj/VfHXVtJZMIVA6oVkm9SLkm10J
         YRzKhRmp/oZB7i17Qsq6BlsbQKOj2/5DnqjR8PsnSKAH+usQqJAQQfAu7qRwIzE7nJoE
         wHGyDcfa6kvG02TNm55UX8oY81DGgqr/jeHCRQmBWgAbXYxt884YSGTlAPGsxHfbSCgD
         hVRzpmeWM/qlE2HBUMONap1m6FPYfAJW4xJDUsChCxALnrhnJ7+lv/679DbycuF0o/uO
         mE8g==
X-Gm-Message-State: APt69E2m4Yj+Wpsix+YuWgiMJH7BEsZmi17HfYCtx74UuDfVyjvitsxp
        BqkChTQzYcouuL0Fv4a1w0s=
X-Google-Smtp-Source: ADUXVKJH9atTFKteXjhIBfPUGjhGeZaworJfhBFldXC281g1fAlr3rkL6P6pIwBlI0Q9UqGc+rkSfQ==
X-Received: by 2002:a63:7983:: with SMTP id u125-v6mr1593428pgc.267.1528968214939;
        Thu, 14 Jun 2018 02:23:34 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id k13-v6sm2774275pfg.130.2018.06.14.02.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 02:23:34 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pcmcia: add error handling for pcmcia_enable_device
Date:   Thu, 14 Jun 2018 17:23:25 +0800
Message-Id: <1528968207-48671-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528694152-31724-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528694152-31724-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pcmcia_enable_device fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_enable_device.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Remove pcmcia_disable_device.
---
 drivers/scsi/pcmcia/qlogic_stub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 0556054..eb2c8bf 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -254,8 +254,12 @@ static void qlogic_release(struct pcmcia_device *link)
 static int qlogic_resume(struct pcmcia_device *link)
 {
 	scsi_info_t *info = link->priv;
+	int ret;
+
+	ret = pcmcia_enable_device(link);
+	if (ret)
+		return -ENODEV;
 
-	pcmcia_enable_device(link);
 	if ((info->manf_id == MANFID_MACNICA) ||
 	    (info->manf_id == MANFID_PIONEER) ||
 	    (info->manf_id == 0x0098)) {
-- 
2.7.4

