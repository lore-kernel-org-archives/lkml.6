Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DB9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69469214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547019497;
	bh=gAMOr9K1cAIl9oCytG2mpMFchsn8+TsC1lqCDMO37fc=;
	h=From:To:Subject:Date:List-ID:From;
	b=w0ufW/CYNRw0fKOslf5Ie9amLsexEzRwpIcNXHWvbbz/v+63ShKx44hkxQqnb4gtJ
	 lMsS47RsicPoNEbZ8Dw9jX0lSLYgXOoZUH3fu74ioRHC0INyzSlbz3laiqe6tb7LmW
	 2wpB5B0HWNDPAPO/ZXH7v3zzb2AsAo7IWpDx5D5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfAIHiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfAIHiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:38:16 -0500
Received: from sol.localdomain (c-24-23-143-129.hsd1.ca.comcast.net [24.23.143.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D65020883;
        Wed,  9 Jan 2019 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547019495;
        bh=gAMOr9K1cAIl9oCytG2mpMFchsn8+TsC1lqCDMO37fc=;
        h=From:To:Subject:Date:From;
        b=BOdoVjguOAsehMG4d34Jkk8pMIeQIcZglslJbDP7KZGpWaK6NPk8h99RUEkFjxZSN
         LJgUWIkJoYV1YFvb48147CANjup29QBqSOp5RvM0eAlftTTuT/aRu5vp0I0fZjMOrn
         KUXys2suaSt0zcM0R6f6PDO3EKbNLoFNRqJHLWWs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: make kset_get_ownership() 'static'
Date:   Tue,  8 Jan 2019 23:36:14 -0800
Message-Id: <20190109073614.18999-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

kset_get_ownership() is only used in lib/kobject.c, so make it 'static'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index b72e00fd7d09e..aa89edcd2b63a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -887,7 +887,7 @@ static void kset_release(struct kobject *kobj)
 	kfree(kset);
 }
 
-void kset_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+static void kset_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 {
 	if (kobj->parent)
 		kobject_get_ownership(kobj->parent, uid, gid);
-- 
2.20.1

