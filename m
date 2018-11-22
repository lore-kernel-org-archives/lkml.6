Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A6CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B2520831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+UMGM8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B2520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405085AbeKVSbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:31:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36709 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbeKVSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:31:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so8220765wrr.3;
        Wed, 21 Nov 2018 23:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMG+pNlEYtF07TcwzI+qeuxLo7IKGlHTCP2l1xVSpE4=;
        b=F+UMGM8P6UTHCdTI1Ctuxtsq8gkKqT2vx2fWbOnesvWYBBNgrY710qLcjdgxkTk2X+
         xAuo7r8/FJ6xYJTyBZSYdi/G161+bYzDzBhF2J4O7dwvzuoc0JKvL6MrTmUunw0ZfTJG
         j7To/Di2j2MxZ9QaLVlx/OrWGvcB6ITAaqO8d+GBNulHc9gDxNTrYo2LnzJ5d3cyTklv
         vbwU0z0w2ksKjC/SykbeweDLfmTsQLX4JCbiTlaXOALMFh2JfyKshqdgsgHOmamdlxPf
         pTooGtjoEWZbQiBDK+kscgFLRwDFPqKP/frr5ZcI8jpWSg63cfV4OEbXrgtJISDt0wx3
         HBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMG+pNlEYtF07TcwzI+qeuxLo7IKGlHTCP2l1xVSpE4=;
        b=mGNgF0aWajy9PtM+H7nWT9dt8lXaJB6u5+xSo/Mv6ZgnFWRB3MqoNkmfGCqhoL0KtW
         IRBB5qKgDQz+GRyXzo8hsZM7Y2muOog+yh2N/a3nj+DDjlAHPOxEpd/7+A+JekvaCXwL
         NLMKPA379P1NHjrupv6sXFO18hzDHynVWYDxK3azA4ve/Ayvu4tKmjsI2+Ejuk8z/tc2
         p3hvO0IHN5l0ptdJCBVKFMbVt6XsNEL35eMN2OJagaK+M3SGsg1CzI8JcOrA3CKVaMr/
         UZ7Clt7wEYst+vdlt9oAezRP2CB3HEWOI8BFPaZL/zu1inAhuzhtqYRb/mjMyCzXAg0C
         dBsw==
X-Gm-Message-State: AA+aEWa38OivvcydPyZEm64FWRJWfA3RFp58UTZFedmol6zubwRrJ4ug
        MI7q93gS+HkogkvfY3oSWI8=
X-Google-Smtp-Source: AFSGD/VmwvvBd0YWIDktkogXTrwX3WSxM+77X+moM3etwa8XnfQgRJXxmfkWGSt2netd5iQlYK2N1A==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr8842655wrs.272.1542873202416;
        Wed, 21 Nov 2018 23:53:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f2sm6734816wru.14.2018.11.21.23.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 23:53:21 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] soc/tegra: Fix terminating condition
Date:   Thu, 22 Nov 2018 00:52:44 -0700
Message-Id: <20181122075244.3909-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/soc/tegra/common.c:27:16: error: address of array
'match->compatible' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]
        while (match->compatible) {
        ~~~~~  ~~~~~~~^~~~~~~~~~
1 error generated.

Whoops, we have an infinite loop and QEMU no longer boots...

https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/160242918

Check that the first character of the string isn't null so that the loop
properly terminates.

Fixes: c57eff9503a5 ("soc/tegra: refactor soc_is_tegra()")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/soc/tegra/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 8a538b968fe9..54627ca957e8 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -24,7 +24,7 @@ bool soc_is_tegra(void)
 {
 	const struct of_device_id *match = tegra_machine_match;
 
-	while (match->compatible) {
+	while (match->compatible[0]) {
 		if (of_machine_is_compatible(match->compatible))
 			return true;
 
-- 
2.20.0.rc1

