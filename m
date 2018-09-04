Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D0CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A9520843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Sp42RFfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A9520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDT7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:59:30 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:54928 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIDT7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:59:30 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A988D10C10AD;
        Tue,  4 Sep 2018 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536075233; bh=4+FeDiFhoR3dy0/HSh453+pK96RjaDz2EVMRV3FeoGA=;
        h=From:To:Cc:Subject:Date:From;
        b=Sp42RFfFhv/E7CDwWGyJJIOn2H/gkgBCnkyEOq5N7ZxlzFSQZ21Af+A0gFMqK0xMN
         jEbnfjBubLGxvUDeITMsUn1enoJdSBM8f/l5a6CVGJlYG+xN5NsnslFFxIG3ZuFXML
         x3FwTh34ysAGZf+Qy3W0GjRqaEUi3fqf1xSQAYqxeitAotdcdCRCTkBi4++e/pnQ3+
         vYFPxtjVTx9iYLA0WvK2B74M98ohDJy0Y8tGL5t1amv6t/Ya2fwLLGwaUbyl8WLFSQ
         PxNdtcvexoeN1g8Mnes6tZ3C6ctDmZ9UQs1VlxpMa5raSMlTVntXEMjohTK+EE9jWM
         qT9e8223nyU5g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.36])
        by mailhost.synopsys.com (Postfix) with ESMTP id 016853B70;
        Tue,  4 Sep 2018 08:33:46 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/2] MTD: spi-nor: add support for sst26wf016, sst26wf032
Date:   Tue,  4 Sep 2018 18:33:40 +0300
Message-Id: <20180904153342.16742-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SST sst26wf016 and sst26wf032 flash IC:

sst26wf*** flash series block protection implementation differs from other
SST series, so we add implementation for sst26wf*** lock/unlock/is_locked
functions.

Add sst26wf016 and sst26wf032 flash IC info to spi_flash_ids list.

NOTE:
these patches is basically following mine u-boot commits port:
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=3d4fed87a5fa3ffedf64ff2811cd95c5ac4503ac
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=a19e97157c3721ef9c4b15c68c1773467a3b4a98

Eugeniy Paltsev (2):
  mtd: spi-nor: Add support of sst26wf* flash ICs protection ops
  mtd: spi-nor: add support for sst26wf016, sst26wf032

 drivers/mtd/spi-nor/spi-nor.c | 179 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |   4 +
 2 files changed, 183 insertions(+)

-- 
2.14.4
