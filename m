Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154FEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C926F20672
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGT2MQqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C926F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeKZDZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:25:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38083 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeKZDZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:25:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so13833528ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdj3reu/TV1b98azsunvTKKx3kLj3onm5IQieLcJEqs=;
        b=IGT2MQqjAxjUi7W39kFdqH+tlrs1BlCl4n/rk6L4QvUPL1W/JIeajO2b5T5AVs0Rnb
         /QQf44Xt8IomXt9lcIe/ELO8DVpjTvxMTdmvk4YQYCDygeFQa9cAsd+eGzEgDhiEjP6M
         XrBzVMdlkYhgauSnD2fwTzaceDMZt0DDFG6cr7NFRQ4ixyk6HDSw89nZ2RIscqC07Edr
         O/OnE6jpDTVOG9iuchNrdjiHDkWhVQvW+8JrgQrd/7zdyLwX8kVuXUs1kcTyCmVVePyq
         YB0wxY0CW/w0j+NmPePyRagsAEjEP+jR4XeaItQPG4J2Zy7Uodvh5X9neviC3Bz0PIFN
         M86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sdj3reu/TV1b98azsunvTKKx3kLj3onm5IQieLcJEqs=;
        b=GLFHK+ksoEzmD+ZDlU19lWKuIa1J22vPXHSnFYYIWP59FT/El5lkkveG53xUx4nBIm
         D0MYVrG6PDXd/nzcyIT4di1/oprTR6u+r1S/uRBzg/pIuO1Qxdu1LSLGp9c24UbnBPMl
         wGoQSJ/g9h+SuHbmMv+XnRSS7W8S/f2dL/4WMFqHfqtuIFf8YzColHt6xa3bad0vGE1r
         oOCJJJMya9V0Gt7K90wL67NCU452IteNqNTg2rZvLm169M4E9Tw+Fu2s56F6UBg3rbzm
         vO1Gpf4/hTIWxMl8ytBJfqiXwxyLklf/slBuSH/cxHiiH65CpqEPps1wzWdZkmOuNDsp
         ytlw==
X-Gm-Message-State: AA+aEWYUbHi+B63uWsFehFT3SVUN0WNz4caAYRkhgtAHv8M7W817SXPS
        7YRWgYuVeyp/81kBNUzcapE=
X-Google-Smtp-Source: AFSGD/VooiyP0zIX+Q9gBXybgPW4rMRgDtuBNg8K8412e9Zi7dBIaN0rx5rlWWx3Jfia56BI10KAXA==
X-Received: by 2002:a50:a726:: with SMTP id h35mr2684008edc.192.1543163656472;
        Sun, 25 Nov 2018 08:34:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40bc:4d00:54c6:20e3:7c3e:2a57])
        by smtp.gmail.com with ESMTPSA id br3-v6sm9507812ejb.24.2018.11.25.08.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:34:15 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] MAINTAINERS: change Sparse's maintainer
Date:   Sun, 25 Nov 2018 17:34:05 +0100
Message-Id: <20181125163405.31443-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm taking over the maintainance of Sparse so add myself as
maintainer and move Christopher's info to CREDITS.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 5befd2d71..3d3e79cef 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2200,6 +2200,10 @@ S: Post Office Box 371
 S: North Little Rock, Arkansas 72115
 S: USA
 
+N: Christopher Li
+E: sparse@chrisli.org
+D: Sparse maintainer 2009 - 2018
+
 N: Stephan Linz
 E: linz@mazet.de
 E: Stephan.Linz@gmx.de
diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc528..68c7435f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13977,11 +13977,10 @@ F:	drivers/tty/serial/sunzilog.h
 F:	drivers/tty/vcc.c
 
 SPARSE CHECKER
-M:	"Christopher Li" <sparse@chrisli.org>
+M:	"Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
 L:	linux-sparse@vger.kernel.org
 W:	https://sparse.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/devel/sparse/sparse.git
-T:	git git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git
 S:	Maintained
 F:	include/linux/compiler.h
 
-- 
2.19.0

