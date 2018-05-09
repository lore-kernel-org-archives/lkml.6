Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZqLsfeARUYRCX0nrT7He9Cw37gZDSkMmSrAKoTpAPG1QUAizt2zhZ+xYEqdcucp2LBfFEdg
ARC-Seal: i=1; a=rsa-sha256; t=1525904273; cv=none;
        d=google.com; s=arc-20160816;
        b=NJNYm1ovaSd1Di45LxAF03GbEFGHuRtL6a/27LCtZhHEUrojD7lNRrOq9GVD0CKPsp
         O0BS+arh6/i1D7iRznvoJH5duZ+4+MFB8zar8S8o5m8EpapEqugCTn1UebsPl/0u8BbP
         zaBSf+Q/2F9p7pje6wxa3gKkTt7CKjwTl20HiE+dfxy+Qo7EcfyqGKsKK2gIgtlvenFa
         8s5cKWdznSWllALO2rEDTyjkM298+413HtXYn3TqBa7+xuGuFy7EZ3VQFlD40aC1zjGf
         jZHsU1C5hsQix0WU+cFRI3gPcvCZoXdxQkPf3MK2htevHF0zBEc4mKt1+EvKOaCywMC3
         ynOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=3gkvGRU/2ijuD4UVo68Xazv62f6W46nJPJ79/BR6Ubc=;
        b=iO2i4BXxXumdZvuxzBNSq6AYDpZ8+T8f8nJHmlJqn1EUI6aice+7UySUTGrYPBx+xn
         PzYQ9r2KNUXZh37h3ecoq4ykqOQWOXkc5WV8hJzyHcYbGViSRXyk7JjMFsK2XH7viCIU
         VDiCoJ1l63wtOQDAGSlcRgAKnd1cyE8SzMdqaxtJ285nda4tgHm6ligsW9WNCWoV049d
         ph5VzM3ZuE6oj03u1/IVlrVzUqtcOg28mperbyGqhAyICT0q5VsFwQVX02IpF+kU4+cN
         p4LbuejgM1XX/GBUk12ZB370EAYwwJWdPMMfS6oaG1WlyvZhgU3pDD0JGhw+Bc3iF9Kr
         ae6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=Oxkl/NjB;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.241.141 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=Oxkl/NjB;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.241.141 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: F1cELi8VM1lIacYsiTNSyVfBAG7oIxvT6mahGHc.O7PJSql1sXYJmbsjKasgOzW
 M8j6g7dSqizpiKty85ADR5RRG0BR7s4UTaAeUrUVpNaqHQh5TZ85DBr8Im4nKG5y7472ZNVXMFZ3
 pEOHVL1vwKvEWpYjSK6ID5qjBRK90KwwoHqzKYYd8OgQhmrBcgXRCqzyvjVOf7uL80G05wsu7bDx
 2fx.Z7XxnlQnBWftG8tap8nj76afywoJylF1asCS9F7WvcdxcibXrUiIldliY46o0P8kEvD66Xs6
 PcUlxhqCRSKRFxlRqM8NClGMQqxPbveNB8cjoH4ffj0xDNqJ.1LNmxqybIlPy74JVLaUCX_n8PWf
 TwXXuORqe4MKY6U.dwvyKbqK2w40BfXbLZxRgDzqL5ks6dG3AjrdEHvZi36OjoyQWoTyyYc7mgk8
 BBM3VPmhl5n7RLaFb6wSxt5J7Fwtnj32pOlhLCU4ws_XYJ_mknpEK_0oWtITuqFfje9lR1NTxQdp
 ZZBzozwSJvh5IsyXWeVUOoD4.IeLeToRA3FIYM7I6YMx47GYC0A--
From: Jeffrin Jose T <ahiliation@yahoo.co.in>
To: shuah@kernel.org,
	kstewart@linuxfoundation.org,
	daniel.diaz@linaro.org,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrin Jose T <ahiliation@yahoo.co.in>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftests: intel_pstate: Fixes for the testing script run.sh
Date: Thu, 10 May 2018 03:47:33 +0530
Message-Id: <20180509221733.15182-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600026599814016657?=
X-GMAIL-MSGID: =?utf-8?q?1600026599814016657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

fix for notification of permission requirement to run test.
fix for exit status value for test skipped.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/intel_pstate/run.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index c670359becc6..74983f74a9a1 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -30,6 +30,13 @@
 
 EVALUATE_ONLY=0
 
+msg="skip all tests:"
+
+if [ $UID != 0 ] && [ $EVALUATE_ONLY == 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	echo "$0 # Skipped: Test can only run on x86 architectures."
 	exit 0
-- 
2.17.0
