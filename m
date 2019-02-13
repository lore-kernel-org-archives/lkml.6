Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8759EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB65222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083208;
	bh=YQkO9hEHx/uFzZpxYpRtl3XsxxfgohwJwxw8GGGOso0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jIG4/9HWqRlcCy21O48225OH3BsgxRg9HJ+11onM4ZbZdC83ATfka8C/zPvdI5b50
	 dydgRj59mwDZWegRKiQMLFPSv6baa5yJgWbw56jw+LEyuEpLsIhA7niNN8XTTkxp1v
	 hTqFzFM2q4HoyI6n1B/p1K8MRDX4DfRSh25HDGf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405356AbfBMSkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbfBMSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:40:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2E2222D5;
        Wed, 13 Feb 2019 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083202;
        bh=YQkO9hEHx/uFzZpxYpRtl3XsxxfgohwJwxw8GGGOso0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyxXejgLycfgB72nmsZL1MnLRI+2OGNucAQ03EgrEmm9Smuv5+QuGmRtFIrOIKdWs
         sF0yoxOF7637xZq1LcPTc37jchuR+qD6D9LIiqtjL5PmP2iVQWia+9aPI04ASN779s
         nRYhd8kgHi2UXWr1QzT1GMD8L4NhjmtAokUZhH6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/24] Revert "cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)"
Date:   Wed, 13 Feb 2019 19:38:17 +0100
Message-Id: <20190213183649.139747626@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
References: <20190213183647.333441569@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 4cd376638c893cf5bf1072eeaac884f62b7ac71e which is
commit 6e785302dad32228819d8066e5376acd15d0e6ba upstream.

Yi writes:
	I notice that 4.4.169 merged 60da90b224ba7 ("cifs: In Kconfig
	CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)") add
	a Kconfig dependency CIFS_ALLOW_INSECURE_LEGACY, which was not
	defined in 4.4 stable, so after this patch we are not able to
	enable CIFS_POSIX anymore. Linux 4.4 stable didn't merge the
	legacy dialects codes, so do we really need this patch for 4.4?

So revert this patch in 4.9 as well.

Reported-by: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: Pavel Shilovsky <pshilov@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -111,7 +111,7 @@ config CIFS_XATTR
 
 config CIFS_POSIX
         bool "CIFS POSIX Extensions"
-        depends on CIFS && CIFS_ALLOW_INSECURE_LEGACY && CIFS_XATTR
+        depends on CIFS_XATTR
         help
           Enabling this option will cause the cifs client to attempt to
 	  negotiate a newer dialect with servers, such as Samba 3.0.5


