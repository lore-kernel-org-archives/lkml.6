Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7E04C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5FE208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNSp7HHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5FE208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935990AbeFMV2f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:28:35 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46926 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935527AbeFMV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:28:33 -0400
Received: by mail-vk0-f68.google.com with SMTP id b134-v6so2413035vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+lKdVjwZDrAfYW7Fmkwu4us3u3yhTbFiOLx89IpfSA0=;
        b=kNSp7HHtaXDD5PWIe1t4FQ+th4+hfH2fXGpRIV75p4RDIw7Zp895lyBOUmTnIWsa4p
         hWNbYT5QfnH+CxnCEzrib+NgXdZV2ZqhPIAA+681cf3GD+u9KyVAxKZAr9s++1wCrPmU
         3uabPGFINQNKN7aFw+Wh7yYtjnipTwtv6ljnK2CVzWgspk6whojnX0nHhVQbywMuZCK+
         l4FYo1OVo+cwRpRovHKyfWdGQO4Lmk81nbcfypXwJITVp5ORdDvbPxl7Ee2csHrWCYXP
         5F6U/UpxX+NFsVUcycnbrV2GotabRgLR6y5ky5WXW9eaSu1ErA1I5Mq4XbKtLmAHFQ6H
         szIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+lKdVjwZDrAfYW7Fmkwu4us3u3yhTbFiOLx89IpfSA0=;
        b=iWt1C9kccaDLakv0xZ8dwUaJa7NFnchAdvIoRLfz4wABNZmimA4q+4GQtGuEd6C9MP
         +jQ3BB1B/RX4TkGLK2MCx+48Q7BPOTlHDJ9G51nH+rsEJPDv2hcS85IQELU8P9OmhcJU
         vQ2jiU27Hb9A9j5h4HHEt9/DRa0Ffx6uq7lJ/ZPf3lrJMrxMXuUZR6e4+szUCt9+dr2C
         DMQCczT8ZsObI+OSYd25xj8VydgqkN2lIrhRJZ6xl2eKEKup6QHogSrlxG8dA8urcjPO
         OOWmfZHbAsEVCNS/K3p43wOInEgE6/g/oHoK7ONe0NCYnVdVqpnWSdgACt0Z6zFyRlyu
         uO/Q==
X-Gm-Message-State: APt69E0GJp0Tcq0X4cExIa/v28qymllA2Dqkh6MZ/0nyYGfzlvgycYWS
        3euQl6SFwm8miggYNA14WxU=
X-Google-Smtp-Source: ADUXVKJtjNCW8h7w8c71b32YA+QMgu3zowmjX9qC1cgJc8GlF+5GU0YjGQnfy/WYWTXcFd9CVpowlA==
X-Received: by 2002:a1f:8188:: with SMTP id c130-v6mr4411847vkd.96.1528925312812;
        Wed, 13 Jun 2018 14:28:32 -0700 (PDT)
Received: from javier-Z97X ([2601:582:c500:a66c::21e8])
        by smtp.gmail.com with ESMTPSA id k31-v6sm1836761uaf.49.2018.06.13.14.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 14:28:32 -0700 (PDT)
Date:   Wed, 13 Jun 2018 17:28:25 -0400
From:   Javier Martinez <javiermlinux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jhogan@kernel.org, aaro.koskinen@iki.fi,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: octeon-usb: octeon-hcd.c: Remove boiler plate and
 add SPDX
Message-ID: <20180613212825.GA16479@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed massive boiler plate text at top of the file and instead
replaced it with a simple SPDX license identifier.

Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 47 ++-----------------------
 1 file changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cded30f145aa..df61e8321140 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1,48 +1,5 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2008 Cavium Networks
- *
- * Some parts of the code were originally released under BSD license:
- *
- * Copyright (c) 2003-2010 Cavium Networks (support@cavium.com). All rights
- * reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are
- * met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *
- *   * Redistributions in binary form must reproduce the above
- *     copyright notice, this list of conditions and the following
- *     disclaimer in the documentation and/or other materials provided
- *     with the distribution.
- *
- *   * Neither the name of Cavium Networks nor the names of
- *     its contributors may be used to endorse or promote products
- *     derived from this software without specific prior written
- *     permission.
- *
- * This Software, including technical data, may be subject to U.S. export
- * control laws, including the U.S. Export Administration Act and its associated
- * regulations, and may be subject to export or import regulations in other
- * countries.
- *
- * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
- * AND WITH ALL FAULTS AND CAVIUM NETWORKS MAKES NO PROMISES, REPRESENTATIONS OR
- * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
- * THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY REPRESENTATION
- * OR DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT DEFECTS, AND CAVIUM
- * SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY) WARRANTIES OF TITLE,
- * MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE, LACK OF
- * VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION OR
- * CORRESPONDENCE TO DESCRIPTION. THE ENTIRE RISK ARISING OUT OF USE OR
- * PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
- */
+// SPDX-License-Identifier: GNU GPL
+
 
 #include <linux/usb.h>
 #include <linux/slab.h>
-- 
2.17.1

