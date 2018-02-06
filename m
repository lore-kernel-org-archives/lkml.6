Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2250E5wcd70dYf4aFiWdsrAbqmJUYGahqPQujaDIOLkJdNUmKJjGwzf0zWyOq2HYuRjVAdgh
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=UKdsK1HCX6zTt7Z9Akm52WoLmgRUU18ry6q+3TneUaK6wBAZHPoZHzx5pWGUD/2FzN
         nAKLzRtRhpIRJQOCFsbQNU5d+EY8yp+TMtGfbRtk1bkZPpCzvq+UDSRq11cXgbCDxyii
         FLVoxA7lxrcuV/G9J07LOm4VfRIbKRJ4Z/xzfHrvH1h5F6qbTSI2XWwTpAC09KODZsBY
         5tnSSsQ8LrJKXGn2l87O3Cf6u9prwWAI2sNVEE4Pmul82JCcO6p/STKOrzTU9Wy1winy
         LwPyTo5rahX1PXMUev82X+AGl/rNLRj/Ldw5wrXHi+PTJKE/sMDEfwbYjUeA50GZqcz/
         6h0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=UyG2oZNDTZKIRYq2fA34r4g+n0Fl50xMf4w/++5QxVI=;
        b=wFmZuA2cjsCcxDH9+QvCxsKEuWenxXpmmKk8uM6/qYSTG1e6raSOyFxd1lxiZgxX0l
         bDmxjVoBWGesiBG5t200E3oyxCgMMbzzagemZaEaqWQ4gTTFERiXtrTZLVy6i7ao5oaj
         6NY3+Iq32G5asE4KC7nUyxvyLZTWW1QEXTRy6FbOJSjtKcKNPNNaA0xzpV1tPBGg6M8c
         oVcG7I2Jkw2wIcW+/JbVdEUvMCDnXqFTrTMcr54CHKwhaIZ5PaDgCTCvUR0FI5nL930V
         qEzC6ZCwIwyP2pQvsS5Pc4pzzEMLEywf66+gWPlQo7gNe+GeMDbsc7WFn0xfaqknOE+U
         ZiWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QXlow55/;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QXlow55/;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAp011351
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
Subject: [PATCH 10/14] kconfig: test: check if new symbols in choice are asked
Date: Tue,  6 Feb 2018 09:34:50 +0900
Message-Id: <1517877294-4826-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778323035647?=
X-GMAIL-MSGID: =?utf-8?q?1591609778323035647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If new choice values are added with new dependency, and they become
visible during user configuration, oldconfig should recognize them
as (NEW), and ask the user for choice.

This issue was fixed by commit 5d09598d488f ("kconfig: fix new choices
being skipped upon config update").

This is a subtle corner case.  Add a test case to avoid breakage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/tests/new_choice_with_dep/Kconfig  | 37 ++++++++++++++++++++++
 .../kconfig/tests/new_choice_with_dep/__init__.py  | 14 ++++++++
 scripts/kconfig/tests/new_choice_with_dep/config   |  3 ++
 .../tests/new_choice_with_dep/expected_stdout      | 10 ++++++
 4 files changed, 64 insertions(+)
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/config
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/expected_stdout

diff --git a/scripts/kconfig/tests/new_choice_with_dep/Kconfig b/scripts/kconfig/tests/new_choice_with_dep/Kconfig
new file mode 100644
index 0000000..53ef1b8
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/Kconfig
@@ -0,0 +1,37 @@
+config A
+	bool "A"
+	help
+	  This is a new symbol.
+
+choice
+	prompt "Choice ?"
+	depends on A
+	help
+	  "depends on A" has been newly added.
+
+config CHOICE_B
+	bool "Choice B"
+
+config CHOICE_C
+	bool "Choice C"
+	help
+	  This is a new symbol, so should be asked.
+
+endchoice
+
+choice
+	prompt "Choice2 ?"
+
+config CHOICE_D
+	bool "Choice D"
+
+config CHOICE_E
+	bool "Choice E"
+
+config CHOICE_F
+	bool "Choice F"
+	depends on A
+	help
+	  This is a new symbol, so should be asked.
+
+endchoice
diff --git a/scripts/kconfig/tests/new_choice_with_dep/__init__.py b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
new file mode 100644
index 0000000..4306ccf
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
@@ -0,0 +1,14 @@
+"""
+Ask new choice values when they become visible
+==============================================
+
+If new choice values are added with new dependency, and they become
+visible during user configuration, oldconfig should recognize them
+as (NEW), and ask the user for choice.
+
+Related Linux commit: 5d09598d488f081e3be23f885ed65cbbe2d073b5
+"""
+
+def test(conf):
+    assert conf.oldconfig('config', 'y') == 0
+    assert conf.stdout_contains('expected_stdout')
diff --git a/scripts/kconfig/tests/new_choice_with_dep/config b/scripts/kconfig/tests/new_choice_with_dep/config
new file mode 100644
index 0000000..47ef95d
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/config
@@ -0,0 +1,3 @@
+CONFIG_CHOICE_B=y
+# CONFIG_CHOICE_D is not set
+CONFIG_CHOICE_E=y
diff --git a/scripts/kconfig/tests/new_choice_with_dep/expected_stdout b/scripts/kconfig/tests/new_choice_with_dep/expected_stdout
new file mode 100644
index 0000000..358d5cf
--- /dev/null
+++ b/scripts/kconfig/tests/new_choice_with_dep/expected_stdout
@@ -0,0 +1,10 @@
+A (A) [N/y/?] (NEW) 
+  Choice ?
+  > 1. Choice B (CHOICE_B)
+    2. Choice C (CHOICE_C) (NEW)
+  choice[1-2?]: 
+Choice2 ?
+  1. Choice D (CHOICE_D)
+> 2. Choice E (CHOICE_E)
+  3. Choice F (CHOICE_F) (NEW)
+choice[1-3?]: 
-- 
2.7.4
