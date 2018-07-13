Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D06ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0090820840
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Z+3gu1g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0090820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbeGMQkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:40:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36976 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbeGMQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:40:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id a26-v6so835055pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rm2yiY17vIRzStFCIsVLihDFgEjKxLfVJGn5PHG9JQ4=;
        b=Z+3gu1g+K+jkQ2DbFXuPnWrJgUckMBE7bQGYDCrnRgbS1NiDNZDFXA1CPfG+zMPhrJ
         v16yoU9sNd5bI5fX0NXE8X/PCguB/gVPcxsJ1Qc1JzvKhunlzYqvZ1EyWnRJ9d+W+ZbM
         0ktsLEVA3hPb8mKku1MkCi1Y/cF7pKcyLXpI+7GHk5wyJzGd9bFv6g4yfWwqS9Lb21x5
         SZ0b6ljOSUoFPJ5VdClS4/3m6HSk6HRmX2mFhKr5troF5XXZAdYr1Kbth4dmxQrIB/Bz
         7VayalhRkEVO4eWKDqjUitWx3QPsa/u4hvcIKMPujBHivOoft6RRKorQUpsLP5TN1yjz
         G77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rm2yiY17vIRzStFCIsVLihDFgEjKxLfVJGn5PHG9JQ4=;
        b=bLLh+MdS34dmj1KlfDaxJfS3ckOFNgXiaa1JHXHyQejqilnNiUu+2LX06ER63YBIv5
         qm+YhCrc9rKHMEWICrCLkv0YF7Qzyb7ck3JHp57B6l+azcEh+82YpS0uwFRN1ZPI+ypo
         7oSVGBPFp/zC0x5TWuv/vvE5fiCW5Y3jadx9G+jJfYr9z5+ZClpuXfH29Dt5rVPOvEbG
         4OsWAfIp0UEP7TD8ePeOco0PKLnrQG6k5NAIhOfyUSAMeBmJrFEYB07t8WRISw5BaJLk
         9X80jZMokWBQA/JUPLYYKNHNt5YdlenAKGbh78jcilaupUN8trZex2MAqI1XM/EyWgOJ
         R2UQ==
X-Gm-Message-State: AOUpUlHA3wW8dIbFPqTR3RSeY0EWPq+4AHAriBokcdMFzm/b4EVNV7DV
        hHp/CnDV3MOnk3hlR4yZa4ExiXaq
X-Google-Smtp-Source: AAOMgpdX41TVZPBfpJLHHp3iMKMCDoCqyXgca+8jvbU1mcPyqIrn8Gq7LAIclr0UJgmkS1CbQVrcOQ==
X-Received: by 2002:a65:49c7:: with SMTP id t7-v6mr6798859pgs.23.1531499119239;
        Fri, 13 Jul 2018 09:25:19 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u2-v6sm38861447pfn.59.2018.07.13.09.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 09:25:17 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 2/2] kbuild: buildtar: add arm64 support
Date:   Fri, 13 Jul 2018 09:24:58 -0700
Message-Id: <20180713162458.22154-2-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713162458.22154-1-olof@lixom.net>
References: <20180713162458.22154-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make 'make tar-pkg' work on arm64.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 scripts/package/buildtar | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 55887ac84ee4..d624a07a4e77 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -105,6 +105,14 @@ case "${ARCH}" in
 			cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 		fi
 		;;
+	arm64)
+		for i in Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo ; do
+			if [ -f "${objtree}/arch/arm64/boot/${i}" ] ; then
+				cp -v -- "${objtree}/arch/arm64/boot/${i}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+				break
+			fi
+		done
+		;;
 	*)
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
 		echo "" >&2
-- 
2.11.0

