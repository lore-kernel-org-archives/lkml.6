Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C9AC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD7D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfBHOGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:06:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:32150 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfBHOGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:06:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 06:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="141779272"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.115])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2019 06:06:02 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 0/2] Unify send() callbacks
Date:   Fri,  8 Feb 2019 16:05:58 +0200
Message-Id: <20190208140600.24996-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A portion of send() callbacks have returned length, in many cases just
returning back what was given as an argument, and tpm_crb has returned 0 on
success.  This patch set fixes and unifies the behaviour.

Jarkko Sakkinen (2):
  tpm: Unify the send callback behaviour
  tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm_atmel.c         |  2 +-
 drivers/char/tpm/tpm_i2c_atmel.c     | 10 +++++++++-
 drivers/char/tpm/tpm_i2c_infineon.c  |  2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
 drivers/char/tpm/tpm_ibmvtpm.c       |  2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c    |  3 +--
 drivers/char/tpm/xen-tpmfront.c      |  2 +-
 8 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.19.1

