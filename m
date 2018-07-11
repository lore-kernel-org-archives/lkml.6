Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50596C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E312C20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="BYJmsPcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E312C20C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbeGKTOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:14:54 -0400
Received: from bosmailout10.eigbox.net ([66.96.189.10]:47753 "EHLO
        bosmailout10.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbeGKTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:14:53 -0400
X-Greylist: delayed 1811 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2018 15:14:53 EDT
Received: from bosmailscan04.eigbox.net ([10.20.15.4])
        by bosmailout10.eigbox.net with esmtp (Exim)
        id 1fdK14-0000I1-E0
        for linux-kernel@vger.kernel.org; Wed, 11 Jul 2018 14:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:Message-Id:Date:Subject:To:From:Reply-To:Cc
        :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bqsjo+f7DypH/mu/6GfajloXIs2zRirnKGYAvq+9Bjk=; b=BYJmsPcUKe//GuOXwf+c6SlDR3
        WPpV56a/7/aqWiVcjtMJz6/Gpge1WSrrLxtr4V5Oa7ckAyBCZuJiJCavSCdnUYWo3DP3HwEJT1Qo+
        nUjEhFhgYY1c7cSoDIqWXgccCLC1xsIv9b4b9Xn5wUHfS+K3Iafs0/43hyh39ZvHVgiR0CMcjVtSi
        GaviMjea+P5HHld36E1quYwMTjiUStKgaZ5UGZbCtYeZjHD+p9Ydw0fyrPC/+3+H4LDcxzXuiGFy5
        PuROH5eHAlYlJFOsjLgyGH8R3vZlTcwtJYfI+u40Fjw/UGSPmQfJQcWAHINGJViFS10qtihMg0lUM
        TIKEFDSg==;
Received: from [10.115.3.31] (helo=bosimpout11)
        by bosmailscan04.eigbox.net with esmtp (Exim)
        id 1fdK14-0007C1-Ah
        for linux-kernel@vger.kernel.org; Wed, 11 Jul 2018 14:39:06 -0400
Received: from bosauthsmtp17.yourhostingaccount.com ([10.20.18.17])
        by bosimpout11 with 
        id 9Wf01y00R0N5uqq01Wf3e6; Wed, 11 Jul 2018 14:39:06 -0400
X-Authority-Analysis: v=2.2 cv=PN5/wbiC c=1 sm=1 tr=0
 a=f4kFLigMKr8AH7rIJ//qJA==:117 a=Dlu3QSMc4l9Ye4MXzL7CyA==:17
 a=R9QF1RCXAYgA:10 a=c2dxBoeyqOUA:10 a=dSbym95GAAAA:8 a=LctjhZXQU1kGAagAwoEA:9
 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [37.142.20.114] (port=12213 helo=localhost.localdomain)
        by bosauthsmtp17.eigbox.net with esmtpa (Exim)
        id 1fdK0y-0003Ex-L1; Wed, 11 Jul 2018 14:39:00 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Constantine Shulyupin <const@MakeLinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scripts/tags.sh: add __ro_after_init
Date:   Wed, 11 Jul 2018 21:36:42 +0300
Message-Id: <20180711183646.4022-1-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 37.142.20.114
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 66f08bb1cce9..412a70cce558 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -245,7 +245,7 @@ exuberant()
 {
 	setup_regex exuberant asm c
 	all_target_sources | xargs $1 -a                        \
-	-I __initdata,__exitdata,__initconst,			\
+	-I __initdata,__exitdata,__initconst,__ro_after_init	\
 	-I __initdata_memblock					\
 	-I __refdata,__attribute,__maybe_unused,__always_unused \
 	-I __acquires,__releases,__deprecated			\
-- 
2.17.1

