Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE052082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107387;
	bh=qi/1rbIiYONejxgakyjezyIMD2N1nk6B5RsHXC4A4Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Frfl8kByJfT1Wqama3/gEm7ydGYJHQ9W1qAZXCBmxSMSkfpZ+Vz8j1jP7ruG6ClU1
	 k9kGh0Pjhwj9DYjFRbwX4HmKNC4GmYQ0LY7B/MbIQRvAC03LelG0Sy53rY40kIXsYx
	 CBGv7MOv31fpBSavVB53YZECTd3MNt6CvANijBag=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE052082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeLFOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbeLFOm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5DB320661;
        Thu,  6 Dec 2018 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107379;
        bh=qi/1rbIiYONejxgakyjezyIMD2N1nk6B5RsHXC4A4Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/Wwlq/qBqNP36wVrIIjwkCBUq8KNrBqICG0uWL6KPGZN2o7D5IUd50TBt0t9hghz
         mNFT8zHm9A9fRkkxPsZKpdwyPhz/3HT5t4xqFHepzzuRR7wGWIIBnNX6lAwZdb+6A2
         j+igOuB60X1llolvtphEOpmIq3lhSVkmAmcVAt6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Wong <adam@adamwong.me>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 39/55] Input: elan_i2c - add support for ELAN0621 touchpad
Date:   Thu,  6 Dec 2018 15:39:13 +0100
Message-Id: <20181206143003.811861314@linuxfoundation.org>
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

From: Adam Wong <adam@adamwong.me>

commit bf87ade0dd7f8cf19dac4d3161d5e86abe0c062b upstream.

Added the ability to detect the ELAN0621 touchpad found in some Lenovo
laptops.

Signed-off-by: Adam Wong <adam@adamwong.me>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1266,6 +1266,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
 	{ "ELAN0620", 0 },
+	{ "ELAN0621", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }


