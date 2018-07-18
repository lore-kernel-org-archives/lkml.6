Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE312ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925CC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hk69AUoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925CC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbeGRBiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:38:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbeGRBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:38:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1498EDF42;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=msGo
        G7BxDRXFQvdEbTnebXwVP5E=; b=hk69AUoom8AvtyRNcbVhrmzdw+THwpg1tiZq
        iPdfrPHfdTQJ/Ma1q4Dap73ukiF12ALg0gjQFtm7UidQKTGMiPBtVMYdl8KbNv4+
        jwBDJLjJ90QAS2RKHA62qzNzoOLQk9OclpJQsRPtLiUwYwFuSYsImMrcDVdzCQ6D
        aatDXMo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7B0DEDF3F;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47D72EDF3D;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 7A60D2DA0698;
        Tue, 17 Jul 2018 21:02:44 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: [PATCH 3/3] vt: add /dev/vcsu* to devices.txt
Date:   Tue, 17 Jul 2018 21:02:42 -0400
Message-Id: <20180718010242.5254-4-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718010242.5254-1-nicolas.pitre@linaro.org>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org>
X-Pobox-Relay-ID: 47D1D3D2-8A26-11E8-98DB-063AD72159A7-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also mention that the traditional devices provide glyph values whereas
/dev/vcsu* is unicode based.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 Documentation/admin-guide/devices.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 4ec843123c..1649117e60 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -173,14 +173,18 @@
 		they are redirected through the parport multiplex layer.
 
    7 char	Virtual console capture devices
-		  0 = /dev/vcs		Current vc text contents
-		  1 = /dev/vcs1		tty1 text contents
+		  0 = /dev/vcs		Current vc text (glyph) contents
+		  1 = /dev/vcs1		tty1 text (glyph) contents
 		    ...
-		 63 = /dev/vcs63	tty63 text contents
-		128 = /dev/vcsa		Current vc text/attribute contents
-		129 = /dev/vcsa1	tty1 text/attribute contents
+		 63 = /dev/vcs63	tty63 text (glyph) contents
+		 64 = /dev/vcsu		Current vc text (unicode) contents
+		65 = /dev/vcsu1		tty1 text (unicode) contents
 		    ...
-		191 = /dev/vcsa63	tty63 text/attribute contents
+		127 = /dev/vcsu63	tty63 text (unicode) contents
+		128 = /dev/vcsa		Current vc text/attribute (glyph) contents
+		129 = /dev/vcsa1	tty1 text/attribute (glyph) contents
+		    ...
+		191 = /dev/vcsa63	tty63 text/attribute (glyph) contents
 
 		NOTE: These devices permit both read and write access.
 
-- 
2.17.1

