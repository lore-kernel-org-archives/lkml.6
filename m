Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE5EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5FF21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdDY3gew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBHHeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:34:08 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40802 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBHHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:34:08 -0500
Received: by mail-wr1-f43.google.com with SMTP id q1so2443785wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 23:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=inJqTiEgrDhETE3bawzlt9w7vAaWsM+B/ix4JgWmlzQ=;
        b=rdDY3gewVCY3boh17ik2SLDntkFFb4mCeaCS2w/ekFadHSdT0U0dBHDdyHMS/+6WMv
         2/BJu9ajF7cMPRJiDPmjWq7tBwhIOdVB0QeVsGZzVnivdmZndB2RFHJRjMkpuWkvuPpJ
         wlI4JshP1Ae3Pmtnf8eSTDcZ2myjkESMfYCg6GU8a+xoIn9bM9zC02tpMGr85pEgh1j7
         VqBAQsvWqnxc69+ScarufyBVuZOdNaZz654nOE8W+NzhZJ0p2UhxZe0gbb79lesTl1yF
         thQcYZqxnvSsAVhoWvxUdi8qSVvo3SR6qBqSB7+9loA6I+kwfDkTe8szcsWySvAgP2ht
         PPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=inJqTiEgrDhETE3bawzlt9w7vAaWsM+B/ix4JgWmlzQ=;
        b=C3SdtBC6jlpZMDSdKa0Qxp299kpeUhyM/vWlk0yArsXivjpjvtct6iH1I048Bgt/8c
         GkKyZPMuGS+J1Y/e4Cp1pUMX4O1/QYWqaR7VRwBlVa3koPdqAfuemkuopq/g5AWu3J/P
         2pXemBJANX/f20VeoJeCpVmkRMOsABwKGnEL7pNw8X5CPKxLvbMLehei9X4Q9pWLzCqy
         P9SFSxIx3MmI0Y7oASqqUuiyD7Q5ycP0M8ikB0IkcAHeA1/Ou+7FycWpKrZhv01P6Uzu
         eQ8FZWnvFPVdHI3drk4X4P8EPHsdCuMS+aH6wRJlT9J0mmGeqrqqCwOvR0JU/Q0tNDjL
         XKTg==
X-Gm-Message-State: AHQUAuY8VT7rRujVye2RPePcKCNLbwSZmSyW6A/WsloDTgMwuv2v/UXD
        PPio3TRZm3ztCqGtvVAKFGgivJk=
X-Google-Smtp-Source: AHgI3IacUK1/HahP7D5gaAUBhhOmmxSB026i8vXdaAly6FdddQTtylJkJ9YedQcgVL5YpwvX2FUqug==
X-Received: by 2002:a5d:5750:: with SMTP id q16mr15138329wrw.12.1549611246253;
        Thu, 07 Feb 2019 23:34:06 -0800 (PST)
Received: from avx2 ([46.53.243.121])
        by smtp.gmail.com with ESMTPSA id d17sm679588wrw.68.2019.02.07.23.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 23:34:05 -0800 (PST)
Date:   Fri, 8 Feb 2019 10:34:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/string.c: make strncmp() smaller
Message-ID: <20190208073403.GA19734@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Space savings on x86_64:

	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-29 (-29)
	Function                                     old     new   delta
	strncmp                                       67      38     -29

Space savings on arm:

	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-60 (-60)
	Function                                     old     new   delta
	strncmp                                      116      56     -60

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/string.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/lib/string.c
+++ b/lib/string.c
@@ -344,16 +344,14 @@ EXPORT_SYMBOL(strcmp);
  */
 int strncmp(const char *cs, const char *ct, size_t count)
 {
-	unsigned char c1, c2;
+	while (count--) {
+		unsigned int c1 = *(unsigned char *)cs++;
+		unsigned int c2 = *(unsigned char *)ct++;
 
-	while (count) {
-		c1 = *cs++;
-		c2 = *ct++;
 		if (c1 != c2)
-			return c1 < c2 ? -1 : 1;
+			return c1 - c2;
 		if (!c1)
 			break;
-		count--;
 	}
 	return 0;
 }
