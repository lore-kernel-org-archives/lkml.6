Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49hm0mH3jYH8dUiumCRkSm5gkEXZhAWMJWgP98U5Ndho1NJ5JCL7IjxVXIVvzBympZxJXZM
ARC-Seal: i=1; a=rsa-sha256; t=1523954810; cv=none;
        d=google.com; s=arc-20160816;
        b=pI/VZAdzO9je1kH7/yn+fPVhRF38rUipRc9ue5UP4csji4MFXH8MOMJ8yJhcnWFhwO
         CQFtZansOUdNytdKP//Q0tY1zuHdhf51OdqlEVl8FYaZTGdd9hVDZQ/81TZsbrW/riBC
         u9CdwNvrA/O646Pr205ytp3STXRaFF9oU/vBNv8gwMg+QUTaAsfwogoS6NPA9GHq/7XO
         /2GTouVZ9rYrGFxAHh5CYKqbW2jBjBBTa00nVbFvzF62/xh0G/sbys49bUC7wF9dv3ME
         VtWsRDER9cfLM/86QvWQ9QhjirjGzQSjQ8U1b4RU5WaTvCm3iaUuqfGaZlz0vKiz9/Sc
         wRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=w6/aWsGN0YOYB/NI2L0glJgqmBg4UTqi/T+F2nXI9Fo=;
        b=xOjDflzIZG5SznPxfMw725Qvptr+RHZOn8GA2uU7rFLf92ZzTd4U1Ty2T5qkD+GzpD
         +sldA1JiRmeuXQX796/3UsxXs5pJSGb/SJD2JSpJYlncwO3+RwwdnF018HRhyD+jXBNm
         7VgCPVr8XKqsiw6DnySIKI6cKhCLpeTYVsy0Zy9obU++H1DDT/bnZY5nLdWA3EsFPZyI
         ryb/i2tC22Y3vU16WOCZbyIo7ReN9VGRciMreKdLEG24OffIAx5M8ze2E7+d7Bg5BeMM
         bi98uvDoediTWERh/HtPQW+dyrFdAGKqBOWWh3TW7HxcqxKuUzrrJjTaWFRWhxOlnPr9
         zwpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jv9+NAN8;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jv9+NAN8;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeDQIqi (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 17 Apr 2018 04:46:38 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44963 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDQIqh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Apr 2018 04:46:37 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] doc: dev-tools: kselftest.rst: update contributing new tests
Date: Tue, 17 Apr 2018 10:46:31 +0200
Message-Id: <20180417084631.11242-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597982439415965732?=
X-GMAIL-MSGID: =?utf-8?q?1597982439415965732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a description that the kernel headers should be used as far as it is
possible and then the system headers.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 Documentation/dev-tools/kselftest.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index e80850eefe13..27f08d6ba91c 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -151,6 +151,9 @@ Contributing new tests (details)
    TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
    test.
 
+ * First use the headers inside the kernel, and then the system headers. The
+   internal headers should be the primary focus to be able to find regressions.
+
 Test Harness
 ============
 
-- 
2.11.0

