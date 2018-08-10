Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F8C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB8920845
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB8920845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeHKBjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:39:09 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:50926
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbeHKBjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:39:09 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id oGU1fUuz6dH2EoGU1fgvKD; Fri, 10 Aug 2018 16:06:13 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1foGU0-0000Z8-Tt; Fri, 10 Aug 2018 16:06:13 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/5] uio_hv_generic: drop #ifdef DEBUG
Date:   Fri, 10 Aug 2018 23:06:10 +0000
Message-Id: <20180810230611.2114-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810230611.2114-1-kys@linuxonhyperv.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
 <20180810230611.2114-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfJJ2JLnfSw2Wl9cjZiC4TJghbe1VvU1I0i+lWcJgJJ8Lb6KCF2VFrYZ0sl+cUxzE2pox8xDrjcFKVje4fdN8Q70ds7xz+z/jDB575vNiSAtSLhzgdjYk
 7TqmdZYtlwT/wQv7/7fBKKmKtbuDq76U+2ihhwkTEDKzZD1GHGyTIMW/NYhqNxrMTLUo2BXpEO0dWu0zI3D918NcSTr+rho+gBGZDD8kV5yxJOagdifU8Uou
 aA197/kIe2X9vpzXFn77V7RMtp+DAjUS9f0qsfPOb+ku8+jnQ/JdiiJ3VrJ6qEOIqTQfe21uCF1VmHm1q2rKkIoZkXkSxCz5pmq8Q+MN42xIBWswNGqFy8sI
 NIY4sQVkQKd+fDYeq0C0OHgv1wKX/3pD2+8hrg/0D3kzkcR0m764Q64TXnY2w0oDb5FthEM0LW/DdSnIIs6QbXn1a+XWBWeV0lrluVa0epjy2Nj7HMiA+hAE
 QU9KfTvVvZKSKRQppErNBtEFvTF02bBiVszJFjVKlEw8enJzp/pF6WHYfYT0NsaPy70rdtC7ZfdaFYVs/ROopXMbm/lp7EMJNsAq7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

DEBUG is leftover from the development phase, remove it.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 35678d08d9d8..ab0c0e7e8a44 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -19,7 +19,6 @@
  * # echo -n "ed963694-e847-4b2a-85af-bc9cfc11d6f3" \
  *    > /sys/bus/vmbus/drivers/uio_hv_generic/bind
  */
-#define DEBUG 1
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/device.h>
-- 
2.18.0

