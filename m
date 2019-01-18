Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF9C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8820D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="hftwyaLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfARV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:58:28 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:20676 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbfARV61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:58:27 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 7F4654067A;
        Fri, 18 Jan 2019 22:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1547848704; x=1549663105; bh=JLoYwAlER0Y9DmEB0Cm
        X920G4MVLSZxGYhZy36IMzm0=; b=hftwyaLb6TXNWJ+iupE8v97QTpoQEmvw3Mz
        FBd/MJR3l4VPsGpHdbDUaTmPV1Lm90oA4/Vi0TpL67wnnYrpwGnMbFajCbGmixiY
        7XM1zTOWnLPJiLrGqP2rsR8IFZM3qsg0ES8ptzH4SpSbNpOmRr5tX0tS0EcfGYlJ
        CFndFhKpBMxwKfIk++8SrD7Iefi8HMuO1Hb6SHaSXljfTaiihofHMQLfxmf3OirS
        pMoxS+XyBi+MLpWfeW2I54GzYHAGyyc1a7tWVeSit8xQ6w9P++4SF4ovIlVnr2+x
        6L9OCkF3kkb6dSPzs8c5ry4YGaFjxSJlebHJ/BcayuS5AjAWBV+v5q+V+SJLyH/J
        dxFTSKGxz+Jvx4pIhZrT8NDI9ZFj36SgTZxhCrdPUxS5Z3X5ii0CuABSa2l6O30n
        7VWdIw+HHBA1qhPnL2BN1yAkGjn15goyzAN6qXm3Wf2HHu4yoI1LMxLC+nLQzJRl
        jZaE7VnMBZAed42sVmEtbh/yZtX1HSDqJvLeBoDWKXgVhoVNEQUCCEzlendVfJhp
        PFPofdikQcu9Q3DsHnkxTGGljWFHgJGzexyTrBbO5eb9reJQM1ZCvSW8lnaKrck0
        JrOtMcxsbUq5Xcz3imB9yLByG25UpRhwGeHdZfWlcdIJKbEuCGIS1bcmJ3G6zGFf
        n6gMeDyA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j_A9YLnrVlDj; Fri, 18 Jan 2019 22:58:24 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id C3852404B2;
        Fri, 18 Jan 2019 22:58:24 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 1CD633BD;
        Fri, 18 Jan 2019 22:58:23 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg KH <greg@kroah.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:process: remove note from 'stable api nonsense'
Date:   Fri, 18 Jan 2019 22:58:04 +0100
Message-Id: <20190118215804.3340-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link referred by the note can't be retrieved: this patch just
remove that old note.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/stable-api-nonsense.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/process/stable-api-nonsense.rst b/Documentation/process/stable-api-nonsense.rst
index 24f5aeecee91..57d95a49c096 100644
--- a/Documentation/process/stable-api-nonsense.rst
+++ b/Documentation/process/stable-api-nonsense.rst
@@ -171,8 +171,7 @@ is also a rough job.
 
 Simple, get your kernel driver into the main kernel tree (remember we
 are talking about GPL released drivers here, if your code doesn't fall
-under this category, good luck, you are on your own here, you leech
-<insert link to leech comment from Andrew and Linus here>.)  If your
+under this category, good luck, you are on your own here, you leech).  If your
 driver is in the tree, and a kernel interface changes, it will be fixed
 up by the person who did the kernel change in the first place.  This
 ensures that your driver is always buildable, and works over time, with
-- 
2.20.1

