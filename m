Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FCCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933AC218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548362759;
	bh=MGe9vt7zS1x7SAtgc39/4FTfbYI5Q+jTs31g2El77u0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cctxB9KHnYitArkR8E2oFHaTewCziJn9REESAnqf1PT31q53PQMzwjUjOVTafY/2Y
	 RH1WTKqtJM27x7D0FUMqa/lpFx8qBUc1DLZwxKl5seBddQ8dLkt5Rcg+XSoCCTGvKY
	 u2pQPD7vXCfrXrJGG/JXuMgYmJPANOmRhZxHT5zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAXUp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAXUp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:45:57 -0500
Received: from atull-730U3E-740U3E.fm.intel.com (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9249F218D0;
        Thu, 24 Jan 2019 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548362757;
        bh=MGe9vt7zS1x7SAtgc39/4FTfbYI5Q+jTs31g2El77u0=;
        h=From:To:Cc:Subject:Date:From;
        b=wyvCOgecio166vPCt6Vi4eUi31/OO6CTkGVmGacpe3r9iPBW1mKH5tgSB+0PtaoHp
         RbYaHlc2cxKvb6OmVy8oudPGzZzMvkGSeGPXN7q5RF/vRriiilgE8fImWlsLlLL0LP
         bN48CeoGFKBe6AoSCpVLWY2ELC/I+Rk/wXBxvr50=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH 0/3] patches for FPGA
Date:   Thu, 24 Jan 2019 14:45:51 -0600
Message-Id: <20190124204554.5438-1-atull@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please take these patches for fpga.  They have been reviewed on
the mailing list and apply cleanly on current linux-next.

The "fpga: stratix10-soc: fix wrong of_node_put() in init function"
is a bug fix, sorry it's late.  It will only affect the
Stratix10 platform.

The other two can go in whenever is appropriate.

Thanks,
Alan

Alan Tull (1):
  fpga: altera_freeze_bridge: remove restriction to socfpga

Colin Ian King (1):
  fpga: mgr: altera-ps-spi: make array dummy static, shrinks object size

Nicolas Saenz Julienne (1):
  fpga: stratix10-soc: fix wrong of_node_put() in init function

 drivers/fpga/Kconfig         | 2 +-
 drivers/fpga/altera-ps-spi.c | 2 +-
 drivers/fpga/stratix10-soc.c | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.7.4

