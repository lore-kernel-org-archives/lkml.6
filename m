Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BEC1B0E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2380216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hSDl9HO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2380216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeI1I1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:27:52 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:52926 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbeI1I1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:27:51 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8S25FOg028340;
        Fri, 28 Sep 2018 11:05:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8S25FOg028340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538100316;
        bh=Iq5sDsGfDX2Qg+RTLGdJRZ8SLr40Q65uOj5111MvuxY=;
        h=From:To:Cc:Subject:Date:From;
        b=hSDl9HO4en+T/boXgArDqshVfS185VvqWZ6LVMTLPo7fhhtAPczrsuTky9lL5TJAt
         Z6LPFNc5ZX4GHmWLgOsX6S6VHDMFmmDXZSqFxQZ8DHfNdd3OzoJBYhx6F7BE20AJ4y
         w/zyHoGG9RGbx001pjD0auP0ei+nibfXEk0+uSPFZhZTQx+1x3pjT3TKUsY0cVxC0g
         3tC6GE/B5kT/f87W+hQlxiiR6rHJtUaghpCPKES8TF/5bBwZvjOBdSlDgC8IaGPLDF
         mWPxlK7+Q9ZbKZCWgXqBF4hJiybI+kBcaDjaPQ0C/Fq8jBpVPspgfLen49twv2f+Ma
         ENNtJtANZNotg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc:     Dai Okamura <okamura.dai@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] serial: 8250_uniphier: remove unused code and add auto-flow-control
Date:   Fri, 28 Sep 2018 11:05:06 +0900
Message-Id: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
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

