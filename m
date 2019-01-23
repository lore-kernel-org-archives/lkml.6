Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35EAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867E720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfAWJZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:25:54 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64803 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726313AbfAWJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:25:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52645408"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 17:25:50 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 729824BAD9D9;
        Wed, 23 Jan 2019 17:25:50 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 17:25:49 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: minimal version requirement for ld
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>
Message-ID: <4bec5d62-6033-b3be-d4b2-30d72d381c34@cn.fujitsu.com>
Date:   Wed, 23 Jan 2019 17:23:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 729824BAD9D9.A8704
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
(Not sure I am sending the right place)

Documentation/process/changes.rst says the minimal version for binutils
is 2.20. I am trying the binutils-2.20.51.0.2-5.48.el6.x86_64.rpm of
Centos6 on Fedora28, and it give me:

  HOSTCC  scripts/basic/fixdep
/usr/bin/ld: unrecognized option '-plugin'
/usr/bin/ld: use the --help option for usage information
collect2: error: ld returned 1 exit status
make[2]: *** [scripts/Makefile.host:90: scripts/basic/fixdep] Error 1
make[1]: *** [Makefile:464: scripts_basic] Error 2
make: *** No rule to make target 'include/config/auto.conf', needed by
'include/config/kernel.release'.  Stop.
make: *** Waiting for unfinished jobs....
  HOSTCC  scripts/basic/fixdep
/usr/bin/ld: unrecognized option '-plugin'
/usr/bin/ld: use the --help option for usage information
collect2: error: ld returned 1 exit status
make[1]: *** [scripts/Makefile.host:90: scripts/basic/fixdep] Error 1
make: *** [Makefile:464: scripts_basic] Error 2

Then I tried adding:

    HOSTCFLAGS_fixdep.o := -fno-use-linker-plugin

in scripts/basic/Makefile, and it give me:

  HOSTCC  scripts/basic/fixdep
/usr/bin/ld: BFD version 2.20.51.0.2-5.48.el6 20100205 internal error,
aborting at reloc.c line 443 in bfd_get_reloc_size

/usr/bin/ld: Please report this bug.

collect2: error: ld returned 1 exit status
make[2]: *** [scripts/Makefile.host:90: scripts/basic/fixdep] Error 1
make[1]: *** [Makefile:464: scripts_basic] Error 2
make: *** No rule to make target 'include/config/auto.conf', needed by
'include/config/kernel.release'.  Stop.

Any idea on this problem? Or anyone has ever tried ld 2.20 successfully?
-- 
Sincerely,
Cao jin


