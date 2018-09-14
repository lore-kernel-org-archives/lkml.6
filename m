Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A910FFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5646A20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw3yoAfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5646A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeINU0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:26:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35341 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:26:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so11003246wre.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+U41f2+QdDA4tqRXfQRvMnvYDl9B9hhng4S3igm6iU=;
        b=Rw3yoAfJsSSLpxyOVruirhvWifZo4GaIePSJNAzhdJUzxicU6XC+ltV4sBtu7dGQ6S
         bfjT8k4wHgldbs7fvzKCuIm3x6JQp7JdyEzz8WBWqNc6F8EwT4hrcd+lRp2iAop0fSf6
         tNdgCNN0hFvNxWEQDXumcph6AxgqPwKrovCu3ZvR/f25DNoIqbCYOZJo+NarheY5rG8d
         +g7NEKl7gtjZm16fG6GOI2kKKu+FRNX8ezfmxDDEWNQeJQ6iugMhZuGbhXse/87Rm6UR
         wOn0JZ9x/V31oi1NM50ZVSof6jT3gOMfCoghlNrr/dhAatrBKJYN9T3ZUyQXNUE4awdz
         XywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+U41f2+QdDA4tqRXfQRvMnvYDl9B9hhng4S3igm6iU=;
        b=SFZsNVfJJlFLQKYuFd7rrJqqfGTciALrcPuhI2VnLUiVnEg7TL841oVWOUYe0ab1Y8
         KK/bsUh5WPBxj1rXKbf/sbIElvxtjzsnfC1x3VkksD5GdseuuzUWb+HNYSjZo8WvmYxd
         V+B3Bdl/y7Ku0fyxa+9kW6W/q45ZNtSr+keHtahl/YA86bcsS6YKMPyvGPE1itb75i4R
         E/yY3XGCEs1sZ7CZ0LCWYGl55M5wv5k3ZaxgtNSJXRr5NQCApsrFV9oTXQye8+kqmkiR
         nP7hxcK1+JRRBcXO/wWl9qZRrT5067cbLCeWe/0F3rbI4/D/Mff2C90PgF87zB+SrQSy
         orcg==
X-Gm-Message-State: APzg51AeUtYGLIBbMnV2ByyfEXrZhB25MnC4qKPk1JVKTl40JDE1rBI0
        dzaSV99rfR32B5FqLCk/ubo=
X-Google-Smtp-Source: ANB0VdZravhE1iWw/hFhQ3x5zBru1rymIMABmpzeCZQlXBfXPlQvms4tnp5/PuT9NKAXHsRWOpDo/g==
X-Received: by 2002:adf:ff82:: with SMTP id j2-v6mr9372784wrr.165.1536937912193;
        Fri, 14 Sep 2018 08:11:52 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa89.dynamic.kabel-deutschland.de. [31.18.250.137])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5198502wrn.58.2018.09.14.08.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:11:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: rtl8188eu: simplify calculation
Date:   Fri, 14 Sep 2018 17:11:35 +0200
Message-Id: <20180914151142.1179-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simpliy calcualation:  * 10 / 2  can be reduced to  * 5
Also cleans missing spaces checkpatch issues.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index c040f185074b..0880f18520a0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -575,7 +575,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 			i++;
 		}
 
-		max_rate = max_rate*10/2;
+		max_rate *= 5;
 	}
 
 	return max_rate;
-- 
2.19.0

