Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4277120840
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Oa3gZeiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4277120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbeGMQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:40:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38662 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbeGMQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:40:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so12408841pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uH3v63s5BJKrYdOJrZsJicvfRYoW+4nJx0COrlfxjdg=;
        b=Oa3gZeiZx0WwfNmyRkX9Xu3Khh2T4rJxY+8JrAFmDAHnWhB3Qy+yUnaZoqf66uk967
         qC9bsSjbzDoRMY4udPsdjwrRPGPeFIxiCva0ydFO9v1m0ad5bmq/IPmWEudxSnIxrAgZ
         nLpDyEdwNFEYLPu5zjIMbzTkzencErirMC95f9ouK0mF+HKNweQZkJUtV9Px29q6O+zQ
         e6rjHY177GT2oViWW1tr3LbgUlqiCvNYASM+/Qy222tGWz44MK/J6sF2i4KXphE+YSnR
         WaeRqLenKh46PWCg2tOiKJXdUT+Vt3vrELwpHeYbyukEKOv1EtFZWrUg3EqAZVoMlfrk
         JGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uH3v63s5BJKrYdOJrZsJicvfRYoW+4nJx0COrlfxjdg=;
        b=Xp2gd3g50LG4STWOqygBKWQHc6+PlE9i/McwQmX9U0hoxRZtFZP1f3zdE3gyl6d60x
         4J90wQDHpnrTQfTa2q6jmd2QPoHvpF2rBCU+wdLK2P2ep+ovon/BzR0KtdyBbIs3MsnZ
         c1jOxdt/O5k1yL+HOuc3U+LI4ZE8jP9sNQUxZ14CJYPtzAwSO+JwudDnY2e5qC99h7mS
         fayqqlmLCxHpQ1G19la0cuR8lu0IB12hQpEXe9Vbg7fzSou99Ypv1H6AkuLSu3DOOibb
         I+o+YMeCn7yCI5xziWswNMRFn9IHz7UVPqFNMcfUVWzDuPpmW57S1hLZVIYzlodl/Xw+
         DplA==
X-Gm-Message-State: AOUpUlFCD7rLyblzvewRkH/uZ5TEBCw/Btn2gXwqcGCdaoV8SvWFBW1j
        ob8F/8gpVPTrm9wWwYtIMnrllQ==
X-Google-Smtp-Source: AAOMgpfm2aiyW/X3MQ/GG50hFvT11NW7umSYC10Nvu2UoA+2QVSD8uiyEoeve1KEik1U4BZqez6uGA==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr7117233plb.14.1531499113568;
        Fri, 13 Jul 2018 09:25:13 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u2-v6sm38861447pfn.59.2018.07.13.09.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 09:25:11 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/2] kbuild: buildtar: remove crufty vax pieces
Date:   Fri, 13 Jul 2018 09:24:57 -0700
Message-Id: <20180713162458.22154-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH=vax isn't in mainline; it can be added back if/when it shows up.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 scripts/package/buildtar | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index e8cc72a51b32..55887ac84ee4 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -84,10 +84,6 @@ case "${ARCH}" in
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 		[ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifimage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
 		;;
-	vax)
-		[ -f "${objtree}/vmlinux.SYS" ] && cp -v -- "${objtree}/vmlinux.SYS" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.SYS"
-		[ -f "${objtree}/vmlinux.dsk" ] && cp -v -- "${objtree}/vmlinux.dsk" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.dsk"
-		;;
 	mips)
 		if [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.bin" ]; then
 			cp -v -- "${objtree}/arch/mips/boot/compressed/vmlinux.bin" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
-- 
2.11.0

