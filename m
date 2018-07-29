Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0941EC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1D920873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYBOyzWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1D920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeG2QEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 12:04:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37367 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeG2QEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 12:04:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so10757081wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYftl/T68n7Y59Hsk+fiWLfQWFzrh/htNURzxHN4IWg=;
        b=NYBOyzWX/PhAvq76m+nciH98raf4gPwJ1tYy7vKJgsB6JphkZQ97kGuvXrlHDys7qo
         +uzCJVvMZSNdQhIdIdaYrbXhNPGMvErTYtDfxIP43eVMonWu23j44OnIhB2m4jOxVDdx
         Y3aJNEo5tqnug3TP+OJDtoj8Y+DK/vXAhHUwHHg5zreeDouIixKMJIkYVRY95ozsARbN
         EjTAtLasewqxB6liGTtnNOm4CWWw+j9erLHCI7+RL8YpDUmHxM2jZW+b/1nobVZjWbVL
         QFp1RUvyunS6pebcrPKGOSWQu0xc+/z+NZ1m6nuNw/QjXtylk9OELoRGQG+6ABEHMc2u
         m9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYftl/T68n7Y59Hsk+fiWLfQWFzrh/htNURzxHN4IWg=;
        b=p5Z+oBrbsoPvzCfiDFdEElQzdk0W/bCE5YwwMJMQLMFEoyInRCqqeIfWMWsHBTKnwd
         Gv4zmAXUdVT5xDKxPFAO9u+r+kD19MznFC26VKNOS3dl1Hv8v1pQkcS26uKM5D39fGrh
         vXPUCmahK87/X7s2TAKV4FW1nm1cUZJIvPzXjy+Ckt1IT1FitqIRp9Tj1+QOdR679kSg
         8yuAXmgQQlqvTPQ9cXURs872ZshMb0ak7ldD8Y7Znx5u+1LP2fUBGQiBbn/G2+2D73TH
         jQTQidnYShn9m/97GZsqqsDHTyV+YmgWhYT1Ko9SP5IIR/evOfKr1ycJveMsOrsuuNN2
         ZNeg==
X-Gm-Message-State: AOUpUlHBAsNqvWkmepLuJELTJj/PlXmZkZzVqIaud5T5MOdY+sMgCGgE
        OBAACPABcDV3akWru2rqoTrop+KA
X-Google-Smtp-Source: AAOMgpf5IUvga2zqa7CWR45rqWvGeYw78mqJ/cufU8YHW+/sC3n+01ZW9ZbbIXoI6OBnGfmjoURYRw==
X-Received: by 2002:a1c:f913:: with SMTP id x19-v6mr11950640wmh.63.1532874847948;
        Sun, 29 Jul 2018 07:34:07 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id w9-v6sm12266768wrk.28.2018.07.29.07.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 07:34:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 297426403C9;
        Sun, 29 Jul 2018 17:34:06 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xEtEwebEXLap; Sun, 29 Jul 2018 17:34:04 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id D5A6F6408D2; Sun, 29 Jul 2018 17:34:04 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] Staging: octeon-usb: Using defined error codes and applying coding style
Date:   Sun, 29 Jul 2018 17:33:38 +0300
Message-Id: <20180729143338.2251-1-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180729124320.GA27275@kroah.com>
References: <20180729124320.GA27275@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced -1 with defined error code EINVAL

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
v2: Apply coding style to function cvmx_usb_poll_channel
v3: Break down function cvmx_usb_poll_channel
v4: Return defined error code and applying coding style for function calls
 drivers/staging/octeon-usb/octeon-hcd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index 3f44ac260eff..edf87d1b3609 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2590,6 +2590,7 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
 		}
 	} else {
 		pipe->next_tx_frame += pipe->interval;
+
 		cvmx_usb_complete(usb, pipe, transaction, CVMX_USB_STATUS_OK);
 	}
 }
@@ -2624,16 +2625,16 @@ static int cvmx_usb_dma_halt(u32 hcchar_chena, u32 hcint_xfercompl,
 		cvmx_usb_write_csr32(usb,
 				     CVMX_USBCX_HCCHARX(channel, usb->index),
 				     usbc_hcchar.u32);
-		return -1;
+		return -EINVAL;
 	} else if (hcint_xfercompl) {
 		/*
 		 * Successful IN/OUT with transfer complete.
 		 * Channel halt isn't needed.
 		 */
 	} else {
-		dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
+		dev_	err(dev, "USB%d: Channel %d interrupt without halt\n",
 			usb->index, channel);
-		return -1;
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.16.4
