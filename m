Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5585C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5638720843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5638720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeIDAFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:05:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:60379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeIDAFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:05:44 -0400
Received: from lamerx.fritz.box ([93.235.184.138]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSyv-1fYLZO1FhR-00p3Li; Mon, 03
 Sep 2018 21:43:59 +0200
From:   Peter Huewe <peterhuewe@gmx.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH] tpm: Make SECURITYFS a weak dependency
Date:   Mon,  3 Sep 2018 21:51:51 +0200
Message-Id: <20180903195151.7576-1-peterhuewe@gmx.de>
X-Mailer: git-send-email 2.16.4
X-Provags-ID: V03:K1:q/KYIDzJb0NikFBs9kH4esQhkb8UyF51KLa7ti+1Qu0R/aqpxSC
 pyWb3gh8I398NwLq+GWyTnbUFxq9BDQdKurv7Uj69As2WhBqvx6ZNQei1j6DMJErTFiro7t
 Asw8oiNzAVrFmSfZD0STnwcrt0wjzXkrst0tU1I8o99Yjq2HGSNI8wUnfN3g2TBPPUw8Sf4
 PprAZz6xcP1aRG1RSIiyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UA24tmR7RTk=:NBDVlWchiRyzTr6I1Kphke
 9hEuDqEHVMi93l5aHl71ID7kDA+dCRVApnwQNaHzb4TZvW5yonPOK19nUmF8kvoftkdHpnclh
 qg45WEklddH+rtUWKdM058sWMjhM4scjTcsv07QxYJDmku5vc4PsNUWrvlHtyN+VkG+KE7juU
 ZC9Npt3gDGwbQJceQDwxhKcJ1PsQnLFahi5PyfNvvBCOh4V/IBStGxGgKyzu2GVuMABxtS6uN
 CxdR3cepoOikrzVadL9WcrCde+8Sm0TISZKxyYpPh2HrU1kvOVbo+3yAsGGMCVJDqy4XcQwo8
 kTKrtDYIKGvhZvXcdsfGJjesXH0HKdMYnOxXcvZL9zZJfM+FC1r4KSqh2ES7geh256BPIgIAz
 HXJfwYkY19w2rBxei+RuM3cwtz+n0iRZbLhgQW4JUfUBE6hKmCC3YmwcwQzvFI/lgrYQbC60i
 GSU75R3+0hNdSnijN7483fBVEsj0Bb0tl3ybLsOfF6Ky0AGtVuBLCI2sHoAPmvPVllc800gx7
 MgTQa3ORWBKdOkgtRmvi3J9JAeFGAlO+q27gUsV7txFwFqlX/ruQymMNbviadlhQzk4b5Z7T6
 29peIwnBcxByyS4LArpyVaYB5M80EUnJnCY5ZS7/GINq2gEU69Tj3hVQ8WK09c2UFQzvPkA6L
 ZohDGh1Xn65iADxeoY2s+uBX1kbMFIFMDlbYwCNVmPhGzUmPQXOWKD14wd+bVDRuwqQJRKUTo
 u0XTXyM0lNnUlY2W1jQQ7PVJ/QhxKm76JN9ow1r2VC5eUBe7bIYpr6GyS1k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While having SECURITYFS enabled for the tpm subsystem is beneficial in
most cases, it is not strictly necessary to have it enabled at all.
Especially on platforms without any boot firmware integration of the TPM
(e.g. raspberry pi) it does not add any value for the tpm subsystem,
as there is no eventlog present.

By turning it from 'select' to 'imply' it still gets selected per
default, but enables users who want to save some kb of ram by turning
SECURITYFS off.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 18c81cbe4704..536e55d3919f 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -5,7 +5,7 @@
 menuconfig TCG_TPM
 	tristate "TPM Hardware Support"
 	depends on HAS_IOMEM
-	select SECURITYFS
+	imply SECURITYFS
 	select CRYPTO
 	select CRYPTO_HASH_INFO
 	---help---
-- 
2.16.4

