Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95B0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9820866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc6QxCRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB9820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeILTsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeILTsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:48:21 -0400
Received: from localhost.localdomain (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF18420866;
        Wed, 12 Sep 2018 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536763412;
        bh=sdifeuDHj7NfMNDAeXYuTyFu9nuhMBG5rt3w0VDPIyo=;
        h=From:To:Cc:Subject:Date:From;
        b=hc6QxCRlI5WIU8OdfCPUQwlnLImikPCXynKv9krMon2UyjuXk79Dy41xHTrGN/DhR
         Gp7eWgdFVms7ZhSqDPKcVU3xJ8eGf/PZaQ+XxyiUADdgrX9rMbBLsg2+g03XxIzSUH
         78YAREp9NiwEmuTQ6qtH2USpWs//qYMuK1sicy4A=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 0/5] fpga: patches for v4.19
Date:   Wed, 12 Sep 2018 09:43:22 -0500
Message-Id: <20180912144327.3130-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please take these five small patches for FPGA.  They
have been reviewed on the mailing lists and apply cleanly
on linux-next/master and char-misc-testing.

Thanks,
Alan

Alan Tull (3):
  fpga: do not access region struct after fpga_region_unregister
  fpga: bridge: fix obvious function documentation error
  docs: fpga: document fpga manager flags

Moritz Fischer (2):
  fpga: of-fpga-region: Use platform_set_drvdata
  fpga: dfl-fme-region: Use platform_get_drvdata()

 Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
 drivers/fpga/dfl-fme-region.c              |  6 ++++--
 drivers/fpga/fpga-bridge.c                 |  2 +-
 drivers/fpga/of-fpga-region.c              |  5 +++--
 include/linux/fpga/fpga-mgr.h              | 20 ++++++++++++++------
 5 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.7.4

