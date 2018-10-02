Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE5C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D5B20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D5B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=corsac.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJCDck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:32:40 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:42732 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJCDck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:32:40 -0400
Received: from mail.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20::5])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 5BBB6780372
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 22:47:27 +0200 (CEST)
Received: from scapa.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20:6af7:28ff:fe8d:2119])
        by mail.corsac.net (Postfix) with ESMTPS id DD33290
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 22:47:23 +0200 (CEST)
Received: from corsac (uid 1000)
        (envelope-from corsac@corsac.net)
        id a03b5
        by scapa.corsac.net (DragonFly Mail Agent v0.11);
        Tue, 02 Oct 2018 22:47:23 +0200
Date:   Tue, 2 Oct 2018 22:47:23 +0200
From:   Yves-Alexis Perez <corsac@corsac.net>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org
Subject: [PATCH] yama: clarify ptrace_scope=2 in Yama documentation
Message-ID: <20181002204722.GA9610@scapa.corsac.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current phrasing is ambiguous since it's unclear if attaching to a
children through PTRACE_TRACEME requires CAP_SYS_PTRACE. Rephrase the
sentence to make that clear.

Signed-off-by: Yves-Alexis Perez <corsac@corsac.net>
---
 Documentation/admin-guide/LSM/Yama.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/Yama.rst b/Documentation/admin-guide/LSM/Yama.rst
index 13468ea696b7..d0a060de3973 100644
--- a/Documentation/admin-guide/LSM/Yama.rst
+++ b/Documentation/admin-guide/LSM/Yama.rst
@@ -64,8 +64,8 @@ The sysctl settings (writable only with ``CAP_SYS_PTRACE``) are:
     Using ``PTRACE_TRACEME`` is unchanged.
 
 2 - admin-only attach:
-    only processes with ``CAP_SYS_PTRACE`` may use ptrace
-    with ``PTRACE_ATTACH``, or through children calling ``PTRACE_TRACEME``.
+    only processes with ``CAP_SYS_PTRACE`` may use ptrace, either with
+    ``PTRACE_ATTACH`` or through children calling ``PTRACE_TRACEME``.
 
 3 - no attach:
     no processes may use ptrace with ``PTRACE_ATTACH`` nor via
-- 
2.19.0


-- 
Yves-Alexis
