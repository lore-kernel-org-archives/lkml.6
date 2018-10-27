Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1678C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42D52075D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42D52075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeJ0Vcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 17:32:51 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63977
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbeJ0Vcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 17:32:51 -0400
X-IronPort-AV: E=Sophos;i="5.54,432,1534802400"; 
   d="scan'208";a="283509231"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 14:51:56 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] constify v4l2_ctrl_ops structures
Date:   Sat, 27 Oct 2018 14:16:38 +0200
Message-Id: <1540642600-25840-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make const v4l2_ctrl_ops structures that are only stored in a
const field or passed to a function having a const parameter.

Done with the help of Coccinelle.

---

 drivers/media/i2c/ov5645.c                    |    2 +-
 drivers/media/platform/vicodec/vicodec-core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
