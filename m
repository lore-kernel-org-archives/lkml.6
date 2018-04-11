Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481660-2-4302306128767583569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481660; b=DgKY968YzfSLEISac0WLkPCaS1wVCWKgSwN6LRzOf0sLv8zD/0
    EXxCfr4PvThBp7T6caF8xcFXRl/h9CRphkgpNFwVE2kfhFr2X6GkOQep7UPwG66G
    JdMOdsPTTuxFe2eruJnYULR7ABqHsxcBQsvC3PipKRPaq6aEc8oGThWghVE8cEnr
    35NAe1VD8K1PUzi1IETwgcp+8QVJMYTceoeJHY3Mk5A87aq9uX4gEZwrsWSL4iBJ
    sQ7uvCq4RT5+khGgz92ujGhVlghO/5saHv7yGn2Gl0ysU6sZeoS9qV4z++0mFRZb
    hPPCo9YHr/qk/EgPl5aR2lwmqX7sLxHO9EVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481660; bh=Xi+hDlUic5LewJt9J9xwhJcFBcgB7V
    O70JU1JIfRpKs=; b=rpI1PzGJ0n0xeEznIP5++BPXShL7TfHmOQUdpBSdfp/ZwB
    SrdtdI/wnu+l05F2DXg71H1obAIscL3W0G89kG4U+RT89zfLLGmWTkXD+2c7Q6Cm
    NcyI77YV5S2jMJYBcm4xhOjj7+32LyC06ths4kFieQvT0uHBZhDDN8h4qDiG3i99
    /qgAXteLnSYbiJYMNr0CAsvhSi3cDPruU0EFvhoV68mvNObgZvRrkE8/fi4qQ/vD
    qfNWhgidls7e2AeI+bEtknQ8smSj7uNVVZRJ9AiZWraNfyWJu2UNLZfNaC2pO2xb
    +uwkM1zeY/Thnk7seRr2eGe+lzqoEcLZ4IyXLATQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEbDGvROviTVXpxBDIbLCyMBqEz8HmkLyqpyFwyesFC5LTfwpDvo2TgPyB7AKNHbsXQXJ5ipcV+uKg6wIK7Am/oRgj1gI3m7ciUfm7YxWDoVfjBwvH1k
    VAME4SCuGYzKA5O+WKG5feLE20qUgJZ49DWxoFeNvl/bpf+KUUA6wCKn4V9LfONWsVbBK7fHxDMPhB4ZuwRBPLYKsRlpI+tWDgDcrQICMz8PuDyLZvT5R/CR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ZVUqWHHvAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=m2PzPqTuUCvmICZ7DVwA:9 a=QEXdDO2ut3YA:10 a=29zIhhCU-8ffwYrvJFm6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754373AbeDKSjV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754369AbeDKSjU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 038/121] leds: pca955x: Correct I2C Functionality
Date: Wed, 11 Apr 2018 20:35:41 +0200
Message-Id: <20180411183458.625125203@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tin Huynh <tnhuynh@apm.com>


[ Upstream commit aace34c0bb8ea3c8bdcec865b6a4be4db0a68e33 ]

The driver checks an incorrect flag of functionality of adapter.
When a driver requires i2c_smbus_read_byte_data and
i2c_smbus_write_byte_data, it should check I2C_FUNC_SMBUS_BYTE_DATA
instead I2C_FUNC_I2C.
This patch fixes the problem.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-pca955x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -281,7 +281,7 @@ static int pca955x_probe(struct i2c_clie
 			"slave address 0x%02x\n",
 			id->name, chip->bits, client->addr);
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
 	if (pdata) {
