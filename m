Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C144C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D341821473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXkQCfye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D341821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbeKZVyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeKZVyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE7121104;
        Mon, 26 Nov 2018 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230054;
        bh=HLsNGGLTrYCDyUrJODV1sZEcm6dC3Bcsy04uSVQ8ILQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXkQCfyedGGPT0VgfSaFVxj5XuB2WQIVf0IzSgRBOAflaQWiaa5ZQ2jVhZpXCYzha
         XhbOqSk/iJHYdGQQDj63VfGGYhyHAgJeb+K3OzyiI4iP9XYFOTKirgUe9gKnneJaA/
         O9V9Z3HJ8Mbj4vZQOdbXDSgpy/ThRYWHzDBIIAmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maarten Jacobs <maarten256@outlook.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 53/62] usb: cdc-acm: add entry for Hiro (Conexant) modem
Date:   Mon, 26 Nov 2018 11:51:34 +0100
Message-Id: <20181126105054.664243378@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
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

From: Maarten Jacobs <maarten256@outlook.com>

commit 63529eaa6164ef7ab4b907b25ac3648177e5e78f upstream.

The cdc-acm kernel module currently does not support the Hiro (Conexant)
H05228 USB modem. The patch below adds the device specific information:
	idVendor	0x0572
	idProduct	0x1349

Signed-off-by: Maarten Jacobs <maarten256@outlook.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1724,6 +1724,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x0572, 0x1328), /* Shiro / Aztech USB MODEM UM-3100 */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
+	{ USB_DEVICE(0x0572, 0x1349), /* Hiro (Conexant) USB MODEM H50228 */
+	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
+	},
 	{ USB_DEVICE(0x20df, 0x0001), /* Simtec Electronics Entropy Key */
 	.driver_info = QUIRK_CONTROL_LINE_STATE, },
 	{ USB_DEVICE(0x2184, 0x001c) },	/* GW Instek AFG-2225 */


