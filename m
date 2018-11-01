Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E532C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114102251C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HeWpV6gM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114102251C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeKBIsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:48:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeKBIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kYodn+jQwdLoVno5s35N/0INSeG4+NM/NdR1TpRcWGE=; b=HeWpV6gM///AbKOLT7uuDeH4yW
        sGvH2j9p5UXZ6iEWkGwPuCaWHimsDQyDuEZFi7CrQoUaJ+cY1Rqia1BiedUee16TVUxp+CLYzrTxM
        0tEj8VTlYef6LYigx5y20TabhsvlodWf1dV9Aq8PlWqY6n54Q7tO1YEEqoUaXpCpfriAvQ6SOZgfz
        /gmGrNRumadnizf8+91IuXY0nocrPKFj6zCFqb9Jz3iGbjLQwDP3T+jf/Zvj2ftbll9gLO60gykbz
        GWaPVEMLL4MbgXvpqQjU/wFLnFI8Pj/wMIRION3XEQkwLf8dfZy/upidN/8vP37A8vHfhw3njO+R/
        UVyPxI7Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIMc1-0000p0-9Z; Thu, 01 Nov 2018 23:42:53 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend] scripts/faddr2line: fix location of start_kernel in
 comment
Message-ID: <1d50bd3d-178e-dcd8-779f-9711887440eb@infradead.org>
Date:   Thu, 1 Nov 2018 16:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a source file reference location to the correct path name.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/faddr2line |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20181101.orig/scripts/faddr2line
+++ linux-next-20181101/scripts/faddr2line
@@ -71,7 +71,7 @@ die() {
 
 # Try to figure out the source directory prefix so we can remove it from the
 # addr2line output.  HACK ALERT: This assumes that start_kernel() is in
-# kernel/init.c!  This only works for vmlinux.  Otherwise it falls back to
+# init/main.c!  This only works for vmlinux.  Otherwise it falls back to
 # printing the absolute path.
 find_dir_prefix() {
 	local objfile=$1

