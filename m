Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6022C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950CC21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="HujoWfmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950CC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeJFIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:25:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35435 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:25:58 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so5275504itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+xfeCp5wM3qAshHnoJfh/upuETYwzId/xw7Du0ES+aE=;
        b=HujoWfmZILWh2+fUdL5Rc7I0RO2eLo4nq0Fq7TH4eFua1lsqdpVsHu99vTYks72rOH
         94iUHBGfSku2OXgtux9PyHvAHp/9azHGk5E5YIInzVqEVT/3j3ZSVH+w0XZ/cswvsQDr
         7+9x58Vs2XButebfzkcRqZNL3TbTanQWNnGrE/Ego1sSFOwS1bJYV6wOgKXaQCYugW7o
         mBXFub2/B3u7oWs8/usRlf8UQis7aClZMAOJCD3NqwH/wIQPWcnBbfz09GmxPPXjUd7U
         XJGsTcI8cgeXwaZfUr4wNTnBCLJVO/WjGojP4uwu0pTBuJwgQwq852vNVFw3AsDV03Lj
         Yh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+xfeCp5wM3qAshHnoJfh/upuETYwzId/xw7Du0ES+aE=;
        b=gG1MIVx/ByO7l3d6HouOQJTHJ7xrQa6hvmkryk6zECr0PYhuBT6eYUHSuupHkTlUif
         0O/qQdkeYRKGbQoOP7S4TKyAX2lKNrrkGEBbvSoXY/cG6VTra/JiyVp9wC7sDxuy7B5r
         RQVRM5MKkEKomdA637CCbAtayeDp0ruCmhhlBUKuSPF2ZIsfJWiwulXNWCJcwnJLYu7u
         HlpOLlvIX7S3Aq9+80nH7/B/56He5MfPDbj5Bx66J/50RNNpV7tOqSTWEyxR/abSwb7Z
         mGId1b3eet/fB0OR7R13dvq3aRHrxNWdzZ5yFUrXtCd21UfixXWzP5NnOaS90cJ0cfXf
         V45Q==
X-Gm-Message-State: ABuFfohfm7o42F9NPBxaUfRc641qVZCt4nE/h2VCoPtCIVg8cbrM8ZWY
        kXWWcsR81JgWbegSw0zl9KHFnELqyBjRg3tF3Tb1Pw==
X-Google-Smtp-Source: ACcGV63l5r+uFCFEzC/+gAQcxZ5yklPTgig1Ur/l78/xm80m/Zfb+hbVhcQbY0QVDg2nJX8yIsVJKWVPnzLpmiwtFEA=
X-Received: by 2002:a24:65ce:: with SMTP id u197-v6mr87602itb.99.1538789077593;
 Fri, 05 Oct 2018 18:24:37 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 5 Oct 2018 22:24:26 -0300
Message-ID: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
Subject: [PATCH] staging: iio: ad2s1210: fix 'assignment operator' style checks
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes all "Assignment operator '=' should be on the previous
line" checks found in ad2s1210.c by checkpatch.pl.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s1210.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c
b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..d4b1c2c010f2 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -301,8 +301,8 @@ static ssize_t ad2s1210_store_control(struct device *dev,
             "ad2s1210: write control register fail\n");
         goto error_ret;
     }
-    st->resolution
-        = ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+    st->resolution =
+        ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
     if (st->pdata->gpioin) {
         data = ad2s1210_read_resolution_pin(st);
         if (data != st->resolution)
@@ -363,8 +363,8 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
         dev_err(dev, "ad2s1210: setting resolution fail\n");
         goto error_ret;
     }
-    st->resolution
-        = ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+    st->resolution =
+        ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
     if (st->pdata->gpioin) {
         data = ad2s1210_read_resolution_pin(st);
         if (data != st->resolution)
-- 
2.18.0
