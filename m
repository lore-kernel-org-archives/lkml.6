Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kT37MapPGlsbDwAAmS7hNA
	; Fri, 08 Jun 2018 09:43:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A9ECE607A4; Fri,  8 Jun 2018 09:43:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="JDRtZliz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6FB660590;
	Fri,  8 Jun 2018 09:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6FB660590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeFHJnE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:43:04 -0400
Received: from services.gouders.net ([141.101.32.176]:47098 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeFHJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:43:01 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w589a3UU027525
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 8 Jun 2018 11:36:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528450574; bh=PAtvejQWAKrxIc4EJKKteVD4TSG1CWcUEJEfDesklQU=;
        h=From:To:Cc:Subject:Date;
        b=JDRtZlizwAiS5OiW3oJ2MO0Y2X0aJnv4CzO5D480nJhcRDpxCQqs0XkHn+LRZyA5S
         BrqGXCLY58hmbn1BYeo7MhBL+iXIecdW2fUjEiwhanFckBA4BX5gbWZ2UzA2JibmeB
         vMeCm8rb8y/61ZAGLLy6GibaTkB0i6THZP7mblCI=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC v3 0/1] Emacs-like isearch for mconf.
Date: Fri,  8 Jun 2018 11:35:45 +0200
Message-Id: <20180608093546.7687-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v2 went out incomplete, without the patch.
Better so, because it would have just wasted people's time.

For v4 I am planning to implement Sam's idea to kind of being in a permanent
isearch when not using special keys.

Changes in v3:

* Use current git tree to make the patch apply.

* Eliminate debugging output to stderr.

Changes in v2:

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

Dirk Gouders (1):
  Emacs-like isearch for mconf.

 Documentation/kbuild/kconfig.txt   |  18 +++-
 scripts/kconfig/lxdialog/dialog.h  |   6 ++
 scripts/kconfig/lxdialog/menubox.c | 171 +++++++++++++++++++++++++++++++++++++
 scripts/kconfig/lxdialog/util.c    |  14 +++
 scripts/kconfig/mconf.c            |  47 ++++++++++
 5 files changed, 254 insertions(+), 2 deletions(-)

-- 
2.16.4
