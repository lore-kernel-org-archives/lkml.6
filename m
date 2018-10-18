Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABAECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224EA2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224EA2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJRQz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:55:58 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:51619 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeJRQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:55:58 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9I8ai2L003391
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:36:44 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8aWYk003353;
        Thu, 18 Oct 2018 16:36:32 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:34:38 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <deanbo422@gmail.com>, <zong@andestech.com>,
        <ebiederm@xmission.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 0/3] nds32: Unaligned access handler fix
Date:   Thu, 18 Oct 2018 16:34:31 +0800
Message-ID: <cover.1539654056.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8aWYk003353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches are about unaligned access handler. We fix some
bugs in unaligned access handler and add some kernel configs
for unaligned access handler. Then we add the kernel unaligned
access handled by software in handler.

Nickhu (3):
  nds32: Fix instruction simulator bug for unaligned access handler.
  nds32: Add 'HAVE_EFFICIENT_UNALIGNED_ACCESS' config
  nds32: Add unaligned access in kernel space.

 arch/nds32/Kconfig.cpu    |  3 ++-
 arch/nds32/kernel/traps.c |  4 +++-
 arch/nds32/mm/alignment.c | 43 +++++++++++++++++++++++----------------
 3 files changed, 30 insertions(+), 20 deletions(-)

-- 
2.17.0

