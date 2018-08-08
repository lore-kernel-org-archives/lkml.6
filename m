Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050B3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FE02170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FE02170F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeHHIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:09:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:41524 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHHIJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:09:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w785or1m009669;
        Wed, 8 Aug 2018 00:50:54 -0500
Message-ID: <683a481141c6ee4b85e6128e62ea5131b74bbe3f.camel@kernel.crashing.org>
Subject: [GIT PULL] FSI fixes for 4.19
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Date:   Wed, 08 Aug 2018 15:50:53 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

This adds two FSI fixes to what you already have in your tree

  - Fix a NULL dereference in the scom driver

  - Fix a command buffer size issue in the sbefifo driver that
    breaks some operations with POWER system debugger (cronus)

Cheers,
Ben.

The following changes since tag fsi-updates-2018-07-27:

  fsi: Prevent multiple concurrent rescans (2018-07-27 09:58:12 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-08-08

for you to fetch changes up to 15e2a7218c2788d79c5633336d17cb9428c221e7:

  fsi: sbefifo: Bump max command length (2018-08-08 15:44:47 +1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (2):
      fsi: scom: Fix NULL dereference
      fsi: sbefifo: Bump max command length

 drivers/fsi/fsi-sbefifo.c | 39 ++++++++++++++++++++++++++++++++-------
 drivers/fsi/fsi-scom.c    |  1 +
 2 files changed, 33 insertions(+), 7 deletions(-)

