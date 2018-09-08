Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F55C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390672086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390672086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIHTSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:18:21 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:18:21 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7sYM-1ftgSv3jta-004xrU; Sat, 08 Sep 2018 16:32:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] compat_ioctl: remove last RAID handling code
Date:   Sat,  8 Sep 2018 16:28:16 +0200
Message-Id: <20180908142837.2819693-10-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:iW7l/Gd5IQMh7nfRB2avxtImh6Fc3QsDzwqSE8CsNKg/ePQA3El
 vsnxK19XNvCGdRJlgqHCw8qR9tu67nekmJA0NhwUMaPudeCDp/RhL4t444f/KATXyLKZKmJ
 lNaFpBlrr/5zrrWu1k4rGlnBlAnbgTKOByJf/KWYljWidLjXd2s2PjpjIzWVBLoSPJ5sWYi
 y355Ts4qNTOIT/KOilbXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sC2n6bb9Lts=:wAD5c2VTEVHuJ8K8fvJJOD
 Pkm7DV4E8MXD0tSBVhZ8po58wHKmosjQ1VkeA5ADPgFozyMrAC5PRcvD9VRT7HO74hNx65sNB
 qdAJ2wsxQxqAXmoopcaCL2bbFH1jHV4ijCRLUyTRAwyxFwGoyyU15rbmrUabshOCsHAs13tDi
 0F/Hzx1ONIwVZsIxD+yE9CNjli04nO7NuMvH2ldACLDK3apyK2J/lnc9wq4IsR8j+/uhlQEex
 GmfVNKv131g77qwtRlmM86hWyw7+OdyOdmGt/yFcHOEpPNq7LvjzPXy/7wkcr/uiMHxj21XwM
 vMk2Legm3MF568cyxATbupeVYqlKlZKO98uqm2y3Y4UJvP1aU+DxtRHqRaPDVJtnmeXw3J6wL
 +Hy1XBK7VEMgKgS1meODmWD0Af6LAlAvrMrf8o3dOinCgjMlViZxjlhqQfm2ej2HRRsmoWd32
 VOcPlGU5VcWgsvOTXqwsscoasoNW9E9W0kUEtyRsXzePgzRVpagba7t6phEOE4LT3K4Tux6IK
 PB3RGoYEcNocW7MZjzCmW26WN2UnYyAexaxB8MxlsfCe50OP8QbvwJPIFZdcWPCy5uV2axgf5
 +4a4m83kZCTRVqXnGoEfm1+VkVPtJC8XPC4olV3jrpj4/VnxJ22Tju6c/kdqBwbA215MQgJjF
 G48qnGO87Et7AGnykF1IdyJaxsTR8jTTtxJxdB++IYnEPjCrrzd7xJdWnLxM/CyY9G/8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aa98aa31987a ("md: move compat_ioctl handling into md.c")
already removed the COMPATIBLE_IOCTL() table entries and added
a complete implementation, but a few lines got left behind and
should also be removed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e755802cd887..bb73d52f02a2 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -676,11 +676,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	case TCSBRKP:
 	case TIOCMIWAIT:
 	case TIOCSCTTY:
-	/* RAID */
-	case HOT_REMOVE_DISK:
-	case HOT_ADD_DISK:
-	case SET_DISK_FAULTY:
-	case SET_BITMAP_FILE:
 		return vfs_ioctl(file, cmd, arg);
 	}
 
-- 
2.18.0

