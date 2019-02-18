Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2479C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A735218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550532244;
	bh=YDmOKMkgvE1tKivEbAyluX4b/hDh9yig7Er+g2La4QE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lartkIMCE+AkWWVEfvikLL6/uXjAGhefkmTf8LyA2ha/xsIVMWvgXNqAT9/LMPQeP
	 hzBFOZMUbYwNQZERrkGpzgoBJwe3YIiJxR9ZCzjg6lIDnqRfu/KU02aJT7KPQbsW2c
	 RAhyBtRvgcZpd+cNef7TYgqf7n3ZolRVN3kXmTss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfBRXYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:24:03 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34397 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbfBRXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:24:02 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6536E3481;
        Mon, 18 Feb 2019 18:24:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Feb 2019 18:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hNMkb4bQzXmhzFly4
        1b0O1VF8jmcWk9234vaYcXiT5k=; b=HrgFS/uhpclN20gHq6RMtROZyPmPAqEu0
        eExlNoL3NYneeWlZKL3VmAN6a0lHz2gGIBE3hnPNP+Bv3FcWv61xun1uPrwJd6xn
        pXC1JdR07fHqzvdJncK0QAQYUGYpzo1qqR3AO+7CiCQJBFX4+/tzECT5F9OMo+ZI
        TrrlweemTnbWZg8NFB93MVhwD0C4SqlB3oBJrB0/p70TDyMCTKdsgp64kfODTUe+
        qZBd5Jf9I77mUZQjR6N6A3ySOoU8J4vs//7WXpGIvacZt5p7FBIuYCRI+7H73YMP
        /j0v0bhRCZ47rl/OZlowcGR39hNdQTdaCexS6EuUgOW2BoDFho4yg==
X-ME-Sender: <xms:kD5rXOk3TtbYyfz3oEJMlPCPQhrL290etHtk8JBeTR-KVyNgEm-VMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddtjeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppe
    duvddurdeggedrvddtvddrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kD5rXBWvHGEyseG9N-sokjCClprP2_WqTwx_Un9Z9uZrwLCy2SX7zA>
    <xmx:kD5rXBu5AR8EvHFLP6H6iMbktFlDjrxSl1W9LFR9rwXYHuCSbb3yNg>
    <xmx:kD5rXBjff1AU9LlMouiCRynFSAkcfo1H5sAVK52SVeSI55UXYxBpIA>
    <xmx:kT5rXG8kBCRdsAjCVxjDv_KTTWEVRTeXWkpo9-d21Zq-iVp06_FlQg>
Received: from eros.localdomain (ppp121-44-202-130.bras1.syd2.internode.on.net [121.44.202.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E2E7100E5;
        Mon, 18 Feb 2019 18:23:56 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] lib: Add safe string funtions 
Date:   Tue, 19 Feb 2019 10:23:02 +1100
Message-Id: <20190218232308.11241-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No file maintainer, CC'ing all those who touched this file :) And
Shua for kselftest stuff.


Hi Kess,

During your talk at LCA you mentioned that we could do with a couple
more safe string functions.  One to zero the tail of the destination
buffer after call to strscpy() and also the self explanatory
strscpy_from_user().

Here is a patch set with my attempts to implement these two functions.

While doing this I noticed that we have a test module for lib/string.c
(lib/test_string.c) that is not tied into kselftest.  So I enable this
first up in patch 1.

Patch 2 and 3 are function docstring cleanups.

Patch 4 adds the copy and zero function, naming it strscpy_zeroed().
I'd love some help naming this better.  Patch also adds test code.

Patch 5 fixes function docstring to correctly document the behavior of
strncpy_from_user().

Patch 6 adds strscpy_from_user().  Does not include test code.

I had to do a bit of learning for getting the tests hooked into
kselftest, I think its all correct.  Module is built correctly when the
config option is present and the tests run both via

	make -C tools/testing/selftests TARGETS=lib run_tests

and via loading the module manually.  As a side note, this series leaves
tools/testing/selftests/lib with 4 shell scripts that are identical
except the test name.  We could probably do with refactoring them into a
single script.

Patchset introduces a checkpatch warning

	WARNING:CONFIG_DESCRIPTION: please write a paragraph that describes the config symbol fully

I couldn't work out if this is a false positive or not?  Does the new
config option CONFIG_TEST_STRING need more documentation?  I don't see
where extra docs should be added and it seems self explanatory as is.


thanks,
Tobin.

Tobin C. Harding (6):
  lib/string: Enable string selftesting
  lib/string: Fix erroneous 'overflow' documentation
  lib/string: Use correct docstring format
  lib/string: Add string copy/zero function
  lib: Fix function documentation for strncpy_from_user
  lib: Add function strscpy_from_user()

 include/linux/string.h                |  4 ++
 lib/Kconfig.debug                     | 14 +++++++
 lib/Makefile                          |  2 +-
 lib/string.c                          | 41 ++++++++++++++----
 lib/strncpy_from_user.c               | 60 ++++++++++++++++++++++-----
 lib/test_string.c                     | 35 +++++++++++++++-
 tools/testing/selftests/lib/Makefile  |  2 +-
 tools/testing/selftests/lib/config    |  1 +
 tools/testing/selftests/lib/string.sh | 19 +++++++++
 9 files changed, 157 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/lib/string.sh

-- 
2.20.1

