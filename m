Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B026C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C03D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGdjGimO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C03D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeIABdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:33:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40592 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIABdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:33:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so11139262ljc.7;
        Fri, 31 Aug 2018 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XHp5kZcFvaIa+QEHAd7ZE10oFqyt5prSd/2ihgZaGzs=;
        b=rGdjGimOTf8u3WlWxz3ipWuPLKgD+vDDTgOqPJXFe3n7JokImUpjUSyNjkPvfQsVDE
         CMHSvLsZ3JBf8SdEB1u4cM1/Ha4kWrgI4hakZ9u+uSN672JTtE8CEJtPquSFXG3YJM0c
         3FkLedKaReVm+0dddTmJAzvyVMJPa21hM9WJQYsnwKoAt28n6l56yIrwx6B+hOm9+9Rj
         mLxUF0D9pj5Mc+azpUkmp6Cg6pu9Z8pOewBVn5i/oRVM24o/6B/S7VoCiDcRlpuLuxN3
         zeZQKOGa8FzlBxv5CWXFdi4ssudgVFmsVFWzRNEUwnDmSjHVR1yqawofMcSwJeEih867
         Q5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XHp5kZcFvaIa+QEHAd7ZE10oFqyt5prSd/2ihgZaGzs=;
        b=axuuHLPo9ZpNImm7TuzyM6IMGHdxmUc4E6xz5W/YauHQMURktkBz6b6br/6T8zppv8
         Rb+eLtJuHtPbtl5PgqNCysdWLYef+O5MPOgyOphH6eik2V3hIg+E7JMrEtoIB5r24kxq
         1OoC/fcHQAZJLCx+YkTfpDzLI3ozRiGgK0xcvO65L2MMbxjiVEfpIBpZd5q3kFkw8Bg/
         Ci813X+SvgMvSKHH14hp1dpYE/OpxhHa6soro5/J40meQiR0DxoNeTyP5RmQ9zoC6Mgl
         py1FhRYnK4rRg8VoL7lJ04dagb2V3214gtZcRszJ8xtHLqcnDVarI6ZUlJbhcdpr5yhP
         nvKQ==
X-Gm-Message-State: APzg51Bo6mhpVCYv9xuaOTzXTsfWoCtHoUkaYEQxUApe5iYZ76uhJejG
        ZLApblomFXHnjDNankJBmRk=
X-Google-Smtp-Source: ANB0VdZNubS/WLckYJEuQgj+e9KiEFubOpCed8vRea2Myb0hH9Mqo8Cw10x34ozZo2D1llM02hq4Ww==
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr2744614ljh.98.1535750659366;
        Fri, 31 Aug 2018 14:24:19 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id t4-v6sm2037130lfd.13.2018.08.31.14.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 14:24:18 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: vm: add unlikely() to BUG_ON()
Date:   Sat,  1 Sep 2018 00:24:08 +0300
Message-Id: <20180831212408.20071-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() is unlikely() to BUG()

For unlikely(), borrow the definition from tools/include/linux/compiler.h

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/vm/map_populate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/map_populate.c b/tools/testing/selftests/vm/map_populate.c
index 6b8aeaa0bf7a..1bf8ff068dcd 100644
--- a/tools/testing/selftests/vm/map_populate.c
+++ b/tools/testing/selftests/vm/map_populate.c
@@ -21,9 +21,13 @@
 #define MMAP_SZ		4096
 #endif
 
+#ifndef unlikely
+# define unlikely(x)		__builtin_expect(!!(x), 0)
+#endif
+
 #define BUG_ON(condition, description)					\
 	do {								\
-		if (condition) {					\
+		if (unlikely(condition)) {				\
 			fprintf(stderr, "[FAIL]\t%s:%d\t%s:%s\n", __func__, \
 				__LINE__, (description), strerror(errno)); \
 			exit(1);					\
-- 
2.17.1

