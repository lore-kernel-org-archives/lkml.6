Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479809-2-15164786277572952062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479808; b=lpVcRIZAN2WVQjJlq1bK7x99+I6CgkF5liJYe9Co3A+QLSgzWV
    ttINvOEVe9LpZ29Qj1PnmerNatgs0p73x5pQHlhke9MLDmxVO8bU/MbHn96zM0DD
    KAEVJPPEb6iNsT7aL8PRdMloE3hsmily4HrjN1WlOolglum6DuLaNFukdtredcZq
    TpSyP8gFcDbKbDJBuJQu9l9FygAA0X+zcZTkWzywv4sArr3l2r4i89Vh4sPU5Wqn
    ZMz74iZXEXmvlDVLOsX3MjLMyGpmoE3iE1oElL3/pv9TKyvuhVulZ5sneFpXDeNa
    5Do5c0Vsk5tEMnF43JEA1UVuwLbNnMY8LF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479808; bh=oDnvPlbnXhsVMqE/85EzB3wMViXSp2
    /2rZE2d35YbyY=; b=RWmaJiMy8QlFs6V2xfU0N9tizVfLV4pAWGCekGlaSFyIc7
    cvTIS2IT+HeF+g9Vz+DEEWyReSe3WZjXITaknl9BhD2d+JQf1jMHaRFk0meyVAWz
    Saudw64Rnca60I7XHqzL48U182eUwXHooP/yPnzwM4p4mIAKeKeIXgx4wHDLJUZJ
    8izgX2pt2z2egXhMHqWzNq78CInazdCkwzcEmyrETtAJtHZJcTcuh8jeA8BFEY4G
    efnWfmW4/2AlZZibHxl/orYIX4I1ATfOJJw5hueVaYfFba61Uml7xmy+dgG9SlgD
    pub8CEL8QbJylMNHEri2BHPTj65aZCmO000I4Ryw==
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
X-CM-Envelope: MS4wfEQjAR5+fAQKynjVQSMQ+2LdDPbVfNMnOsxXqQIYd6O/HGVxYRb4O/4Psnu7/2nTPxKJ2yxTLpHeo292S5W9G3SKhytTPrujoJ65rMUH8UB8UKdeq5/H
    oI3KUBp7mNXh/txyefh31oIx0PhfHy2975kKuAoNIJ1gOW+G88xNjcd220V02Wd8Tg8XjaCRd3UBoqScrv86WI5uANkzTNwyHqiQSGGUbBVAB6YqlKzuAvNL
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AMTvMMonAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=MxJhSPhoEE-0-1SkMGIA:9 a=QEXdDO2ut3YA:10 a=p5oU-coMHzOM5oT1KbOf:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755637AbeDKSp5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755632AbeDKSp4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 056/190] iio: hi8435: cleanup reset gpio
Date: Wed, 11 Apr 2018 20:35:02 +0200
Message-Id: <20180411183553.625668664@linuxfoundation.org>
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

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>


[ Upstream commit 61305664a542f874283f74bf0b27ddb31f5045d7 ]

Reset GPIO is active low.

Currently driver uses gpiod_set_value(1) to clean reset, which depends
on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.

This fixes driver to use _raw version of gpiod_set_value() to enforce
active-low semantics despite of what's written in device tree. Allowing
device tree to override that only opens possibility for errors and does
not add any value.

Additionally, use _cansleep version to make things work with i2c-gpio
and other sleeping gpio drivers.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/hi8435.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -453,13 +453,15 @@ static int hi8435_probe(struct spi_devic
 	priv->spi = spi;
 
 	reset_gpio = devm_gpiod_get(&spi->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio)) {
-		/* chip s/w reset if h/w reset failed */
+	if (!IS_ERR(reset_gpio)) {
+		/* need >=100ns low pulse to reset chip */
+		gpiod_set_raw_value_cansleep(reset_gpio, 0);
+		udelay(1);
+		gpiod_set_raw_value_cansleep(reset_gpio, 1);
+	} else {
+		/* s/w reset chip if h/w reset is not available */
 		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
 		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
-	} else {
-		udelay(5);
-		gpiod_set_value(reset_gpio, 1);
 	}
 
 	spi_set_drvdata(spi, idev);
