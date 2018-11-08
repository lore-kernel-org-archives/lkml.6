Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB8C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0681C20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="G8/FE/FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0681C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeKIJDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:03:02 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:34730 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeKIJDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:03:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 9C48D40498;
        Fri,  9 Nov 2018 00:25:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1541719507; x=1543533908; bh=sosOOG4S7ZVAH0KBW1GrMurDPj+6dQqHbNp
        ziQe8Xw0=; b=G8/FE/FELZ+iFc9m0PvSGx2e3piq/HQZQJYY0+ZyU8xplndcxO9
        O3GhqgcxgkpIzfRxKqnEmeIH1sIERbGVm4r9yD1g6Uh9zum23jydJgwa6asdlCzz
        1ApSc4IfXaE9328PWxFzcDjT/yk2QBEz8rsYn9eLrdXzvc/ob2yGPGtYgYxbx1JE
        Z24gUV/wNuCo//plNQG56BhTaDqiv1fI/qpC5SDIOzT3sv+QiXPVmDIjvgXCIRms
        6J6T5PwAUke+yS1QyWRFkqONLsFCQN6RGlVTahI1WMQd3wU0Cd77m1buo2E8gh/g
        dk3MMXYvqO9XqzsJdOcDyeZmzB2iAmLlVOr4FcgmUfJMgRlTofq7kN4IDA94I4jg
        IWXT9wEZne+A/8fgJw6SKqIlOK0SFUpowx4rcbFvyqY86qjSMDIkgTK35XsMxD7T
        My8PMFksycGb7IUK+0X3SxGZu8mGlXy9vzHeznTywnReQ/IuJHGYi6C8HraoapBm
        mgxW1sYSOdu0tpQdczRnzuxiiB4fo7fTZeX9rVt6fEbP+44mlyvju0pRlxgwOimt
        aQTuYzxzadyAVgdhIQUWvhB1mRrPF6O5IBXnpqwXMjtDnKrAzRnNYmksUF0M5wDU
        MNoPtiUa/XiIQQ3qC2jOQDfPofsspXDjBmCE7+1SHUNTEvEqlP1aRWh8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TEBKA5R9TNJr; Fri,  9 Nov 2018 00:25:07 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 059A0403A1;
        Fri,  9 Nov 2018 00:25:07 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id A32CC2CB;
        Fri,  9 Nov 2018 00:25:06 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 3/3] doc:it_IT:doc-guide: fix reference to foobar
Date:   Fri,  9 Nov 2018 00:24:17 +0100
Message-Id: <20181108232417.14982-4-federico.vaga@vaga.pv.it>
In-Reply-To: <20181108232417.14982-1-federico.vaga@vaga.pv.it>
References: <20181108232417.14982-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replicate the following patch into italian translation

1bb37a35671c  doc-guide:kernel-doc.rst: Reference to foobar

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/it_IT/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index 2bf1c1e2f394..a4ecd8f27631 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -107,7 +107,7 @@ macro simil-funzioni è il seguente::
    * Context: Describes whether the function can sleep, what locks it takes,
    *          releases, or expects to be held. It can extend over multiple
    *          lines.
-   * Return: Describe the return value of foobar.
+   * Return: Describe the return value of function_name.
    *
    * The return value description can also have multiple paragraphs, and should
    * be placed at the end of the comment block.
-- 
2.19.1

