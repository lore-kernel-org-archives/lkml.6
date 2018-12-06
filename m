Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FDCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA54F2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107380;
	bh=UUzGoy0XG7bk9+EelM1KYEeKQHSqX8St6oGMxXgXj2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTl2ZMLBUBQk9b6Rhevsfprh5rsE0/iouEv5zCPyVOF5oi7azIE/LsIIHsyu9Yehh
	 1iE01EbjC8jNJd6nay0Lh4rWoANhp/T/royl2Ty9ISYXPd0CtcEfbD/VWWBWnSAR5O
	 Gp8GSiUw+2zKoE+GLUrhMsYU5XFwhIENxKa8dzBw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA54F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeLFOm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbeLFOmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9456920661;
        Thu,  6 Dec 2018 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107374;
        bh=UUzGoy0XG7bk9+EelM1KYEeKQHSqX8St6oGMxXgXj2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMwwz60Ce7pdHHSFjjkexolZQ9p7iHN7ytxXdx45zDN51xTMuKgetDoIUTPjbQhmo
         Cw/Grjo3jbCmSbKh4eyafYXb6iCoBirH+46WdEQRdXm0wHRGk5+IdtV0OrqBm69SOh
         49zfMkPxjBj8+CQw34i6g6uXRwaEn7kU1GpclOo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Gaskin <patrick@pgaskin.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 37/55] Input: elan_i2c - add ELAN0620 to the ACPI table
Date:   Thu,  6 Dec 2018 15:39:11 +0100
Message-Id: <20181206143003.703639282@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Gaskin <patrick@pgaskin.net>

commit 3ed64da3b790be7c63601e8ca6341b7dff74a660 upstream.

Add ELAN0620 to the ACPI table to support the elan touchpad in
the Lenovo IdeaPad 130-15IKB.

Signed-off-by: Patrick Gaskin <patrick@pgaskin.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1264,6 +1264,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN0620", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }


