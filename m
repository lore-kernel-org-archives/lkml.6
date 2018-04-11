Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479556-2-4966196659481450395
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
    1523479556; b=WaYbjRuYGzVX1dE6HkbOjcRHeWu9m0sNbsu4srB6AcpbEoXqRU
    14fQW3gRUI4U/bkyDdspM0NzRVfeKnSKFmyDUnp+OMXKwFICvsuguSc7LK5SHN40
    /Ade7NEZurgdf82mFz1SLgdAEjDrJiOAhpYYHsfyOsTRzthLdVHvN6nsgq5rX7ZO
    MhiTq0wecAjItZHlOa/drG/l3PmAOiYoQtDUiiKAQv3+EmKym819fsGccxZNDXhF
    V46Bj2DWzbVslHazYT/aOuQnwtG0Phx2AykUATQxNWCSByzPCZF9GWz5X6Obo0jf
    B+p1N3hT8QjarHlRiy0Qx7j4kN7KEC7zV8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479556; bh=nVQxH4kQau4jP9OUfOrKn1MOBODSBz
    T5vQtzrx5OrtI=; b=NYav3WPi2U+NOY+gcz1U2TRqfoU4EYJOhrW6Hsl5UmUABd
    vcIOXOp8WIfg1SuhygsKcH/k/qZoDFzCrTfxwkJup6IryVD+I/O/b5Du7FJAnZwZ
    Iwo5mIeAQzro0AP0+BwwdPwjOQ/I0aJfUj4Rc/saJBgDryeqSotx5ZJBqVKXpcnq
    1fcbu0djOuoZt92oUr4aZvxBfDf42R8KTzfvTMWzx9jPDvMf+X6h7rh2jqfr+MTZ
    4b9fPKurriLJHVs1EhNUbM3Xnh7JhshdaSSYz1dnPsSjAWNOHPKcxKdQzrA8xU2f
    6CQYD2XgphHn5vxjEFKMGKSnRokDIASvzyyx0bIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPXPRF9JzBvP+ODWwEwSpwymFtSXBVnayD1jFCpabSC2Ie6YkK5HbtHCvhiuMcFXEU3mNom4eLOAOOhCXnozRulrpSyxvFB5CXKyQ2NEY7ud4aLYsz50
    x1vL5a4Dlo8bXo8+qV3KzHFRv8cOVKz/G52lgEykpFXeWAmyx3lgZ+7efX+VccO8+rkXI24cgl/dG+d/hgZnPxbXVQxBoYQkjkzd0mwLrwvHoqU4ylflCUYS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ZVUqWHHvAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=m2PzPqTuUCvmICZ7DVwA:9 a=QEXdDO2ut3YA:10 a=29zIhhCU-8ffwYrvJFm6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755796AbeDKSqy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755776AbeDKSqx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 061/190] leds: pca955x: Correct I2C Functionality
Date: Wed, 11 Apr 2018 20:35:07 +0200
Message-Id: <20180411183553.885699828@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
