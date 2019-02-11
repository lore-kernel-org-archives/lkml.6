Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A759C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24448218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfBKMD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:03:59 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBKMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:03:49 -0500
Received: from orion.localdomain ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQNF3-1gfdnS1cyv-00MIRX; Mon, 11 Feb 2019 13:03:43 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 3/3] scripts: mkdebian: fix dependencies
Date:   Mon, 11 Feb 2019 13:03:36 +0100
Message-Id: <1549886616-12609-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549886616-12609-1-git-send-email-info@metux.net>
References: <1549886616-12609-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:yinQI2MbnPmQUBeGYrwLivGdnqDO53NUX6nEkaHclg6pGtiUA+x
 lNTrqEoOVvoIyrLfiTx6el4NawMEleysqcBACjSVNk5duzKQ5Esazq8TT9MjCzd5CWqQzLb
 Rz9zc7CRhmyY0PriNJ5Rs681MRCZ3N59iY4nTa0DqMq2+NpR1UV3bRWvQwV1qSNJxH2fggT
 r67dt/YxMFEVjXXh7B3gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hBm9e2JQzVw=:W0KkDMcZuSTstbAz34OFGw
 9oTYPbo0Y1fm+2lSSwJbNH6oE88L8pZgUUXfWvpYav1ATiEBdfRElgOSRgzqjlTNyeX+oJHZo
 y7rNqh3TrX4Giyblk+cJ5u7dAyZ7D48Cg4AQqWQAZ+9UQvFnFzbT3h3ChsBuLzIakhqeyEUhh
 2/qV6C7gAyg8pOK/viGGV741J9tDVGZ+Kbq7FwjMoCTqNw49KsQGwCpR/4V1dDBci6Ly7SLXz
 zRdpH+fTe8Pp++o8bxX2S6bbxgX/MVNqWt3BFgfBFJ3z9sHqOhhep6dwF1pPSIVQaovJo+93D
 xnksNPYqhHlOwrOlwXlsYHAyGXI7P0NUZd4lrLN97LN++aQrONmHi8fM1yaJquwQEAxUYmI54
 zZVLmpjQ5+OcTcXYQY1R451wVyeVRs9uXOdHZuW4kFJF0pB0LV4r63uAMymfNCfB5PR9Czg9E
 5vhE4wvsNub0guKzS4/IM2HJ2AGoEtjT6i6odOPfHQzy+IeHHnrzH19gj8lOQjKwCYWQOglP6
 fQzAaKkQj/lAMRCCQBvc6SqB6z70ODXfHJY7RD7ZXG0Ik22OdsoYCZNghFN/oNIxPpI9Ypz5c
 AWu2Yk97CHALPlweQJM7uRxiyC96d6Su6DbQi8DasNfhOgwbzD0bN4zZMkxyQGmFqB61OnvXs
 DdcGZnB2CBulO5vWPdm6e04q58GuwlWhQUxdgVUUr18eqlmQvzdef9q8V1kh4wZCrxAcEuBOJ
 EYQX0vDFzlCBYn+Ec7gojSsoa3e2lU2Qy7ffPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We missed some build dependencies in the generated debian/control file.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index ff226be..1caaf0b 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -173,7 +173,7 @@ Source: $sourcename
 Section: kernel
 Priority: optional
 Maintainer: $maintainer
-Build-Depends: bc, kmod, cpio
+Build-Depends: bc, kmod, cpio, bison, libelf-dev, libssl-dev, flex
 Homepage: http://www.kernel.org/
 
 Package: $packagename
-- 
1.9.1

