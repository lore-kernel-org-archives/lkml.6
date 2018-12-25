Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A88C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD9C21726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 19:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EsS8mAlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeLYTgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 14:36:42 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51914 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLYTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 14:36:41 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 08608AFD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ResIuuohpL4N for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 13:36:39 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id CF931A88
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:36:39 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id k25so1171489ios.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=S3arjK9lymWq8Gis82Wib0NPZcJUj7BlMTvV8U54j6Q=;
        b=EsS8mAlNOxCYt9VVvbIWFOGH/3dcNmKuCSagNF3GQc3PVT7Y8SN6diUHtuwuhQv+lv
         v71qph7RKCnxhaeZu70r2mIFZ5iGDxTeK2WoDNntjgT0igTyFrzq0NUhspiZMT/DmBF2
         cgB95ILdE3VDThX7M4F9qAiRW9LLcQJxcwq+Ak9+ol8C3VfqJmUfA2J6f52x4+h7UWji
         7vR0ZarAlrXi/T/fkCYt+zpSkZdnEFQ7m8uxNLBlddj2YEBvMQuRfCDkE2iOzcbBQ9Jz
         Fyvc4uIemF+mL6vvS2J8n4F2N7Vjz9hyeTK9oO8qutTHyhAZmi/dJIDqtX8tdBmPIl5q
         XvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S3arjK9lymWq8Gis82Wib0NPZcJUj7BlMTvV8U54j6Q=;
        b=mLl6NsNpQKjc6CzbsBUu9mvSwngv2heOvB2s2mWUm4v5gmHoJXH24+XuehK2QTz1vE
         N0ZLmZcJyKO3f+JANz7oyPCMtXVAw3IipqhDDqhCYMGCevjLiqkNP8fgW4N/5P+ysvlF
         PABvnSAoq/k3HdFSeJqKMXm/H56I9oOdN3+pBrgZUhoIfSuhyuEcBa11QbNvUwIKNkrG
         g//4JSK47ptyJMXIzzLQmaGUVvumfup0oiC/2nxIzzDdIO/A/REIrCFnO/TM1M7OOyH8
         HwCYsK2jPkeEVbuu17oWXAQOgdkr43qEsfQ911EBv+Q3YF7gr55G2fAYlaC6eG2M5NsT
         nkeA==
X-Gm-Message-State: AA+aEWYae9jnBhUhiKAcoI7rA9FzPMk1aWfCvst++vjo5E+tNvbxsnMq
        CM20Y4NBEdZgmPIZZyuZu+1F4DJaIRoj6OP7l556vkgXelVkfler4totjiznQJlmJKPypdtfXdM
        gbbjAcVUG2UETzsMa/j0yEf+3YnfX
X-Received: by 2002:a24:9144:: with SMTP id i65mr12074541ite.115.1545766599440;
        Tue, 25 Dec 2018 11:36:39 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5D7gX5x7vwphZBHX40Ogmk+0/4kdN0iezQsISaM9OQebKiqXl+UDZnTJ4L9xSX3Up6mUZ95w==
X-Received: by 2002:a24:9144:: with SMTP id i65mr12074533ite.115.1545766599192;
        Tue, 25 Dec 2018 11:36:39 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id u126sm12026361ita.1.2018.12.25.11.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 11:36:38 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wmi: avoid a double-fetch issue in wmi_ioctl
Date:   Tue, 25 Dec 2018 13:36:11 -0600
Message-Id: <20181225193611.69216-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

buf->length is first copied in from user space and security-checked. The
second copy issued by copy_from_user copies it again. The data in user
space may have been modified by malicious users. filter_callback()
further uses the potentially modified data. The fix avoids the
double-fetch that overwrites buf->length.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/platform/x86/wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index bea35be68706..93cab9a70ad7 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -850,7 +850,8 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			buf->length, wblock->req_buf_size);
 
 	/* copy the structure from userspace */
-	if (copy_from_user(buf, input, wblock->req_buf_size)) {
+	if (copy_from_user(buf->data, input->data,
+				wblock->req_buf_size - sizeof(buf->length))) {
 		dev_dbg(&wblock->dev.dev, "Copy %llu from user failed\n",
 			wblock->req_buf_size);
 		ret = -EFAULT;
-- 
2.17.2 (Apple Git-113)

