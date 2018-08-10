Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88E8C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C25218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vaolix-com.20150623.gappssmtp.com header.i=@vaolix-com.20150623.gappssmtp.com header.b="2F0FKLpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C25218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaolix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHJWis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:38:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40591 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHJWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:38:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so9269504wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vaolix-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ayDFM8RMM3sZlkNzJCdBtFS0E1+e0YZDf5aO+hXznGI=;
        b=2F0FKLpIqg4f7COC04aK9FW1wbrI3N3M7tgPoF/Can9N+gjRgT0Dj3/NYHgz2u9W2a
         t+CKSYRH8fqY+oJVOCzU/uE8Cj6fn14mZVpvXjFZBw8Nlzo8zbdVDwDhQp3X79CKu7Wm
         LJHLW0dH5fD6VU3jl2XSMPh+m0dzKwmDy5s8++Fu8WV5U197DvZnLz/lx2XgDgyiFXN0
         jzMLJs/77QJElc765paaPj5qYInfJE4OXorQ4koruK3zKWx4xFM2q2TUhDtIgcWdoGYJ
         aJUFUuY62gBklx46KMpU+63uQvSeKaOFwPOMOESA+LiIYt8JXWi/TU/er6Ud1bgQhXSu
         luLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ayDFM8RMM3sZlkNzJCdBtFS0E1+e0YZDf5aO+hXznGI=;
        b=HGDtk7z9Scfix/IybF6a2mQYyb7ke0sjSztnRlhJCQDt1d1EAJWQ7JI/0HIJ2HiHB/
         0bH5L1brU4iz8GMfTrmltlw7A693lZiFx0PA7ppO53GZOdjseDt1I4OkfkB+e9oUHqST
         pZ5C6oOYc1hLTncwxXEMCUieQJ4nR2eiS8+9uJRRhINMhR4Ss5hxA31os9ou2lE+NlMd
         zZc8+F5UzgrCCKiFymtL51P+Ro3cDJeUiOsMP/nxagK9L9K41pXHaxV3EC7rBGL+/Zd6
         8heYPlmN20vZjpu8isrfbXyWwRiUR2mDoGH4KnjQ6UmdzCCqelYVKI9uDsTUe8tE0DGL
         URGQ==
X-Gm-Message-State: AOUpUlHz+tox2PfMQQ4lioOvRmne6neLgesgo7tWNBjgUXDQvu9E+KIu
        Sh4oJoC6f871SRSsOvAyFGcP6U5MFwQ=
X-Google-Smtp-Source: AA+uWPzukrqVf/XxnbFtvYLc09d4FppIAJEwJNkAwp14ORs5BLKqRXXWDjPqI66uvCJPI+HbXe5LNg==
X-Received: by 2002:adf:9e84:: with SMTP id a4-v6mr5048579wrf.70.1533931646872;
        Fri, 10 Aug 2018 13:07:26 -0700 (PDT)
Received: from [192.168.27.102] (gw4-pha-stl-mmo-1.avonet.cz. [79.170.253.179])
        by smtp.gmail.com with ESMTPSA id c1-v6sm1411809wmb.40.2018.08.10.13.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 13:07:26 -0700 (PDT)
From:   Aleh Filipovich <aleh@vaolix.com>
Subject: [PATCH] platform/x86: asus-wmi: Add keymap entry for lid flip action
 on Asus UX360
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <04607a59-7e47-5463-7ff6-cb1aae7e3626@vaolix.com>
Date:   Fri, 10 Aug 2018 22:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB-large
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry to WMI keymap for lid flip event on Asus UX360.

On Asus Zenbook ux360 flipping lid from/to tablet mode triggers
keyscan code 0xfa which cannot be handled and results in kernel
log message "Unknown key fa pressed".


Signed-off-by: Aleh Filipovich<aleh@appnexus.com>
---
  drivers/platform/x86/asus-nb-wmi.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 136ff2b4cce5..db2af09067db 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -496,6 +496,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
  	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
+	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
  	{ KE_END, 0},
  };
  
-- 
2.18.0

