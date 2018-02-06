Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226aFhpYByM8vsFqXqfnTD1aLSpCB/O0+5KN/G5uNfZquyiHI+XGtdFOMEXCdii73lohtLHe
ARC-Seal: i=1; a=rsa-sha256; t=1517955700; cv=none;
        d=google.com; s=arc-20160816;
        b=cq2cDOaQ7yfLYv2PIzk18K9WRKUIi058bsbMib72AFnh3IjCvNOWgrm+0a8Zwq51M9
         Cj7IreIJ+N0uFOFcWNTpUgWY60pgf/ZmWZCO15Q3CFsp3j7FAU3jn5XR2BGj0qHc4u4T
         6SULIugcCS53woQUap8Qar0VeMyeki0Ngct19/fu4GnkfZDAHEH3xM6vq04iEEQW1PeO
         2bJd2qp6zpde16apJEQFxt13uQH6Fx7l7YiMEhtxHOr6YN9o9U6HSjIQona7OOH1djnq
         +tAl9jlMq+m0yhuRuRzs1w9/X2tD7Ia2jozbmZ4EU0aVxESGaBtrSYXE5YjwzRqg5Kky
         RKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4Fny+tkVFsTkjKUySCp+acuqbglgHzaRiN0cx61O/Ns=;
        b=q98VQ0J/+GvuYREi3TV5uF53Y0mk3fOP49svqA6o6YZZlpzRNv1qJiVM+El7qSEWfr
         vklQ+znFlhLGOcRsY/FT/WV3KNuLqgGezomCd4hBzk13oMbYs6LQ8zIKLVF9jfFIMPK+
         kXfIxpPDXrZx8h8+PB1H8ArrkA19Gb6On/2jyRD5MAJR6Li2ZDu486KfWBJYcVyzavb8
         11pZ/0izqeHvjbZo9DeNpDZ68eUAeyZEPXZMkM0DW44AU+jZAlGehhVZMsRyw1nB0JvZ
         s0VqDaOn1aU0z4R1TJawnjnchjgsATiDdTHlKi2MqeuieOq1mCF1+jvUFFZ6KU+eFS6O
         iajQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=OfDIGHES;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=OfDIGHES;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbeBFWV3 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 6 Feb 2018 17:21:29 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46456 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbeBFWV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Feb 2018 17:21:28 -0500
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests: memfd: add config fragment for fuse
Date: Tue,  6 Feb 2018 16:20:44 -0600
Message-Id: <1517955648-11186-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591691916709223124?=
X-GMAIL-MSGID: =?utf-8?q?1591691916709223124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>

The memfd test requires to insert the fuse module (CONFIG_FUSE_FS).

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/memfd/config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/memfd/config

diff --git a/tools/testing/selftests/memfd/config b/tools/testing/selftests/memfd/config
new file mode 100644
index 0000000..835c7f4
--- /dev/null
+++ b/tools/testing/selftests/memfd/config
@@ -0,0 +1 @@
+CONFIG_FUSE_FS=m
-- 
2.7.4

