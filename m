Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F714C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD5F24284
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj+u73p4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD5F24284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeF0FRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeF0FRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:17:20 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34763214C4;
        Wed, 27 Jun 2018 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530076640;
        bh=od2Xrp0vVF4f39NYeYRcbDs8UbOoYPAjhif789qS968=;
        h=From:To:Cc:Subject:Date:From;
        b=mj+u73p4combgBu+9WRuSrE/hGSLKjqSunbxPWbJvNuCrolZNQr770Ug2TBjTEkte
         ov4sxdh7PNzg6knDyGtBW5/k1+3HnfF/T9T50o9eu3PeEA+Bg7FsJT57BPTA7KlLnw
         c7PS2e1oXkfNS8Kvg+jOPxBtdFw9J7BtX82IUjTE=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] A fix and a cleanup to the x86 sigreturn selftests
Date:   Tue, 26 Jun 2018 22:17:16 -0700
Message-Id: <cover.1530076529.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sigreturn_64 selftest has always failed on AMD CPUs.  Fix it and
clean it up a bit.

Andy Lutomirski (2):
  selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs
  selftests/x86/sigreturn: Minor cleanups

 tools/testing/selftests/x86/sigreturn.c | 59 +++++++++++++++----------
 1 file changed, 36 insertions(+), 23 deletions(-)

-- 
2.17.1

