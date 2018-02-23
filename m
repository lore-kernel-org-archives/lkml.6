Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415877-2-8110040208875033860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415877; b=iAniDfYzdb7757xRm+AnWXcEkyNY7nGz647s5BKeP1dUORd
    mTua0NdHYYlK5Pgwn1Z1Zx6+Putw+RiDdaUBseu5gGH603xueh/fYUo0Pz8GQK6Y
    iO6B0eow1E1NAbfpHuGknl4jTO4tprLIx3ruCVwf3q1dDYOpXr+YxaxSTarpuA9A
    mNEVKb0EGSLrjEs+kq1m0qRfy9ibRycESTHJAxp7BG5BaeulRDfMdzJls5LxtKU5
    nKHzkKU4x3kR4p8n4t1dZbU9271LorW0DrFhOemaoKw6E39iFMIC28S3i5/TeK6I
    kGzvxfV1wOiFjj5toTiCmhCDkOcM5HKBm7FrVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415877; bh=Z8SErVP6L+l1GHJOmo3R8lsk//
    7zYpe4E4iDWoknIng=; b=NdkWTheImbtRyX45fhLHrzJrh8mXlFmvQQGwCLPsCL
    MMJiUcnUMIia9Xn8fDWiJDqXr6KBbrGkFa7hdOH66KDuiQHHblFYb7N7sIIhKu7+
    HmAUH4JiCGR73o0szmxeqxDMPnO9aJu7cxUK16wOmfN+yjv9BDNHehPsKZiONYKZ
    dM46wJtKY+qop3R/86jECGj1k3NKDe/NvrYofgkStMDJ6rrIACPZvKKMxVw4gurp
    c4NQciPPEnYB1maQ7fwnJe2rEtsw4TTG3H8HYhEeBcNRZ7RN83LVMG+ajuV2OmTJ
    0VaGZUGgbcYZs0SYO+CasD1hwgPrQ7vX7fNOVQ8knhuQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeBWSoY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:44:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933538AbeBWSoY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 052/145] media: s5k6aa: describe some function parameters
Date: Fri, 23 Feb 2018 19:25:58 +0100
Message-Id: <20180223170731.620636626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>


[ Upstream commit 070250a1715cee2297de0d9e7e2cea58be999d37 ]

as warned:
  drivers/media/i2c/s5k6aa.c:429: warning: No description found for parameter 's5k6aa'
  drivers/media/i2c/s5k6aa.c:679: warning: No description found for parameter 's5k6aa'
  drivers/media/i2c/s5k6aa.c:733: warning: No description found for parameter 's5k6aa'
  drivers/media/i2c/s5k6aa.c:733: warning: No description found for parameter 'preset'
  drivers/media/i2c/s5k6aa.c:787: warning: No description found for parameter 'sd'

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/s5k6aa.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/media/i2c/s5k6aa.c
+++ b/drivers/media/i2c/s5k6aa.c
@@ -421,6 +421,7 @@ static int s5k6aa_set_ahb_address(struct
 
 /**
  * s5k6aa_configure_pixel_clock - apply ISP main clock/PLL configuration
+ * @s5k6aa: pointer to &struct s5k6aa describing the device
  *
  * Configure the internal ISP PLL for the required output frequency.
  * Locking: called with s5k6aa.lock mutex held.
@@ -669,6 +670,7 @@ static int s5k6aa_set_input_params(struc
 
 /**
  * s5k6aa_configure_video_bus - configure the video output interface
+ * @s5k6aa: pointer to &struct s5k6aa describing the device
  * @bus_type: video bus type: parallel or MIPI-CSI
  * @nlanes: number of MIPI lanes to be used (MIPI-CSI only)
  *
@@ -724,6 +726,8 @@ static int s5k6aa_new_config_sync(struct
 
 /**
  * s5k6aa_set_prev_config - write user preview register set
+ * @s5k6aa: pointer to &struct s5k6aa describing the device
+ * @preset: s5kaa preset to be applied
  *
  * Configure output resolution and color fromat, pixel clock
  * frequency range, device frame rate type and frame period range.
@@ -777,6 +781,7 @@ static int s5k6aa_set_prev_config(struct
 
 /**
  * s5k6aa_initialize_isp - basic ISP MCU initialization
+ * @sd: pointer to V4L2 sub-device descriptor
  *
  * Configure AHB addresses for registers read/write; configure PLLs for
  * required output pixel clock. The ISP power supply needs to be already
