Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591418-2-15542510300630040321
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591415; b=b7+d4+avm2sdV4LbcjhZwLTBj57ThhxLprpIC/LiCYxjw5F
    k4BetntaiZPEvxXJjkBs+tBBWVXDFL5xq6HMy62EC2jIDwKE1XMOZLfejP82hiJf
    C1DHm//Nm1g9t1ge/XChXHIZ3VaxSy3iVdMdbfa/gbOpAxx1bVHVhsd5FdBEE8tC
    rPZYL+APo5s9MeBy+fdzanpaRnZ3Ij4qXGyVnHn/Be3e5Spqv5jJtlRAVvTSSzhu
    I1PtQtqqC8UN6mCXl9cU5cebbthBeX8bCr/TZVrN8WpaaZ7rWjIxzlX2s/hZUd4o
    9YH5qehJDIz+8F7puJMavB9t9YjA9BgiC2nE1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591415; bh=pabqwkTcoVCZpRBfLA0aRp9oBi
    /aG0edcb/s9RfhgeM=; b=ndaRzliBSS72zz8OSMvirJ1Azo59XW8Dm5RU0o6mHf
    5GLwFGViuSZwQBBAqpcqi9jqoR5VBZhp8jT3kUk2uturPTyIVL1SfZZNHIQNWVFg
    c4QFZgfBCXHan4AfjSyw59hMJN2j/RSW/BTKgqv8KEWy2HiQ+JzrIXuOnukk6hOY
    N53LoBu+MRZbO07SdOanDTF2GtIQNqQ3ZkSgHuNlqhsFjEFqlJ2SCvQ6HyIigN/N
    3q4ZKREzANqIDpvDEGp4HmUiFbwUULxErq6RvihD0/opsmT95X7X7pKsX/kRgglA
    /S8TX3NU9AK4Kw0jkpEg/yTmWxLyUSnmxqGN/puag5wA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeBBRKF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:10:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeBBRJ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:09:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 065/156] uapi: fix linux/kfd_ioctl.h userspace compilation errors
Date: Fri,  2 Feb 2018 17:57:26 +0100
Message-Id: <20180202140843.235961169@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Dmitry V. Levin" <ldv@altlinux.org>


[ Upstream commit b4d085201d86af69cbda2214c6dafc0be240ef9f ]

Consistently use types provided by <linux/types.h> via <drm/drm.h>
to fix the following linux/kfd_ioctl.h userspace compilation errors:

/usr/include/linux/kfd_ioctl.h:236:2: error: unknown type name 'uint64_t'
  uint64_t va_addr; /* to KFD */
/usr/include/linux/kfd_ioctl.h:237:2: error: unknown type name 'uint32_t'
  uint32_t gpu_id; /* to KFD */
/usr/include/linux/kfd_ioctl.h:238:2: error: unknown type name 'uint32_t'
  uint32_t pad;
/usr/include/linux/kfd_ioctl.h:243:2: error: unknown type name 'uint64_t'
  uint64_t tile_config_ptr;
/usr/include/linux/kfd_ioctl.h:245:2: error: unknown type name 'uint64_t'
  uint64_t macro_tile_config_ptr;
/usr/include/linux/kfd_ioctl.h:249:2: error: unknown type name 'uint32_t'
  uint32_t num_tile_configs;
/usr/include/linux/kfd_ioctl.h:253:2: error: unknown type name 'uint32_t'
  uint32_t num_macro_tile_configs;
/usr/include/linux/kfd_ioctl.h:255:2: error: unknown type name 'uint32_t'
  uint32_t gpu_id;  /* to KFD */
/usr/include/linux/kfd_ioctl.h:256:2: error: unknown type name 'uint32_t'
  uint32_t gb_addr_config; /* from KFD */
/usr/include/linux/kfd_ioctl.h:257:2: error: unknown type name 'uint32_t'
  uint32_t num_banks;  /* from KFD */
/usr/include/linux/kfd_ioctl.h:258:2: error: unknown type name 'uint32_t'
  uint32_t num_ranks;  /* from KFD */

Fixes: 6a1c9510694fe ("drm/amdkfd: Adding new IOCTL for scratch memory v2")
Fixes: 5d71dbc3a5886 ("drm/amdkfd: Implement image tiling mode support v2")
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/kfd_ioctl.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -233,29 +233,29 @@ struct kfd_ioctl_wait_events_args {
 };
 
 struct kfd_ioctl_set_scratch_backing_va_args {
-	uint64_t va_addr;	/* to KFD */
-	uint32_t gpu_id;	/* to KFD */
-	uint32_t pad;
+	__u64 va_addr;	/* to KFD */
+	__u32 gpu_id;	/* to KFD */
+	__u32 pad;
 };
 
 struct kfd_ioctl_get_tile_config_args {
 	/* to KFD: pointer to tile array */
-	uint64_t tile_config_ptr;
+	__u64 tile_config_ptr;
 	/* to KFD: pointer to macro tile array */
-	uint64_t macro_tile_config_ptr;
+	__u64 macro_tile_config_ptr;
 	/* to KFD: array size allocated by user mode
 	 * from KFD: array size filled by kernel
 	 */
-	uint32_t num_tile_configs;
+	__u32 num_tile_configs;
 	/* to KFD: array size allocated by user mode
 	 * from KFD: array size filled by kernel
 	 */
-	uint32_t num_macro_tile_configs;
+	__u32 num_macro_tile_configs;
 
-	uint32_t gpu_id;		/* to KFD */
-	uint32_t gb_addr_config;	/* from KFD */
-	uint32_t num_banks;		/* from KFD */
-	uint32_t num_ranks;		/* from KFD */
+	__u32 gpu_id;		/* to KFD */
+	__u32 gb_addr_config;	/* from KFD */
+	__u32 num_banks;		/* from KFD */
+	__u32 num_ranks;		/* from KFD */
 	/* struct size can be extended later if needed
 	 * without breaking ABI compatibility
 	 */
