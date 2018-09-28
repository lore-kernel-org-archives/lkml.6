Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED57C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60962206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60962206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeI2ETA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:19:00 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:45041 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbeI2ETA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:19:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E942218224942;
        Fri, 28 Sep 2018 21:53:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tent70_56e1f89d88241
X-Filterd-Recvd-Size: 2208
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:53:16 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Leonidas S . Barbosa" <leosilva@linux.vnet.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
        linux-crypto@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'IBM Power in-Nest Crypto Acceleration'
Date:   Fri, 28 Sep 2018 14:53:15 -0700
Message-Id: <20180928215315.29365-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	6894	IBM Power in-Nest Crypto Acceleration
	6895	M:	Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
	6896	M:	Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
	6897	L:	linux-crypto@vger.kernel.org
	6898	S:	Supported
	6899	F:	drivers/crypto/nx/Makefile
	6900	F:	drivers/crypto/nx/Kconfig
	6901	F:	drivers/crypto/nx/nx-aes*
	6902	F:	drivers/crypto/nx/nx-sha*
	6903	F:	drivers/crypto/nx/nx.*
	6904	F:	drivers/crypto/nx/nx_csbcpb.h
-->	6905	F:	drivers/crypto/nx/nx_debugfs.h

Commit that introduced this:

commit 28bceeaaf81140d69647acd0eb7dc9312f27844a
 Author: Dan Streetman <ddstreet@ieee.org>
 Date:   Thu Jun 18 12:28:32 2015 -0400
 
     MAINTAINERS: clarify drivers/crypto/nx/ file ownership
     
     Update the "IBM Power in-Nest Crypto Acceleration" and
     "IBM Power 842 compression accelerator" sections to specify the correct
     files.
     
     The "IBM Power in-Nest Crypto Acceleration" was originally the only
     NX driver, and so its section listed all drivers/crypto/nx/ files,
     but now there is also the 842 driver which has its own section.  This
     lists explicitly what files are owned by the Crypto driver and which
     files are owned by the 842 compression driver.
     
     Signed-off-by: Dan Streetman <ddstreet@ieee.org>
     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
 
  MAINTAINERS | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

No commit with drivers/crypto/nx/nx_debugfs.h found

