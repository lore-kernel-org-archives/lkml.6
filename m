Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C6A2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBrFvPu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C6A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJQHrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:46 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50905 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbeJQHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:45 -0400
Received: by mail-qk1-f202.google.com with SMTP id 142-v6so1061303qkn.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4xqp6vFemfXW8THZIer615fzQIJFwGYlGopIVPlWEZU=;
        b=BBrFvPu6rMmaVi30GrjwrXOOL8LtR+BGznO8B6Lu7/D0K7Rxmkg7bSDYdO0W37ggd6
         KUNSubXNekqIeyP7oqpcPSpGI0mcv6Vtw2I5Z3936kap9Ya6W1ZImCRBoHm8wueyJwFs
         n3DXvsdpVwzqIG6E5uoEIgwtyv44VHSz4lAto6aCW+jm0k6tzCeeR55BZmH2pd3RGt4g
         JcdwDvt19oZbFzthf6WjznwYRdU7Wo4RSSdCEfrnbjAXW9y9Kzjl6Y+tfZ7jDte0Y1Zr
         7s2y2yF6SPkihHyj/U3+03bMRJrvXI/JB2rc/uNM0cpzs9K2a3FRYrGnf1rSvlzbT2SQ
         qbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4xqp6vFemfXW8THZIer615fzQIJFwGYlGopIVPlWEZU=;
        b=OJ5Ygi9btWbFQ2BRR/ELyJYRdiYjqYok5CDJCu3qsRear5Ft/LjnbS7Hm5k7PUQhwY
         lOj9q6rET2p1EEtY2YQKT0xtA+TYq4xfPv8vv7TmcncEClsmsGtKd9P2I6F6DWaCywNg
         lpmmafIMSJPBg/kRYyp7QPXyOHE8X7QDMOgsfbYetfdBwZxgo56RbjB3nVUVML5+TEjX
         ckkeAV2RSa2jdCwOBP/y0k0Tp3xpUcygiqKddPjp1ze2khv2C0B/tnIUIa/jSCdET+yi
         +fyb7DvQei3SVn6z6YoldzqSNYDeNnOhRpjtEz63RlJJGD8oWg8kk0ukEabbpGLnbQtG
         gqaA==
X-Gm-Message-State: ABuFfogrVo/wV7JYpM7Z/MuZkgw+/kTpn2n9UAOOXnsZem6uSdST+sWX
        yNdas0N8sKrGAsf1CiQfD+Fui31ciY12PY2FQy/n1g==
X-Google-Smtp-Source: ACcGV61ZHBmusrNthEsvEz3NbEV4FbUz7HloQ+nhCM0P9R1x78s+c2LlynbGJcX007Ruj/zTWK2lQyTYOoSWK9tR8t8v0Q==
X-Received: by 2002:a0c:c13b:: with SMTP id f56mr20378309qvh.11.1539734094801;
 Tue, 16 Oct 2018 16:54:54 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:17 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-29-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 28/31] kunit: added Python libraries for handing KUnit config
 and kernel
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kunit_config.py:
  - parses .config and Kconfig files

kunit_kernel.py: provides helper functions to:
  - configure the kernel using kunitconfig
  - builds the kernel with the correct architecture
  - provides function to invoke the kernel and stream the output back

The kernel invocation is wrapped in a subprocess call within the module
because regular invocation of the kernel (./linux) may modify TTY
settings.

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/.gitignore      |   3 +
 tools/testing/kunit/kunit_config.py |  60 ++++++++++++++
 tools/testing/kunit/kunit_kernel.py | 123 ++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 tools/testing/kunit/.gitignore
 create mode 100644 tools/testing/kunit/kunit_config.py
 create mode 100644 tools/testing/kunit/kunit_kernel.py

diff --git a/tools/testing/kunit/.gitignore b/tools/testing/kunit/.gitignore
new file mode 100644
index 0000000000000..c791ff59a37a9
--- /dev/null
+++ b/tools/testing/kunit/.gitignore
@@ -0,0 +1,3 @@
+# Byte-compiled / optimized / DLL files
+__pycache__/
+*.py[cod]
\ No newline at end of file
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
new file mode 100644
index 0000000000000..183bd5e758762
--- /dev/null
+++ b/tools/testing/kunit/kunit_config.py
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import collections
+import re
+
+CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_\w+ is not set$'
+CONFIG_PATTERN = r'^CONFIG_\w+=\S+$'
+
+KconfigEntryBase = collections.namedtuple('KconfigEntry', ['raw_entry'])
+
+
+class KconfigEntry(KconfigEntryBase):
+
+	def __str__(self) -> str:
+		return self.raw_entry
+
+
+class KconfigParseError(Exception):
+	"""Error parsing Kconfig defconfig or .config."""
+
+
+class Kconfig(object):
+	"""Represents defconfig or .config specified using the Kconfig language."""
+
+	def __init__(self):
+		self._entries = []
+
+	def entries(self):
+		return set(self._entries)
+
+	def add_entry(self, entry: KconfigEntry) -> None:
+		self._entries.append(entry)
+
+	def is_subset_of(self, other: "Kconfig") -> bool:
+		return self.entries().issubset(other.entries())
+
+	def write_to_file(self, path: str) -> None:
+		with open(path, 'w') as f:
+			for entry in self.entries():
+				f.write(str(entry) + '\n')
+
+	def parse_from_string(self, blob: str) -> None:
+		"""Parses a string containing KconfigEntrys and populates this Kconfig."""
+		self._entries = []
+		is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
+		config_matcher = re.compile(CONFIG_PATTERN)
+		for line in blob.split('\n'):
+			line = line.strip()
+			if not line:
+				continue
+			elif config_matcher.match(line) or is_not_set_matcher.match(line):
+				self._entries.append(KconfigEntry(line))
+			elif line[0] == '#':
+				continue
+			else:
+				raise KconfigParseError('Failed to parse: ' + line)
+
+	def read_from_file(self, path: str) -> None:
+		with open(path, 'r') as f:
+			self.parse_from_string(f.read())
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
new file mode 100644
index 0000000000000..87abaede50513
--- /dev/null
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import logging
+import subprocess
+import os
+
+import kunit_config
+
+KCONFIG_PATH = '.config'
+
+class ConfigError(Exception):
+	"""Represents an error trying to configure the Linux kernel."""
+
+
+class BuildError(Exception):
+	"""Represents an error trying to build the Linux kernel."""
+
+
+class LinuxSourceTreeOperations(object):
+	"""An abstraction over command line operations performed on a source tree."""
+
+	def make_mrproper(self):
+		try:
+			subprocess.check_output(['make', 'mrproper'])
+		except OSError as e:
+			raise ConfigError('Could not call make command: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+	def make_olddefconfig(self):
+		try:
+			subprocess.check_output(['make', 'ARCH=um', 'olddefconfig'])
+		except OSError as e:
+			raise ConfigError('Could not call make command: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+	def make(self):
+		try:
+			subprocess.check_output(['make', 'ARCH=um'])
+		except OSError as e:
+			raise BuildError('Could not call execute make: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise BuildError(e.output)
+
+	def linux_bin(self, params, timeout):
+		"""Runs the Linux UML binary. Must be named 'linux'."""
+		process = subprocess.Popen(
+			['./linux'] + params,
+			stdin=subprocess.PIPE,
+			stdout=subprocess.PIPE,
+			stderr=subprocess.PIPE)
+		process.wait(timeout=timeout)
+		return process
+
+
+class LinuxSourceTree(object):
+	"""Represents a Linux kernel source tree with KUnit tests."""
+
+	def __init__(self):
+		self._kconfig = kunit_config.Kconfig()
+		self._kconfig.read_from_file('kunitconfig')
+		self._ops = LinuxSourceTreeOperations()
+
+	def clean(self):
+		try:
+			self._ops.make_mrproper()
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		return True
+
+	def build_config(self):
+		self._kconfig.write_to_file(KCONFIG_PATH)
+		try:
+			self._ops.make_olddefconfig()
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(KCONFIG_PATH)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			logging.error('Provided Kconfig is not contained in validated .config!')
+			return False
+		return True
+
+	def build_reconfig(self):
+		"""Creates a new .config if it is not a subset of the kunitconfig."""
+		if os.path.exists(KCONFIG_PATH):
+			existing_kconfig = kunit_config.Kconfig()
+			existing_kconfig.read_from_file(KCONFIG_PATH)
+			if not self._kconfig.is_subset_of(existing_kconfig):
+				print('Regenerating .config ...')
+				os.remove(KCONFIG_PATH)
+				return self.build_config()
+			else:
+				return True
+		else:
+			print('Generating .config ...')
+			return self.build_config()
+
+	def build_um_kernel(self):
+		try:
+			self._ops.make_olddefconfig()
+			self._ops.make()
+		except (ConfigError, BuildError) as e:
+			logging.error(e)
+			return False
+		used_kconfig = kunit_config.Kconfig()
+		used_kconfig.read_from_file(KCONFIG_PATH)
+		if not self._kconfig.is_subset_of(used_kconfig):
+			logging.error('Provided Kconfig is not contained in final config!')
+			return False
+		return True
+
+	def run_kernel(self, args=[]):
+		timeout = None
+		args.extend(['mem=256M'])
+		process = self._ops.linux_bin(args, timeout)
+		with open('test.log', 'w') as f:
+			for line in process.stdout:
+				f.write(line.rstrip().decode('ascii') + '\n')
+				yield line.rstrip().decode('ascii')
-- 
2.19.1.331.ge82ca0e54c-goog

