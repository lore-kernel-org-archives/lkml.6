Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D2820656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="CrClnKsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeLSJCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:02:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39539 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeLSJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:02:13 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so8297612itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwN8VWRtxA4fG8RzQPWuFuWC/ns2jSuFgGSopCTHtl8=;
        b=CrClnKsjYxNgCdwA6wPR5TrDWQiZP2suV78nuWaZWlgDfKCQEpqLIA7g+zEvQMaqTj
         rLgu5Wtdy4n3LVqu/umqthswOFSws7XHHExt8mX5CvqegAf48lxQsHK+kLpNB9Ys09pq
         nu5W33wPzWvew6RGhhykVjiWVOsDxpiQflCW0NsNKmRFQ95Fop0ZHYjA4dljTe/+6zBU
         WCOQhhED4Y0ZLzvF2jbH9ORB7VxQW/CRCxr5cRdDskIG48WJIfHiB6Oh48sCwat5pMwO
         zdQUv71oWVGSxeNga06LLyU/lL7VyXG/BUP0QhZJJ4sGUevUEsU8sWyn5mfv7EH+wiH0
         yeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwN8VWRtxA4fG8RzQPWuFuWC/ns2jSuFgGSopCTHtl8=;
        b=WXgNxXLNWhFhR0WBLn7XMuld0L+GBcQZBJ6fsBOLA/xPjWTsu5BIZj82crleTlU7dH
         TReZpcesyiSUdCrZU/lUgmiRRpHvWn5wOWtnv/ExhKvIOhw4U7/Nn5OrXw6lN28pbpvw
         z7O1uzEZcC/2kg8J2mdALbGGIyaST8gVSA3oU6VqKFDJrFWeBXwa3arq2URXjh+xY1uR
         EEdgKBCqGH2YFJI7C34JmliWnbjMi7CT1toTvlzHqXxlPOwV96qBwuwSzpgmH5v8QW+p
         ZZkINq87JLPHmWKNcc+jblIsfSGtA1fbh64A7p5pWAHJLf0KzwA8yiRJiOumPTJP97U+
         n5eg==
X-Gm-Message-State: AA+aEWYgn9rMyu30I5tnzaxlEvGBkqEBcwl/9vp9A6pCJfa7LHRuaqvF
        WIP6fWAkkE1tJZHDmz9kZ4X+/A==
X-Google-Smtp-Source: AFSGD/Usj4qLd/D/2FZ5Iqnn1derTEbofO4sYY+bzVjVZ97EWhX93uZtyuEeXF1NhsJU6xdBGUNSOw==
X-Received: by 2002:a24:64b:: with SMTP id 72mr5349161itv.59.1545210132271;
        Wed, 19 Dec 2018 01:02:12 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id b188sm3045973itc.9.2018.12.19.01.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 01:02:11 -0800 (PST)
Subject: [PATCH 12/12] scsi: arcmsr: Update driver version to
 v1.40.00.10-20181217
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 17:02:08 +0800
Message-ID: <1545210128.4457.50.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update driver version to v1.40.00.10-20181217

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 9041edc..a94c513 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -49,7 +49,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.40.00.09-20180709"
+#define ARCMSR_DRIVER_VERSION		"v1.40.00.10-20181217"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096


