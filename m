Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31E2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvip2yWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D31E2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbeKVAqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:46:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40222 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeKVAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:46:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so5717902pls.7;
        Wed, 21 Nov 2018 06:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ahGcy3Aj/ZRD57cpOpenWEgLyfrinUPuHsiGgEeEa8k=;
        b=Cvip2yWl5E5PelmLiEyAWdgboPr27tjueVg3RWEok8XlYOxNxJ3S7EiAZ2cNXg86pS
         EKBUD3p6sDWEOfbQQYfhrc1LoMOoHQ80OR1v6zMbOiIPK/a+VQkHjMToDBBcYxKUnDWR
         jkfMZcEPz871TM3Foy0V94wm58Ckuzg8bNzbJkwq4YvCjmsViV705eoUqXErldmoIlQL
         xstseTVW7kD0nJH1Q0jqx6pt8MW6+zBy/shqLLG5GxsKVJqmiF9SwGye312QACIP1JIe
         lxBMsCYkHV6arMcdsESZf50gKw/KWm/MmZzBzb/FiAXDK81b0Cg0MMUnW1jKoomMkMDC
         Go2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ahGcy3Aj/ZRD57cpOpenWEgLyfrinUPuHsiGgEeEa8k=;
        b=rQ3duZz1feZ/22rpzn+WLrxmvLBWU7WpN15/3I8SFVIRw3UhtJofR2R4xcgjLf4Rul
         9YPFszoFA07llxi7QSuMBLYHAAI1aTle8hVIL6y+21il0ldJn4HgirTEVFt+XMfW0aqm
         d1Vz685o948WNM2M92wreOh4JDQw4UPyQa6ZlLppDrRYRnhushHfXx6wuzzMbW+5MXop
         2LX9fDaPnji7mZqBdjr+ZGZLS6UXdVdpBSjgqSgKIGWSSXRYrvJPACkMWQVMFh/ZTto4
         3y7zLwp9VnOi4k1zWMa/IUvynIsDcqaEwvgTdujpKo+3ujFi6aiirud8Orf9vpxzxSYS
         XeIA==
X-Gm-Message-State: AGRZ1gLQckWckpT30inlGl1EcH3opKqKYe84/v18B3S7/ZOrdd2TULdr
        IitanQAgJZ7TuGLS67FtEFA=
X-Google-Smtp-Source: AFSGD/UCCQ3vrrDn8i443NkYRBQUtBhz9Y3m/baFY81Mt6ulyBrChm2F5U3shvqk90RfAdQ6I5AlXA==
X-Received: by 2002:a63:fd53:: with SMTP id m19mr6212703pgj.340.1542809528901;
        Wed, 21 Nov 2018 06:12:08 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t3sm25753543pgv.31.2018.11.21.06.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:12:08 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc/tegra: refactor soc_is_tegra()
Date:   Wed, 21 Nov 2018 09:12:04 -0500
Message-Id: <20181121141204.22819-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned by
it and that reference needs to be dropped by its caller.soc_is_tegra()
doesn't do that, so fix it.Call of_machine_is_compatible() to refactor
soc_is_tegra() whcih automatically manages the reference count.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/tegra/common.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd8f41351add..0b40700b672a 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_match[] = {
 
 bool soc_is_tegra(void)
 {
-	struct device_node *root;
+	struct of_device_id *match = tegra_machine_match;
 
-	root = of_find_node_by_path("/");
-	if (!root)
-		return false;
+	while(match->compatible){
+		if(of_machine_is_compatible(match->compatible))
+			return true;
+		match++;
+	}
 
-	return of_match_node(tegra_machine_match, root) != NULL;
+	return false;
 }
-- 
2.17.0

