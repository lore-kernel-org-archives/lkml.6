Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225jTJSw+TTUWbnCxKEtqUPiLIL76GGOaqMtrAuPmF5SlOQF0YvfDWtuuZkH1nccsLPoYfsR
ARC-Seal: i=1; a=rsa-sha256; t=1519248608; cv=none;
        d=google.com; s=arc-20160816;
        b=RCeSVWqrsDFL+IMtbyeQyOww6vhT6VXZh951glDaYEbj/0nMqhOXIlmW0AzITNP4Tp
         k2UGc6T8Eo5Bysa44LpEYHvhNSF3z1AtstzN/R03rdhNtdT/v70Omy/4KUPfVEESICtk
         e8SFHNl0BmOVlfCpeMeNiGVw7M/NJtWj8pQOJ5632TG/K0pDSzNUj2zLDSmlAXbVbEwi
         tVohxXZBzuu1G9VWR9PmW09WPcHSfrtGs/g8B3VwAAMz0jeILje3bp3kF+UBMDZeHNuw
         OHDvw4ZSb2jd6ZclZXwLwA0CqL77GQnJ0XyGFbZfAoSqMSOMfGJi4cD9OsZPwW0ZKweV
         NJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bKbROBt8bro/1R7RuI7l8xvlAs029waLbPu46IxcIqY=;
        b=Edfm1SdqfhBfv4Pz56xOyfnWZ4j8gTn54Ab2f6gE1jJ2JIAJ0JCK1nfF/3kbRhKV3Z
         iaFkZAw/mvA4ESvUCw2swJbM47cUr3VqDlFxkApLht1HK8tf2u48vEYIdq2fR6fWW6iT
         S0t/nGB3FN/HxCWoXF6MSC2SSMsLX2ibzSfDmsDDmBGwPp1iFaNlsz7bWk9vKHYqwPwT
         GcaiG7OMBsJsC2othWZiFSE0gobX1/9tOmyP9fIbzmNtXLPksu9A9gqBhaCXLc179qfp
         3V6xFii8AJyufZnstm9stGbZ/ZteNJRg3mpkYk0GnC8zKwhj6YHFR/IswEwPrJkAvzLu
         LHuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=gXEqqTwU;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=gXEqqTwU;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeBUVaH (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 16:30:07 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39654 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUVaG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 16:30:06 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/bpf: update gitignore with test_libbpf_open
Date: Wed, 21 Feb 2018 22:30:01 +0100
Message-Id: <20180221213001.18682-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593047628966433611?=
X-GMAIL-MSGID: =?utf-8?q?1593047628966433611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

bpf builds a test program for loading BPF ELF files. Add the executable
to the .gitignore list.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index cc15af2e54fe..9cf83f895d98 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -11,3 +11,4 @@ test_progs
 test_tcpbpf_user
 test_verifier_log
 feature
+test_libbpf_open
-- 
2.11.0

