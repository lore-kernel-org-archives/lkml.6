Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7834ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604F4205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604F4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGSQXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:23:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeGSQXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:23:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51FE487A77;
        Thu, 19 Jul 2018 15:39:36 +0000 (UTC)
Received: from indium.redhat.com (ovpn-121-214.rdu2.redhat.com [10.10.121.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 134272026D6B;
        Thu, 19 Jul 2018 15:39:36 +0000 (UTC)
From:   Major Hayden <major@redhat.com>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Major Hayden <major@redhat.com>
Subject: [PATCH] buildtar: Copy bzImage for s390
Date:   Thu, 19 Jul 2018 10:39:34 -0500
Message-Id: <20180719153934.5788-1-major@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 15:39:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 15:39:36 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'major@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the arch-specific bzImage is present in the tarball
for s390 systems.

Signed-off-by: Major Hayden <major@redhat.com>
---
 scripts/package/buildtar | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index e8cc72a51b32..58937caab488 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -84,6 +84,9 @@ case "${ARCH}" in
 		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 		[ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifimage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
 		;;
+	s390)
+		[ -f "${objtree}/arch/s390/boot/bzImage" ] && cp -v -- "${objtree}/arch/s390/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		;;
 	vax)
 		[ -f "${objtree}/vmlinux.SYS" ] && cp -v -- "${objtree}/vmlinux.SYS" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.SYS"
 		[ -f "${objtree}/vmlinux.dsk" ] && cp -v -- "${objtree}/vmlinux.dsk" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.dsk"
-- 
2.17.1

