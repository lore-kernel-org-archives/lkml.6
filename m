Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A0ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AED208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQuPpklI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AED208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbeKIHsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbeKIHrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:47 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46E0208A3;
        Thu,  8 Nov 2018 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715015;
        bh=iTM6qDOb3KgW/iGAKu9YrYyRmkptrrrl72R7yKPjS+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQuPpklIzR1TcA0vJwrkKxk66IjRd0y4//v2Uqk1tujjfcKiW8QgEKoWf+Mpbkmxn
         7wz4idPWttUoPJvs6VGHgydrbADieEtqNVOoF96uNT/fa409Ott/bbuYVrQ7T+hI7k
         6vS+kFIXhQYh6wsFUWuH8PViLSlvHMtAMSWsjHYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mikhail Nikiforov <jackxviichaos@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.18 26/34] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM
Date:   Thu,  8 Nov 2018 13:52:55 -0800
Message-Id: <20181108215140.507942896@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Nikiforov <jackxviichaos@gmail.com>

commit 13c1c5e4d7f887cba36c5e3df3faa22071c1469f upstream.

Add ELAN061C to the ACPI table to support Elan touchpad found in Lenovo
IdeaPad 330-15IGM.

Signed-off-by: Mikhail Nikiforov <jackxviichaos@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1346,6 +1346,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
 	{ "ELAN0618", 0 },
+	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },


