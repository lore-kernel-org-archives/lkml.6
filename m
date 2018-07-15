Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34928ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF60320882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3tmpxCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF60320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeGOHLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 03:11:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37094 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeGOHLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 03:11:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so13915605plc.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 23:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p7OtHrF792ZKnGH4+MbQvhqlwoH/la438tnih5wCHhY=;
        b=o3tmpxCLj+0YAuv8iHh4+yCqZ5eg9uETZL1l8VB6YiQAHHCH2PofsAkLl6luWXjWvy
         d0+a8LbaJ5/a+m9giLvwjOPbjbP/Uhzpp4BiJVISDAI+IrXkK3RdK7E29oJ+tkoxnxSN
         aliL0lF0W0KDPkf6E4Rq8s+d/ZzwOLLRe7dFl31vxt5aomeHV6XDze8tcT1OaTYdcHSl
         dkSMFLruOExR5zsuBIZD07HVWEz16iYJKufeSMSBMN1Z1XFeeJw7n8Fn+4xTOFvS5ZXb
         Hg+V2IeDqRnL1pD0dbGX4BDY6VKZbLyQJ7UrT4ENgtRPXLDSk9IxrHyj87TCmaf8wOJH
         xWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p7OtHrF792ZKnGH4+MbQvhqlwoH/la438tnih5wCHhY=;
        b=qDmF9G5ELMhDU4/dc0DB9e8mMxtkeLvL69Rm3MRUs8xpit3PLy54h7tMYdajq/7d54
         Yig0L0wSEoJ8Xa+Endl1zosSMm2PI75lG2IgQe7+mttwiYQCBl4kfYf4NBrtqnMxPsIp
         YsZleYt36IiuB2hBwAAwxz++18s3wij+e0MpJdIr7AohmTnay9A7QxuTutaniRIuNWr4
         eGd9fzu3SvHl1G/X4MlV6o1CyKVypRhBljtgXBVVsxIvbSHfCVlZLETrjS+sLJmSeMY9
         mAk88kkXrVPpJ/ohT4V3wTqEv++BAOQOkNEv2Yc5wyccBtLa/UXHMRC2ubY0UGSl0SCi
         uuLg==
X-Gm-Message-State: AOUpUlESZ3iUG+XSlRRbAR3iVZAJX7XzZ0igYrNt8MmUcWmFDffa0FlJ
        gzwl377KQrlWFe7ULK/Okx8=
X-Google-Smtp-Source: AAOMgpfU/O+xC+PkfpHXtTZ8fab0KF1Yql/HnB+N13bxwgn0Z2HQHDKXU6jujsJ/3grWfJsj4bWpew==
X-Received: by 2002:a17:902:b08d:: with SMTP id p13-v6mr1397224plr.0.1531637363849;
        Sat, 14 Jul 2018 23:49:23 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id j5-v6sm21191737pgp.6.2018.07.14.23.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 23:49:23 -0700 (PDT)
Date:   Sun, 15 Jul 2018 12:19:18 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: comedi_internal.h: Avoid '(' at the end of
 line
Message-ID: <20180715064914.GA5081@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring function argument 'struct comedi_subdevice *s' to the
previous line to avoid ending the line with open parenthesis.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/comedi/comedi_internal.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_internal.h b/drivers/staging/comedi/comedi_internal.h
index 515f293a5d26..914a644ca416 100644
--- a/drivers/staging/comedi/comedi_internal.h
+++ b/drivers/staging/comedi/comedi_internal.h
@@ -32,8 +32,7 @@ void comedi_buf_map_get(struct comedi_buf_map *bm);
 int comedi_buf_map_put(struct comedi_buf_map *bm);
 int comedi_buf_map_access(struct comedi_buf_map *bm, unsigned long offset,
 			  void *buf, int len, int write);
-struct comedi_buf_map *comedi_buf_map_from_subdev_get(
-		struct comedi_subdevice *s);
+struct comedi_buf_map *comedi_buf_map_from_subdev_get(struct comedi_subdevice *s);
 unsigned int comedi_buf_write_n_available(struct comedi_subdevice *s);
 unsigned int comedi_buf_write_n_allocated(struct comedi_subdevice *s);
 void comedi_device_cancel_all(struct comedi_device *dev);
-- 
2.17.1

