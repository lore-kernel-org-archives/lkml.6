Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8288C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8484C20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SC09p8Qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8484C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeK3A7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:59:34 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK3A7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:59:33 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0F2B55A;
        Thu, 29 Nov 2018 14:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1543499644;
        bh=vgcpg16c7feL58nJj5xNLlkIlEdpoXkaWzaLwpnDXvI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SC09p8Qrv5mh7V5sZFqtx78rZWkEg03NMz9bCacY8Oq/ZHP9r4q4K05wFFcqkowqU
         XOc2l8KPGgcWLczKgPT26sN4ZAXbmpHnV7xoJ67tP2elzfeqgbPlc45dEo88dtsQSg
         pc+O/pilTsDkHYvlIvE9tIKvBnjRISCySTU/bN0Q=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        frowand.list@gmail.com, knut.omang@oracle.com,
        Felix Guo <felixguoxiuping@gmail.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
Date:   Thu, 29 Nov 2018 13:54:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128193636.254378-12-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

Thanks again for this series!

On 28/11/2018 19:36, Brendan Higgins wrote:
> The ultimate goal is to create minimal isolated test binaries; in the
> meantime we are using UML to provide the infrastructure to run tests, so
> define an abstract way to configure and run tests that allow us to
> change the context in which tests are built without affecting the user.
> This also makes pretty and dynamic error reporting, and a lot of other
> nice features easier.


I wonder if we could somehow generate a shared library object
'libkernel' or 'libumlinux' from a UM configured set of headers and
objects so that we could create binary targets directly ?


> kunit_config.py:
>   - parse .config and Kconfig files.
> 
> kunit_kernel.py: provides helper functions to:
>   - configure the kernel using kunitconfig.
>   - build the kernel with the appropriate configuration.
>   - provide function to invoke the kernel and stream the output back.
> 
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  tools/testing/kunit/.gitignore      |   3 +
>  tools/testing/kunit/kunit_config.py |  60 +++++++++++++
>  tools/testing/kunit/kunit_kernel.py | 126 ++++++++++++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 tools/testing/kunit/.gitignore
>  create mode 100644 tools/testing/kunit/kunit_config.py
>  create mode 100644 tools/testing/kunit/kunit_kernel.py
> 
> diff --git a/tools/testing/kunit/.gitignore b/tools/testing/kunit/.gitignore
> new file mode 100644
> index 0000000000000..c791ff59a37a9
> --- /dev/null
> +++ b/tools/testing/kunit/.gitignore
> @@ -0,0 +1,3 @@
> +# Byte-compiled / optimized / DLL files
> +__pycache__/
> +*.py[cod]
> \ No newline at end of file
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> new file mode 100644
> index 0000000000000..183bd5e758762
> --- /dev/null
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import collections
> +import re
> +
> +CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_\w+ is not set$'
> +CONFIG_PATTERN = r'^CONFIG_\w+=\S+$'
> +
> +KconfigEntryBase = collections.namedtuple('KconfigEntry', ['raw_entry'])
> +
> +
> +class KconfigEntry(KconfigEntryBase):
> +
> +	def __str__(self) -> str:
> +		return self.raw_entry
> +
> +
> +class KconfigParseError(Exception):
> +	"""Error parsing Kconfig defconfig or .config."""
> +
> +
> +class Kconfig(object):
> +	"""Represents defconfig or .config specified using the Kconfig language."""
> +
> +	def __init__(self):
> +		self._entries = []
> +
> +	def entries(self):
> +		return set(self._entries)
> +
> +	def add_entry(self, entry: KconfigEntry) -> None:
> +		self._entries.append(entry)
> +
> +	def is_subset_of(self, other: "Kconfig") -> bool:
> +		return self.entries().issubset(other.entries())
> +
> +	def write_to_file(self, path: str) -> None:
> +		with open(path, 'w') as f:
> +			for entry in self.entries():
> +				f.write(str(entry) + '\n')
> +
> +	def parse_from_string(self, blob: str) -> None:
> +		"""Parses a string containing KconfigEntrys and populates this Kconfig."""
> +		self._entries = []
> +		is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
> +		config_matcher = re.compile(CONFIG_PATTERN)
> +		for line in blob.split('\n'):
> +			line = line.strip()
> +			if not line:
> +				continue
> +			elif config_matcher.match(line) or is_not_set_matcher.match(line):
> +				self._entries.append(KconfigEntry(line))
> +			elif line[0] == '#':
> +				continue
> +			else:
> +				raise KconfigParseError('Failed to parse: ' + line)
> +
> +	def read_from_file(self, path: str) -> None:
> +		with open(path, 'r') as f:
> +			self.parse_from_string(f.read())
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> new file mode 100644
> index 0000000000000..bba7ea7ca1869
> --- /dev/null
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import logging
> +import subprocess
> +import os
> +
> +import kunit_config
> +
> +KCONFIG_PATH = '.config'
> +
> +class ConfigError(Exception):
> +	"""Represents an error trying to configure the Linux kernel."""
> +
> +
> +class BuildError(Exception):
> +	"""Represents an error trying to build the Linux kernel."""
> +
> +
> +class LinuxSourceTreeOperations(object):
> +	"""An abstraction over command line operations performed on a source tree."""
> +
> +	def make_mrproper(self):
> +		try:
> +			subprocess.check_output(['make', 'mrproper'])
> +		except OSError as e:
> +			raise ConfigError('Could not call make command: ' + e)
> +		except subprocess.CalledProcessError as e:
> +			raise ConfigError(e.output)
> +
> +	def make_olddefconfig(self):
> +		try:
> +			subprocess.check_output(['make', 'ARCH=um', 'olddefconfig'])
> +		except OSError as e:
> +			raise ConfigError('Could not call make command: ' + e)
> +		except subprocess.CalledProcessError as e:
> +			raise ConfigError(e.output)
> +
> +	def make(self, jobs):
> +		try:
> +			subprocess.check_output([
> +					'make',
> +					'ARCH=um',
> +					'--jobs=' + str(jobs)])

Perhaps as a future extension:

It would be nice if we could set an O= here to keep the source tree
pristine.

In fact I might even suggest that this should always be set so that the
unittesting could live along side an existing kernel build? :

 O ?= $KBUILD_SRC/
 O := $(O)/kunittest/$(ARCH)/build


> +		except OSError as e:
> +			raise BuildError('Could not call execute make: ' + e)
> +		except subprocess.CalledProcessError as e:
> +			raise BuildError(e.output)
> +
> +	def linux_bin(self, params, timeout):
> +		"""Runs the Linux UML binary. Must be named 'linux'."""
> +		process = subprocess.Popen(
> +			['./linux'] + params,
> +			stdin=subprocess.PIPE,
> +			stdout=subprocess.PIPE,
> +			stderr=subprocess.PIPE)
> +		process.wait(timeout=timeout)
> +		return process
> +
> +
> +class LinuxSourceTree(object):
> +	"""Represents a Linux kernel source tree with KUnit tests."""
> +
> +	def __init__(self):
> +		self._kconfig = kunit_config.Kconfig()
> +		self._kconfig.read_from_file('kunitconfig')
> +		self._ops = LinuxSourceTreeOperations()
> +
> +	def clean(self):
> +		try:
> +			self._ops.make_mrproper()
> +		except ConfigError as e:
> +			logging.error(e)
> +			return False
> +		return True
> +
> +	def build_config(self):
> +		self._kconfig.write_to_file(KCONFIG_PATH)
> +		try:
> +			self._ops.make_olddefconfig()
> +		except ConfigError as e:
> +			logging.error(e)
> +			return False
> +		validated_kconfig = kunit_config.Kconfig()
> +		validated_kconfig.read_from_file(KCONFIG_PATH)
> +		if not self._kconfig.is_subset_of(validated_kconfig):
> +			logging.error('Provided Kconfig is not contained in validated .config!')
> +			return False
> +		return True
> +
> +	def build_reconfig(self):
> +		"""Creates a new .config if it is not a subset of the kunitconfig."""
> +		if os.path.exists(KCONFIG_PATH):
> +			existing_kconfig = kunit_config.Kconfig()
> +			existing_kconfig.read_from_file(KCONFIG_PATH)
> +			if not self._kconfig.is_subset_of(existing_kconfig):
> +				print('Regenerating .config ...')
> +				os.remove(KCONFIG_PATH)
> +				return self.build_config()
> +			else:
> +				return True
> +		else:
> +			print('Generating .config ...')
> +			return self.build_config()
> +
> +	def build_um_kernel(self, jobs):
> +		try:
> +			self._ops.make_olddefconfig()
> +			self._ops.make(jobs)
> +		except (ConfigError, BuildError) as e:
> +			logging.error(e)
> +			return False
> +		used_kconfig = kunit_config.Kconfig()
> +		used_kconfig.read_from_file(KCONFIG_PATH)
> +		if not self._kconfig.is_subset_of(used_kconfig):
> +			logging.error('Provided Kconfig is not contained in final config!')
> +			return False
> +		return True
> +
> +	def run_kernel(self, args=[]):
> +		timeout = None
> +		args.extend(['mem=256M'])
> +		process = self._ops.linux_bin(args, timeout)
> +		with open('test.log', 'w') as f:
> +			for line in process.stdout:
> +				f.write(line.rstrip().decode('ascii') + '\n')
> +				yield line.rstrip().decode('ascii')
> 

-- 
Regards
--
Kieran
