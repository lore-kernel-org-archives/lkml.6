Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C24C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2257720834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBypc8Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2257720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeH3Th4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:37:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34420 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeH3Thz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:37:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so4061858pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=59YJuTd/P3YlkbKgdzoXos1iq41zGzPiWfFh8Oq0dRU=;
        b=JBypc8TzxvutiL03VLybhPV/L6bqSZZlD1YvMDqb9Afg2MQIDELO9XxZb4vSSDMeg4
         JAEEC+QeUTOkBfGFTN8aMkDsCrnHLuCUEWuPfgD6UyET9C7Px4b+B3+txMD4n9zSL2G8
         AVe7Qa+ja1xhH5s2q5grXnkhO5smtUxfFpbrcQ6vQDh+HrXfrZqcRHEyqQdaRCZTaTlz
         619IqM0J9RinHJveabdfJwloCvV8ED5h62SkR1RlZ0MaRoe64HGn3JiP47vFDJr4C0J+
         j3OS1/c/Kt8ucpwOE7fnqofZ7c9l+aIeq8wsdZT7iLrMosJGCMaSs+AeGJfnCUA3oVdo
         t1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=59YJuTd/P3YlkbKgdzoXos1iq41zGzPiWfFh8Oq0dRU=;
        b=EXmeohz/wZJJ10jeVr7+M3y2edlzfd5OYcru9YFAOypoo15hoc3SxPmgBUijnAnhPO
         fn5qd2BgKmgc6Wa+dpSAMQHmW3WiNG05M8yI6v8gR6qqC5HlLb5SwfYFXHdajZNfKD2v
         I1rgZAjd2vmMfSUPxgjYQj/bjZYup/mP3q8xWTil092ycmX6+iUfTgwXJk1S4dFgeZbB
         4DY8qQE82AUR5UZBox3n/NPog/31HvttyMPg26nzhsP8nyb4FgksUh3x/3vl4bMaHHj9
         ZsXmnOnyyTfFixU/sba9gxbotkLgN48uNvrOvKOaOr6swxhr+0mQcDGdXFxfi12b4UDC
         AK0g==
X-Gm-Message-State: APzg51D/HpeizCoPIJ59Hy5bM8YooGRhNmBHb9sPesgTWxp4xmizWjVf
        mTCT6gyILbbHPpUlP1TIuIs=
X-Google-Smtp-Source: ANB0VdawHpdM4DWIxbxOzhTXeFXkCe9FfV/jOAILh1e238fm0ycK49thdBEIJZyRSZqhFfAnvMzESQ==
X-Received: by 2002:a63:4826:: with SMTP id v38-v6mr10308880pga.379.1535643312759;
        Thu, 30 Aug 2018 08:35:12 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.27])
        by smtp.gmail.com with ESMTPSA id 5-v6sm10715816pgc.86.2018.08.30.08.35.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 08:35:11 -0700 (PDT)
Date:   Thu, 30 Aug 2018 21:08:13 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] device-dax: Convert variable to vm_fault_t type
Message-ID: <20180830153813.GA26059@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of commit 226ab561075f ("device-dax: Convert to
vmf_insert_mixed and vm_fault_t") in 4.19-rc1,
'rc' was not converted to vm_fault_t. Now converted.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/dax/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6fd4608..bbe4d72 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -392,7 +392,8 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 {
 	struct file *filp = vmf->vma->vm_file;
 	unsigned long fault_size;
-	int rc, id;
+	vm_fault_t rc = VM_FAULT_SIGBUS;
+	int id;
 	pfn_t pfn;
 	struct dev_dax *dev_dax = filp->private_data;
 
-- 
1.9.1

