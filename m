Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB9C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28AE20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28AE20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeJLUJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:09:14 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeJLUJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:09:14 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkHEN-1fmvXH0NYH-00kjiN; Fri, 12 Oct 2018 14:36:26 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkHEN-1fmvXH0NYH-00kjiN; Fri, 12 Oct 2018 14:36:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] rxrpc: add IPV6 dependency
Date:   Fri, 12 Oct 2018 14:36:16 +0200
Message-Id: <20181012123624.2001922-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:WiIoDQenrtwnN8/kruEhqVqt3WvjVX8hBGlzPW+ibnSxKcWWORU
 q/K+Imdji6+eIif0nccNt/CQqlnsIeXRumVPn8KJr+ZomSW8vbFgqWxP/V/DzT2uDbNsyML
 BohbWlXWhM3D7uOca4FdLliF8Eli0lh+7yNq8vBxsG/ePcbHc6sIAnzh1ElyGZrG4WQ/fsz
 qB0Ml3X9A98JJfHzi2lsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ctqIcyHsFxo=:1x2Ey0dhd7ka+FpwJo/xSY
 vwuM/0hcOrjQ39zsQBXQLJBKBa6ZPjdIdNRxInnRxU99jI7slsgwAKmNVFCfvC64FOI/M8p1B
 FGb8r/r0pfM8H9NCnzpu32buuXeUASpUGvoQqtVxgFknOizSIusCMhMCDEEDXfblQC2wFk6ck
 tFd+mRJYYLhExLp7rVU8pAEZYPw26NJDRzuPQy8wGBjtrgaB5hCf1r2HCtwzJAIGI17BYhWVv
 kc2DRP+Xg+HhyykWba7pqYcEsQFl7SDU0d37IJxuCy9zDqlrwRsJ/J02WEvhl3Tb9YlWEclT2
 k2naRrwFm8Rd1eCR7C6QKduRfBaytwKZ+G+E+vAnn9WXW4eoAls64/brB4kctMc5uAxLyZ4zt
 f/Dwx++L5ttyaM8UodoFuKop+YNaEYdAvSlF/pGxUgMRXegk4AARr4qeL08h7ijvm7bZq4niP
 7MXW9QwTOMUUBd3abUJJLgT7BQPhCuKG1pKBCxaXmWEyJiPBoLfHAmEgb1RjoxYapUDXynRzI
 Mv09NEVmHKe/6nizYmuZls0kxthkqbuYbwIV8NMSRFejvkDjPYJ2PqJlSWbi0lK9fpRzcYaBj
 zimE6SRgGWkdzumbDal9/LCqtMDQevlQecJr/Cjy2M/mRcNA6Oo/KtHQTLw6LSecT5iER/TUD
 r3ZMoDdmz5lz+h1tddhVDkdzd/imm1DltA0z3xfmOCR8d+2cmUV3sJN6Lbo+Qg9IzzX8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The udpv6_encap_enable() function is part of the ipv6 code, and if that
is configured as a loadable module, rxcpc cannot be built-in any more:

net/rxrpc/local_object.o: In function `rxrpc_lookup_local':
local_object.c:(.text+0x2688): undefined reference to `udpv6_encap_enable'

Add a dependency that allows building rxrpc with or without IPv6, but
that disallows the broken configuration. Since AFS selects RXRPC,
this needs the same dependency.

Fixes: 5271953cad31 ("rxrpc: Use the UDP encap_rcv hook")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/afs/Kconfig    | 1 +
 net/rxrpc/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index ebba3b18e5da..e2cad2c9d9d8 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -1,6 +1,7 @@
 config AFS_FS
 	tristate "Andrew File System support (AFS)"
 	depends on INET
+	depends on IPV6 || !IPV6
 	select AF_RXRPC
 	select DNS_RESOLVER
 	help
diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
index 86f8853a038c..d925be00fc74 100644
--- a/net/rxrpc/Kconfig
+++ b/net/rxrpc/Kconfig
@@ -5,6 +5,7 @@
 config AF_RXRPC
 	tristate "RxRPC session sockets"
 	depends on INET
+	depends on IPV6 || !IPV6
 	select CRYPTO
 	select KEYS
 	help
-- 
2.18.0

