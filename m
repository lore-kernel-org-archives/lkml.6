Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA0D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="DxHcfH9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA0D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeIDXbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:31:46 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21320 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536087893; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Tzob6UMQyib+vU9cGjSTcZeIEiLJgM/S1F3NWN9pGM6jW2W3W6WgSFkr9YGnUZ3X50dA9curRC1p8NscNfNb4UvbRqVlSZZuJy2Y+AJNZh12vTDq1/I17kQaH1Ex66eQgq0nVC20MXEQiTJV/8V6/4H2Itk80v32sHnx6De2PGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536087893; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Pf2PRmgsIQHYNQn5EGGqBJisgszcDAV41VbdQqssaeQ=; 
        b=PbnaATDL0sTi31O9Jo2IY7EkNlzxLUPDGOEPZqRFlC5NuJcsBBOrQrF/7Y1/u0uTrWq/uRppIvpIEMb4FNo8gT/IcZvByrcD8ATbjStUQrxIovQ4UAqkmYBZqm4AbBk6DtstY4sdpBa2iYL/jDM1+MuCidSTosH9XoXmTUbIioA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1536087893;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=787;
        bh=Pf2PRmgsIQHYNQn5EGGqBJisgszcDAV41VbdQqssaeQ=;
        b=DxHcfH9njXT9+mrLGf9tHH4AryPamUYGh7z4Wu1epVraLPkfVKeRsVscHKC8jKjk
        4u5zsbd1W3iKbqUiAGEWgL91F/eGu44OVsOiuV7eP8qb88Ur6oxGyeQ1BNNemR2iq5v
        BuuKYIgfQkzIhh2YwSMXvBzQ91z3Js0Lay2nrVMs=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1536087893529337.82404336156753; Tue, 4 Sep 2018 12:04:53 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: add entry for fxas21002c gyro driver
Date:   Tue,  4 Sep 2018 21:04:34 +0100
Message-Id: <20180904200434.10442-4-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904200434.10442-1-afonsobordado@az8.co>
References: <20180904200434.10442-1-afonsobordado@az8.co>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for fxas21002c gyroscope driver and add myself as
maintainer of this driver.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b7b24b145f0..faf5f41b1465 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5838,6 +5838,13 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/usb/gadget/udc/fsl*
 
+FREESCALE FXAS21002C
+M:	Afonso Bordado <afonsobordado@az8.co>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/gyro/fxas21002.c
+F:	Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
+
 FREEVXFS FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 W:	ftp://ftp.openlinux.org/pub/people/hch/vxfs
-- 
2.18.0


