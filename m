Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FE1C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC812173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498341;
	bh=NoXAUmJg03dWtgoya8hid7B0UPl5MA64yma3hg3f/Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PeTmjayuTl3tee6v8ekwvAvxTFL/YQb0QpI8juNKa3fvqPwZvUePGr8zY4a5ccBAV
	 9e94FTLBGecL5LAtQxAPZ1ltCDz5t2ZlbcbsOCiMHmFq6YEmmaRAqL9dRHY/PhwKw1
	 GVDE+cef1rO4ioTVD5Umm9+druqu4xz/xH7/nD3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfBRN67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388465AbfBRN6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A339420842;
        Mon, 18 Feb 2019 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498335;
        bh=NoXAUmJg03dWtgoya8hid7B0UPl5MA64yma3hg3f/Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1g+JNJ3Azvw9Fqe58t6JcAP6Eeyl45rEwiQ/9dM5wfNpRH0kpE486ti+b3xDARC9m
         tjLT45m3ZZR/uWskLQ1cydhVzrnPS9xazceWrDs1PjLROdraRawhjmpRbb20Ku0A6c
         2LuOUmEQT1GHlHvGFedZxKRUBxgjTGL24YRk9uqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mauro Ciancio <mauro@acadeu.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 36/58] Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK
Date:   Mon, 18 Feb 2019 14:43:57 +0100
Message-Id: <20190218133511.428732416@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Ciancio <mauro@acadeu.com>

commit 7ad222b3aed350adfc27ee7eec4587ffe55dfdce upstream.

This adds ELAN0617 to the ACPI table to support Elan touchpad found in
Lenovo V330-15ISK.

Signed-off-by: Mauro Ciancio <mauro@acadeu.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1250,6 +1250,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
+	{ "ELAN0617", 0 },
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },


