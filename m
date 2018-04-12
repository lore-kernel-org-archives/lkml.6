Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1272426-1523547618-2-9959721837694539666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523547617; b=DKEok6OestXGu5TpYrxx0O1V+8XJ+5+ViRW8x8Aaq1kESQQp9g
    IdMAg8OIwWwwGoctsXkqDlm17i5syxjYAQE1VuHnQJ+MBPpVjDiQTX3ozrPRWBmn
    ees862Avut6Yd+QIaJ2jKVStklwOWhn5zDFGCTuqQk+vN9EUI1U8GrKW4qv/6NnF
    wT2qgbpdNS5zE50qrcAchAjoocuNaMTSO8ZlbrOsQwNeVlOPFnOZcf8cuO+zntm2
    mxCcSHybHg5RnpjAXhmGxaKuaDbVdak8R6k9pBGzHpvGNmDBVzogIvUVGZKPqaXP
    +smnz5LttBqulTuIfuoO6I40Vnbn47vvC5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:date:message-id:subject:from
    :to:cc:content-type:sender:list-id; s=fm2; t=1523547617; bh=Shkw
    WSNGOiNiuMMl274km5VHGl7qYRXkAgmefCwD8BQ=; b=mKZJ6NwxGc2LRZNKK+ED
    n0/zNcuARvn03STPIrN2yaopmWDtDdU/siyCnue2f3T4vzaLqG8OBV++3YsFW89M
    Qy7LSlEkEKYbMvrYsLgLRWYfTP7IRVlnLJ0VC1LjGMBnxnPU5eXjgUw7klCU1+i0
    IPCFRDH0DoCZLwrfsc/6OIcZdQxFEpqMJVDAYk3uvBLJpudYSYA5aK1UypRJPHxv
    eswYItuV/0jMaGnN5YcM4CEumCGznpMhk5vL/cUrT1DthbaulGt1xnh+5WnToGAs
    LVgSRkC42o2S3LvFruDvHlpqquTn/H10M12BADg3MqUuOh+VagAKfFNOHjoQotwX
    DA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=PqTD6RBf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I2vlWqu3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=PqTD6RBf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=I2vlWqu3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDhQjjeOJj/l//fCfgfvBWxmGDbVHSdS4F+9VgYhCO3NL7wYs6O1Hyt2sYauNKQt5LcieCqO/ejjSq4cfim0GfAwFVc5aqpVptaJXR6/iIV0EZpFfb6q
    8q4h3t4aE5i/wE5OW18Xw0gNwV7KWmbax9A/KXLBUBBq3tGElOjIpw71d+LS4DsM5EoOEfa7DL2sP2tVUggqQ38yb6ikuEjuwxzl0l4m4jnDzuzkuuRqYHij
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=Sg8HuZxHAAAA:8 a=VwQbUJbxAAAA:8 a=w-BpR986XJu17BnA2oMA:9
    a=TmDJqoknooiIxX5u:21 a=2ppPeEhsXgrD0MNl:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=JFlNBosjgyz61O-hmi61:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDLPjw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 11:39:52 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:54738 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbeDLPjv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 11:39:51 -0400
X-Google-Smtp-Source: AIpwx4+9YXY3zpfFh6ZqaQ0025dgkCU6VqUyOnW8dcn8Q3XxU+eM24p6U4N2QsUmxmnnyfAflTINMZh54Q==
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 17:39:41 +0200
Message-Id: <20180412153941.170849-1-jannh@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been reserved
From: Jann Horn <jannh@google.com>
To: mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        mhocko@kernel.org, jhubbard@nvidia.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, jannh@google.com
Cc: linux-man@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clarify that MAP_FIXED is appropriate if the specified address range has
been reserved using an existing mapping, but shouldn't be used otherwise.

Signed-off-by: Jann Horn <jannh@google.com>
---
 man2/mmap.2 | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/man2/mmap.2 b/man2/mmap.2
index bef8b4432..80c9ec285 100644
--- a/man2/mmap.2
+++ b/man2/mmap.2
@@ -253,8 +253,9 @@ Software that aspires to be portable should use this option with care,
 keeping in mind that the exact layout of a process's memory mappings
 is allowed to change significantly between kernel versions,
 C library versions, and operating system releases.
-Furthermore, this option is extremely hazardous (when used on its own),
-because it forcibly removes preexisting mappings,
+This option should only be used when the specified memory region has
+already been reserved using another mapping; otherwise, it is extremely
+hazardous because it forcibly removes preexisting mappings,
 making it easy for a multithreaded process to corrupt its own address space.
 .IP
 For example, suppose that thread A looks through
@@ -284,13 +285,15 @@ and the PAM libraries
 .UR http://www.linux-pam.org
 .UE .
 .IP
-Newer kernels
-(Linux 4.17 and later) have a
+For cases in which the specified memory region has not been reserved using an
+existing mapping, newer kernels (Linux 4.17 and later) provide an option
 .B MAP_FIXED_NOREPLACE
-option that avoids the corruption problem; if available,
-.B MAP_FIXED_NOREPLACE
-should be preferred over
-.BR MAP_FIXED .
+that should be used instead; older kernels require the caller to use
+.I addr
+as a hint (without
+.BR MAP_FIXED )
+and take appropriate action if the kernel places the new mapping at a
+different address.
 .TP
 .BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
 .\" commit a4ff8e8620d3f4f50ac4b41e8067b7d395056843
-- 
2.17.0.484.g0c8726318c-goog

