Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D7C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C11521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0UdUVY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C11521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbeJIB5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbeJIB5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:57:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7679A2064A;
        Mon,  8 Oct 2018 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024247;
        bh=87MmQiy5XEVx4QTsPbskllGK7Rh+LZvksjuzm7L135o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0UdUVY+2Bbv/Rwwr6BZl+Dn5mRAn2IQb5sNSr8zcEM2tRJlzjHP4vnCGlbxVs0ll
         c10i8IUfBJhZhc1Nx3S+xhYzeHK54S72i6W2UITwh2ZkuYs5KpY0ky9FpYXi6JGQjh
         8QC0TLYsBl4/domovzLyX8069B7zrzeDUqKaOpuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 53/94] Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"
Date:   Mon,  8 Oct 2018 20:31:34 +0200
Message-Id: <20181008175607.823729530@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit 65099ea85e885c3ea1272eca8774b771419d8ce8 ]

This reverts commit 535fba29b3e1afef4ba201b3c69a6992583ec0bd.

Seems the submitter (er me, hang head in shame) didn't look at the datasheet
enough to see that the registers are quite different.

This needs to be reverted because a) would never work b) to open it  be added
to a Maxim RTDs (Resistance Temperature Detectors) under development by author

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/temperature/maxim_thermocouple.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -267,7 +267,6 @@ static int maxim_thermocouple_remove(str
 static const struct spi_device_id maxim_thermocouple_id[] = {
 	{"max6675", MAX6675},
 	{"max31855", MAX31855},
-	{"max31856", MAX31855},
 	{},
 };
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);


