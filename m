Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413726-2-14411543813582637397
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
    t=1519413726; b=vtcreG4rtDKXWAzqUILCWUm7tcCZXNSLo0wbP7OA99zyVHf
    LCIy7NEqUArTMEg3s5z8Q2dMLiGTA6eKQhwSxcY0ZJ4ooufdTgDtqFOL/iBBN38B
    TCDBD4ikY9MPDpnQRkARsfYqk/HZUXw5vHVTByeXxwNGxS9WE9bFwus7GQAlbVwo
    u7p5+70ryeeuRGGSnBQFTQBUHl4D1unXPLOcdLJaGm6/J1rEzFsQwlbec79wLuK7
    yORfFdyDkQLfUiku5ZG4CkUYxTmYKeM7XeZg0q3V2YRjFm4lOKRF12TCzD5Icp+p
    dm9MAxEHXUTzGapTh19BGsyi4iKL/tlykmoz0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413726; bh=kon5cSl75H23CWQW1emW8TLloR
    dZdcXZCjbRAZV4uPQ=; b=kbAFqUHtAtr3J6JaXwDblv8FgdSSJjwyhrcv2D1vD4
    wC/bNQdv9eIulw0Y+QO9gjn4sMFTKV4F6oQVLvoF7rbmxgUsdwIN7+SYBH8rTbke
    7qvZkNQyPVF3T8v1O6358DJ71hWJw7XRVi4wsIlsBxras9P5ScXh5A6yzBJoXAMg
    wN+NF/JsyLdu9rweXnPabBTR0vE7K/yBgwzQ9z4scJk6GPUPGb1aFQvULArVoUtO
    LYydVCe+HOv9xRR9C9XmA/8cicWBlqR2lwhISxLTBRQKj4eib3/QVVsKUB6H6+5v
    Ksb2C6ebck7VDzzBZIRRme9nqo3ff2Q7fxtcMyaxegJw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935431AbeBWSxr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935140AbeBWSxq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 099/159] iio: proximity: sx9500: Assign interrupt from GpioIo()
Date: Fri, 23 Feb 2018 19:26:47 +0100
Message-Id: <20180223170755.443076295@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


[ Upstream commit e53111ad5deaef98d8c18a9933ef1f5624c5979d ]

The commit 0f0796509c07

("iio: remove gpio interrupt probing from drivers that use a single interrupt")

removed custom IRQ assignment for the drivers which are enumerated via
ACPI or OF. Unfortunately, some ACPI tables have IRQ line defined as
GpioIo() resource and thus automatic IRQ allocation will fail.

Partially revert the commit 0f0796509c07 to restore original behaviour.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/proximity/sx9500.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -871,6 +871,7 @@ static int sx9500_init_device(struct iio
 static void sx9500_gpio_probe(struct i2c_client *client,
 			      struct sx9500_data *data)
 {
+	struct gpio_desc *gpiod_int;
 	struct device *dev;
 
 	if (!client)
@@ -878,6 +879,14 @@ static void sx9500_gpio_probe(struct i2c
 
 	dev = &client->dev;
 
+	if (client->irq <= 0) {
+		gpiod_int = devm_gpiod_get(dev, SX9500_GPIO_INT, GPIOD_IN);
+		if (IS_ERR(gpiod_int))
+			dev_err(dev, "gpio get irq failed\n");
+		else
+			client->irq = gpiod_to_irq(gpiod_int);
+	}
+
 	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET, GPIOD_OUT_HIGH);
 	if (IS_ERR(data->gpiod_rst)) {
 		dev_warn(dev, "gpio get reset pin failed\n");
