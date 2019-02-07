Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02735C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44ED21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut7SJDrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBGPeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:34:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45068 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfBGPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:34:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id j3so70422pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=Ut7SJDrMi/leeSOl/+NZOCMvJsnB6wCh7ACgQEGX4C5gJk8KVJE4NnXMW+q2U62bSm
         aBTa85Vxagzl9U2vxEccea5tJzC8ncGd2Grng/1PbQSl+cgzzR/pd6udSggTZQnyJrPo
         hptDzeM3qE0t4hMl/eZFWYwWLtf2m5zu4GmugkxgLDqVvf3mw1MjeuLI/u8rExsQEUTv
         wHnJICY6wOZ14h8veg1/0QNpfnnU+ANa72o8afr6KAFGtMpYQrGcydThdVAsuxGWa/Qa
         r/Fh7ERbw70pxpWBr7x8cpF42x71vJLZSyPmvdzKPjEfQPKVuPUSa8tPNIEVnVGzE0Xl
         JIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=jWPAJCBO8RLRT6vZMGBM3XB2ibmviKNNjHYqpnhlwWxi6tn2WEtchXHKuH5J4XQxds
         PFZ2xiUh5L5ojf9CvelKYZAof4ZtcIJYNszcFmAp1lhSczuP0Y77873Hawztq5xAiH+9
         6LBymsofReHyN77OsxSYVeiosSjXm1+TWW4qtKmsx0F0N9jRfsuIqXYRjBQ7xfGjyYMz
         yMO7RKukpEwouuRhkFYan9Tygzkco0X48WBSODgW7qJEfO6a1kGK9xQ6fiPRpC9Cnipm
         lCUCeCVpIuPx0cTBErK/tLOsKuMKw6RTyfQ+otsho+W8HuR09ytIDCprw4S1Zl9XugBl
         2Tww==
X-Gm-Message-State: AHQUAuZG7CpnHC1CvRCR4M0AcdHMFCAXBhIoMBLWmcC2b6yU2Dd38eab
        rcTOGtG2KKLrSKLvKComiQE=
X-Google-Smtp-Source: AHgI3IZDNX6Z5Oxg532YzbYjudTQ51L7iQgJQGq2CYVoEILCVVsWPWVbPyjdNh+Kyge6U162UuMCFA==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr358861pgj.17.1549553662714;
        Thu, 07 Feb 2019 07:34:22 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id j6sm16493945pfg.126.2019.02.07.07.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 07:34:21 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com,
        joro@8bytes.org, sashal@kernel.org, dan.carpenter@oracle.com
Subject: [PATCH V3 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope
Date:   Thu,  7 Feb 2019 23:33:49 +0800
Message-Id: <1549553629-8414-4-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
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

