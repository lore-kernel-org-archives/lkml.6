Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22230C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95602075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95602075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeJWTlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:41:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35772 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeJWTlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:41:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id e2-v6so1240374edn.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pFIid1ttnKbTSJAGSgem9ZOeJp9oXMhJmrteQgVEv28=;
        b=htRFTUws+CDcHQr1EHCrs1h+MsO5LMI/EwGj4IcOw9pT1SX0RVKReZdLeTURw2EpjP
         86+o+XZx61C/BrtHrhRdAQj/5y81lWPreL1M4bFvAshT2aKM9FES4wCXLLsBV6g6C03p
         yFVESoeyUCSwLxE+BY40PScmSCy7PfF3622v+EHWBx7VZ92OeIWV6TVqbfXH2el6v/T8
         QFKPdXbbQ3zeW3eou/UJmio5UmE1D0dXmnUIpY8Hq4Rc/WkB1w8CgBizYhYmTXe8ehyb
         40nKcQL6c7cJlVUOLyuKx5to3O4mK6vq26LZca59RXAK5vpjcTLSF9lC+qaqOY5jRYVW
         qg0g==
X-Gm-Message-State: ABuFfohb4pryw5m4NNtbpkXZsadah34Xo5a9XE5cG1Y09J7CTxAHXKX7
        K2esqDBHj/MCrZk2Erh3FlU=
X-Google-Smtp-Source: ACcGV61areFcIPsc9fz06s3bj/9pgny59Z3jjsYX5imLajYXIT+XRGWFMewZhOfVdw4TaS3p+PyZUA==
X-Received: by 2002:a17:906:454b:: with SMTP id s11-v6mr37300926ejq.83.1540293499243;
        Tue, 23 Oct 2018 04:18:19 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id x21-v6sm480339eds.30.2018.10.23.04.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:18:18 -0700 (PDT)
From:   efremov@linux.com
To:     James Morris <jmorris@namei.org>
Cc:     Denis Efremov <efremov@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] security: fix documentation for the audit_* hooks
Date:   Tue, 23 Oct 2018 14:17:48 +0300
Message-Id: <20181023111749.1581-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

This patch makes argument names equal in the documentation and
declarations of the audit_* hooks.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/lsm_hooks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 596351f7c3d1..9fb67c212298 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1329,7 +1329,7 @@
  * @audit_rule_known:
  *	Specifies whether given @rule contains any fields related to
  *	current LSM.
- *	@rule contains the audit rule of interest.
+ *	@krule contains the audit rule of interest.
  *	Return 1 in case of relation found, 0 otherwise.
  *
  * @audit_rule_match:
@@ -1338,14 +1338,14 @@
  *	@secid contains the security id in question.
  *	@field contains the field which relates to current LSM.
  *	@op contains the operator that will be used for matching.
- *	@rule points to the audit rule that will be checked against.
+ *	@lsmrule points to the audit rule that will be checked against.
  *	@actx points to the audit context associated with the check.
  *	Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
  *
  * @audit_rule_free:
  *	Deallocate the LSM audit rule structure previously allocated by
  *	audit_rule_init.
- *	@rule contains the allocated rule
+ *	@lsmrule contains the allocated rule.
  *
  * @inode_invalidate_secctx:
  *	Notify the security module that it must revalidate the security context
-- 
2.17.2

