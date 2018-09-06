Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B1EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC3C2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jBZx93Mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC3C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIFUjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:39:43 -0400
Received: from mail.efficios.com ([167.114.142.138]:41870 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIFUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:39:41 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6A5511C5420;
        Thu,  6 Sep 2018 12:03:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 5Ph2uvetTrlf; Thu,  6 Sep 2018 12:03:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B125B1C541B;
        Thu,  6 Sep 2018 12:03:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B125B1C541B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1536249809;
        bh=HY9tXowjk7ffpZxIzy4mBvpOYg7d+jUHl6EnkL3HYBU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jBZx93MvrAoLmgusCRuTVUZ/mJpPaLCM2YgbyTfb+bEj7CjM2noylRMCBrfekpxBD
         ro0LzqBaiozKd66bjUnbrb8SvyN6JekW+jtfTwHccYBFaVckZ1QCnM81hR1gfUvNsq
         s7cTh4NwYDtooFc1OwOX+I84hvLlYEkYHN5YOXnXHASyqa2BlcITtiIW1+FxMJ1Fiu
         58nGKUJk1VMCYNkHFGO6yBjkPQadcsWJE8eGcJ/0KucpuVVkMCk+TZwfiUZam9D1VN
         srsSXEpPz3ocaskaJNkEsz+Rd017J/lfh3ZDvwVO+1BD1ni0fZRR+LjW3cn4gGtrlq
         J23K2/R3d8BPw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dLV7Y3iR3V7r; Thu,  6 Sep 2018 12:03:29 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9F6971C53EC;
        Thu,  6 Sep 2018 12:03:29 -0400 (EDT)
Date:   Thu, 6 Sep 2018 12:03:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <650389638.9188.1536249809628.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-UST 2.11.0-rc1 (Linux user-space tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_3006 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_3006)
Thread-Index: 2QRgt/u34CkOgFpPYHyhbSsV9vN/YA==
Thread-Topic: LTTng-UST 2.11.0-rc1 (Linux user-space tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the first release candidate of LTTng-UST 2.11 Linux
user-space tracer.

This release is named after a modern Saison beer from Montr=C3=A9al's Oshla=
g
microbrewery. It is a refreshing, zesty, rice beer with hints of fruit and
spices. Some even say it makes for a great Somaek when mixed with Chamisul
Soju, not that we've tried!

Lafontaine is also a tongue-in-cheek reference to a water leak that
affected EfficiOS's offices during the development of this release.

The most notable features of this new release that apply to lttng-ust
are:

  - Introduce the LTTNG_UST_ALLOW_BLOCKING environment variable,
  - Take NUMA configuration into account for UST buffer allocation,
  - Support unloading of probe providers (dlclose),
  - Session rotation,
  - Support for arrays and bitwise binary operators in filters.

The new LTTNG_UST_ALLOW_BLOCKING env. var. can be used with the
'--blocking-timeout' channel parameter to allow tracing to block
the application (or wait for a specified timeout) when buffers are
full. This is useful when dealing with very high throughput tracing
workloads. See lttng-ust(3) and lttng-enable-channel(1) for details.

See the lttng-tools release tag for more information about session
rotation, as well as support for arrays and bitwise binary operators
in filters at: https://github.com/lttng/lttng-tools/releases/tag/v2.11.0-rc=
1

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:
2018-09-06 (Fight Procrastination Day) lttng-ust 2.11.0-rc1
        * Fix: add missing stdbool.h include
        * Move symbol preventing unloading of probe providers
        * Fix: Remove unused line from liblttng-ust-fd makefile
        * Fix: add liblttng-ust dependency to liblttng-ust-fd
        * Fix: use LIBDL/LIBC_DL to select either libdl or libc
        * Fix: lttng filter validator ERANGE error handling
        * Filter: implement dynamic typing for load object
        * Filter: add FILTER_OP_RETURN_S64 instruction
        * Perform bitwise ops on unsigned types
        * Filter: catch shift undefined behavior
        * Filter: implement bitwise lshift, rshift, not
        * Filter: index array, sequences, implement bitwise binary operator=
s
        * Fix: AM_CONDITIONAL should be outside AS_IF block
        * Fix: build jni libs with openjdk >=3D 10
        * Fix: ustfork: save and restore errno in syscall wrappers
        * Fix: cache the result of getpid() internally
        * Fix: reset cached vpid context on fork
        * Fix: build example SO when PIE is enabled
        * Fix: string comparison on incorrect length in context provider
        * Support unloading of probe providers
        * Rename lttng_ust_enum_get to lttng_ust_enum_get_from_desc
        * dlopen() liblttng-ust.so from constructor to prevent unloading
        * Add probe provider unregister function
        * Cleanup: Move version numbers in separate variables in configure =
script
        * Remove duplicate provider name checks
        * Fix: remove for() loop initial declarations
        * Use ust_lock during sock_info operations for atomicity against fo=
rk
        * Force tracked fd to be bigger than STDERR_FILENO
        * Fix: numa: dynamically check that numa is available
        * Fix: specify SONAME in python-lttngust LoadLibrary
        * Fix: ensure fd tracker is initialized when called from constructo=
rs
        * Fix: fd of an elf object must be registered to the fd tracker
        * Cleanup: clock description for metadata was moved to lttng-sessio=
nd
        * Fix: liblttng-ust-fd.so: override fclose symbol
        * Revert "Use initial-exec TLS model"
        * Revert "Fix: typo: DECLARE_URCU_TLS_IE -> DEFINE_URCU_TLS_IE"
        * configure.ac: add --disable-examples option to not build/install =
examples
        * Disable NUMA by default on 32bit arm
        * Update Makefile.am output about libnuma not found
        * Update readme to document opt dep on numa
        * numa support: allow disabling numa support
        * Update README to document dependency on libnuma
        * Take NUMA configuration into account for UST buffer allocation
        * Fix: typo: DECLARE_URCU_TLS_IE -> DEFINE_URCU_TLS_IE
        * Use initial-exec TLS model
        * lttng-gen-tp: formatting
        * Fix: lttng-gen-tp: only replace file extension
        * Fix: move fsync after ftruncate
        * Fix: sync buffer file metadata on buffer allocation
        * lttng-ust(3): reword and fix style of `LTTNG_UST_ALLOW_BLOCKING` =
variable
        * lttng-ust(3): specify "If set" instead of "if set to 1" for some =
variables
        * Fix: doc/man: use a single XSL file and match local names
        * Fix: Expand the shmobj size for the sequence number
        * Introduce LTTNG_UST_ALLOW_BLOCKING env. var.
        * Fix: lttng-ust-elf.c: define NT_GNU_BUILD_ID if not defined
        * Calculate context length outside of retry loop
        * Fix: Quote CMAKE variable assignment in Makefile
        * Rework configure script
        * Fix: Typo in doc/examples/Makefile.am
        * Fix: Don't override user variables within the build system
        * Move m4 scripts to m4 dir
        * doc: remove duplicate LTTNG_UST_BLOCKING_RETRY_TIMEOUT man page e=
ntry

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
