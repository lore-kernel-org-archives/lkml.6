Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7C5C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1762084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wPMH3BXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1762084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeKCDul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:40 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E31E2084A;
        Fri,  2 Nov 2018 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184148;
        bh=1Tf8/pXYg4ECIz6EbyZPPAYlTaNPNvpynwZBkFr8s2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wPMH3BXMC7HhyPlekks0+UFk612UQNo7FHHs6Q2Yhei0Mh05cnpU4SAPgys0RpZp2
         tVhG/yGa1pAIcYSAskvU2Iy9nWhXgNaa08mTY0DVO4MHGKsibZiiFzKyJ+wDElwVj3
         cGMPRhaa85VQJoYqWUz52LOhQF7jh+w3ovAIfHSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 094/150] selftests: rtnetlink.sh explicitly requires bash.
Date:   Fri,  2 Nov 2018 19:34:16 +0100
Message-Id: <20181102182909.992480659@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3c718e677c2b35b449992adc36ecce883c467e98 ]

the script rtnetlink.sh requires a bash-only features (sleep with sub-second
precision). This may cause random test failure if the default shell is not
bash.
Address the above explicitly requiring bash as the script interpreter.

Fixes: 33b01b7b4f19 ("selftests: add rtnetlink test script")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 0d7a44fa30af..8e509cbcb209 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # This test is for checking rtnetlink callpaths, and get as much coverage as possible.
 #
-- 
2.17.1



