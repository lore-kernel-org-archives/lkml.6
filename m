Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F44C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C94720671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C94720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeJWTNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:13:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43914 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeJWTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:13:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so1135814eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fRGathRiWjimlmLkpHvOLrKXzxonY3pbZREzIQ/Jx/Q=;
        b=KpExK7iKL3qfixpJX4YdTR5x5mqz0ysO20DZ0g4+Mu1Q4UlUjkrFpMo6x9uKupAGHX
         vezzu2fKOGArp4634NS3gvi8zdRBCaN3sOC8mcbPNi4kN7HSGHCL0BPlqjEjKFDLTxa/
         pyZjf4f8XSF8Ev2lave2b1clqaTYO8V3rGcMlk2POoRmTP2ohcVHzHhF+WouqYoIWBwR
         ttFTpMRGznLSouLxERV+or+uK6HX0ICtFv4Ol7G+LrDW0Sov4ewt3gDH2fMr4N4PsqrV
         XpnlygprBaXmQNTMfbdD26V0IvH9mbEHOZomXq4nfKEckSqjDCS7G/6lacp4WPBAMCaS
         BuDg==
X-Gm-Message-State: ABuFfogxx70MudqFih6EVL87B8IRX743uXnNNREZduYbHv5Flx+pwvdD
        t1vslwaNjrs0bVJ+4yGYjW8=
X-Google-Smtp-Source: ACcGV63UI/HhGCv93Pqx5FS71dHP1Rm3FxXIzjIPZJ24VFbj2IMQUcbJsRaktwcKtwW6Vn7C7EM/Sg==
X-Received: by 2002:a50:9f63:: with SMTP id b90-v6mr16146565edf.218.1540291838751;
        Tue, 23 Oct 2018 03:50:38 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b26-v6sm393696edw.0.2018.10.23.03.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:50:37 -0700 (PDT)
From:   efremov@linux.com
To:     James Morris <james.morris@microsoft.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] security: fix documentation for sb_copy_data hook
Date:   Tue, 23 Oct 2018 13:50:22 +0300
Message-Id: <20181023105022.15729-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

The @type argument of the sb_copy_data hook was removed
in the commit "LSM/SELinux: Interfaces to allow FS to control
mount options" (e0007529893c). This commit removes the description
of the @type argument from the LSM documentation.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/lsm_hooks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 97a020c616ad..57893534efca 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -111,7 +111,6 @@
  *	options cleanly (a filesystem may modify the data e.g. with strsep()).
  *	This also allows the original mount data to be stripped of security-
  *	specific options to avoid having to make filesystems aware of them.
- *	@type the type of filesystem being mounted.
  *	@orig the original mount data copied from userspace.
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
-- 
2.17.2

