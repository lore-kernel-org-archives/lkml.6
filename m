Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx488zpM7IaOIddJcPpKNH0pj0PE1ZHr6GyGoTUkJ1NMazybKm92L+m+HGdkX6F56WB9deTpU
ARC-Seal: i=1; a=rsa-sha256; t=1524133714; cv=none;
        d=google.com; s=arc-20160816;
        b=WWYFuZRL1j7aPvGi6RKAFO88QdeWm1uLyKadQeQIasc41YhkfaVZE/NF+i3sphy7HJ
         J0CAeWTwVXgj6uf6hIpMTJo6zDE/FnXg5t4SJIp9UlcUXQI6i0L7HeJKrUAwxSozOBH+
         hVM8IljtaQT0pDMUu+E+otdhmDflcCT+xDvhgsPnI/xnvacxI1q9X8IogC6v3MKqCSII
         ad56Ge7sW4F8qA5Tog/rxprFRFcJojb7zr43rsw5Uu1RSkwreXuyUyqrV6qnf6JMNpvQ
         lYTzA93MGUwuUkUEkbxTE19Qi5ph12lESrHv78bVLtiJwfvamuUDWhzt1U7fJAZqBVcc
         WGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bmb++EjRledQ2Dn9RPHmsgCYxgm0c5UUpBQMHIECUMs=;
        b=iU0NCYmPV8XH5GHOPT4ikpDuTHIjUNNwTg5cnlc4LHgPTPxOph+T1qRpd01ROaRAXy
         VTuxiOIttAqd4spgUQ543szaV/hzm+yKQ9abt4XiaeIEFscsvSA/FLYRSiwNbaP3NIx/
         00btko0yPwGs0Kv1eyfhIkWT+Q2LlnKGfe1bAXcZvx0/SK0SeD1Wn7j+C8It/CWc8C3A
         Jenow1Ulk/EXc5azrJqQRjk4ob9JX1hZ3+7WtQp3C+LUg0CboIV/J3B2U/sCivOaLl/K
         YIlJiSlYWRmVk+8LP/sWfwhrruRENijU8q9IhnIeq/G0XdLIFJjM8E8GZMffKiFZ8N9p
         jkyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=HJE+WVgK;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=HJE+WVgK;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeDSK2d (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 19 Apr 2018 06:28:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46252 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDSK2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Apr 2018 06:28:32 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] doc: dev-tools: kselftest.rst: update contributing new tests
Date: Thu, 19 Apr 2018 12:28:25 +0200
Message-Id: <20180419102825.2990-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417084631.11242-1-anders.roxell@linaro.org>
References: <20180417084631.11242-1-anders.roxell@linaro.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597982439415965732?=
X-GMAIL-MSGID: =?utf-8?q?1598170033359465498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a description that the kernel headers should be used as far as it is
possible and then the system headers.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 Documentation/dev-tools/kselftest.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index e80850eefe13..3bf371a938d0 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -151,6 +151,11 @@ Contributing new tests (details)
    TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
    test.
 
+ * First use the headers inside the kernel source and/or git repo, and then the
+   system headers.  Headers for the kernel release as opposed to headers
+   installed by the distro on the system should be the primary focus to be able
+   to find regressions.
+
 Test Harness
 ============
 
-- 
2.11.0

