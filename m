Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159413-2-1694683385330698866
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159412; b=isR3eSvTNWlOtOwWjhnqOnNVld1krsXdjN75UxGn2yKqnaYOyp
    UrI3ww0ZwoogyyE8FIx8Q1nD6QWINLVTzHqQ+g7gLjsArYtpdj5ahbHrU0qFDBgL
    IgY0vaZeKdueR6H4AxsrvMTxVcUs9DY0MOMUbxQPQrUCFkdu0gop+WowwjXY89Kw
    1Q6qAIUqq/aa5/rVD9phHNZh8cGwQl3oebuciMw8+Ae4CF9ANsyCdzX97jh0RzdQ
    VxGUZICZLLYBnjB/2E33IC1fwgdkktR9fVf+iCLvRgziSwmOMjCHraOrEjprFOtQ
    kLdwqPVYMpeV+agJca3uo9lqMhORnqL+tv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159412; bh=aIxCn39S4LZrkyWpEKRgkWk7KkjGd/
    7bF3KZN/m9gbE=; b=IaDD4EWlzlOdLRDBsxP43jrbxrS2UPAma/AjEBmdzhOzGg
    KXBGp3jB+V/7f9pLWvX+eDzacY81mfeN02mCtD6RlkP/nOe1zuoWMfvRoj0fU7bk
    EHVp+M8Tcy11Z2G65h7I/abgkvFFYxhHnlnWK3Yf/kMH8X19dpNMwToq/m/oWcDh
    XD07CW0yxx8EuktIh370soNgoRwdzs2YIKyKXgA5weOgFGcPO/cv4qGTproTusC5
    ZVQqV54Xf0JqTx4vce1GgWFpJlQAxLdEMKkyzwcdXCFp/Z2NSoT1fNf9c/spSCsa
    rgijaVi7SfQjAQdHc1gGHF5pZrMntIII1YSBAMCQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=DUA21b/G x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=DUA21b/G x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKnaf2TnAG1lLKUYCQxvvjiD64fhBfJlbUeOgweMEYm+s0bUWxB6BgFx+0EvDG8dtbp0xmZKMRRSgCwHGTLvsI+AifURh/D6dVSi4idrnxCUgwfh/qXI
    nfv3sz2uxZp9KplkAPlTzOZwbVFFn1u42YDA0dbyy4ExX1z23SkZh6FvSiZkyHgN7eyiUGUVNxad1wXA8HeJV4O7ofGPar+V3rM7nFh6rnu8csgJHCFGbb4J
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=9SQxSNahadhKcKig7uUA:9
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968111AbeEXJ4Y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030300AbeEXJ4W (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 081/165] media: lgdt3306a: Fix module count mismatch on usb unplug
Date: Thu, 24 May 2018 11:38:07 +0200
Message-Id: <20180524093625.294215809@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 835d66173a38538c072a7c393d02360dcfac8582 ]

When used as an i2c device there is a module usage count mismatch on
removal, preventing the driver from being used thereafter. dvb_attach
increments the usage count so it is properly balanced on removal.

On disconnect of Hauppauge SoloHD/DualHD before:

lsmod | grep lgdt3306a
lgdt3306a              28672  -1
i2c_mux                16384  1 lgdt3306a

On disconnect of Hauppauge SoloHD/DualHD after:

lsmod | grep lgdt3306a
lgdt3306a              28672  0
i2c_mux                16384  1 lgdt3306a

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/lgdt3306a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -2168,7 +2168,7 @@ static int lgdt3306a_probe(struct i2c_cl
 			sizeof(struct lgdt3306a_config));
 
 	config->i2c_addr = client->addr;
-	fe = lgdt3306a_attach(config, client->adapter);
+	fe = dvb_attach(lgdt3306a_attach, config, client->adapter);
 	if (fe == NULL) {
 		ret = -ENODEV;
 		goto err_fe;
