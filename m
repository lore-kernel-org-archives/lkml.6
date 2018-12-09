Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD79C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022D420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGKRb1m1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022D420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeLIUbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41991 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeLIUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so6499432lfh.9;
        Sun, 09 Dec 2018 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wj2cnV5NfgWAeq4QRBAjBkMHkVET0shlG5K+DrgkR8=;
        b=LGKRb1m1CaKNBImC5Wcz03HIovpkSc7hCibA4ZQ5cDBTPuN+nITP2tBRW5TEL/WOGm
         c+QxeESEt4T2rMCeF2XY3FLdhjbL9bt2KrKMeUeyPMm4quz7TgC1YifFXorZH+ApKzJy
         cHKL1DC1qf1QwaqwQbvaiizsT/WTWgq7q1J4fOBhNw8gvXsb01P7W3eEdRXL2lmQMevd
         Ysln4zgJqNisJuogQQUVp6+pFrhxMvt7SUttJsmKjT3f3JJQZ36Ql9psPsMFRh7IyVJP
         c+vAn/hplwoMlhhfRWrmHft0pdtuZBDOW2FhRYE/20dSLjguwFGCz6Y71BmnOTiTdq0M
         ksow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wj2cnV5NfgWAeq4QRBAjBkMHkVET0shlG5K+DrgkR8=;
        b=edHiUwd9dWDHTcfpGmQikS79VSUvLA4Ot49sUBp9/ABlMh4e4afhfJ0SetYb6F24cl
         QV3f9VfS/py3v2+fNNq7B2Eo3hdwdCkYzJK7VuxJJk/Jf5FXMBhDjUe5ovCrKzWPQbOZ
         ejWM9u+VFYI6gUk88rhi/gfxtHOL//vR30vhEzKzoYzLuVT+B0bI6uMkzFhpoEZyVuOL
         ZpiU5mAKJFhXVj95Wkfns7x8UQgfufuPBAEbqc/Ic4NwPLqSKbr/19Whk2Livv5nnaJh
         J3QJxrligxFWEs3NePmoqKRjAhR9jpxFoixNhtPdNEyMlxUfgF40wbjBzTCzaXNuD0Qq
         DFQA==
X-Gm-Message-State: AA+aEWaKGOKt5NR1xa1tyNG2cKpLQ2MWoNQ+U4m49U6EOIHTll0/B1Qv
        k+lputGhRx0yi32qMZnq8xk=
X-Google-Smtp-Source: AFSGD/WlKla8eHMeM6QO9j/NVn2EpNiYvtkLe0oHNfIrCX977I/zw8rwUqxvc7RFPSqWptOQQqIncg==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr5162356lfd.74.1544387478798;
        Sun, 09 Dec 2018 12:31:18 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/21] iommu/tegra: gart: Prepend error/debug messages with "gart:"
Date:   Sun,  9 Dec 2018 23:29:47 +0300
Message-Id: <20181209202950.31486-19-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART became a part of Memory Controller, hence now the drivers device
is Memory Controller and not GART. As a result all printed messages are
prepended with the "tegra-mc 7000f000.memory-controller:", so let's
prepend GART's messages with "gart:" in order to differentiate them
from the MC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 99afdbf8860c..9d2df43ce50b 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,6 +19,8 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#define dev_fmt(fmt)	"gart: " fmt
+
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
-- 
2.19.1

