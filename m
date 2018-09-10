Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03758C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989F1206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cojb2TXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989F1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeIJHpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:45:53 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:42080 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeIJHpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:45:53 -0400
Received: by mail-qk1-f178.google.com with SMTP id g13-v6so13430235qki.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4tGo/9pCGZ9CQIivtrwXqooV4pgZlPgFCgblwzvkBPk=;
        b=cojb2TXPGPp84pt0tgeXGXdOAevEVsMrI2LLeNULRpRrEFxxaiMq8zBWiOL0w//upt
         7b4zGLgzpwa5q6dq/LAkt3fKqqc2+AVRYEtmSYccZUJi3xOc892Gm66ucNnnnmd6XG3M
         y0c1aR0o48ewK8bBmWlATwAQg9zCtpNKOq1ojDBLg2r+IHCpifU3nILKQ3X7ceXB5rZ3
         SHdN/UGiixUflDQRSJyjlu1Yo9XkAAHIr3fec/M14TK7I/jv3GtBvJipkhkv46dirG9A
         NilEjhVmvacGh4aA8pyGPHNpPQjaO36wTZ8YTz8mr+vIJn26eEIIsx9o27vczsb3CD5d
         qg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4tGo/9pCGZ9CQIivtrwXqooV4pgZlPgFCgblwzvkBPk=;
        b=A96xVxTCJH3ECa/2/OOSPuy8fDiHtFa1Pa0kzi9Myb6H/TYujimPRqbqSbuUJecBBu
         IHDf3d98gTPeUpw7KDxJL++xDVGcSTx2DOy9bMRRf+c4h3JQC3pt5uydilC8Wa00s6Uw
         nB4sx6suZfs5wiYhemtbae+/oz0W8xSF9bh7wvEcdvcPugqCba9SqvNcZGfAY+zNcKev
         JPucADrvs3P24X/elzysaoETF6XyCWP+JEhdm6ZRymsA5Dr1+NSsggvOWqNCXWDSpr25
         ZzYQxccPKuaJqxljcHWYA8q7sbtVjhkFXFaXAmYKxgICqhp0RQR6664O1da5BQ+eTTmL
         y1dQ==
X-Gm-Message-State: APzg51AYVUf0guHqWw1rB4G9evI+Xa34PyesaYlGrrVsJ0Af2Gvwfg2s
        9INMjoAQXm3vjVviiEAfzEkCfOqg
X-Google-Smtp-Source: ANB0VdZVKzVxqgK/RaFXyXETQAY7ICqVN/5XeQCMNCrFgsysTuVCS9PPDzrLIsoru4oTsIRe9+F00Q==
X-Received: by 2002:a37:788:: with SMTP id 130-v6mr13483343qkh.175.1536542261909;
        Sun, 09 Sep 2018 18:17:41 -0700 (PDT)
Received: from localhost.localdomain ([187.66.107.61])
        by smtp.gmail.com with ESMTPSA id u72-v6sm9529046qki.89.2018.09.09.18.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 18:17:41 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH TRIVIAL] MAINTAINERS: small punctuation fix
Date:   Sun,  9 Sep 2018 22:17:31 -0300
Message-Id: <20180910011731.7700-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c..6567bf245 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -93,7 +93,7 @@ Descriptions of section entries:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
 	   Odd Fixes:	It has a maintainer but they don't have time to do
-			much other than throw the odd patch in. See below..
+			much other than throw the odd patch in. See below.
 	   Orphan:	No current maintainer [but maybe you could take the
 			role as you write your new code].
 	   Obsolete:	Old code. Something tagged obsolete generally means
-- 
2.18.0

