Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC0EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8F42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wgjIKIkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8F42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeLLWF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:05:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42502 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbeLLWF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:05:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so9231778plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tojsaxYtzGw4VUa07hP8Iro7zYaRhBsbIH7KfTp/GN0=;
        b=wgjIKIkDhdzkYnqPDHKZG6Xkhtz0Z7oCA7Eg1VYG7Rw10AuS9/wFDzszGt3jE0RYpu
         BJDO5x6hN7NbIZ+3pENYYOHMmXRH8mXuCQtgV0Uxs4YABZFci9ybqXluC/gtrchX4v2q
         hgL89d7E5nOBsck6McZJqK7nN5qqNeWVyYDlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tojsaxYtzGw4VUa07hP8Iro7zYaRhBsbIH7KfTp/GN0=;
        b=tQHdn0vwriS4ihvxXlhfr9Xlw/oC/jupp2vGoX/ytkzhvqzWVzNQgicjxXprkncx/C
         T2ocDjs/dArvkA9itknSqiLwcvJhVoNxwuz7sNBBTPY/sLbYBYUYc+bdvGZ3IZsl1uyh
         6RfEIl4/MQ9fnE1IpCSk/T4E/eIKT5c3dYAsW3VJXb6mkf/lMkmHIZyMfs3vUdvtMrgk
         4/m3vH7guIrtth5JuVwcJjJT+uBrgz+K+0XBl33YI1WVXF9AFxmo6FJi0wOhYHaQEdp6
         Mrj0pkkxB67DmeM6/XgPJ9jR7YZ+hTK4jQiZlem252EANqEjS4QIXm4jELBx1xoUZ4Q9
         5QYA==
X-Gm-Message-State: AA+aEWYeoVo+PbXV+W+3vLTzieT9XHAqQotVR0+pHNeT1/nlaP3LBNLM
        thg3kieFAv6OJc0e8k4Hm59NRg==
X-Google-Smtp-Source: AFSGD/UxK1G+wZUhq2La4WFKV9b5McakIYhxYhtbWABuVRqk7kW6DZkuWJLa2mKrz+MYmpuudSOAJQ==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr20625930plr.200.1544652325579;
        Wed, 12 Dec 2018 14:05:25 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id o1sm29340869pgn.63.2018.12.12.14.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 14:05:24 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-man@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 2/2] memfd_create.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Wed, 12 Dec 2018 14:05:14 -0800
Message-Id: <20181212220514.205269-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181212220514.205269-1-joel@joelfernandes.org>
References: <20181212220514.205269-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More details of the seal can be found in the LKML patch:
https://lore.kernel.org/lkml/20181120052137.74317-1-joel@joelfernandes.org/T/#t

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 man2/memfd_create.2 | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/man2/memfd_create.2 b/man2/memfd_create.2
index 3cd392d1b4d9..fce2bf8d0fff 100644
--- a/man2/memfd_create.2
+++ b/man2/memfd_create.2
@@ -280,7 +280,15 @@ in order to restrict further modifications on the file.
 (If placing the seal
 .BR F_SEAL_WRITE ,
 then it will be necessary to first unmap the shared writable mapping
-created in the previous step.)
+created in the previous step. Otherwise, behavior similar to
+.BR F_SEAL_WRITE
+can be achieved, by using
+.BR F_SEAL_FUTURE_WRITE
+which will prevent future writes via
+.BR mmap (2)
+and
+.BR write (2)
+from succeeding, while keeping existing shared writable mappings).
 .IP 4.
 A second process obtains a file descriptor for the
 .BR tmpfs (5)
@@ -425,6 +433,7 @@ main(int argc, char *argv[])
         fprintf(stderr, "\\t\\tg \- F_SEAL_GROW\\n");
         fprintf(stderr, "\\t\\ts \- F_SEAL_SHRINK\\n");
         fprintf(stderr, "\\t\\tw \- F_SEAL_WRITE\\n");
+        fprintf(stderr, "\\t\\tW \- F_SEAL_FUTURE_WRITE\\n");
         fprintf(stderr, "\\t\\tS \- F_SEAL_SEAL\\n");
         exit(EXIT_FAILURE);
     }
@@ -463,6 +472,8 @@ main(int argc, char *argv[])
             seals |= F_SEAL_SHRINK;
         if (strchr(seals_arg, \(aqw\(aq) != NULL)
             seals |= F_SEAL_WRITE;
+        if (strchr(seals_arg, \(aqW\(aq) != NULL)
+            seals |= F_SEAL_FUTURE_WRITE;
         if (strchr(seals_arg, \(aqS\(aq) != NULL)
             seals |= F_SEAL_SEAL;
 
@@ -518,6 +529,8 @@ main(int argc, char *argv[])
         printf(" GROW");
     if (seals & F_SEAL_WRITE)
         printf(" WRITE");
+    if (seals & F_SEAL_FUTURE_WRITE)
+        printf(" FUTURE_WRITE");
     if (seals & F_SEAL_SHRINK)
         printf(" SHRINK");
     printf("\\n");
-- 
2.20.0.rc1.387.gf8505762e3-goog

