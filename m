Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3946A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYOV93ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3946A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeK0EaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeK0EaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:30:20 -0500
Received: from localhost.localdomain (unknown [136.62.81.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9458620862;
        Mon, 26 Nov 2018 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543253733;
        bh=8atqugW7BTKSjx9+utV7lFSCLM6mj+Qyx7Bz5OfhIy0=;
        h=From:To:Cc:Subject:Date:From;
        b=JYOV93neSKl8hRHiJyKETtZjCCp2rZOi6cjaJsVyYIljMi4526yu5a6YoY0jCXle6
         hE5ht8UeTRYUJUt8KV/pnoOLP85+1/oShveFZHBZvF1/CVGwUdJeukO6WbLfLAJoos
         wCAqiPcfIWvj8Ytw4gf1TRXxnjaGU7YveY+TLvCg=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 0/2] patches for FPGA
Date:   Mon, 26 Nov 2018 11:35:26 -0600
Message-Id: <1543253728-26542-1-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please take these two fpga fixes patches.  They have been reviewed
on the mailing list and apply cleanly on current linux-next.

Thanks,
Alan

Anatolij Gustschin (2):
  fpga: altera-cvp: fix probing for multiple FPGAs on the bus
  fpga: mgr: altera-ps-spi: enable usage on non-dt platforms

 drivers/fpga/altera-cvp.c    | 34 ++++++++++++++++++++++++----------
 drivers/fpga/altera-ps-spi.c | 40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.7.4

