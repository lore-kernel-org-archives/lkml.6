Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF8AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EAB21726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="eap7N3hT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLYV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 16:26:40 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:46670 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeLYV0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 16:26:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id CCC17AE9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7yUW7gtpSimh for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 15:26:38 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 9C0A873A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 15:26:38 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id 135so17996503itk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YZ/ut4gelaWAVFYeFqfM3A/J9UTKw9HJjR1xfSAeaog=;
        b=eap7N3hTSbg6iwBzyXcc0MErmo0zpE/cpBQN9sUEMNElpLdEoNyf+3V7qcj/tPgVlg
         znwClg6xqnFaSE/a6p8nH71IA2I5mcfPck9o4MuqEZuH3lGElHK80gnL4SHmAiEWvO7+
         8iH8GzLiFuEJAfQmD7I6RYZFovd2/KYxFXEsB3Z0iyLJqoSQp8dmOQIZ/2xyIjSlXt3O
         4+w6Bw69UitGM4897cm1vpdukcKYEcapnpAPgceVtg3il1p+4+chwN4q6iE/6sA4WlwX
         xV6OgYZjrj8vPx20doum0dw7i+/XyIrvah+xX3SrXdu/dZTx5LsfRS8MUnKzP2tt0kf7
         uX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YZ/ut4gelaWAVFYeFqfM3A/J9UTKw9HJjR1xfSAeaog=;
        b=uK8pb2oZIR10OyBUpybT8V4T3atmpNtThf03jO66h0wd+8Sja0PyUKOiKiQ8II7N3o
         Z0mawu0lrPM4+kl8t1aKgLKZ4YN/ds4qHcM7UtOLByAHNblysgQw5P92B/QrAGS2FgVd
         sEyMyZ6kv/X5gzg2JgeSthDnf/DiYZw/jnpOx6Ol3M/pgqa94Jto35XhsDp+1nfxCJ6D
         maW66lKeuEAmIoWOurm0DLQEr6eDqm/1Vfo1HCX1AMEFIqdr7NF4ganlstcmuiXlmWFa
         wArTWf4Nt2hZebh0Wg1x0cKjP6kf7ePJHIXmnyrQ29ptTY6E1nS1wbm06Jo02BzsN15F
         1QaA==
X-Gm-Message-State: AJcUukcmLjwABxegZrz5TKPBy9JKzRUrrzbrV+jY2vlmt66uRQyzuDWG
        5buYPS1w0ceZuNIdWaa6LyCo68WC51abxf6jesSCKytjeYXqbONHLeMCtHPC/n/6O/07OE5QsAo
        h4QQdLJ78ZyF38UHXW2zH2SSpJZt1
X-Received: by 2002:a6b:2c92:: with SMTP id s140mr11690247ios.218.1545773197972;
        Tue, 25 Dec 2018 13:26:37 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5nXPyjgdXbLk7lzFUEX2KvGjr5133d4Rnwcs279saXt0vH0hwuxgFwm0qz3LLsiwRnMvzlJQ==
X-Received: by 2002:a6b:2c92:: with SMTP id s140mr11690241ios.218.1545773197751;
        Tue, 25 Dec 2018 13:26:37 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id n124sm13164874itn.4.2018.12.25.13.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 13:26:37 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: a potential double-fetch bug when copying msg
Date:   Tue, 25 Dec 2018 15:26:09 -0600
Message-Id: <20181225212609.69856-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_msg[0] is copied in twice from user space. It contains size and is
critical. The fix ensures it is not changed in the second copy.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/dpt_i2o.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 93bd1d1bd5b5..2294520842e0 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1850,6 +1850,8 @@ static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
 			rcode = -EFAULT;
 			goto cleanup;
 		}
+		/* Ensure it is not changed in the second copy */
+		msg[0] = size;
 		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
 
 		// TODO add 64 bit API
-- 
2.17.2 (Apple Git-113)

