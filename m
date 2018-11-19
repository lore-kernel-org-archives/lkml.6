Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7305BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179BB21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwIhcSAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179BB21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeKTDCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731517AbeKTDCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E342A213A2;
        Mon, 19 Nov 2018 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645508;
        bh=ec2jiD/8jSvolZrZH6GlbHJyhyFUS9zdeDzawTCji8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwIhcSATqLzi7VEGuNcCxEIYJwpsfGCVO/YMcRK9hLzfk/DzMXqnPyjCHi8ycLfL8
         VTvcDpdro/tAxeDEbhkYUpUdij4X7REKgRhvpVSr5T9PD5CFZA4HeHRghQAmm+WNR8
         vNEr3Y7d4BVPRP4E4FbpS64Ulqdwcv0TBau2EPyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 151/205] uapi: fix linux/kfd_ioctl.h userspace compilation errors
Date:   Mon, 19 Nov 2018 17:27:38 +0100
Message-Id: <20181119162638.686113161@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry V. Levin <ldv@altlinux.org>

commit aba118389a6fb2ad7958de0f37b5869852bd38cf upstream.

Consistently use types provided by <linux/types.h> via <drm/drm.h>
to fix the following linux/kfd_ioctl.h userspace compilation errors:

/usr/include/linux/kfd_ioctl.h:250:2: error: unknown type name 'uint32_t'
  uint32_t reset_type;
/usr/include/linux/kfd_ioctl.h:251:2: error: unknown type name 'uint32_t'
  uint32_t reset_cause;
/usr/include/linux/kfd_ioctl.h:252:2: error: unknown type name 'uint32_t'
  uint32_t memory_lost;
/usr/include/linux/kfd_ioctl.h:253:2: error: unknown type name 'uint32_t'
  uint32_t gpu_id;

Fixes: 0c119abad7f0d ("drm/amd: Add kfd ioctl defines for hw_exception event")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/kfd_ioctl.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -247,10 +247,10 @@ struct kfd_hsa_memory_exception_data {
 
 /* hw exception data */
 struct kfd_hsa_hw_exception_data {
-	uint32_t reset_type;
-	uint32_t reset_cause;
-	uint32_t memory_lost;
-	uint32_t gpu_id;
+	__u32 reset_type;
+	__u32 reset_cause;
+	__u32 memory_lost;
+	__u32 gpu_id;
 };
 
 /* Event data */


