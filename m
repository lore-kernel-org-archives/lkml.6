Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8FC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976612070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJkRVveb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBHBtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:49:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45377 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfBHBtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:49:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so896070plm.12;
        Thu, 07 Feb 2019 17:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8saBs/ha8WBC8UhqXS1dzcwx+GqnE+SFkWlf6qOh+vI=;
        b=XJkRVvebMMsXwXEiOrHL6dTL7oXnQ11wMgFCEt5bGLZ3uD9ODJqtUFmGb/iDEvo2b3
         n7bvFATVBnUbxpdI+ic4HxN4gmn9I5Zfykq5QOWXUCaxBQ3oMgph+53bUFA1UrnNPDpq
         TN+JZxISNz1aMVqvL9VtOAVCLKAnVXPDXxoT50Xbp3FsHGzOwQ/ErFQ0Kou7fI+Sn4wY
         bLqldw1YsxKmHyOOB6w88IwLcE5ZjvFKGl3GSzkewdujdYwmEDN7vvgE8MZX3rYNA0Yo
         l+VYvy42J37KcgJv4K1DujMI34K65AZ2g1ZpiULmRsD9J8z3I/njf1BnuRpHhQxapIvn
         7LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8saBs/ha8WBC8UhqXS1dzcwx+GqnE+SFkWlf6qOh+vI=;
        b=ZOAnLcChHla1b/y5LsVbpeHeHRWc8fBh3VGWDy6MSm++daqvDLlEjz5xugWZZ+snkO
         U+zIb4uJ93jlW9kygkUCiUKls1YtNZs2vqwMJSx72x8uiCXqt9woExcd3p8SIKxP8a9x
         302YyjiPa+CeIO7Gv7sFqjNLqMsuY9cOGtyr6QdeoFqQJUv0QdjCnGKMWNXiIcEugR0X
         KOPtFtuHJIBuYEUKCu37tLczGkpoh5IMOzqJ/4gaMbKhivY49FypL0/8vD16J8Sc0HVr
         DpKJ1Sl0Q4CmX45JyCfGKcUUjzoxtUufPfEyMovjbx/yKClzTLCbNO5MjupnraCXnyYK
         KAGA==
X-Gm-Message-State: AHQUAua5k+1L/vV/a9zAbL1YwVS43vkYGMHscGBWUZHi18bvOwMir8Gg
        BOgVJ2YY45VgVt8BT5t2u8vizAo2
X-Google-Smtp-Source: AHgI3IZxxMiS6MOyL6ASROoQZ6sg8Rp4q7EcZH9y8h0UHWaSGjReNLVPJLfRMHayy7M5AM4q1cR0rQ==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr19534536pla.216.1549590552907;
        Thu, 07 Feb 2019 17:49:12 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v89sm561643pfk.12.2019.02.07.17.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 17:49:12 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] xhci: Drop superfluous initialization in xhci_queue_ctrl_tx()
Date:   Thu,  7 Feb 2019 17:49:06 -0800
Message-Id: <20190208014906.22707-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify field's initialization by directly assigning its final value
instead of initializing the variable to sero and then bitwise or-ing
it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Fixed a typo in commit message

[v1] https://lore.kernel.org/lkml/20190207000331.7547-1-andrew.smirnov@gmail.com

 drivers/usb/host/xhci-ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 40fa25c4d041..91e592bfb80d 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3379,8 +3379,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	/* Queue setup TRB - see section 6.4.1.2.1 */
 	/* FIXME better way to translate setup_packet into two u32 fields? */
 	setup = (struct usb_ctrlrequest *) urb->setup_packet;
-	field = 0;
-	field |= TRB_IDT | TRB_TYPE(TRB_SETUP);
+	field = TRB_IDT | TRB_TYPE(TRB_SETUP);
 	if (start_cycle == 0)
 		field |= 0x1;
 
-- 
2.20.1

