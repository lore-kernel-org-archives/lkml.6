Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477732151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNDxFmXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477732151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeKVGfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:35:02 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56374 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbeKVGfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:35:01 -0500
Received: by mail-vk1-f201.google.com with SMTP id d123so1062379vkf.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d7sicbEgcvJ3lW3PNFo8/Z0SzxtWlaphKtgjSSnmx8k=;
        b=vNDxFmXtA51tbgjAuIjrIz7Jyywxiv6MkfRJ172+m3T/xbQHCvZGFZL5SvmJC6MMht
         hBxb4Y9ipgQecf0RKnfSrHW8Gk8vRPz92Sofz8uwtaW+E8Jg9A2uRCZ0mL1GYsuJxI94
         C7oAGlAxYcj58rQWC5HE//6bRg0Ss5v5+20JoKUW1VZtUuPFxHfOcJueiUDzVw/Sh495
         ew5H4zUo/PqRyZMdhbPV5AETAvbsvcp3DUaTdFR7PAhUg40ujksXIZTtsVM3ZxDifiiq
         7+SJR4dtWZt7xO3Y6btpJdUt0y18WgF87tDL1qwtzMyfdDsqcHOtVss/2/qFTypVrb84
         dbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d7sicbEgcvJ3lW3PNFo8/Z0SzxtWlaphKtgjSSnmx8k=;
        b=Ca9hFU3LMR/JjCxavXoV7NQgxzegHQnXIqbPDa064Pj5sfmaDgq6DHbwjcv3ck+H1l
         Z5ZUm2aXkZGCoaiIe7fBlM4HQsu3vFyNoQVii3YwXRXAqIL60d57SkE0BdkeeLz2SsOq
         fOwi9C2qy/s8Ejz4EWxnxiDTuFlzezpgo0dnSbpISslTT9FlBj/5IVZDv79EaStkhn0m
         VsjxzmNTyAhlmS9kiUF67Fg6evBZswuLXSyVLftGpDtDB6R9VDh4zsUs3VhAlwJ9OtZk
         yQZGszXKZuxwCO/RRwlQ8YsSilGfuOpozBDod6hOxT7o+j325UvMLREnAvvsIVrZXo7n
         C8RA==
X-Gm-Message-State: AGRZ1gL0GiTaAgaZInddp8OUrFWqq2kp4qCDLVz+gi5XXGV3ORaoCh0R
        IJD4fLnQbDqvKLWS387zEauuj1hw9g==
X-Google-Smtp-Source: AJdET5fiXmiv4HnIYOrfownj8ApwHNTz55U27qI2n0mYSmjjVtv5PKhHSjfpvJjQUJTzO64mYKu9RmWopw==
X-Received: by 2002:a67:470d:: with SMTP id u13mr6443291vsa.41.1542830358037;
 Wed, 21 Nov 2018 11:59:18 -0800 (PST)
Date:   Wed, 21 Nov 2018 20:58:59 +0100
Message-Id: <20181121195859.10894-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [PATCH] fs: add a comment explaining how MNT_NS_INTERNAL affects mnt_may_suid()
From:   Jann Horn <jannh@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, jannh@google.com
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 380cf5ba6b0a ("fs: Treat foreign mounts as nosuid"), in addition to
the intended effect, also prevented suid execution of memfd files.
(And I think that's a good change.)

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7f91265ea67..e68488426e42 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3400,6 +3400,9 @@ bool mnt_may_suid(struct vfsmount *mnt)
 	 * prevents namespaces from trusting potentially unsafe
 	 * suid/sgid bits, file caps, or security labels that originate
 	 * in other namespaces.
+	 *
+	 * check_mnt() rejects MNT_NS_INTERNAL mounts; this means that suid
+	 * execution is blocked for files on internal mounts, e.g. memfds.
 	 */
 	return !(mnt->mnt_flags & MNT_NOSUID) && check_mnt(real_mount(mnt)) &&
 	       current_in_userns(mnt->mnt_sb->s_user_ns);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

