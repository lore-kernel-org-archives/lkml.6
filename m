Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172307-2-1371107527073912142
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
    t=1522172306; b=CjKKJFQRRSMDbGptXue5fwTLx1PsJ+ehLOBbqW/1Csupj+C
    NgHrflP/sxdNs5d4IRUkdCsJfd3TRB222vjYp/ZPTzRAagWO4xzyZNvSbF5QJdka
    vR5BOTqACERizBX/AoCoEJXB7OvAigpdhuP16C44FN1WwcRAl3z9hH1vDK8Ux989
    aC6qDjHjbM6TJyrgbsZkXMJshyU6mY+FRcfRvSD3jKj8plLpTA05+J1HndbbZbNc
    yEDZN/9tZRLFDGb1s9DAq7Qh+/yChPif+aOWrMdaTX9tOSR9OYz5JvxViWISRw/D
    mlojhiCffnHdj8nTuI5ws5BH2yVVzA0GavjyZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172306; bh=HJACQ8KPPa+UAS7E6m1/MVvCXQ
    gc1XS5yKYx2b/NddM=; b=jj5lkG3Guw7weCaS7W3LD7F6IDbNpzmbe9aPsiKuKA
    Jdl/pj4IJaFQb+4+SnApi562sMe0+JE+HGPSBXspnFXKlrPeXFkPKWcXix4tWcWw
    nYPd1qDkktTM+SDkKH5SECgbfMhXSZN40zyc0uEkzSZKAkzGo/CvXEDNgEa7GFju
    tKovlCn+t+wiWb9WsxYjHEdlUkWpUq8/Ez5VME/9vTOAJJvou4iePalZwpMlC5+I
    Z5sdBfm8G4RvZad0GzJjG9OOBA3LNGU274HIiaYCfFyjQI9VJtWOeBlSdAoGUOoy
    eZ2Be1/jlaYybZtvpMmAIzzno/CSFtQ++CUOkCggjc8w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfHQpzIH1KLvb54cWuiv6cI6Qc+GSFGREbbi/HTgAt9t+7Kct8BGT8e5ct9FsLGX8JVtizDj5rWHqBETlekaAD2mPrPoo8lACHjS+EjpU9AJfYTp/IRti
    MCetalYefrpXaC8uunVDcYdEen4djadnK/uQ8PUlWzmrnNkSi7C+0hWBWe5uckIuXnVF/3IyuipaVkZ9IuEPwLioz+0hBFFTCAvxRTwXpzJkbUgmjG0Jorhs
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=A268-kvZAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=ag1SF4gXAAAA:8
    a=kg1Jk7u5AB4xihVo41kA:9 a=QEXdDO2ut3YA:10 a=nmtw_DHK8Krhp2MH4jI5:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754257AbeC0Qed (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:34:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeC0Qeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Lai <richard@richardman.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 006/101] iio: chemical: ccs811: Corrected firmware boot/application mode transition
Date: Tue, 27 Mar 2018 18:26:38 +0200
Message-Id: <20180327162750.405377291@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
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

From: Richard Lai <richard@richardman.com>

commit b91e146c38b003c899710ede6d05fc824675e386 upstream.

CCS811 has different I2C register maps in boot and application mode. When
CCS811 is in boot mode, register APP_START (0xF4) is used to transit the
firmware state from boot to application mode. However, APP_START is not a
valid register location when CCS811 is in application mode (refer to
"CCS811 Bootloader Register Map" and "CCS811 Application Register Map" in
CCS811 datasheet). The driver should not attempt to perform a write to
APP_START while CCS811 is in application mode, as this is not a valid or
documented register location.

When prob function is being called, the driver assumes the CCS811 sensor
is in boot mode, and attempts to perform a write to APP_START. Although
CCS811 powers-up in boot mode, it may have already been transited to
application mode by previous instances, e.g. unload and reload device
driver by the system, or explicitly by user. Depending on the system
design, CCS811 sensor may be permanently connected to system power source
rather than power controlled by GPIO, hence it is possible that the sensor
is never power reset, thus the firmware could be in either boot or
application mode at any given time when driver prob function is being
called.

This patch checks the STATUS register before attempting to send a write to
APP_START. Only if the firmware is not in application mode and has valid
firmware application loaded, then it will continue to start transiting the
firmware boot to application mode.

Signed-off-by: Richard Lai <richard@richardman.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/ccs811.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -128,6 +128,9 @@ static int ccs811_start_sensor_applicati
 	if (ret < 0)
 		return ret;
 
+	if ((ret & CCS811_STATUS_FW_MODE_APPLICATION))
+		return 0;
+
 	if ((ret & CCS811_STATUS_APP_VALID_MASK) !=
 	    CCS811_STATUS_APP_VALID_LOADED)
 		return -EIO;
