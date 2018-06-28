Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D82FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269502588F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hObBr1Yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269502588F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeF1B41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbeF1B4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:56:24 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89572258A0;
        Thu, 28 Jun 2018 01:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530150984;
        bh=WfHr8Tx4ZYlw18uHR12tPzYvtfrnUjEsxIAZxpy2Opk=;
        h=From:To:Cc:Subject:Date:From;
        b=hObBr1YyFijg88AveeKpAIvafe8Ub2oWShElTGOOC26z6WRYfkhidy2FwwbP2DHZw
         2SweH3k9sk8QVrKTzPrR1u9lyah+QHqPhibCQtum2lgBXrHju8KSiEroaWmKUq+mVP
         aq2xVX5/wiDZjaAqkeoTtbnTF3CpgLNDUzAQsC9M=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: [PATCH 0/2] fpga fixes
Date:   Wed, 27 Jun 2018 20:56:17 -0500
Message-Id: <1530150979-5693-1-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please take these two patches of fixes for FPGA.  They apply cleanly on
current linux-next.  They were reviewed on the mailing list.

Alan

Alan Tull (1):
  Documentation: fpga: cleanup

Christophe Jaillet (1):
  fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'

 Documentation/driver-api/fpga/fpga-mgr.rst    | 12 ++++++------
 Documentation/driver-api/fpga/fpga-region.rst | 12 ++++++------
 Documentation/driver-api/fpga/intro.rst       | 14 +++++++-------
 drivers/fpga/altera-cvp.c                     |  6 ++++--
 4 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.7.4

