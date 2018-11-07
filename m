Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3738C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE73F20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMYyzULw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE73F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeKHDXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbeKHDXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:23:24 -0500
Received: from localhost.localdomain (rrcs-67-79-197-43.sw.biz.rr.com [67.79.197.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA6020827;
        Wed,  7 Nov 2018 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541613116;
        bh=yKe8VAWk4EyMlrpmXsInRxvctWDPafafhvCnl1bZ9Bs=;
        h=From:To:Cc:Subject:Date:From;
        b=MMYyzULwAYtCyn+nTW0pu3oDLmJidpjpgTh1kj3tfx2Y/FRKiHPycJs4gNh6us9r9
         +nWFxGQZkD19JhD5t2OFbOKprkLfYwL15X8qMsc1L8fCrZX4QSIFOqpajC56lfshpg
         0KJrKmuNNJK9UiCkzq7dCxS8MNr9vY5D0DMDe55c=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 0/4] patches for FPGA
Date:   Wed,  7 Nov 2018 11:51:44 -0600
Message-Id: <1541613108-29660-1-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please take these four small fpga fixes patches.  They
have been reviewed on the mailing list and apply
cleanly on current linux-next and char-misc-testing.

Thanks,
Alan

Anatolij Gustschin (1):
  fpga: altera-cvp: fix 'bad IO access' on x86_64

Andreas Puhm (1):
  fpga: altera-cvp: Fix registration for CvP incapable devices

Mike Looijmans (1):
  zynq-fpga: Only route PR via PCAP when required

YueHaibing (1):
  fpga: dfl: fme: remove set but not used variable 'priv'

 drivers/fpga/altera-cvp.c | 15 +++++++++++++--
 drivers/fpga/dfl-fme-pr.c |  2 --
 drivers/fpga/zynq-fpga.c  |  4 ++++
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.7.4

