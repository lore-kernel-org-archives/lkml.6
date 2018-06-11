Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HKEIEmMFHlu+cwAAmS7hNA
	; Mon, 11 Jun 2018 05:16:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5DF1460792; Mon, 11 Jun 2018 05:16:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpQq/U/p"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E57ED601D2;
	Mon, 11 Jun 2018 05:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E57ED601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeFKFQf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:16:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46609 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753911AbeFKFQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:16:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so9581395pff.13;
        Sun, 10 Jun 2018 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9HnoT00GA/e4hqOrOsR5vOygtqQIU8ZliGrohbyJ7B8=;
        b=YpQq/U/pDVPE8Ir+DaDWKrS3GbzC8URtjRh1KR5kYS0eRxbIrqzXvC9ilQvL0n8rOr
         foS+VJo3IKHoV+7hMeRnafS4UIdCzJijASkRAfO6YNph69B0uPXkl74CVBmXWgOrR250
         aTfyNjUgdw0ik7CtV6VXhL8St2zMU3de6kKiuoQDkEPcVgu6wqEf7V2Zu3HYlewODbpM
         uThnIIRNJbXcBkfcTDpnHe2oVA1CKs0peuDxKJMuqSJ7NpMqk8nUDuFi2fVVqDFirxqo
         hANszDzUiOY+Bn1694328f8sXdydcFb0wNl55wI3dxxBjzty4DG7JptfyXLskwEfuzHs
         3OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9HnoT00GA/e4hqOrOsR5vOygtqQIU8ZliGrohbyJ7B8=;
        b=dtKaOBLzfNPddI93mF6xbo2ZcnLhjMnn5wv6/fVroGitUQ83+AL/VjVGrWV2LtWhkU
         un5ZtKBlxtnteMo++eYKJEJJilaLqf9qa/5ek4KXEKY2wht1pN1sBnXpx8qD7OdGUFEu
         AHYkuROXyiz7mXiyo355yhHIoTKReSDMkj2zjXgTp+a2xnDGYUPcV1iaSCvfhdp8IGqK
         wLs250xNKVK5GRYAnGFhEX8fsuovhHHqZYVO+hq/xjVUkDePVZi0JyNvo/1qjmAhXn2u
         Xt0KQxOyOkQhJezHkZFC78ZLqXcXdUv81fjxKz0EKNf2QYSNEJBDYrzeEXvhsHenzJAb
         RHvw==
X-Gm-Message-State: APt69E0Ssf0Zrm19L8MLq4phnkCgkgElYkpyTlkOiMsNpvbnH/FbUyBt
        3rIKc8CLpP2RQuy0ppmkQYY=
X-Google-Smtp-Source: ADUXVKL6LZUBbmnzDgrGM7YA298sQpF7YdtJuBAjNkzHPxniGbc7LjoCfrzlCioXEVRNaKgKmmetEg==
X-Received: by 2002:a62:40dc:: with SMTP id f89-v6mr15791018pfd.194.1528694190968;
        Sun, 10 Jun 2018 22:16:30 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id m9-v6sm108051463pff.41.2018.06.10.22.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 22:16:30 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: add error handling for pcmcia_enable_device
Date: Mon, 11 Jun 2018 13:15:50 +0800
Message-Id: <1528694152-31724-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pcmcia_enable_device fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_enable_device.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/scsi/pcmcia/qlogic_stub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 0556054..9287d52 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -254,8 +254,14 @@ static void qlogic_release(struct pcmcia_device *link)
 static int qlogic_resume(struct pcmcia_device *link)
 {
 	scsi_info_t *info = link->priv;
+	int ret;
+
+	ret = pcmcia_enable_device(link);
+	if (ret) {
+		pcmcia_disable_device(link);
+		return -ENODEV;
+	}
 
-	pcmcia_enable_device(link);
 	if ((info->manf_id == MANFID_MACNICA) ||
 	    (info->manf_id == MANFID_PIONEER) ||
 	    (info->manf_id == 0x0098)) {
-- 
2.7.4
