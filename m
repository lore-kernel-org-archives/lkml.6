Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA7C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F218E20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppx2wWYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F218E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJABD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:03:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36184 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbeJABD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:03:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so12233542edq.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=30IOd5LaeKuNGXjO4NwQNRRvkuQlItzEiPmugV5h41Y=;
        b=ppx2wWYIeujJxEe/2f8e2RUFVdAbEkMsY5yZykRjgeETrRwd4pjvhY5SleaBcL5E9X
         7PAgO68sVJ+P07MkTjXctHQ7NqYjOI0q7F2W4klEMHfJDtfKKgiCTGCNHE+Dk2FMcbQK
         BS02HiVI041lFtDiNaDvkXF5PSRGKTx106KizOVyqIm2Y9GxJ3m1DNBR+N/0OZOG2xB7
         WtdwhJlWyJiythb5PRsTEkjkGmeQ4h3J5fmh3UNdEKEBBsEAMzpOh065EWiiPopWPy+g
         fLSbr9lTWugGbml272hACJP0vV+nzyGVveGL9f+ljr1mpeg8H5XW5+isnEeT3aGvFHqi
         c89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=30IOd5LaeKuNGXjO4NwQNRRvkuQlItzEiPmugV5h41Y=;
        b=MaSPq6XU/oe4SZtm1hGgb9FDN3dxA5iZuMkPTZl9yCk9m2BC2WLrbR8qGfSid720Di
         va3uNhBikcDOIFZH7zdH5zslejdf01n8Ht5+J1ZaxB3C+Xxi+t/Wgo/yqbISlx+QHvYl
         cITpbbz1sxu0CbCwulCwYm7xqrtUqOAX1iLDgVEwNf11KaLRduMSYdcT44smeY/bxbib
         hCB7kSYuSTsW+QTJm67/fX+s80YTpsV07KQ1PemaGU3ZUGjNMnKbCSioTRYnKEf425Ez
         8c0peCuZcY9YKRT1KmLzxuN8yiWSbXI/ci/+HLP4v526UZIwia/t8EWxvgr1cm4VK/L/
         wtHQ==
X-Gm-Message-State: ABuFfojeUBIFb3qi6EkrqsTTd4mi/ohyqtTJ5aJCOOgjo3X5liIfTas9
        ooVsXQmerNU+cFewypdU5Tk=
X-Google-Smtp-Source: ACcGV62eyfx4Qz4yEJYrJYMxAz4RgzW2lxEymuav8hKKznvxPYa5npDTVZmRAeXMRplLPYa4yZh/Aw==
X-Received: by 2002:a50:8664:: with SMTP id 33-v6mr3570621edt.190.1538332162157;
        Sun, 30 Sep 2018 11:29:22 -0700 (PDT)
Received: from localhost.localdomain (4daeca99.ftth.telfortglasvezel.nl. [77.174.202.153])
        by smtp.gmail.com with ESMTPSA id l25-v6sm1726006eja.5.2018.09.30.11.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 11:29:21 -0700 (PDT)
Date:   Sun, 30 Sep 2018 20:29:19 +0200
From:   Rick Veens <rickveens92@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: Removed unused define and code
 efuse_re_pg* from wifi.h
Message-ID: <20180930182919.GA19383@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following:
 bool efuse_re_pg_sec1flag;
 u8 efuse_re_pg_data[8];
are not referenced anywhere in the rtlwifi code.

Signed-off-by: Rick Veens <rickveens92@gmail.com>
---
 drivers/staging/rtlwifi/wifi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtlwifi/wifi.h b/drivers/staging/rtlwifi/wifi.h
index a45f0eb..9cb6c79 100644
--- a/drivers/staging/rtlwifi/wifi.h
+++ b/drivers/staging/rtlwifi/wifi.h
@@ -1840,10 +1840,6 @@ struct rtl_efuse {
 	u8 efuse_map[2][EFUSE_MAX_LOGICAL_SIZE];
 	u16 efuse_usedbytes;
 	u8 efuse_usedpercentage;
-#ifdef EFUSE_REPG_WORKAROUND
-	bool efuse_re_pg_sec1flag;
-	u8 efuse_re_pg_data[8];
-#endif
 
 	u8 autoload_failflag;
 	u8 autoload_status;
-- 
2.1.4

