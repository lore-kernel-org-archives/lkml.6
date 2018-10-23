Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E8EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C61207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C61207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJWTiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:38:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39909 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:38:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5-v6so1216970eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kO/0D40r2wod5v3I6jD1fuRXjPfSQhJNJigkdYeWUl0=;
        b=f9VYlW9BCpTvU05SIY9OrzXAvBp+qw8iFgL/Sr3kUx9AJvbyIBtpIAyIcfg2BggYMO
         veNWkhT0IbVquMWDlgJegwQI25iFBAgbnbY5/lVp/oqc8po0odj3uo2+E/bDvY+9ieL+
         Ar2ErOtBO+T/Zljj4xSrPZuc9drMCb5712YjokWnj51vS35vDBGvUaJ1PoKAWjKsjy2w
         HgV1Tief2RivCfI93kavqXjVoL4l1cwajnaItdF8q2bOVEtk+a24Lsp34BnVj2assSg+
         4F3QUoAkqV0Ur8dRDCwUS/Oqe8B78b+yNzuvo5DUHFD0QG/PE4vgq9568ULhJz0203rM
         nk9w==
X-Gm-Message-State: AGRZ1gIErnjkew9Ekf9jTdi3SMfOeuSeCcdYEWJqQJZkbueZUTtRG35v
        EXbpQvQqiLLwXFF3YD7Amww=
X-Google-Smtp-Source: AJdET5ewv3ohtWeO4+dAj+oTWa/Z9k3y8f78KeG0ARFlTh8ss974vQ/tydFinM/d2kAmAcgrYLW06g==
X-Received: by 2002:a50:a3f6:: with SMTP id t51-v6mr645211edb.238.1540293312257;
        Tue, 23 Oct 2018 04:15:12 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id l34-v6sm459177eda.54.2018.10.23.04.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:15:11 -0700 (PDT)
From:   efremov@linux.com
To:     James Morris <jmorris@namei.org>
Cc:     Denis Efremov <efremov@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Catherine Zhang <cxzhang@watson.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] security: fix documentation for the socket_getpeersec_dgram hook
Date:   Tue, 23 Oct 2018 14:14:50 +0300
Message-Id: <20181023111450.31837-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

The socket_getpeersec_dgram hook was changed in the commit
"[AF_UNIX]: Kernel memory leak fix for af_unix datagram getpeersec patch"
(dc49c1f94e34). The arguments @secdata and @seclen were changed to @sock
and @secid. This patch updates the documentation accordingly.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/lsm_hooks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ae3766720264..a598e601ccb3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -861,9 +861,9 @@
  *	the IP_PASSSEC option via getsockopt.  It can then retrieve the
  *	security state returned by this hook for a packet via the SCM_SECURITY
  *	ancillary message type.
- *	@skb is the skbuff for the packet being queried
- *	@secdata is a pointer to a buffer in which to copy the security data
- *	@seclen is the maximum length for @secdata
+ *	@sock contains the socket structure.
+ *	@skb is the skbuff for the packet being queried.
+ *	@secid: pointer to where to put the secid of the packet.
  *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
-- 
2.17.2

