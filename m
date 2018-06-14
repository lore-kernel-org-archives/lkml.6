Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3B0C6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE2D208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSfQZDgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE2D208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965168AbeFNXlx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:41:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35546 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965001AbeFNXlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:41:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id 15-v6so3614504pge.2;
        Thu, 14 Jun 2018 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dkb3VUc4xoAcDFTCNdQiGUQCXp+PgrPRBCs5iUfoRg8=;
        b=CSfQZDgX4Caw13oUANUdH6ibXgbq7EzVu2c5xBXg2hz0oOz677yRXODiykcMBjWRfR
         4gpbTNjRS7ZdJr7jLadlcw4DcBrGBs4tQd4/en4w70t820hmQ/Zgfv30+brr7/KGSXOp
         2vm/YRiA1IZHUFdcS8XNoAj5c/ZpmphfwEo3bERJi8LF3DFNelb3Z9Mjy3/LzcIVxDLj
         Ifai8y5I4t8nxYPuAJfertOfCIVrF7PWw42IwGyuSOswjARksOwL/uz8iiTmbqsbXfOy
         EWxOY+PUJMhzgkPQEbCSBowlLhE8lFGBune1ckDZYfxCfeLq9y/pJKWjlmHw1dzGj3sk
         q1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dkb3VUc4xoAcDFTCNdQiGUQCXp+PgrPRBCs5iUfoRg8=;
        b=FFrPAc4Ygajh0TFOK+gDH+d3sJhxpDUc6P3D/fvj7Zgj+EKgigiKu1+mvSq0eu6MXY
         cy441tKuLnz5ogISr48NyRvxWR1B15D3KilUrGikjcQPd2ddLYfe0aO63y3bN4iR852N
         raEhNBaLa9UO4KCLCC95ZHwd6or3vGcKBUqYyZxOzh1M+yxcEDdpQqREHA5/6E7PPiX+
         lg/GSmvZ8dRCRbEYaezjNexE5lHCRdL8bgdWjInO9gP4EAD8+TeU1xKBbKbzFHYz7P3o
         WNdzSrr1n8AAHDmTKGjElaUiEEHXBl0JvIck6cHPyXH7C9kQui0A9tlZD+LgxAwfUOJg
         HkRA==
X-Gm-Message-State: APt69E3XOcU0BPRzmZYn6Q+sDEw5qS2oMPfxZsuJG6OaABwQXtMD1tCE
        72vAPqVy1RrycIHrMWBxki0=
X-Google-Smtp-Source: ADUXVKIG1HJlCXM7FMZwLfptNBnMT9k400MWaaL+SpNTsiE43NE1cQgNb/GDvuOPc4OorYdN/Giwpg==
X-Received: by 2002:a63:7a07:: with SMTP id v7-v6mr4001182pgc.444.1529019711408;
        Thu, 14 Jun 2018 16:41:51 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id q200-v6sm8409139pgq.9.2018.06.14.16.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 16:41:50 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pcmcia: add error handling for pcmcia_enable_device
Date:   Fri, 15 Jun 2018 07:41:38 +0800
Message-Id: <1529019701-55981-1-git-send-email-jiazhouyang09@gmail.com>
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
v2->v3:
- Change the return value.
---
 drivers/scsi/pcmcia/qlogic_stub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 0556054..9d5751a 100644
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
+		return ret;
 
-	pcmcia_enable_device(link);
 	if ((info->manf_id == MANFID_MACNICA) ||
 	    (info->manf_id == MANFID_PIONEER) ||
 	    (info->manf_id == 0x0098)) {
-- 
2.7.4

