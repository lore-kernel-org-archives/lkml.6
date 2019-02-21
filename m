Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1952148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="XaGLCHY+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wg8o7ZbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfBUFQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:16:53 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41263 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfBUFQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:16:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A63C3329C;
        Thu, 21 Feb 2019 00:16:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Feb 2019 00:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hL6jEQSIrj6Vd5fbSsDCnjgf4jf
        kEYudSEpTk9uXra8=; b=XaGLCHY+/G+4g5ASNgaNY1fth/Rjlp2hfO87yJlpdJK
        GH5Mapn9EwtgbPnDuJcw32mEAV48CnPVKwqpPodhlVgok7sQToLrGbtUHcdO19Zw
        +qNV5E/Y2CtkGf4Uv07cQAIJVIBbUTiPZheuOeio3rvnObrRiXEhPiSg9LTPcHlc
        pkJQZ7PLHVlxr58llJ68mxnPmlYccMafcK/DuOdIRj9zcaA0GdqgmoZn3tpTfvoj
        E28wIJHa7U3MqULbVKWVgAPlVUuJgNZwKKudAFasasuZnvrOp69cYPHleuHow9Jm
        uo4UdyUkOhHHKUB8n2E4/Ho/OLplR3waUWdzYecgnjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hL6jEQ
        SIrj6Vd5fbSsDCnjgf4jfkEYudSEpTk9uXra8=; b=Wg8o7ZbCfR4Peu1sshhWto
        HGX6brRMfirxTctFBleiS9DI0kbW9X9YWzeOnwlNOK2YwS6rqadm2w9C+kEWUH9p
        t7mbw9OmPN2h+5Av4PVX3W1pLVYr+6av/d0EoM/gCfNgZqK6GWIX6YdPjHipPW9H
        BWvUIg9aZRqtEnT5U1h0nPH6CuG7jBPvr4FzMx4j9gBHdtUTIt7NVG+jnkOn/Mvk
        kl/y+iFr6tcP8PG7xih0Qrd24PU+IkptZG2ZN4WzXylFeqh9q5VSFNztb6waUVEW
        YTZbnryAo6ye35JirgXeTu0XimsDJOhmmyT/D/71dI419ObAD/6eO9z0oJ3N0grQ
        ==
X-ME-Sender: <xms:QzRuXIXGlOsn85z8fnNtYyzYlm9fS9qaK5z25DpnLMsrA9hNxPXGnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdejgdekvdculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdefledrudeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:QzRuXOFtIZsZ9SYHcQ4Xyf1cpsgHUbGL1GHG-R1eZ-zH6L1mTMdq5w>
    <xmx:QzRuXA9Ob8PfhoQXyKV1Azf8k9O4IlzZbOi4djh6yZATawkAdpvUQg>
    <xmx:QzRuXG1gS9KCj4oLI4Xj789Vp1Cpv2cg6xMZxUlW5B0U2pLKbqCr0Q>
    <xmx:QzRuXHgfBpdweT6EQwpUic2eA2ZLIlXOUJWnajKOpb6J51-bnBUj-Q>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6153E10328;
        Thu, 21 Feb 2019 00:16:49 -0500 (EST)
Date:   Thu, 21 Feb 2019 16:16:34 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] lib/string: Enable string selftesting
Message-ID: <20190221051634.GC11758@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-2-tobin@kernel.org>
 <CAGXu5j+ZbNu=6W2Srzbo7aYJZDcR_rRsEbVMOdcKdQXEGs1ZBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+ZbNu=6W2Srzbo7aYJZDcR_rRsEbVMOdcKdQXEGs1ZBw@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:57:18PM -0800, Kees Cook wrote:
> On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > Currently we have a test module but it is not tied into the kselftest
> > infrastructure.  In preparation for adding string manipulation functions
> > and testing we should enable kselftest to utilize the test module.
> >
> > Enable string testing via kselftest infrastructure.
> >
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  lib/Kconfig.debug                     | 14 ++++++++++++++
> >  lib/Makefile                          |  2 +-
> >  lib/test_string.c                     |  4 ++--
> >  tools/testing/selftests/lib/Makefile  |  2 +-
> >  tools/testing/selftests/lib/config    |  1 +
> >  tools/testing/selftests/lib/string.sh | 19 +++++++++++++++++++
> >  6 files changed, 38 insertions(+), 4 deletions(-)
> >  create mode 100755 tools/testing/selftests/lib/string.sh
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d4df5b24d75e..0dca64c1d8a4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1802,8 +1802,22 @@ config ASYNC_RAID6_TEST
> >  config TEST_HEXDUMP
> >         tristate "Test functions located in the hexdump module at runtime"
> >
> > +config TEST_STRING
> > +       tristate "Perform selftest on string manipulation functions"
> > +       default n
> > +       help
> > +        Enable this option to test string manipulation functions.
> > +       Currently this only tests memset_{16,32,64}.
> > +
> > +       If unsure, say N.
> > +
> >  config TEST_STRING_HELPERS
> >         tristate "Test functions located in the string_helpers module at runtime"
> > +       default n
> > +       help
> > +        Enable this option to unit test code in lib/string_helpers.c
> > +
> > +        If unsure, say N.
> >
> >  config TEST_KSTRTOX
> >         tristate "Test kstrto*() family of functions at runtime"
> > diff --git a/lib/Makefile b/lib/Makefile
> > index e1b59da71418..9c30e1fee27f 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -39,7 +39,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
> >          bsearch.o find_bit.o llist.o memweight.o kfifo.o \
> >          percpu-refcount.o rhashtable.o reciprocal_div.o \
> >          once.o refcount.o usercopy.o errseq.o bucket_locks.o
> > -obj-$(CONFIG_STRING_SELFTEST) += test_string.o
> > +obj-$(CONFIG_TEST_STRING) += test_string.o
> 
> This patch should remove 'config STRING_SELFTEST' from lib/Kconfig too.
> 
> > diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
> > index 70d5711e3ac8..2ee4559b277e 100644
> > --- a/tools/testing/selftests/lib/Makefile
> > +++ b/tools/testing/selftests/lib/Makefile
> > @@ -3,6 +3,6 @@
> >  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
> >  all:
> >
> > -TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
> > +TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh string.sh
> >
> >  include ../lib.mk
> > diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> > index 126933bcc950..2032402ad409 100644
> > --- a/tools/testing/selftests/lib/config
> > +++ b/tools/testing/selftests/lib/config
> > @@ -1,3 +1,4 @@
> >  CONFIG_TEST_PRINTF=m
> >  CONFIG_TEST_BITMAP=m
> > +CONFIG_TEST_STRING=m
> >  CONFIG_PRIME_NUMBERS=m
> > diff --git a/tools/testing/selftests/lib/string.sh b/tools/testing/selftests/lib/string.sh
> > new file mode 100755
> > index 000000000000..99024b6f3a6a
> > --- /dev/null
> > +++ b/tools/testing/selftests/lib/string.sh
> > @@ -0,0 +1,19 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Runs string manipulation tests using test_string kernel module
> > +
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> > +if ! /sbin/modprobe -q -n test_string; then
> > +       echo "string: module test_string is not found [SKIP]"
> > +       exit $ksft_skip
> > +fi
> > +
> > +if /sbin/modprobe -q test_string; then
> > +       /sbin/modprobe -q -r test_string
> > +       echo "string: ok"
> > +else
> > +       echo "string: [FAIL]"
> > +       exit 1
> > +fi
> > --
> > 2.20.1
> >
> 
> You mentioned "redundant scripts" here. You might want to refactor
> first, and have a common tool that does the core testing, and then
> have the scripts doing one line each:
> 
> i.e.:
> 
> #!/bin/bash
> exec./test_module.sh prime_numbers selftest=65536
> 
> with "test_module.sh" doing all the rest.
> 
> I bet there are other test_*.ko tests we could wire up too, and this
> refactor will make that much easier. And actually, maybe we should
> just have a single test running that just reads the "config" file for
> the list of test modules, and runs them with the correct output format
> to show which are skipped, etc.

Got it.  I'll have a go at all this and pre-pend it to v2.

thanks,
Tobin.
