Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9699C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83EA21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546451624;
	bh=LcKZlvoRX33dmQciVkcef+bnWhQI7ZK/RTMwiP7LhCk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zaFsUMbiqdNh6jVJtGyEAgW+PUM9BLSTeVu++vMIdvR4FPljK2O01E/rFsfmPqdAq
	 p+gWo9B7+unM6h6P63luP95iZZRFZmRBq/ypFHF5M7KnUN08ONbmNkJDVQjSxPovug
	 EzZmypCWE3rpNQu5yKyy3BRM/cqlKvQVXj7EUJYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfABRxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfABRxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:53:43 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EE721871;
        Wed,  2 Jan 2019 17:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546451623;
        bh=LcKZlvoRX33dmQciVkcef+bnWhQI7ZK/RTMwiP7LhCk=;
        h=From:To:Cc:Subject:Date:From;
        b=Zm50CIc2XilrRj0/jGphiwhyWETLtDQiy9EX850whLC92puZ6mTBQqF59e24qTZbH
         UmBxXhK6+dXhqNHqfizDmfjOhfghtiO031ms9LHhGrkb5Kl7iFUIqJ89oIpKiw+VwB
         VpvSnfyDO2uO3pghn75i38IJ3dlx4Qdw4koUANlM=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] one more clk change for the merge window
Date:   Wed,  2 Jan 2019 09:53:42 -0800
Message-Id: <20190102175342.71807-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b677574bdf292e31c8f9810ff0fc0b35839d4636:

  Merge branch 'clk-imx7ulp' into clk-next (2018-12-14 14:03:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 08972760d366b83a87d366b0079747f8c409163c:

  clk: imx8qxp: make the name of clock ID generic (2018-12-28 10:43:57 -0800)

----------------------------------------------------------------
One more patch to generalize a set of DT binding defines now before -rc1
comes out. This way the SoC DTS files can use the proper defines from a
stable tag.

----------------------------------------------------------------
Aisheng Dong (1):
      clk: imx8qxp: make the name of clock ID generic

 drivers/clk/imx/clk-imx8qxp-lpcg.c        | 148 +++++++--------
 drivers/clk/imx/clk-imx8qxp.c             | 154 ++++++++--------
 include/dt-bindings/clock/imx8-clock.h    | 289 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/imx8qxp-clock.h | 289 ------------------------------
 4 files changed, 440 insertions(+), 440 deletions(-)
 create mode 100644 include/dt-bindings/clock/imx8-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8qxp-clock.h

-- 
Sent by a computer through tubes
