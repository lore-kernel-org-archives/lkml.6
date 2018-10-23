Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D28C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1C8206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="As0auclp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1C8206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJXMBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:01:11 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:34209 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJXMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:01:11 -0400
Received: by mail-io1-f74.google.com with SMTP id c7-v6so2941374iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1Y1b8SBui5i1WbPU04wJ7c/lG6pCNlRxFnkrizObCeA=;
        b=As0auclpd/NIt3dM9mMPBD/uCGZ0MI8Mf2Z+ndD/aeTAHO+0cIRzabKP/1dBVpEzYR
         jaJNJEEgupFWvhxBW1ZFR2QCPfebZ9fsbnl2V+uPMapkcLcDdq80Uace+NaWN9RbZUmH
         Siyy801iwcJZ7xdJDd5pRlLiNwlyF1UM/s46l8mKOkRPYnAtrqxvKnvIo5IuxOvV5IDI
         TEVRJdcyWAoiiVRHudOz6o5Ou3Kf9Mt5dLoRZ++hMRPfH7u1sOYG8a8gs8mV0curjifG
         zzEi+fdAR/eGedKvXuRaNF1xbmxQxjqTPkBZ2CKsxe8ObLw3NQ916S5J9AiIAIOVTbzK
         OleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Y1b8SBui5i1WbPU04wJ7c/lG6pCNlRxFnkrizObCeA=;
        b=FjL003HAv4Vf1y3Q5MZla6ybqWs30VsWSXdjLOqBmubc0xxayOd01Ga27UTD8cshQg
         Cf/EDIlEjvkahLo1ut/01W4mVctgYcNnQO7By4Pnxy08tBWzKqeNKhoiMy6vR/eie1oX
         6u8eHkLPmvjSmWvMWwoUJT+7JKXZ/lFmceF3cjO9MGBlk+IyMafz6jYdlSfDlUN2klL9
         lW279MUvtyH85UBBP8g5DP+T9oOIgKP0Lau1ehQ1G10gY8V3ibkEK+6HGRWnj7XuOLez
         A+cmRzzop58uIi9QYzsfCjgteu50ppjSMKKvJeeM+CWIoKVddLl2m5cOh9pUMbK2s/2T
         rSnA==
X-Gm-Message-State: AGRZ1gJQLAs5XioTVsLgp3ZXIrpvci6+pi4oO3xAVYAr/JGLFGxgfseA
        XCt4wSeJZhxsbdRxPHVPVnGjaP0WLubCO+p3MBu+sA==
X-Google-Smtp-Source: AJdET5eXl1RwBiR99b11tNC4/XTHuL0sUXlN+y5MByENeFpAD1IyxTAYzInomACClGoK5g3C0qlTiAP7/J3EQb2YhWkWwg==
X-Received: by 2002:a24:4dc2:: with SMTP id l185-v6mr251352itb.28.1540339202564;
 Tue, 23 Oct 2018 17:00:02 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:57:46 -0700
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
Message-Id: <20181023235750.103146-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC v2 10/14] kunit: add Python libraries for handing KUnit config
 and kernel
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ultimate goal is to create minimal isolated test binaries; in the
meantime we are using UML to provide the infrastructure to run tests, so
define an abstract way to configure and run tests that allow us to
change the context in which tests are built without affecting the user.
This also makes pretty and dynamic error reporting, and a lot of other
nice features easier.

kunit_config.py:
  - parse .config and Kconfig files.

kunit_kernel.py: provides helper functions to:
  - configure the kernel using kunitconfig.
  - build the kernel with the appropriate configuration.
  - provide function to invoke the kernel and stream the output back.

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
2.19.1.568.g152ad8e336-goog

