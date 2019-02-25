Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3ADF213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551068181;
	bh=mgR174nKTOC+iU9FuSEPYAJeK/2io86vhl5FfR5yV5s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=F8dA5eKWnfpQHopmMSUlLsh5ol2CvMobmZ4CIAAAAYo4MICBpM2YcC8hh7E7aKvvk
	 AFKM14ySfpYz9kdA/eRsUnfmnSNCM9GTg19ZFRfZCCXjQd49FkZLbDAm4jhrVDrC9F
	 wiIdMlQeM/hzApxDUq1ubdJKV6UNrmSiaDbshEfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfBYEQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:16:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38161 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfBYEQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:16:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF83222201;
        Sun, 24 Feb 2019 23:16:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 24 Feb 2019 23:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ruUSGtR9etN4YTUqd
        6RCSzMhjpzc44SJj9Bq253ykjs=; b=xuLBIB5twd+RtqIWIY571Alp7DNgml6Ji
        TxEd5E+1POVcIc0gPdE49LizOptqR2Kw52WmDO6aN9GO5wxXGtv8wPquP3NFTA6K
        BtmGWAU6QkQhcQ/3122nv7j/I4KbwmqCTfhWUvvlSxHB/I9S6mbkhLiKzN/hg4va
        VSngUX6P2KCTtoAmctOmwRK8ur7tEaa0eT/Leyd0I0J8L+zUps92l/HgbznBOe5d
        ElX7SMzxWVdgtXk0wKgW5g54ZSw/A4AwFG1XRAkq6cRzNG7YItx1uHvXQGGqgI1q
        y5ZfL3+FiyV0v2qiCpcJ8UXRq7BS5HrYgbKY+yqGSKwWoOGUTmqOQ==
X-ME-Sender: <xms:EGxzXGIqdX1GezPTgFmxEEvG4udTeTeIA90723gZP7YRJadPQQAwhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrudehgdeijeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecuffhomh
    grihhnpehlkhhmlhdrohhrghenucfkphepuddvgedrudegledruddvvddrfeenucfrrghr
    rghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptd
X-ME-Proxy: <xmx:EGxzXNEcelFHa0hSePX8SIa6pP64bt1kAHB177IOi0hC-Y2dRxINyw>
    <xmx:EGxzXCx-OGk-EHQ8oQfcLFwb7uaoYZKenrMpJkVNaTanWC1vPVNeiQ>
    <xmx:EGxzXO6w3GcviLz7sfM7qjiWGfNu36MMWT6Ll0bl0g2MZivC_z0sBw>
    <xmx:EWxzXBUuAzpYthw7Vs0Qz48b0nhjv1KPB9LH0AuuNKG4S57jzmIrWw>
Received: from eros.localdomain (124-149-122-3.dyn.iinet.net.au [124.149.122.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77BC2E4240;
        Sun, 24 Feb 2019 23:16:10 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] lib/string: Add strscpy_pad() function
Date:   Mon, 25 Feb 2019 15:15:33 +1100
Message-Id: <20190225041534.27186-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set was formerly

	Subject: [PATCH 0/6] lib: Add safe string funtions[sic]

And FTR can be seen here:

	https://lkml.org/lkml/2019/2/18/1428


The v1 patch set has been reduced to a single patch by dropping the
strscpy_from_user() stuff and by rolling all the docs changes into the
main patch as suggested.

This patch adds the function strscpy_pad() named after consensus was
reached on the v1 email thread (linked to above).

Thanks to Kees for the extreme test case coverage.  test_basic() is
probably redundant but is left in for the benefit of any poor sucker who
has to debug a regression using test_fully().

The test module is _not_ tied into kselftest.  As discussed on v1, there
are some issues with tools/testing/selftest/lib/ at the moment.  I intend
on working on those issues as suggested but it does not seem totally
relevant to this patch so instead of slowing this one down with my poor
knowledge of how kselftest works it seems better to do this separately. 

thanks for looking at this,
Tobin.


Tobin C. Harding (1):
  lib/string: Add strscpy_pad() function

 include/linux/string.h |   4 +
 lib/Kconfig.debug      |   3 +
 lib/Makefile           |   1 +
 lib/string.c           |  47 +++++++++--
 lib/test_strscpy.c     | 175 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 223 insertions(+), 7 deletions(-)
 create mode 100644 lib/test_strscpy.c

-- 
2.20.1

