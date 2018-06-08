Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9XerIjfOGlvfdAAAmS7hNA
	; Fri, 08 Jun 2018 18:53:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2F88607E4; Fri,  8 Jun 2018 18:53:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="IaJGaQ9V"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 51FB6601D2;
	Fri,  8 Jun 2018 18:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51FB6601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbeFHSxW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:53:22 -0400
Received: from services.gouders.net ([141.101.32.176]:37038 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeFHSxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:53:18 -0400
Received: from lena.gouders.net (ltea-047-066-004-082.pools.arcor-ip.net [47.66.4.82])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w58IkL2S032281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 8 Jun 2018 20:46:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528483595; bh=/HbC3y36XI2B+fM2jOeSIgL1Mjsqs0vEDBV0ByzYWTE=;
        h=From:To:Cc:Subject:Date;
        b=IaJGaQ9V5yCToStSj/VNTW07Mq1tFrjYCU4LfkQvAuN46T2Oev87IHKzduXnHSKE4
         LqKnzh1Kds8i1Ez9S9bwYqCH9ywhB9pk1YH5JD0YyuWd2ALYiJ9VU6CJZK3zdsnkTn
         zMQc+l32kczHTJqF+4+zF0nt2a+vgZUc+jgwC7/o=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC v4 0/1] i-search functionality for mconf
Date: Fri,  8 Jun 2018 20:46:05 +0200
Message-Id: <20180608184606.5029-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this version is a prototype of the idea, Sam suggested -- I hope I
undestood it correctly.

This is a remarkable change to mconf in it's behavior; mainly it now
differentiates two focuses and operates differently, depending on the
focus.  When the focus is on the menu, mconf is in i-search mode, for
a detailed description see 1/1.

As stated earlier, this is just a prototype, documentation is missing
and the code is not ready for a real commit.

Dirk

Dirk Gouders (1):
  Isearch functionality for mconf

 scripts/kconfig/lxdialog/dialog.h  |   3 +
 scripts/kconfig/lxdialog/menubox.c | 207 +++++++++++++++++++++++++++++++++----
 2 files changed, 189 insertions(+), 21 deletions(-)

-- 
2.16.4
