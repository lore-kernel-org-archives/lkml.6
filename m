Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E95C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B852173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547108744;
	bh=+2MhRG6Kn3kcTM9/XiTKBzKOccXOgXwkoGSodUtnyl0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=h/vrgdO6ZyjUSc8Uz5FzUJrn/ciCUmF3RI8Gc0BvO+T9wW9MeiHo4y5acae1QekRY
	 YhPZdslw2ZwoMJVekhPsHS4ovcCTNpPbMpYuiQTKrhmeYwt/OOgQ120/x9wsMUeDxV
	 jdDKJhscA8XG41lnAb6OWkuFgBcBzGNGfWz6rAZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAJIZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfAJIZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:25:43 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D4420675;
        Thu, 10 Jan 2019 08:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547108742;
        bh=+2MhRG6Kn3kcTM9/XiTKBzKOccXOgXwkoGSodUtnyl0=;
        h=Date:From:To:Cc:Subject:From;
        b=Qig/5BCv09cHlhhPqz8bmfeBWhwIvNfAXw4JuWNCqUQOB7aT0Dq36tafkadm31FXC
         egXE1DNS0I20BJDF+wDEJMbnldNd9TknX0cN2tpDORat0ZrfstbZPjs+u500i9oeTC
         kuAPtnyUYQRfgm1/qOm4ggNuJq97tKIe7TyDl1co=
Date:   Thu, 10 Jan 2019 09:25:31 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [GIT PULL] mtd: Fixes for 5.0-rc2
Message-ID: <20190110092531.766738a0@bbrezillon>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the MTD fixes PR for 5.0-rc2.

Regards,

Boris 

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mtd.git tags/mtd/fixes-for-5.0-rc2

for you to fetch changes up to 81d9bdf59092e4755fc4307c93c4589ef0fe2e0f:

  mtd: rawnand: qcom: fix memory corruption that causes panic (2019-01-08 12:33:24 +0100)

----------------------------------------------------------------
MTD Fixes:
- Fix a bug introduced when exposing MTD devs as NVMEM providers and
  check for add_mtd_device() return code everywhere

raw NAND fixes:
- Fix a memory corruption in the QCOM driver

----------------------------------------------------------------
Boris Brezillon (2):
      mtd: Fix the check on nvmem_register() ret code
      mtd: Check add_mtd_device() ret code

Christian Lamparter (1):
      mtd: rawnand: qcom: fix memory corruption that causes panic

 drivers/mtd/mtdcore.c             |  2 +-
 drivers/mtd/mtdcore.h             |  2 +-
 drivers/mtd/mtdpart.c             | 36 +++++++++++++++++++++++++++++++-----
 drivers/mtd/nand/raw/qcom_nandc.c | 20 ++++++++++----------
 4 files changed, 43 insertions(+), 17 deletions(-)
