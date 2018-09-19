Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B4ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510CD2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SkzCYNc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510CD2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeISLFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:05:50 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:61288 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeISLFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:05:49 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8J5SefZ016652;
        Wed, 19 Sep 2018 14:28:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8J5SefZ016652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537334921;
        bh=eFggD1JXHHFgA+tDvGNgWKLz7dCUjfdU9fCJemdpHyo=;
        h=From:To:Cc:Subject:Date:From;
        b=SkzCYNc4fQulmkrJQeCtj16zPXrfgyaMycUuG++Z0wlBRWheVwVA5qRn132Io8LAt
         U7Kns8fCDBa0Q/+u75ri8dmUAjsgtPOzuf6BlChHgu/nRPIt2LYmTwFyjzFqD38HGx
         dNoy/kMhE6alt98s4r3v6Zi+WOc10tWKEq4oa8dXaJKMyT7DgFbA8qKhVx9647SS4Y
         hIRUhix7oPFDlk8FM/1rsTQWDm/+t8WkdY1EK17Lee9xt82pqe70V6LHYjpesQ6BMH
         XWGtmntTXEMEWtU0oTCc4CmGdzhCnC1BFf7C8gGUl+AxV4fzkFoP3m0ROS3QcL5RRQ
         NnOeGzJ87G9uQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dai Okamura <okamura.dai@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] serial: 8250_uniphier: remove unused code and add auto-flow-control
Date:   Wed, 19 Sep 2018 14:28:10 +0900
Message-Id: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Remove never-used DT property
 - Refactor code
 - Add auto-flow-control support



Dai Okamura (1):
  serial: 8250_uniphier: add auto-flow-control support

Masahiro Yamada (2):
  serial: 8250_uniphier: remove unused "fifo-size" property
  serial: 8250_uniphier: flatten probe function

 .../devicetree/bindings/serial/uniphier-uart.txt   |  3 +-
 drivers/tty/serial/8250/8250_uniphier.c            | 62 ++++++++--------------
 2 files changed, 22 insertions(+), 43 deletions(-)

-- 
2.7.4

