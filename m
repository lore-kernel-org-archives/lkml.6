Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D035C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A01218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8APn6Tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfAaKSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:18:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33152 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAaKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:18:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so1287008plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=m8APn6TuABvcY4k0Fboey8/TJik1LrGr+CdGmgEkP/hNnaOInHgv7WGSxQVCqn29g0
         meGTGv9P4tPQEY6kNVAho/0k9VK5PG+4xIb+oMUXjtmpNRZdRRdA1sb15JJhMgbsA1V6
         OR604A1CJV9nR24JnpYoEqoqBPHHlGkL+qZ9VOvn+Avv6MCUMzYN1f4ueOuNWhmkvYVV
         ORxFaxvhkptSIRP4n2Zh7/c1n4m+0rVqLw066bV/IOpxc/Jbt6P9piCaz6++dSVF80MK
         No2PQxK0bdh3eT6ey0bQG+Ja+wumayziss5uDNowOsmQo3bJzGv2NKDhB7YpHFG40Qxm
         3Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=buz5AZ9RwD9ngdFL3wCfIq+L8aoih3GZhnKwL1o7MhvxAXaqfKq4q/jSz9IqkmPXXZ
         AhywL/meWckishGBcITXIEojtGev6eiIMeBoofeb4VTKZYg0v+kPjt2oy8kFYbLg9DCm
         x82aaV6taeoJ0z5O0e2MWCBCCdZIKikLz1yhYEiaZbIb/y9GfCYQlKtNET7KUoUsOdMj
         Qp3PIC7jrtaMwIi/1Po1+TgoSHN9Xc59zOtSTpduVGUBPJE3h6jTOPZp9G3YVEAmEK3g
         gs8CTWxN1j/xSH2+nkvLOgA8ENx05z37DXOsTXaldxLS2xNrnfuaVXOAwZ7nIDZXfFFA
         nYHw==
X-Gm-Message-State: AJcUukdT3PdZtXMnzVJRe18NQMmPP2twNPacF+XoPS/ZG6mTRqgXYmNp
        tf7AHNu1twGAc08FZgCGX4Q=
X-Google-Smtp-Source: ALg8bN71PEhaAmwnr1jMtGHxvGz8Uq1oFJr4roq1cKQZ9z6O+ytmNZveUukhoXa/47lf2x5OWFC8SA==
X-Received: by 2002:a17:902:a6:: with SMTP id a35mr34195569pla.201.1548929888740;
        Thu, 31 Jan 2019 02:18:08 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id p67sm5944830pfg.44.2019.01.31.02.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 02:18:08 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com, joro@8bytes.org
Subject: [PATCH 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope
Date:   Thu, 31 Jan 2019 18:17:33 +0800
Message-Id: <1548929853-25877-4-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add Hyper-V IOMMU driver file into Hyper-V CORE and
DRIVERS scope.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f64f8d..5fb6306 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7015,6 +7015,7 @@ F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
+F:	drivers/iommu/hyperv_iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
-- 
2.7.4

