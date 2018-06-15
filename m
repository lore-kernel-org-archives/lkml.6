Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE54B20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooU8pJ91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE54B20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756749AbeFOWCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:02:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38704 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756684AbeFOWBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:01:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id b74-v6so5459443pfl.5;
        Fri, 15 Jun 2018 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QulxF+BM47YvMmSL2bIdB2NPvS8MB137aPcCSSXctqI=;
        b=ooU8pJ91fSmKf3F4JZUqqy/yQlWkv0s5dGSDgCjggA+q0OSTC8Ya5O2UFpkMU+Zrb2
         Ki848kUqaFzMXmwN7lBBeQgOAizh1b4yghDgD006BmjDZHDGs3zcBWajLAe4qPKcEMVJ
         1yuAcrXBgAo6UwmS1kh/WnVD/QbFrQWuGb6QudxuxMPWBF/HYa2/g8LtU/rvoADRZigx
         zHeE89c2zHk+W6zlZT3vopgByTaQtAcVrsxE3rUGEz/hwITAPNgd6E3O97gV2FpMB7kR
         SKg05iN4Q2Lny1XiJAb12LSTrRHFI0McbbmYcGyItS4YbbYJPKIgkOWqDf03p3nUFJv4
         iheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QulxF+BM47YvMmSL2bIdB2NPvS8MB137aPcCSSXctqI=;
        b=EPxWsOmx6tkWYkDtSOM2wuiqswcMTPR0sgpJPIMg1fCmlVSdrk3tqBuEXGegHhhbR7
         Rm51pxlxGUxOSaaIADWn/TbnjEFonwwTzWUeD+F6IIMWErRq79w53iaHABssfWUwToIs
         64fukjg5Kc9QwE/2KTa+zHeFkO20vuQdPXjFiOawr6uVuWlcEXanzoj42eKE5EgLWrjO
         7w0ii3VM/Bxm7LxgGDeVeHqakMrtokSVH82nAkxuR5SnB4Mud7spH1VXvgUjO43Wk5mw
         o4ncqgsFIU/4+eRfj+Ww+U9t/ajR97xhhChMSO823Als6+8j6qqLoFUu9Sb2QKRoQRY9
         Kf4g==
X-Gm-Message-State: APt69E3alVBrmCI82zqqtFklJWTIdD8PC8XhPJZdkWgl5FSqh3LZ86N2
        nZG0nTHI8U6olUWCGkuGsUyQDMLW
X-Google-Smtp-Source: ADUXVKIYXI1/ZNyA9c4EyjU1+JSiZTSQ4bZ3DRdR5YjFFk/0fN0T89gsA4APj41WGiIwT4ww/Q1iTg==
X-Received: by 2002:a63:77c6:: with SMTP id s189-v6mr3228619pgc.450.1529100097215;
        Fri, 15 Jun 2018 15:01:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b83-v6sm20233241pfe.159.2018.06.15.15.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 15:01:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: dwc2: host: do not delay retries after successful transfer
Date:   Fri, 15 Jun 2018 15:01:30 -0700
Message-Id: <20180615220131.65402-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
References: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling split transactions we should not be delaying retrying
SSPLIT/CSPLIT after we successfully communicate with the device, so
let's reset dtd->num_naks counter when handling XFERCOMPL.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/usb/dwc2/hcd_intr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index d423b6a49f96c..b9879de6230d0 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -1092,6 +1092,7 @@ static void dwc2_hc_xfercomp_intr(struct dwc2_hsotg *hsotg,
 	}
 
 handle_xfercomp_done:
+	qtd->num_naks = 0;
 	disable_hc_int(hsotg, chnum, HCINTMSK_XFERCOMPL);
 }
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

