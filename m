Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31537C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046612081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046612081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeJXIXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 04:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeJXIXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 04:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17D1C81F0F;
        Tue, 23 Oct 2018 23:57:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B2E176511;
        Tue, 23 Oct 2018 23:57:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/25] amd-gpu: Don't undefine READ and WRITE [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 00:57:50 +0100
Message-ID: <154033907037.12041.8420716608719361104.stgit@warthog.procyon.org.uk>
In-Reply-To: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Oct 2018 23:57:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the undefinition of READ and WRITE because these constants may be
used elsewhere in subsequently included header files, thus breaking them.

These constants don't actually appear to be used in the driver, so the
undefinition seems pointless.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/gpu/drm/amd/display/dc/os_types.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index a407892905af..c0d9f332baed 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -40,8 +40,6 @@
 #define LITTLEENDIAN_CPU
 #endif
 
-#undef READ
-#undef WRITE
 #undef FRAME_SIZE
 
 #define dm_output_to_console(fmt, ...) DRM_DEBUG_KMS(fmt, ##__VA_ARGS__)

