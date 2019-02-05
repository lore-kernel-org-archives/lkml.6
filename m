Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFB3C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D76E21852
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379255;
	bh=J7Ft4x2TUaamY21nOBKznr3zEJiVARD5WJwMB+ej0tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sNKc4KcgqKmh6P56Zkq5zEzdr3AFGPRRXT9uHarr554y/L8oIf8BeT5CkJJhO19KI
	 pPi1/wT1Z5wntakKU/b0eqf/9zus3fhYLQUC/cMh2vNgwP4I2c618ysSFtpTEF2FkU
	 LdXpJKRORqYIbHml1cJnXXgxdYrkIIqoZT1yaPmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfBEPHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfBEPHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:07:31 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDE62184E;
        Tue,  5 Feb 2019 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379250;
        bh=J7Ft4x2TUaamY21nOBKznr3zEJiVARD5WJwMB+ej0tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SADEYiPJvUfN/llyNv0SnnS4kJ6+60/kaaHHcdNgziWP3deRe+04/cMmdFO2oFlw2
         DPvr5iT7L2wKh8TBINhVdut2/z3zc3wlNEWyxKnLK3sTVqJhPFeVcjFpy6wZiC97oO
         LlhutzD7XWdgx33F3Xt/VqbSdRAOG0xR1fuodAqw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 4/8] tools headers uapi: Sync linux/in.h copy from the kernel sources
Date:   Tue,  5 Feb 2019 12:07:04 -0300
Message-Id: <20190205150708.9012-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in this cset:

  f275ee0fa3a0 ("IN_BADCLASS: fix macro to actually work")

The macros changed in this cset are not used in tools/, so this is just
to silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xbk34kwamn8bw8ywpuxetct9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index f6052e70bf40..a55cb8b10165 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -268,7 +268,7 @@ struct sockaddr_in {
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
 #define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_BADCLASS(a)		(((long int) (a) ) == (long int)0xffffffff)
 #define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
 
 #define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)
-- 
2.20.1

