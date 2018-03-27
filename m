Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174270-2-13163312095749347675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174268; b=Iu7L8LESjNyGfnbalq5jNYQt1kOLII3uYegscVuneYcjIvZ
    7OA7UCT6MELG/F1/HxdGyGr4wSpfMi8pod7/jH8kuDd9wQ+P3hmPdXfgniiaWq5N
    dLmvpMnQ8arnRrunE0gQxL0RPa6V0rZP9onE8HmeSCUxBPPqoMrT5FEzXPmxCp5o
    7mQOF/5v2M4X2I8gVg8iriL41G9oh4bmH5De+H/Rb4GGfKbLWAAv91oyNrzB9lCr
    auLjFHMLjBF8e1PDlSieNg6hOZpip9I4bvAFpRa6JMxm9bPewpNedIwQ+qriyBKd
    NLLMJhhBKwO8ksz8IK9LWbOj5+LNvr04smZcdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174268; bh=DIgeIUAvv+VKAnpj9iAC/DsI4F
    xwl373R7adcJDZGpg=; b=d1pdPoJvl3/3O81xPAKz1fNi2FkjDdpKJssNN9Qjry
    wnwUZVMMSFgFkOi9xNKh0zg645v9jKucFR6D6VbKhQVCWFsbGE94WwuOtW6Vjmt8
    uA0K13vsmHTJyW6TaJhCDExdUs4OWCnrauRiA5KFClW5JFd7ApOP+fEWF+EuX4mP
    2EesuCCiTfyBmZrFEr/UGGcus5hjWWB5CfKxtxk2Jh3yX/vXq18DAcix598gNZoF
    7sV1LvVfOrPkUOUe0T4c1VtG4jYnWU+x4+kQdMCQQ6+YKXDb6vsfG4SRi1aAipeR
    +LCnblx+GbREd8SRYAaQdPd/7q9QK+6dSMr/s4iRTj1Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfI9WQaixCBNgXEJJaKB869AqWG3KHdN/p99+RYM2zib2DWeb6l+Oib5hNE3p//fRyzr6E+ibvJkugIOhlqcAp4fGy2UwJE/cBSGncpK54yIbjhJ7EUyG
    Uz7pQc2tYrPBxn9B9c1+RMq5+0UYXUAWxaL7m4SqofHroxRXjdDAfgp5qvqOETg0hwgUTHtd6b5asqssIuVNC5yuSd5ITkWbsJ2zV80NJDP1ygf4B5l0nBPe
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=ag1SF4gXAAAA:8 a=3o5_6LReBt6b7od10RIA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeC0Q2o (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:28:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeC0Q2l (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:28:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Nosthoff <committed@heine.so>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.4 02/43] iio: st_pressure: st_accel: pass correct platform data to init
Date: Tue, 27 Mar 2018 18:27:06 +0200
Message-Id: <20180327162716.539364144@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
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

From: Michael Nosthoff <committed@heine.so>

commit 8b438686a001db64c21782d04ef68111e53c45d9 upstream.

Commit 7383d44b added a pointer pdata which get set to the default
platform_data when non was defined in the device. But it did not
pass this pointer to the st_sensors_init_sensor call but still
used the maybe uninitialized platform_data from dev.

This breaks initialization when no platform_data is given and
the optional st,drdy-int-pin devicetree option is not set.

This commit fixes this.

Cc: stable@vger.kernel.org
Fixes: 7383d44b ("iio: st_pressure: st_accel: Initialise sensor platform data properly")
Signed-off-by: Michael Nosthoff <committed@heine.so>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/st_accel_core.c       |    2 +-
 drivers/iio/pressure/st_pressure_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -657,7 +657,7 @@ int st_accel_common_probe(struct iio_dev
 	if (!pdata)
 		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		return err;
 
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -469,7 +469,7 @@ int st_press_common_probe(struct iio_dev
 	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
 		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		return err;
 
