Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225gHAIrabjVqfMkyUssR4rr5qzOi7y1r8XJ5/+V9vR8417fvdQpI8wSklTXPMKvHjOkfp7A
ARC-Seal: i=1; a=rsa-sha256; t=1517877396; cv=none;
        d=google.com; s=arc-20160816;
        b=VOQJ638mQVJ1p15U3Zjz3dymkDgxMvBGHYZo1Kh9+4Ecm8LJlB2tFiIBuR5AoVD94A
         QsoMBZaNgmNRLMWSjCIk3iRQDf9ks4F5ZGMwplReIqzGmFo78D1nNpmVdKwWOFUDWKJg
         siZ9/Xb0TlbMRCMsKIwi00fjqIdjHsNJN7fDUmPBa6WwkKQWvpxGrjaWnDLPt4s5CSAi
         wNUDAAWPCeiUafZEI4sC7BpPle6RwySRmCBUQ+Gsi7SycyaOyyerpmz9zSY97SPXPHbS
         nhrZUo3H74g6prxvRsyKvJ7PXjhMRRQUyyEdp4fRW1Uv7VEq8dUS6FrLXmpk6GlXdat2
         f6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=e+bBRzoO0V5YQsvcXSf66n+mUtbbyoF3YBYC04GSbmY=;
        b=nAf6Y6bQv2R3w8T6jF47AkrcRf4RRVey1CHx1a2nMZwgUa3TPoi8jP5yZMTrfIkbNs
         HW/tY75raB4l7znv0R35eCCS7PDbX4tl9khWnYhaECN9hGnszZ7gluREfzzgOb6vV5xv
         nOb0iCWvLNczu4nHWMnhpkJTaaJXVUXsnSq/2/Evve/o9ZMKpC1DK3jl2aEO19SnaJl3
         4K32C+VxFcHBrtUrb0WYC+/l4BWwLDXlr/DyywGMMNr6OiqLJdnUJBhOeaBTKhKXvTcv
         6ecslMfDEg6RYKJ9rr9XA3Z16xQDhVlXTjp4n1vJ0wKxhHKKdK1LOR2++2ZB7UkKMvtU
         kbtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hK/ZFrNh;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hK/ZFrNh;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAt011351
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] kconfig: test: check if recursive inclusion is detected
Date: Tue,  6 Feb 2018 09:34:54 +0900
Message-Id: <1517877294-4826-15-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609808664876806?=
X-GMAIL-MSGID: =?utf-8?q?1591609808664876806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If recursive inclusion is detected, it should fail with error messages.
Test this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/tests/err_recursive_inc/Kconfig         |  1 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc     |  1 +
 scripts/kconfig/tests/err_recursive_inc/__init__.py     | 10 ++++++++++
 scripts/kconfig/tests/err_recursive_inc/expected_stderr |  4 ++++
 4 files changed, 16 insertions(+)
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/__init__.py
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/expected_stderr

diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig b/scripts/kconfig/tests/err_recursive_inc/Kconfig
new file mode 100644
index 0000000..3ce7a3f
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig
@@ -0,0 +1 @@
+source "Kconfig.inc"
diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc b/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
new file mode 100644
index 0000000..1fab1c1
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
@@ -0,0 +1 @@
+source "Kconfig"
diff --git a/scripts/kconfig/tests/err_recursive_inc/__init__.py b/scripts/kconfig/tests/err_recursive_inc/__init__.py
new file mode 100644
index 0000000..1dae64f
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/__init__.py
@@ -0,0 +1,10 @@
+"""
+Detect recursive inclusion error
+================================
+
+If recursive inclusion is detected, it should fail with error messages.
+"""
+
+def test(conf):
+    assert conf.oldaskconfig() != 0
+    assert conf.stderr_contains('expected_stderr')
diff --git a/scripts/kconfig/tests/err_recursive_inc/expected_stderr b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
new file mode 100644
index 0000000..b256c91
--- /dev/null
+++ b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
@@ -0,0 +1,4 @@
+Kconfig:1: recursive inclusion detected. Inclusion path:
+  current file : 'Kconfig'
+  included from: 'Kconfig.inc:1'
+  included from: 'Kconfig:3'
-- 
2.7.4
