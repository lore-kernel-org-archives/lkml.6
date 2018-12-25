Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29464C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD953218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="J+JVVh8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLYVrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 16:47:05 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:47484 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLYVrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 16:47:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 63622B23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:47:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iYXUWBSK9373 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 15:47:03 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 330E1A81
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 15:47:03 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id h7so17750447iof.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p5hO4jdGumw2ULA+lkW2QArS4JL6MqkoANesP4lGhwI=;
        b=J+JVVh8BrV5I3BZMVyHDyTZTzy3EVJShzDfINXBXAjzweEct5RZOEV4Vt/GnMjsplA
         MSVstVqNc3Yp4E3f9eRfzxKZNk5kn+5+qDTOq8WCMUOz2tv1Ddh4/bjxf/TBsCoDcts4
         AGckZUA4qWyFD6GJZXzmkjLoSVDJem6pBrx2dm7BPAlP2vA4sUqp3cvPm9o3dET2CJjy
         FhdNk9+wLW9EA3OVy0uHzz6ymdulSVPTxfyJ6SEsaacui6OKC4fzsOjGWbZqwQDb+++G
         9cT61TdYOGX/lwwWaiv993TWrq0Rqq8xBABwH9B7gMCaBKiFKocHzGbth2en0ecI+l2o
         6fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p5hO4jdGumw2ULA+lkW2QArS4JL6MqkoANesP4lGhwI=;
        b=IR1bFuDnt7oqVDPCL02TSNoRFg7TD8zuipMNK56oQFxrTWtyPm+eo42CNAnHSXihgx
         zBDwSIJx/Dv6ulAYnyCuOgumju9ev95yMaGduhqCaAxyBNcaQuruTdEwo0tOB2YDj9bC
         0hKh+bGIKbjF9URxONgMIWauvooIj6aMtNJ48ZpNpzIfw9i8WNKi/T3F3Aczrk5wyo2Z
         EeqPY0FaMEZp9Xd/jvlaqdHg+GmqUsUIZuBJ8y229p1p4vg2Bp3E9gEQyMMbfLEHXQ0I
         f7vPd5LMHdpzAOf5DrPhA5tUKGHkxke7DalVtm7TN3YLhipa3DwCWedScOHT67IIUm2G
         jz6A==
X-Gm-Message-State: AJcUukd2DfMhwvT+QdSgYGufBiNp3pPnbiAdPyxtvsPcmbk6nTH8yk0+
        gbqt4ELZeHqWyxR3sblWDC7Yazbm7Eve93h+cqB5DEtJpuiAcyf7OABK5FqlGKlpRVLhNf/iRAH
        rmNB3KkgKnYxSpGtiBWQia1LIr4s8
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr10758076ite.72.1545774422795;
        Tue, 25 Dec 2018 13:47:02 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7CU5SRKmo8v/Pve1+aSxeHBXVcJ5eGhJgbhXd7ZNA4joHT7utUgdBke9tiGTEqKyrTE/woWQ==
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr10758066ite.72.1545774422541;
        Tue, 25 Dec 2018 13:47:02 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id n20sm1843645ioh.64.2018.12.25.13.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 13:47:01 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: fix a potential inconsistency caused by double-fetch
Date:   Tue, 25 Dec 2018 15:46:33 -0600
Message-Id: <20181225214633.69973-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"user_buf->length" is in user space, and copied in twice. The second
copy is after it passes the security check. If a user program races to
change user_buf->length in user space, the data fetched in the second
copy may invalidate the security check. The fix avoids the double-fetch
issue by using the value passing the security check.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/acpi/custom_method.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..f75f664301b3 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -26,17 +26,16 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	static u32 max_size;
 	static u32 uncopied_bytes;
 
-	struct acpi_table_header table;
 	acpi_status status;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
 			return -EINVAL;
-		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
+		if (get_user(max_size,
+				&(struct acpi_table_header *)user_buf->length))
 			return -EFAULT;
-		uncopied_bytes = max_size = table.length;
+		uncopied_bytes = max_size;
 		buf = kzalloc(max_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -56,6 +55,8 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		buf = NULL;
 		return -EFAULT;
 	}
+	/* Ensure table length is not changed in the second copy */
+	(struct acpi_table_header *)(buf + (*ppos))->length = max_size;
 
 	uncopied_bytes -= count;
 	*ppos += count;
-- 
2.17.2 (Apple Git-113)

