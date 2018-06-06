Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SO1ECLtbGFuOHwAAmS7hNA
	; Wed, 06 Jun 2018 22:10:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A1284608B8; Wed,  6 Jun 2018 22:10:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="VCQBMnjg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D47A7607E4;
	Wed,  6 Jun 2018 22:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D47A7607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeFFWKD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:10:03 -0400
Received: from services.gouders.net ([141.101.32.176]:41111 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeFFWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:10:02 -0400
X-Greylist: delayed 765 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2018 18:10:01 EDT
Received: from lena.gouders.net (ltea-047-066-034-138.pools.arcor-ip.net [47.66.34.138])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w56LuxjZ004716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 6 Jun 2018 23:57:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528322231; bh=TlK9gKnHvk/FZN20G5V1lmxSwPutXORjQZp7aZkCcS4=;
        h=From:To:Cc:Subject:Date;
        b=VCQBMnjggVypeJAjkaUpgW3BtNs8QOUq+bU0oeSRauB5q1I8cBQisPZ5Qs1SIYKgi
         gDavrxs3mxCzO5iDt09gzOXH7uucZceKVgNUb5DRdyFCz4qOafGB8IHlEaoQVZMcEV
         hRjOutAsrMAXh/MtXudMwtDsk8rvEp26oYlhl/s4=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC 0/1] mconf: Emacs-like isearch
Date: Wed,  6 Jun 2018 23:56:15 +0200
Message-Id: <20180606215616.12817-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

being an Emacs user, I frequently find myself pressing CTRL-s in mconf
to search for some menu entry, especially in large menus.

I decided to implement a basic isearch in mconf and would like to hear
if others find this functionality useful, as well.

The new functionality is started with pressing CTRL-s followed by
characters that form the search string.  To search for further
occurences of an entered string, press CTRL-s instead of further
characters.

For example: to navigate to the USB device drivers, press CTRL-s de ENTER ENTER usb ENTER ENTER

Pressing just CTRL-s subsequently results in line-by-line navigation
through the menu (search for empty strings).

The isearch is terminated by pressing either ESC ESC or ENTER.

Because I expect that errors are found in the code and changes are requested, I
completely left out the documentation part and will add it to V2
should anyone find this functionality useful.

Thanks,

Dirk

Dirk Gouders (1):
  Emacs-like isearch for mconf.

 scripts/kconfig/lxdialog/dialog.h  |   5 ++
 scripts/kconfig/lxdialog/menubox.c | 140 ++++++++++++++++++++++++++++++++++++-
 scripts/kconfig/lxdialog/util.c    |   1 +
 3 files changed, 145 insertions(+), 1 deletion(-)

-- 
2.16.4
