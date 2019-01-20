Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A8AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C59E2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="V4T9QiZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfATLRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 06:17:02 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:37496 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfATLRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 06:17:01 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 80F14403E6;
        Sun, 20 Jan 2019 12:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1547983018; x=1549797419; bh=u5PJQeq4w4A5yhgLWfl
        aalMoIP8exjuFkUijpjiiGZc=; b=V4T9QiZGuFNjVv2DnTQ7UAYec0oCZCbTsAc
        yb/OLWpmehnEO8DVce0K5M6y7Tjj0EFd6fxyAfy/7089tPfze+O4ho3x9OIpnf6D
        qPuxygFyETspT8aO5TF4HGhZBFJ9vya3EwjxNv7XVSt7ZNFTd/oQ2P9bF7xXFk7t
        YLQsjf4C59xufLmPP9QS4CeO+3kJTfG4jW/9nwvuXI8FHhIUbo6vcwnjoAisbIwO
        McyG/VZWIsbMlI0k3+tAbfjLxWp9LXXaaaNwpRZCREwKuA2DW+/g3WjS0BS1NY+1
        8jSRSIGfdh+P8L5OK8v2ewH6GZCQWPV+vCTjDFssWbvEIVFwynuOL0N7L9h6xDlI
        RSbxmUIs/p6zgWh8GTjuXML+tdmlfH4Q5Et+1zEfJeFEGnQQXc1jgQH3xcj78yPG
        XJEC0Tro8QLJdC9AQpdqibY0TCbnbnNnyqC20ygZagX8R8PIOujY9fbH6ZVFZ3jz
        c8YmW5REWE26XaaZoWh5NqJ3jjvlPzftObhVpqowX0Ps1HlwmNDH5DGZ1ULY73Uh
        ON8YmDlriCj3S4CIBFfMn9fjl8h1TrJI1R5rvgM9tIwE8/XlEX8iMH3szC2N00+k
        hFXCnyNpV8avmsI7cnjl9owgNFwFZgvvApI7L0Oby09X8DbVI7g/Ms2VmslkpOlr
        M9kFuRM4=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lm-C7Rw9fiJH; Sun, 20 Jan 2019 12:16:58 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id DFDB8403BB;
        Sun, 20 Jan 2019 12:16:58 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 6E1E83D7;
        Sun, 20 Jan 2019 12:16:58 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:process: add missing internal link in stable-kernel-rules
Date:   Sun, 20 Jan 2019 12:16:29 +0100
Message-Id: <20190120111629.31681-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep consistent the document. In the document, option references
are always linked, except for the one I fixed with this patch

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/stable-kernel-rules.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 0de6f6145cc6..070e3f04d183 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -98,9 +98,9 @@ text, like this:
 
     commit <sha1> upstream.
 
-Additionally, some patches submitted via Option 1 may have additional patch
-prerequisites which can be cherry-picked. This can be specified in the following
-format in the sign-off area:
+Additionally, some patches submitted via :ref:`option_1` may have additional
+patch prerequisites which can be cherry-picked. This can be specified in the
+following format in the sign-off area:
 
 .. code-block:: none
 
-- 
2.20.1

