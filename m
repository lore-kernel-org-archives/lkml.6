Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0452C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E3520C10
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOuSBdxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E3520C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeHQQ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:27:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40152 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeHQQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:27:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so3521914pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p+Qk4lvw9mq7dvmc8zt4QzUeXCLEf2fCnrwXKoOwotA=;
        b=QOuSBdxsCP9P140HW4M8/7JDVxfsibPfKYd3uIkXFUfjE7/cvGWr3tvQM6q0Wg15Ua
         NNPSWe/+pqGlLP/eJrkk5TPVKWrseIHHPh2G9jxsLUv33/ZSLVYNEQ/wANRKRrN/2x9D
         wlbRoGfLkFShpZajjIoVDbGjDQ2O+En3MVZ0tKnw1LfLdwSvm2c6Y0VLUa+lU3GreEoc
         GpfKNhdVWzFNvhIhB/T02gVjIPL/qNpw1IybrzmGqUCqLAJjQ7X1S1v03ruOluCK480w
         0ekv4oBRgTx5WnMfoW2y7qcjpRXCd3fIGA3E0D3dlmdRAoWA4NTAQdV0VFDDR5l5FdoZ
         1aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p+Qk4lvw9mq7dvmc8zt4QzUeXCLEf2fCnrwXKoOwotA=;
        b=dlUb0mIIKZ56esUwchvl4osqpCUbBHuGzscO7r6joICdY9NZVN2tU/xus8/BB7hcrR
         DO62+eexzuK5KP0t/EEq7YFoznLEXVv4ZcSHnqkFqoUwXmf3NPjyWWO264sCV3W/IbCi
         /vY/zQc16wONvYxmMff+K3spN9Xjuyx7wgHIbISX9YkULSfkDCWwgplUgnGBZNIueTx4
         WMJVqGudiUmZ83IjjiI51wj8sKfa9ZZS+wAq+DChD8V1dB+zzhi9BsaPqW3hs2bqGvId
         n0rax7KYNMPEU1bYaExk4Tz4oCHSFqPzHd+sMO+XtDxaDO0UnK7aBGb5zRGmbj7OZcNO
         yWug==
X-Gm-Message-State: AOUpUlErJVeQxlSqwsg1c3pm3/nlwlnUpLZ6aP9njeyTU3sTGVmsMZ0F
        TA5zp7jCuC0KmAwGEav2fqs=
X-Google-Smtp-Source: AA+uWPyv4b12PAkk/3fFDRt2J1isBx/WQ8cyIzr7Zy/Yh5dK8SRZgpcTPrGq/+RazO1oAnMuT1Bt7w==
X-Received: by 2002:a63:e457:: with SMTP id i23-v6mr33146152pgk.127.1534512252671;
        Fri, 17 Aug 2018 06:24:12 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id s195-v6sm7789302pgs.76.2018.08.17.06.24.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 06:24:11 -0700 (PDT)
Date:   Fri, 17 Aug 2018 18:53:48 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     mark.rutland@arm.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bhaskar.kernel@gmail.com
Subject: [PATCH] kernel: Add spaces around '=' operator
Message-ID: <20180817132348.GA5326@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl ERROR:

ERROR: spaces required around that '==' (ctx:VxV)

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---
 kernel/acct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index addf7732fb56..6dc0a55b575c 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -449,7 +449,7 @@ static void fill_ac(acct_t *ac)
 #endif
 	do_div(elapsed, AHZ);
 	ac->ac_btime = get_seconds() - elapsed;
-#if ACCT_VERSION==2
+#if ACCT_VERSION == 2
 	ac->ac_ahz = AHZ;
 #endif
 
-- 
2.16.4

