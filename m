Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC3C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B8F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgToXgHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B8F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJQEyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbeJQEyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:54:16 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C64E2086E;
        Tue, 16 Oct 2018 21:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539723723;
        bh=OEkIlRyUw8K81ObluFcinlnW4hZFc6B4IoYRJ0VXWwY=;
        h=From:To:Cc:Subject:Date:From;
        b=OgToXgHgz3dR6R24sWfP3zTbJk/j2h0mZIVkyyul7gf29FYJN24kbQK4SR5HdQH2L
         atCgIOMM5ba0WpJoLfgpgL6qF8qtCtE/WLdrmuu4wbs48ShtDkTkyUnyTp7BjYnw6a
         bmhzp0omGq2pkJc3NP31ALnYH0c4bHvcHNI+P5cM=
From:   sboyd@kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.19-rc8
Date:   Tue, 16 Oct 2018 14:02:02 -0700
Message-Id: <20181016210202.117594-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit bded6c03e398dc6e862dc8301fb9a60175740653:

  clk: x86: Set default parent to 48Mhz (2018-08-30 14:47:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-fixes-for-linus

for you to fetch changes up to 02621216e1d8a13abf1d040ff3b7ccf41b2df578:

  Merge tag 'sunxi-clk-fixes-for-4.19' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes (2018-10-01 15:22:25 -0700)

----------------------------------------------------------------
One fix for the Allwinner A10 SoC's audio PLL that wasn't properly set
and generating noise.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: sun4i: Set VCO and PLL bias current to lowest setting

Stephen Boyd (1):
      Merge tag 'sunxi-clk-fixes-for-4.19' of https://git.kernel.org/.../sunxi/linux into clk-fixes

 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
