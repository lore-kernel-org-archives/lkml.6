Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B0C27C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65485208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d076Uv7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65485208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935305AbeFMTBS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:01:18 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41967 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeFMTBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:01:17 -0400
Received: by mail-vk0-f68.google.com with SMTP id 128-v6so2171966vkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZkEDp9mp6YoqH/Y44X4boSP2LJcB9L2tguOQynTlju4=;
        b=d076Uv7c7fzt+7dGHiOMQaZSidR9jK9HTKEuZn05oeDRuu6kSLsi1ynzjVxHrERqqA
         KoPZBwDMc5+Z7Epnpr+JfM1DqjnduPLZTOu0Pdod000B2C8yIyNjQ87QlfjlLpymyuim
         xWw6NIVeYv6jY/6zIWmb3b46g3pWw/F6eDd7ZqNM2O5+jJVBvMOZ0+Ybt6exRRPwvZam
         0n+MjHkN3Ct/EkLetQtw5lwy7TWN1AA9wDieUkJEO+QgALjlsNSeq3vosiEMD436fpvs
         FsxstfgN6l5mXAsIjtyDLzcwaSMrWnC07MkkLXJWqursbkYYZJcVs6JvgYP9qffE8Kj2
         NgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZkEDp9mp6YoqH/Y44X4boSP2LJcB9L2tguOQynTlju4=;
        b=jl5vVwwaY8Y8l+ZvNpf9K/VFfOgdnLWPWnPQ+GjrgDrLxJnCrkHpPIqCYidoKtORih
         +/QcY23f8znPYkCUPwm8mwgc4mgrmGx2E5ODmoql/lVzEIJKyejmpO+/pU53wqwLsXCR
         aku8iHM1l9FMeP6QEmqtlapWRlNOl3Cv62v2os59WgQOovznJZCB3wv3+pWlsi6228jl
         gzG3SJQJuyAbP7M++8h6TqiHd2VOvec5veXVz6qSvDuHwSjA0NLXOGdBfONlhWYfRymJ
         pg+DwoyM6rYqLJ/MdVoNoEpSne6d7Sfh5g9wAhxAZNEEWr4YCFvyDC8xrS9QLFEbhbGY
         hbfg==
X-Gm-Message-State: APt69E3yTb3EuNVLODLgZ58A3vMVHLbFu1cxiZZt0XAGjt4BsLb4Cv9s
        UzoUX3zBtxn5Y9gbMHS13xs=
X-Google-Smtp-Source: ADUXVKIh8IrAmtTJnrvi6QdD1TUJpaw2GymeKsuWGr+9UnzH6qHl9Lyxs5wfoWpn1ZoeKefRXsV4+g==
X-Received: by 2002:a1f:eb44:: with SMTP id j65-v6mr3799919vkh.14.1528916476537;
        Wed, 13 Jun 2018 12:01:16 -0700 (PDT)
Received: from javier-Z97X ([2601:582:c500:a66c::21e8])
        by smtp.gmail.com with ESMTPSA id v49-v6sm3664064uav.43.2018.06.13.12.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 12:01:16 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:01:08 -0400
From:   Javier Martinez <javiermlinux@gmail.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: comedi: ssv_dnp: fixed style line length warning
Message-ID: <20180613190108.GA14435@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed style line length warning detected by checkpatch.pl in the file
ssv_dnp.c.

Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
---
 drivers/staging/comedi/drivers/ssv_dnp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/ssv_dnp.c b/drivers/staging/comedi/drivers/ssv_dnp.c
index 0628060e42ca..87f46e0eb9ee 100644
--- a/drivers/staging/comedi/drivers/ssv_dnp.c
+++ b/drivers/staging/comedi/drivers/ssv_dnp.c
@@ -16,7 +16,7 @@
  * Status: unknown
  */
 
-/* include files ----------------------------------------------------------- */
+/* include files ------------------------------------------------------ */
 
 #include <linux/module.h>
 #include "../comedidev.h"
-- 
2.17.1

