Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9542C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C6520862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C6520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeICXDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:03:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:53541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbeICXDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:03:30 -0400
Received: from LT02.fritz.box ([88.152.14.153]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MIu7d-1fuQxS2xHF-002UGa; Mon, 03
 Sep 2018 20:41:59 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] docs: kernel-doc: fix parsing of function pointers
Date:   Mon,  3 Sep 2018 20:41:53 +0200
Message-Id: <20180903184153.9368-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:57cWkZ2zjtKcPqe+4gPBbt/1hZgllh/wWr3+rQWnI0dcMOqg2HQ
 bd+Run4udJFC6nMKE1H1frPQoVKI2GX0rV2nWO+TRKCRRv9OA66o+wMqvVVEFiHci1S8nIJ
 padrK+LNu9qcv8rGWOhyGq4xuWukJTKZSDOSs3nt+IIjGFmHXCfSVNHXyd4zKtnB9f8oWtl
 OnPd2n8pY6oAEo1zHYf8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sZldF3BiGJo=:apEClFNf2MqraO+cNZ7044
 38kUo1M4uUZuIqNcNQF2rT8lZYJAoHOEB3EjHCsccg6kyV5ROytKEZp1zuXlmC+fVaQpuJXFm
 x14oazRRyTS0uf5Vivv98pWtlcey2iPtYi386WOrbuREsPZz+en4Gk4k65tmd2psTPgxGSJix
 awcAQR9M4TiO9bRV/6i8t495upVRWeVyZSbMyx8q2K4F/MXSPYrH+6jjSxerRgTCocuyJOkds
 HFmwQByw7crBW4jiu9AA0gyVC/+jQtIObHPinmO01hdHonJqOvVmqC4ZjgpyX4IUJeUKJ7mxj
 POL5ccDcbWm9ln5DnYNgLTQ57dAA75ComxKfR1LbslyhvICIoFnzDN5N9n2/udKt6uUtUmNE7
 DwG/k1/Tdff7693C4sQHhzd1hcvjvXHFnakAGmcqGF8Q5w56/e9DkAy48tmWVUaxPxaOt1uFl
 7R31kiYJifk6YiReQGNRJEa61y7r5Xu76u44GhgefQwDEbEsVYGgiM64nH9+C3H4eTO2z5n9I
 8uOXjowN2qmVQVxLhtXWCBKxPRFkhYotXaT2Iq7ahx53o963ABBUDdG75IpSFB09d99hEOicL
 J4Ud9xnyst4GI8EIWpgmDxouThrAtypR9c/LlYusQe6DNjULo/SZkCR3k4lAkG+FJyufWyc15
 IqfoaI52qPNwUrVeWMnTDChmNqAYIEJVkfxrPoSoH1ww/WK9/1xpopZmaE7g+k1uGN3bu99VC
 afbjaCLJDjE3PB7aQKEUcrJJtEt/688VzuJLi285/11CryV+nnasVWxKYgQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same script kernel-doc is used by the U-Boot project.

kernel-doc fails to parse function definitions like the one below

efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
			      void (EFIAPI *notify_function) (
					struct efi_event *event,
					void *context),
			      void *notify_context, efi_guid_t *group,
			      struct efi_event **event)
{

due to the "EFIAPI" attribute preceding the function name.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 31a34ced55a3..597e3223b791 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1381,7 +1381,7 @@ sub create_parameterlist($$$$) {
 	} elsif ($arg =~ m/\(.+\)\s*\(/) {
 	    # pointer-to-function
 	    $arg =~ tr/#/,/;
-	    $arg =~ m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;
+	    $arg =~ m/[^\(]+\([\w\s]*\*?\s*([\w\.]*)\s*\)/;
 	    $param = $1;
 	    $type = $arg;
 	    $type =~ s/([^\(]+\(\*?)\s*$param/$1/;
-- 
2.18.0

