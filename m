Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5895C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1342173B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVsH1/le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfBBNPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:15:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40671 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfBBNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:15:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so4674730plq.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=FVsH1/le6YUB/0anUsLxSqzZTrbBHRTiFXyvY61zwrAKYtF0b7CmyLGyIsyy3jT4e+
         9ZMPJQBWfmQovuVXuokSWcQJ/go00aMqQJN8PMS0hfmVlmd/ZXlM12AC4B/5A5o5QIn8
         kLUy/jJAUbMks4rgphOsh7aNVywbQiJRrad6XVGS2KDKqWbkaniXf5QCiCxS3Teh6wCZ
         +grHdhW/mRIATzKk6LEsibpNDzVck3iq5BLlTZkkL8jJCUtYROvxjbpDqmxDpUhTEy6O
         OkTigVtH5ws3mhdLJ73gSLZ7Yj1JKevW9cHucF8Ccwyb0Z5cc5gRHDNTANVK34N/Zlam
         nrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHVmlgopHIx0N72f92t2Wp+YYgILXvePaeg84jVpJQw=;
        b=ECCrB0MNc4L5MIkphyCnalKYyBsgwS405bPr9z2/XM+Gt3Jf5ah5VO81sCfe0kgKM8
         gjEgCoMDJZnI5LjIrRxthajuW3Ew6WPAFmnColkE1NT1Dha+jnTC5CAHPmCWPpP68gKz
         D1j8hQS5YhM9YMRmk8RMwLOI8pXUvNgAV12BzVqxOQlf8v2U0mpxJRaJoIDLC3rfL5F7
         TRLIqAevzER6ipJn8Ofgn//+I9rlKrZ0li1g+jlteu/TdVyg2gXYqi0znh1ky8o1+Uda
         ggPDJJJeJLjBrF3PLcetGASf1aWmZfRG03zbIcOzlq4JwzLW40uzDsmt5+DmbaGmGkvg
         +d6g==
X-Gm-Message-State: AJcUukc3SWUSUITlCwYxN5QrTbTSCh/Ao/1on+m/0mFzy5KDU6gZdltH
        GRux7Gb2YmS1DvgGqNkZnFk=
X-Google-Smtp-Source: ALg8bN6hokcETZInYpCCGdtbrnb3YKvjrf3CcXFn3p9Rfs+g0BjRxrNOuERAZWfxBa9j/wKZvArrCw==
X-Received: by 2002:a17:902:4401:: with SMTP id k1mr44206711pld.307.1549113316977;
        Sat, 02 Feb 2019 05:15:16 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id g28sm15148045pfd.100.2019.02.02.05.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 05:15:16 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com, joro@8bytes.org,
        sashal@kernel.org, dan.carpenter@oracle.com
Subject: [PATCH V2 3/3] MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope
Date:   Sat,  2 Feb 2019 21:14:47 +0800
Message-Id: <1549113287-5606-4-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
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

