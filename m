Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BABC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F23220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F23220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeILUUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:20:41 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48005 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILUUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:20:40 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2fDr-1fzGz42jl9-0047w9; Wed, 12 Sep 2018 17:15:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] compat_ioctl: remove joystick ioctl translation
Date:   Wed, 12 Sep 2018 17:13:06 +0200
Message-Id: <20180912151422.571531-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151422.571531-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151422.571531-1-arnd@arndb.de>
X-Provags-ID: V03:K1:GI1gPsQA8YxHO6rmF1znw/bXXzLunbRjNsU4o6L0FDsi6EKjEer
 d/kkYIc8D83ZfzDt3ExcLAjd0bCw+66E0+xqgbw2ZyQk4QZ1G9K8l4+qteLstvhC304T2oc
 oQ/hy/CEB6XqMyrORAFp3mf7N3vly/mBmh/QTOXJhk8zHUolrdCXr1x2GXT0Xv0okVa64hZ
 FXzSGtDi7G+qWvnBLIFww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hkOIWEyC2DU=:GM+jaOzMvQXfoY1PbV7AWc
 3h/68Jg7kbjvtQ4FcVFY9kK1w/bQSapln93EpQA3WXGoMrrpG9/SCMpIQdvPNOhamBOVmaDAX
 Vi1lI679ZgThTK6L1BJ8kChpLYezgVWh8LxYvtvbtAne2WHhPDIDi3OOjgENnzK0FwzYKoTXK
 Zeg2W7UrlxqPWS9I6FlNQ6U0Wgige82vhaSNWFvCd49aOssVm0OjE09VmbQX7jshw7xVm9KuH
 omR3Bmwm5qJuGnBIV/MOt+93tls5/FYlnxT2zFdf1bSt2X71E+YvD7/WrzGUUU/6859v1bzvE
 XVkcUTy999pBQaoKfYI7iygVNEFTGtqyOKWCTa280snVW/X4w96oKoGdl5KmId2SmRr17odha
 ciXBroCnTUDx6YbV1LLPmvTMc41eCoUWS58i0g4MCBRTpQlnWXqOD+2F7xtCTmkMiUEdAz6fQ
 jXg+iVHq1Wv6+TU8p4hKmhCQrYf0yq08i0iAh3a8Zd7FAQOM1bV/zHVTT0BvhEFkC9brq3skQ
 uiRaPirBVAdOADyeAAjsSQcDki0Wg0ThLmCXXMZ/2AsApnhkgXNTsgVR7rjfl3lverxdEN508
 ZIwYCCFh8UIxycmFWGRAtfO5HjXeQZQ44OLDKW5g0rGe+qy7mRi1tagV68y9sYcx7zt0PWuSi
 7mg9Ua9KyqTMAfOpYlpeCQcn2hK5RxyLPQN/1X5xOpmgSUAIsanS3aI430oSGjpDlKTM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The joystick driver already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index d5b8380fb1b1..0e3a879339c2 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -11,8 +11,6 @@
  * ioctls.
  */
 
-#include <linux/joystick.h>
-
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
@@ -870,12 +868,6 @@ COMPATIBLE_IOCTL(CEC_S_MODE)
 COMPATIBLE_IOCTL(CEC_TRANSMIT)
 COMPATIBLE_IOCTL(CEC_RECEIVE)
 COMPATIBLE_IOCTL(CEC_DQEVENT)
-/* joystick */
-COMPATIBLE_IOCTL(JSIOCGVERSION)
-COMPATIBLE_IOCTL(JSIOCGAXES)
-COMPATIBLE_IOCTL(JSIOCGBUTTONS)
-COMPATIBLE_IOCTL(JSIOCGNAME(0))
-
 #ifdef TIOCGLTC
 COMPATIBLE_IOCTL(TIOCGLTC)
 COMPATIBLE_IOCTL(TIOCSLTC)
-- 
2.18.0

