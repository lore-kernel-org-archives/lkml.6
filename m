Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id r2wqCVU5GVuVCAAAmS7hNA
	; Thu, 07 Jun 2018 13:56:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0F2F9607DC; Thu,  7 Jun 2018 13:56:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="q5cyZGO8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 414A8601D2;
	Thu,  7 Jun 2018 13:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 414A8601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeFGN4I (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:56:08 -0400
Received: from services.gouders.net ([141.101.32.176]:37863 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeFGN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:56:06 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w57DrSb7013775
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Jun 2018 15:53:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528379619; bh=NKsOG0J3zq3BpT3qulPAsf1LTfY7QbWlJESYr2JPsjQ=;
        h=From:To:Cc:Subject:Date;
        b=q5cyZGO89z+ab5XkjFU+4ELsBHlqherbZyzVpwrzunAWWtjRV0l6lLBYQcxuFQRKB
         9HFSZWsOqdydxUQmt2rPhpS4vBwqqDfg2y7nGVFJGmkQh6gn9r5PHibpbUjxVDFQ5g
         seZRyYTDES2OxnJKbbv14S2KPtkOaUqZHfr3tv88=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC v2 0/1] Emacs-like isearch for mconf.
Date: Thu,  7 Jun 2018 15:53:08 +0200
Message-Id: <20180607135309.16928-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Hello,

this is v2 of the isearch implementation, I also added Documentation changes which
probably have to be split, because the older symbol-search also was undokumented in
mconf (I basically copied the relevant documentation from Documentation/kbuild/kconfig.txt.

I could not completely let off CTRL-s but am certainly fine with get rid of it and
stay with just one special key (e.g. \) to start isearch.

Changes since v1:

* Additionally to CTRL-s, \ can be used to start isearch.

* Raw mode is off by default an can be enabled by an environment
  variable MENUCONFIG_RAW_MODE.

* I also added a variable for toggling raw mode but did not implement
  anything else.

* The isearch indicator is now displayed as soon as isearch is
  started.

* Any key except \, CTRL-s, alphanumeric characters and space
  terminates isearch and -- except ESC ESC -- is further processed,
  e.g. ENTER terminates isearch and is then used to navigate into a
  submenu.

* Problems with mismatches and matches above the current position were
  fixed.

Dirk

 Documentation/kbuild/kconfig.txt   |  18 +++-
 scripts/kconfig/lxdialog/dialog.h  |   6 ++
 scripts/kconfig/lxdialog/menubox.c | 173 +++++++++++++++++++++++++++++++++++++
 scripts/kconfig/lxdialog/util.c    |  14 +++
 scripts/kconfig/mconf.c            |  48 +++++++++-
 5 files changed, 256 insertions(+), 3 deletions(-)

-- 
2.16.4
