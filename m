Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA4C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B699B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B699B20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeJWTVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:21:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40941 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWTVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:21:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so1162845edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bw2KUU2h83+2pMEOpnOXw8/lOgfIGJ4s790inMagQ7U=;
        b=idSi11WGaIHoDiAio4jOIVewWfQmK8QBxH5U9anDACbxQx29xp35T7SQnAyKNj0EAx
         BZ45i3dYkN7w5p/4FslHt76SK1iwJFLRiC8Qw2KMS98AXhNbGwL9HyRXafuN2sMgTXPn
         8QSYtc+5Q6tyRVG3hh+uhvNzd8gOWmAzEJ3167Ql066xl6gFzLcp21ZUFC0ixFqRkymB
         EQ91/Mhtkts9OxdnKqRyYNLLRCAL549/y+CNH45qx/GVClWisVp6hcQT+FNmApp2HLJW
         1Jckg1Ru+76jcwXNFlIeuEgBkeXKv4mFXBzYnnZyJFJavT6T13ogf+56yXpkG7+m7AqN
         dTDA==
X-Gm-Message-State: ABuFfoiLvXuI4PPwkpHiySd8Gcl+L4qhZ34Pz6V1OTHZzXKZJmMLB+X0
        v29pXMAAo3ZJdBflLm96jDY=
X-Google-Smtp-Source: ACcGV63nicnzIJbU4ty3zkt0a71K34Y/GnbhXGKr5VY7x9in60Pv/WSXEH9Y6EwyRNJ6dF5955pmOA==
X-Received: by 2002:a17:906:f215:: with SMTP id gt21-v6mr38119645ejb.44.1540292287974;
        Tue, 23 Oct 2018 03:58:07 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id w14-v6sm406197eds.16.2018.10.23.03.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:58:07 -0700 (PDT)
From:   efremov@linux.com
To:     James Morris <jmorris@namei.org>
Cc:     Denis Efremov <efremov@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] security: fix documentation for the syslog hook
Date:   Tue, 23 Oct 2018 13:57:45 +0300
Message-Id: <20181023105745.18698-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

The syslog hook was changed in the commit
"capabilities/syslog: open code cap_syslog logic to
fix build failure" (12b3052c3ee8). The argument @from_file
was removed from the hook. This patch updates the
documentation for the syslog hook accordingly.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/lsm_hooks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 57893534efca..8f84ef819e00 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1276,7 +1276,6 @@
  *	logging to the console.
  *	See the syslog(2) manual page for an explanation of the @type values.
  *	@type contains the type of action.
- *	@from_file indicates the context of action (if it came from /proc).
  *	Return 0 if permission is granted.
  * @settime:
  *	Check permission to change the system time.
-- 
2.17.2

