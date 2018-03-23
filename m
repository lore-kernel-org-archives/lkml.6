Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804098-2-14358976116854749089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804097; b=DlmmkdL4hWzannevO09R6JD1bg3Zu2fkMV4HXegDb3e32pY
    W1z9A3/jmal1b37zMnztNXV4hHmiEFB4Bc/JuJHzBxbWtOw6cxKcEXfP0GStnThj
    ozULXPyVrWMZg5Smf9Ht6E7SMJ527rAiR/eOWdt/2luehaiP9BFEhdAqFq4IX/6X
    u8FPPaHSHBmgkyR0oUJfl/hfeL2SNi18EhEP7o/ftDhIoBL3cdQ8kXmHkGo0IDQv
    aG7Sd2m6TPLVAckETuJEHyV1DxhVfM6oxXmril8q75mEesePsT6jj6tseFpVCLZN
    IBlyZv0EYAfos+ehMDp3OQVaKnBDAvQePc92SUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804097; bh=unHiWBwzOja/dvamuj/zjZ/YFE
    AP9OTFz5EEY2V0mN8=; b=fLuFjsJnLvnx+IID4Xbksx6/9cM5agMT8FuSvu3Bwb
    ZAkfb4c1N7uTTtJoc5bxY4wdAhaFhi3ElbxgbgTqt3mSjdqUbqIyp/M+SsVXjnA6
    a/JH4JPzpDMYKvbHIE0rZMBoff3xlOOFxv9JBMYb6rphGtbMVwcvk+AyQYE+eVR9
    +VN9cClFSmyUgderss8epUfWCQGSUOQlkC71/j4mYUf9ZNGkLX30n4T9FQA1sl12
    sxB+7sxgDDvO5lyctJT1MU8qURy3IaxtRPTe+7b/7lD71QeJcQblo9x8jeiyqVm7
    iXDTwTNnt00RFVw+xd/bpRYp28iLpCZwfnTUPBrSlHpw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755546AbeCWKI1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755507AbeCWKIZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 072/177] iio: st_pressure: st_accel: Initialise sensor platform data properly
Date: Fri, 23 Mar 2018 10:53:20 +0100
Message-Id: <20180323094208.500389267@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Shrirang Bagul <shrirang.bagul@canonical.com>


[ Upstream commit 7383d44b84c94aaca4bf695a6bd8a69f2295ef1a ]

This patch fixes the sensor platform data initialisation for st_pressure
and st_accel device drivers. Without this patch, the driver fails to
register the sensors when the user removes and re-loads the driver.

1. Unload the kernel modules for st_pressure
$ sudo rmmod st_pressure_i2c
$ sudo rmmod st_pressure

2. Re-load the driver
$ sudo insmod st_pressure
$ sudo insmod st_pressure_i2c

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/st_accel_core.c       |    7 ++++---
 drivers/iio/pressure/st_pressure_core.c |    8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -827,6 +827,8 @@ static const struct iio_trigger_ops st_a
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =
+		(struct st_sensors_platform_data *)adata->dev->platform_data;
 	int irq = adata->get_irq_data_ready(indio_dev);
 	int err;
 
@@ -853,9 +855,8 @@ int st_accel_common_probe(struct iio_dev
 					&adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!adata->dev->platform_data)
-		adata->dev->platform_data =
-			(struct st_sensors_platform_data *)&default_accel_pdata;
+	if (!pdata)
+		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
 
 	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
 	if (err < 0)
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -638,6 +638,8 @@ static const struct iio_trigger_ops st_p
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =
+		(struct st_sensors_platform_data *)press_data->dev->platform_data;
 	int irq = press_data->get_irq_data_ready(indio_dev);
 	int err;
 
@@ -673,10 +675,8 @@ int st_press_common_probe(struct iio_dev
 	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
 
 	/* Some devices don't support a data ready pin. */
-	if (!press_data->dev->platform_data &&
-				press_data->sensor_settings->drdy_irq.addr)
-		press_data->dev->platform_data =
-			(struct st_sensors_platform_data *)&default_press_pdata;
+	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
+		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
 	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
 	if (err < 0)
