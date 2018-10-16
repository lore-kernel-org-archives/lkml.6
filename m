Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95754C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF002086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="i8zOPn8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF002086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korte.land
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJPQrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:47:09 -0400
Received: from o3.31pqt.s2shared.sendgrid.net ([167.89.55.59]:16637 "EHLO
        o3.31pqt.s2shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbeJPQrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
        h=mime-version:content-type:content-transfer-encoding:from:to:cc:
        subject;
        s=smtpapi; bh=QyMYDS0XVVnOyQIuRHG77IxGrCXgyIdEZNDUWVy/0TE=;
        b=i8zOPn8Unc0N+MjgHkqRVraDBqbkfJVu5RGKJFfYiwvQFuVLnexkNGRp/8i6eOcgR+Ks
        ssMwdfxBtF/WgbeSFsIrI8ygOICLCcfa0hMehDRd8IYV6Ky2AXFgERwIDiF5oVLgMf4Q8S
        slxGoUOa9SunjxDF7QNegQzbn65uuqcOk=
Received: by filter0008p2mdw1.sendgrid.net with SMTP id filter0008p2mdw1-16878-5BC5A808-9
        2018-10-16 08:57:44.262606893 +0000 UTC m=+309092.011588282
Received: from korte.land (unknown [146.185.150.169])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id BCV83WFEQSyi8lOARxWJjg
        Tue, 16 Oct 2018 08:57:44.141 +0000 (UTC)
Received: from mail.korte.land (localhost [127.0.0.1])
        by korte.land (Postfix) with ESMTP id CCAEE60269;
        Tue, 16 Oct 2018 08:57:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Oct 2018 08:57:44 +0000 (UTC)
From:   Will Korteland <will@korte.land>
To:     gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/uio: fix a grammar nitpick
Message-ID: <7e426c03c0e342ade7ce86a977ef13b2@korte.land>
X-Sender: will@korte.land
User-Agent: Roundcube Webmail/1.3.6
X-SG-EID: =?us-ascii?Q?cUnx5NqAuhUbAHG4iZ9Vx1BO6oMeAW3Kqk+xSEzhkR48c1futjyLp2=2Fwp8OUBt?=
 =?us-ascii?Q?=2F5X+h1tdyY33lVKbOQVGXUFTE+NVkXoU+gX6pMe?=
 =?us-ascii?Q?=2FEh1lHGF1qj4vIWo7bSTConpdR3lwoJLCv2atSx?=
 =?us-ascii?Q?vYyjVbFL6LvWN=2F27P7xO92KajGQARLd0yrsbKLk?=
 =?us-ascii?Q?WioW4=2FVA=2FeuJomAJ=2FuwhGtgqnNaemU4WiZ0Sqpc?=
 =?us-ascii?Q?AKm0i5bzMO9TKmb+VYfXmUV98vpB4pyIX+8TmS?=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a minor, incorrect piece of grammar in the UIO howto.

Signed-off-by: Will Korteland <will@korte.land>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
The sole change since v1 is that I re-did the patch against
linux-next-20181016 instead of linux. Sorry for the extra work Greg, and
thanks Randy for the acked-by.

  Documentation/driver-api/uio-howto.rst | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/uio-howto.rst 
b/Documentation/driver-api/uio-howto.rst
index fb2eb73be4a3..25f50eace28b 100644
--- a/Documentation/driver-api/uio-howto.rst
+++ b/Documentation/driver-api/uio-howto.rst
@@ -463,8 +463,8 @@ Getting information about your UIO device

  Information about all UIO devices is available in sysfs. The first 
thing
  you should do in your driver is check ``name`` and ``version`` to make
-sure your talking to the right device and that its kernel driver has 
the
-version you expect.
+sure you're talking to the right device and that its kernel driver has
+the version you expect.

  You should also make sure that the memory mapping you need exists and
  has the size you expect.
-- 
2.19.1
