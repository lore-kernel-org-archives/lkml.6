Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C188BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8864020675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA6nU3pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfBWTba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 14:31:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46264 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfBWTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 14:31:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so2591313pls.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ssFjCsLxVlihmULnX9SRRGwKDgdg88epL5TDtFu8OTc=;
        b=DA6nU3pROfIsM/4Zdt3FIX/LjJwZqvRBavLhOUhvQg7INp8597zUS96LDazCkEDIHA
         FTen7EjTeTRMVog/0YzR38cx3LqrFy+pRh2d2StPMjba/M9MAEu3v8YRxJP3DWhdrsBr
         S3ZqcxujOOuWnC7irqAgLuGBBQIWRa52MD9iru+cPSQJRxjqh5QMNQceiYe9DAIdmz5H
         XCMTyhkxVdTRJCEk58UQzzey+TLb6WqoZVxM6BUlaRQ2bxj94rX5/rBkCm4/JaxhKHNi
         5GZ026a50lKowz0tDPAFq0nBYPusJHsgqEg/wiv4s4ISolCv/UI1EwIjy/4Lj08AyMZq
         zvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ssFjCsLxVlihmULnX9SRRGwKDgdg88epL5TDtFu8OTc=;
        b=W6VpuIJbGVO285WeMpSMbhF1mSg6gAOckbzZVSoESe2nvb71p7z3s08lr00qj/Vb8i
         1DOtiuuxSnFmC1A5dDUeGZIeOsJ8vS3wizp3jU3ViraXWQ6dUisOaglt3DBUcTn6307a
         rQyGqqFCGlivfZIN2826h19GDdGEQ8R22Cf2NRS0yqmW68i22SlT1zVZLDMLeVhUp69U
         j/GOGqyGvjqBr+qi4+9787wtWTowJU1eA+bIJmbUlNS0xIXa8tj4VuQBw3YSPpRwbiaC
         GoTfektDjQWNJ5NVnecXI3Y9DBlK97DIL1E4Rvy6jM7VLiemQdTXRiTPv8+e8jgFI1lX
         xljg==
X-Gm-Message-State: AHQUAuaA9upp7kXT/Wxs5zEEn0YFX5TMkF0SONjD50peEr3JDmginqoX
        5TaZSDB7h5atOBRjcZiDTX8=
X-Google-Smtp-Source: AHgI3IZ6cyJLF6jgmhrctAPrS4ca1Yeg1c56PGr99XXeHD2deMSJnK5XJWScVXlA7sa5lJKNaUjiHA==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr1179103plb.164.1550950289825;
        Sat, 23 Feb 2019 11:31:29 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id j197sm6843036pgc.76.2019.02.23.11.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 11:31:29 -0800 (PST)
Date:   Sun, 24 Feb 2019 01:01:21 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     w.d.hubbs@gmail.com
Cc:     chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: speakup: Replace simple_strtoul with kstrtoul
Message-ID: <20190223193121.GA4402@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_strtoul is obsolete. Change it to kstrtoul. Kernel is building
and booting successfully.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/speakup/kobjects.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
index 2e36d87..ad5a2b2 100644
--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -787,7 +787,9 @@ static ssize_t message_store_helper(const char *buf, size_t count,
 			continue;
 		}
 
-		index = simple_strtoul(cp, &temp, 10);
+		retval = kstrtoul(cp, 0, &index);
+		if (retval)
+			return retval;
 
 		while ((temp < linefeed) && (*temp == ' ' || *temp == '\t'))
 			temp++;
-- 
2.7.4

