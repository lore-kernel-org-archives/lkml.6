Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFD6C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6047B20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6047B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeJCEHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:07:38 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJCEHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:07:38 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDgxt-1fytoU3hEl-00AnCq; Tue, 02 Oct 2018 23:22:10 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDgxt-1fytoU3hEl-00AnCq; Tue, 02 Oct 2018 23:22:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: tegra-bpmp: mark PM function as __maybe_unused
Date:   Tue,  2 Oct 2018 23:21:27 +0200
Message-Id: <20181002212208.2971433-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:vGiWoKMBj91kRHrtpaRlH1jrKTm4N+Na1zsHY7i1d6tLi4KF4sT
 tqRCOpimY4WQBWpxiQnNV5+VNcrXYKu6nPxMBIZc2Z0SNAc1dMmHFI1rvqqVX/g4q+HtEuK
 EfcpKmg0eTUEPFdlhFiFFT9yiwoR4ee+6Ds0jeGS+zz5dpS1ailmMZ0EZBXa0jsTQhJjYPg
 +Tdo1XkyNhubrQvxAgcqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k9uYCVUEpRs=:aXrnZUS75TCqmUf1aTKN56
 2CvHvzbAAZvSJ4eUKwQXq7Dydaxp1l54khADL3TH+pF7S8Ueyan69nweBaJ5LhU0yGzzMgCdi
 xJKtak86uC3z89q6VLmzFkq/36o6LwBnXpqXz9QU+wQb+YF9SYsdrIrGiRJjb8rPjDXcW7s5x
 T1U1lXyCjnnmC21GeRvWrmd+0h4B9wMdVH7EwuzYnIieZKduL3MUS4Ne0lseEPqYw1xKA8JkW
 iIMqpSQVb/n62UwjM8YOFwoRTD0z3uX/QtpbnPaw9iTqefGD7NsbRnlrf7pJts2il0hKrGazz
 VDp8XVnUegIBY9uSVYpswhD4AwTqA9yQqMOf9/3FOhDvWvhvdmrCMWmEJoUqX6w6suNJVNXjf
 ekGayaBAzjonXJwo/VlPFH7fG8TszUXsXHQQKV5VNFI9G96cfVcSCFTSWfhIEJqoF/O8yukAf
 t+grurHT/mSYvMXc7HJdrRwoLL25wNJQmEbTlgk9dCJnU8cVLuWBujFTAucPxohFF29600zY8
 RznBsdN7gwXYLF72jgacN9yCrBh9lnbIt1605UY06mp6RnjX4TOrRNXSMCK173Oa+A6/Yu7u4
 w6ZRfQClQvIV4DAfb2dmjqpL5WmFfms6rvc30L15WHCLyz+lxvnzAlZ2/sprvW0SnNQA1dYXN
 liTZIrd5xBwOPnpt9x9EOlAHVk3Q/dMr87xEkF9zZvSZ6yrRU0feiSDls2TdpQANf/Xs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added tegra_bpmp_resume function is unused when CONFIG_PM
is disabled:

drivers/firmware/tegra/bpmp.c:847:12: error: 'tegra_bpmp_resume' defined but not used [-Werror=unused-function]
 static int tegra_bpmp_resume(struct device *dev)

Mark it as __maybe_unused to avoid the warning and let the compiler
drop it silently.

Fixes: cd40f6ff124c ("firmware: tegra: bpmp: Implement suspend/resume support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/tegra/bpmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 41448ba78be9..a3d5b518c10e 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -844,7 +844,7 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra_bpmp_resume(struct device *dev)
+static int __maybe_unused tegra_bpmp_resume(struct device *dev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
 	unsigned int i;
-- 
2.18.0

