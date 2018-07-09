Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1AFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7021920877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="DYff9orP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7021920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=areca.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeGIK2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:28:09 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:33746 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeGIK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:28:07 -0400
Received: by mail-it0-f43.google.com with SMTP id y124-v6so11400172itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4A51tI84KtLxXm+5/S0ZVYghW4r0KzlpvzzE46570go=;
        b=DYff9orPHdqCc8k0VxcvzP3KPhoySdWkJU0/bBFBkA9A59D+6Dt5/Rt2TQ1v1LfUhP
         8vFRsTZCiPyRBYe2TIJxFTkq+o/p9dtLFfv1ZZ3WlLXYWdwPz7CxF2SSGw3PbtTHkYkx
         9/17PdeW/p9bYX29+KfAK3xdQDNHBWTpSTtI5BgPiYpqNEOODtWhj0val7ZM2dEIDKrz
         28u6jtKCX1VYz6IorzTsl8+1cliU1Maf11dsOwXkq/ioURnxginSssQnlvY43/dugs5z
         RYyjzsBGWu+iuNA4+v/JBYFyDtFM8uUFdipCc5HuvTXIQ61Gv3D+cwC+tkiTqoKWtk/y
         rJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4A51tI84KtLxXm+5/S0ZVYghW4r0KzlpvzzE46570go=;
        b=XRe4e2YJVZ827I46FWOg2VGoy88UEGfA7D4+PBZ9b2EMnmkS3UkPOi5k5rJwQ6+X0P
         KbnTrqJTE95TU/ZDTbJyCES2ifzTbVAYMXjXitSkHn5Xrq6w/r7pnceN23glNizNXW5K
         YzgIDfKEMIKRbcFfQodvg/tg+MYNogUFT+cvIA0wqDlZKMNhoIcrUwabvqohFxyke4Eg
         6l+J5cxGzlF54Y/J8DXtywEEI3OJs+8JRjLrqAh8bsXi+cEjJeuTwIHuDgWUwrV9FQT/
         mqETjVU91Huj18Xa1Ih4OWkMNuM4+bJPm2oQfr3kClcD9XQW0aTV6FcUND4YfXUFAWTt
         9iIA==
X-Gm-Message-State: APt69E0gbgbmEVeS6q8DsE/wl4dT8PckTnmuzgotKa7Ig629AShwdQZe
        EapljUqZvQCbWVYP6iJxYQ2U4A==
X-Google-Smtp-Source: AAOMgpeq/FOi+kzyLcAisz/is57GLcOWEkXSkBOqJCQNDJDx8Vp8LBlqNl1vNxIqW4LBRqx2mZn4pg==
X-Received: by 2002:a02:97a1:: with SMTP id s30-v6mr4309089jaj.89.1531132086718;
        Mon, 09 Jul 2018 03:28:06 -0700 (PDT)
Received: from [192.168.0.108] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id f129-v6sm8596092itc.33.2018.07.09.03.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 03:28:05 -0700 (PDT)
Subject: [PATCH 2/2] scsi: arcmsr: Update driver version to
 v1.40.00.09-20180709
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 09 Jul 2018 18:28:02 +0800
Message-ID: <1531132082.5779.16.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update driver version to v1.40.00.09-20180709

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 2e51ccc..9c397a2 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -49,7 +49,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.40.00.05-20180309"
+#define ARCMSR_DRIVER_VERSION		"v1.40.00.09-20180709"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096


