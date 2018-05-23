Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3452472-1527041865-2-13036496807112210086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527041864; b=RUZCPReDEJj1aCVKbyNibLPg28jMmdxHiyJrBCNyn/cbhE4ZTA
    84XpwOx2ZbgUxXuNVJA40DaI5IYtQMykayXL3JT5qSgETQZjzFv3h2fEsI1oGTbf
    uPz4w1eIJVDV/EMh0cCgxnSOquce6VtfS82+au3XtWk/9U7G0qkPIh/xE9vA/v2S
    RTeJgZCGeifqUSUozlE4mpmXDprDR93fzVplFeX5ks0W2kya3ux9Jlxqwe3rhOGM
    Xdj9tBzKGzwDxElG87I56KKPNMQp2SzxPNwan3wa1VhaeLqjm0eYmuBRQyQtHxz+
    yER+eSuEaIIvB2td160L5r2gnVuCRgY1Z6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527041864; bh=yM4bznCmJK6SDW33U3jTGpfGiPGaS7
    iA9j7uk4ZY1L0=; b=LblW8MVRwiIQqQuM8lC51v8i95bxURUjBqnAJLzIGiAEHm
    EQD9fQMz9v7Abf2Q6GlQP+eaku53BrZYNpMLkgmUVccOkwvUfb6pAd4aqXppeeg6
    YR3NxDeFXp2I7/xQjmQJSKJ3KpPm6wMq44nP6VAAiF8+UEyQ+AX4m3FrgxiiTRzI
    zZ+WCTJ8Tp42/Q3b6z8LrHJHTbkw34DaPKgsr5ufx6riGZpXeCFpDfJRs8szIehG
    R8kQARlbiYL10d4N04lXlpjJ5I1JMUvR8FjPVo5F7iJwmnEYfhL7H2b9H/PPDfah
    JaVypXt11zgcCy2ppa2+i81WR2Q8N8V8j2Feuhig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=e09gF/tl
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qWdwXVkz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=e09gF/tl
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qWdwXVkz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGW4+X4UAQHSpOgNIY+m4OHfglLKnBbg/CcKpVqTbPJldMhdaDrs2D0V5GkJlaJerUclxjHbFmY+EaRC1uzaCvske3laaaRqSgN2mBapp5fjFvoiuqsu
    RB4gWOcQ4IfAxd9PQNWyfcNABAiaTkxDnQzGU2ZnDmciw2gcopuI3hqGEnjtie0XiXpIfY0NHSLCmi8gaXWpXt1b1YtFegNk/xI2BpbrsxOpisUSZVYgrpxl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=d8j6sh8cZkN2rbr-90YA:9 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753717AbeEWCR1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 22:17:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41315 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeEWCR0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 22:17:26 -0400
X-Google-Smtp-Source: AB8JxZoJtM7Qj5moVofDPveGuyqLKksQnhJt9l2+X1aC4rtNNRR4odZfmX9BapiUGI0RFfaYqm8XHA==
From: Nicolas Boichat <drinkcat@chromium.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-kernel@vger.kernel.org, groeck@chromium.org
Subject: [PATCH] usb: hub: Per-port setting to use old enumeration scheme
Date: Wed, 23 May 2018 10:16:56 +0800
Message-Id: <20180523021656.122455-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "old" enumeration scheme is considerably faster (it takes
~294ms instead of ~439ms to get the descriptor).

It is currently only possible to use the old scheme globally
(/sys/module/usbcore/parameters/old_scheme_first), which is not
desirable as the new scheme was introduced to increase compatibility
with more devices.

However, in our case, we care about time-to-active for a specific
USB device (which we make the firmware for), on a specific port
(that is pogo-pin based: not a standard USB port). This new
sysfs option makes it possible to use the old scheme on a single
port only.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

There are other "quirks" that we could add to reduce further
enumeration time (e.g. reduce USB debounce time, reduce TRSTRCY
to 10ms instead of 50ms as used currently), but the logic is quite
similar, so it'd be good to have this reviewed first.

 drivers/usb/core/hub.c  | 13 +++++++++----
 drivers/usb/core/hub.h  |  1 +
 drivers/usb/core/port.c | 23 +++++++++++++++++++++++
 include/linux/usb.h     |  7 +++++++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c2d993d3816f0..f900f66a62856 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2636,7 +2636,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define SET_ADDRESS_TRIES	2
 #define GET_DESCRIPTOR_TRIES	2
 #define SET_CONFIG_TRIES	(2 * (use_both_schemes + 1))
-#define USE_NEW_SCHEME(i)	((i) / 2 == (int)old_scheme_first)
+#define USE_NEW_SCHEME(i, scheme)	((i) / 2 == (int)scheme)
 
 #define HUB_ROOT_RESET_TIME	60	/* times are in msec */
 #define HUB_SHORT_RESET_TIME	10
@@ -2651,12 +2651,16 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
  * enumeration failures, so disable this enumeration scheme for USB3
  * devices.
  */
-static bool use_new_scheme(struct usb_device *udev, int retry)
+static bool use_new_scheme(struct usb_device *udev, int retry,
+			   struct usb_port *port_dev)
 {
+	int old_scheme_first_port =
+		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
+
 	if (udev->speed >= USB_SPEED_SUPER)
 		return false;
 
-	return USE_NEW_SCHEME(retry);
+	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first);
 }
 
 /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
@@ -4392,6 +4396,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 {
 	struct usb_device	*hdev = hub->hdev;
 	struct usb_hcd		*hcd = bus_to_hcd(hdev->bus);
+	struct usb_port		*port_dev = hub->ports[port1 - 1];
 	int			retries, operations, retval, i;
 	unsigned		delay = HUB_SHORT_RESET_TIME;
 	enum usb_device_speed	oldspeed = udev->speed;
@@ -4513,7 +4518,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
 		bool did_new_scheme = false;
 
-		if (use_new_scheme(udev, retry_counter)) {
+		if (use_new_scheme(udev, retry_counter, port_dev)) {
 			struct usb_device_descriptor *buf;
 			int r = 0;
 
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 4dc769ee9c740..4accfb63f7dcb 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -98,6 +98,7 @@ struct usb_port {
 	struct mutex status_lock;
 	u32 over_current_count;
 	u8 portnum;
+	u32 quirks;
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 6979bde87d310..4a21431953953 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -50,6 +50,28 @@ static ssize_t over_current_count_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(over_current_count);
 
+static ssize_t quirks_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	return sprintf(buf, "%08x\n", port_dev->quirks);
+}
+
+static ssize_t quirks_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	u32 value;
+
+	if (kstrtou32(buf, 16, &value))
+		return -EINVAL;
+
+	port_dev->quirks = value;
+	return count;
+}
+static DEVICE_ATTR_RW(quirks);
+
 static ssize_t usb3_lpm_permit_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -118,6 +140,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
 
 static struct attribute *port_dev_attrs[] = {
 	&dev_attr_connect_type.attr,
+	&dev_attr_quirks.attr,
 	&dev_attr_over_current_count.attr,
 	NULL,
 };
diff --git a/include/linux/usb.h b/include/linux/usb.h
index beffceec49158..2ade17992ed66 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -489,6 +489,13 @@ enum usb_port_connect_type {
 	USB_PORT_NOT_USED,
 };
 
+/*
+ * USB port quirks.
+ */
+
+/* For the given port, prefer the old (faster) enumeration scheme. */
+#define USB_PORT_QUIRK_OLD_SCHEME	BIT(0)
+
 /*
  * USB 2.0 Link Power Management (LPM) parameters.
  */
-- 
2.17.0.441.gb46fe60e1d-goog

