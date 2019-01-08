Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE852C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB5D2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfAHTnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:43:18 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:50174 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732366AbfAHTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:43:15 -0500
Received: from ip4d142c80.dynamic.kabel-deutschland.de ([77.20.44.128] helo=xps13.fritz.box); authenticated
        by wp227.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ggxHM-00070C-8y; Tue, 08 Jan 2019 20:43:12 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH v2 0/2] Revamp admin-guide/tainted-kernels.rst to make it more comprehensible
Date:   Tue,  8 Jan 2019 20:40:05 +0100
Message-Id: <20190108194007.29439-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1546976595;8f3fe20b;
X-HE-SMSGID: 1ggxHM-00070C-8y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! This is the second version of my patch to make
admin-guide/tainted-kernels.rst more comprehensible. It got triggered while
working on an update for reporting-bugs.rst, as improving the documentation
around reporting bugs and regressions was one of the main things that a lot of
people wanted to see while regression tracking was discussed in the kernel and
maintainer summit 2017 in Prague.

This is the second version of the patch, which became a patch set, as it now
contains a script Randy (thx) provided during the discussion of the first
version. 

Please review and consider applying.

Ciao, Thorsten

Changes since v1 [1]:
- add tools/debugging/kernel-chktaint
- take care of Documentation/sysctl/kernel.txt as well
- renumber existing description to avoid and off-by-one
- add verbose description for three more taints bits
- fix a lots of small issues raised during review

[1] https://lore.kernel.org/lkml/20181217152043.9989-1-linux@leemhuis.info/

Thorsten Leemhuis (2):
  tools: create tools/debugging/ and add a script decoding
    /proc/sys/kernel/tainted
  docs: Revamp tainted-kernels.rst to make it more comprehensible

 Documentation/admin-guide/tainted-kernels.rst | 159 +++++++++++---
 Documentation/sysctl/kernel.txt               |  50 ++---
 tools/Makefile                                |  14 +-
 tools/debugging/Makefile                      |  16 ++
 tools/debugging/kernel-chktaint               | 202 ++++++++++++++++++
 5 files changed, 380 insertions(+), 61 deletions(-)
 create mode 100644 tools/debugging/Makefile
 create mode 100755 tools/debugging/kernel-chktaint

-- 
2.20.1

