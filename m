Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C2C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365192070D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544811565;
	bh=0dKUEBh8eIyY8Cb9KWx5vL9k3AQaJjyLKK3OMaK8430=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cCfhXOnDTFt0ynSndBJnY+pg6WoXrsvB27ID8pmzBP3pt4ICzfraQWRD5LWOIUqFB
	 mMN5gECcjAwAxHeLxEjxsHfo10IGFMMQDcnPUOej5jal9plwEtgved5lMiiCbZ1HEu
	 HscDeRlTDvbeoIVdP9feZ8JvqOad1rQkf/IdntwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbeLNSTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbeLNSTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:19:22 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916ED206C0;
        Fri, 14 Dec 2018 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544811563;
        bh=0dKUEBh8eIyY8Cb9KWx5vL9k3AQaJjyLKK3OMaK8430=;
        h=From:To:Cc:Subject:Date:From;
        b=nYduV5MwQCbEtpjdWQhf4vQVdxxRi96fEg2bukevM68RTR/awaH1OFtHy8Z896KBE
         vaxenkoQ3W9JOI1Dlq4r/p3lBTBkaGzUgQT8AiVWz6RQPCIPytBugeFAUN0YVoW73w
         vRQYY5rqnCKaWLvHOM+1dysGortIW974NIFp3bpo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.20-rc6
Date:   Fri, 14 Dec 2018 10:19:21 -0800
Message-Id: <20181214181921.99645-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9a43be9cedd516f188e6333d3b43402386723eff:

  clk: zynqmp: Off by one in zynqmp_is_valid_clock() (2018-12-03 09:54:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 8a034aad4892baf82f8c9082f969c5ebc1143a05:

  clk: qcom: qcs404: Fix gpll0_out_main parent (2018-12-10 11:31:30 -0800)

----------------------------------------------------------------
One fix for the qcom QCS404 clk driver that was merged for this release.
It specified the wrong parent for a PLL so a part of the clk tree wasn't
rooted correctly. This fixes it by using the right name.

----------------------------------------------------------------
Srinivas Kandagatla (1):
      clk: qcom: qcs404: Fix gpll0_out_main parent

 drivers/clk/qcom/gcc-qcs404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Sent by a computer through tubes
