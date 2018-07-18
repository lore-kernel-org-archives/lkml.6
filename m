Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23538ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22E020673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22E020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeGRRyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:54:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731362AbeGRRyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:54:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D76B5401EF07;
        Wed, 18 Jul 2018 17:15:15 +0000 (UTC)
Received: from indium.redhat.com (ovpn-121-214.rdu2.redhat.com [10.10.121.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBCF61C55C;
        Wed, 18 Jul 2018 17:15:13 +0000 (UTC)
From:   Major Hayden <major@redhat.com>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Major Hayden <major@redhat.com>
Subject: [PATCH] buildtar: Copy vmlinuz for arm64
Date:   Wed, 18 Jul 2018 12:15:07 -0500
Message-Id: <20180718171507.4837-1-major@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 17:15:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 17:15:15 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'major@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the architecture-specific compressed kernel image to the
directory used to make the tar package.

Signed-off-by: Major Hayden <major@redhat.com>
---
 scripts/package/buildtar | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index e8cc72a51b32..a87c8cbc1ba3 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -80,6 +80,9 @@ case "${ARCH}" in
 	alpha)
 		[ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
+	arm64)
+		[ -f "${objtree}/arch/arm64/boot/Image.gz" ] && cp -v -- "${objtree}/arch/arm64/boot/Image.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		;;
 	parisc*)
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 		[ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifimage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
-- 
2.17.1

