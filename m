Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D6DC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005252183B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrgC6SHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005252183B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbeHDQgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbeHDQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so8053404wrs.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MkQX8yFS8BYlzpvEprUqW0KivtOdW+K2WSmVyMQCX/o=;
        b=nrgC6SHGX6rBtjVM7gyFRnwAaTJQEoSnB/EZ1H0xVyn/lwCfRA6N1rsTKQPheMrNFV
         vb2Zq0Q58PCrufYiB9kzU7qdRNyqbOm3Yx/sTTrgU2IAweX+bExLze1J+Cf9qsarAgl7
         zYSGoyoozQMZsEfHGk+CsHaF5MH52nTpliU7dJdnNB45NHWkgHjmwalOTNOl5B7b+YnL
         DewWig/5hOYXJlJ21vW09NgOhM5IB60YDWB8d3xvi8QBgzx0f4oZk6plOhiocbssT/KC
         v08m+pQ37FuL9Ygxfprc9FvpWJl73hutZGqhIdiPm9siWik2g8sjf4cEzT6VaLW+tgkh
         qMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MkQX8yFS8BYlzpvEprUqW0KivtOdW+K2WSmVyMQCX/o=;
        b=SkmUVmQ2lWvkOTHoi8yVZWVB6bJKlysM0WK9P+6kulHR6WQEzSSmKhkPZiG6GnB77W
         3nAbLBrQlwTjuCDQJZkfYs/sK/NNrXI1OoP51JgBPCD/7OR26PAZ4e0d/3zqLmwQFqh7
         mGyYY48RcNXHZxcjOi9leXvewmZtLeeoclkFuPE6ApR63+3OhsX7mdv2phm8vo9PPhNZ
         yysqh28hfuCZSWh7WrzPJTO8mMB7/erfQgsYWQZyyRDSwG5FJ9LYFDHzbC4JOBx9zmHr
         gXfT5rjs0XNYROJTlndFD6rDKVJEm/9yrmBeC0QCEn1mP6DEDaUZNvJbRMNjI+UOISoh
         gP3Q==
X-Gm-Message-State: AOUpUlFiGFJwn8Ph6TS+P4BPAE8R5Ta/dsXF+j0l3Of6pl7Qr4GsFJ3g
        nZozujm/l+f2hrtZiMjttFQ=
X-Google-Smtp-Source: AA+uWPxI9b8KGOS9kITmzXNGR/hudU1egPKFmf0e2A4vaeIJBwO7RqGsPAgCp+0MkfrcVwLFnf/Okw==
X-Received: by 2002:adf:f585:: with SMTP id f5-v6mr4226811wro.59.1533393356353;
        Sat, 04 Aug 2018 07:35:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id x14-v6sm5409149wrv.21.2018.08.04.07.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: remove redundant include
Date:   Sat,  4 Aug 2018 16:35:42 +0200
Message-Id: <20180804143543.1500-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143543.1500-1-straube.linux@gmail.com>
References: <20180804143543.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header osdep_service.h is included from drv_types.h,
so remove the redundant include.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/rtw_iol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_iol.h b/drivers/staging/rtl8188eu/include/rtw_iol.h
index f20b35e8d0a2..d713782d5cdc 100644
--- a/drivers/staging/rtl8188eu/include/rtw_iol.h
+++ b/drivers/staging/rtl8188eu/include/rtw_iol.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_IOL_H_
 #define __RTW_IOL_H_
 
-#include <osdep_service.h>
 #include <drv_types.h>
 
 bool rtw_iol_applied(struct adapter *adapter);
-- 
2.18.0

