Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2820223-1519131547-2-14158454101604037418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519131546; b=YVNTPyUGIsP8CkULNFXWa19ECZ/3JJgUOhPjDa+ELyKAk8s
    yhpFcWHc7H7Eg2vj6QaxrVa5fU8i/iAqn8i6MSLXIqC3hbSMx3x0i6tcZ+HygyzQ
    XCfy+e06NeH0xKK607JZk+PUmkFBSU8EKbNrE7MJGFHWoUgCzR3sOcXQCjiORHMz
    Ep7oGQvsoLN10CNOO4WHpCLKDInkg7zNp61D6SMYIZXZMp/Kej0eqXxsSqd6mBdW
    uTYpyJ7soRiaJzXntI4y9gAf3xSP2kFUpI3oaFdD9Z+rIkD3Z8g688yetPeYzgZl
    /wyY1CBtUtrL04VxCwfksqgJnk1IbRZHmxI9sJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519131546; bh=HyKLwpouSsJ3axqOUytryUS+TZ0c5a5ikCGLNB5IQlw=; b=Y
    kut7b4wmCNMFzJ4khqPf65jDep4p9l1r5ip9SqzY+rd2QVK8YhkZGKKDYDy5TYzi
    Kb5HDqzGrHJgmxpq5M13c+0uBuFxlJIbaP5P0koR4u8HbJe2i6WzSajkgs/BhqS5
    9LdshMVWFAv1yGRtb0SvillWdh4UDxpAMb15WEN24Vb7kI7t5MkiWKbSmjmnDwBB
    FjRRpQHhLqoFkbxKSb1KiNqyGWQVzvEnbjDwHQ60rVravZz0gyyNm56undRRnaD0
    HnrKb20NmSuPX5Xe0mbxjpvyGCrPKVEmeAZYpohPwqMm77Ta1YLAvCa94IXLVwE0
    DJIXUkGNttwu9KoEQiCMQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeBTM6u (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:58:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61515 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751888AbeBTM6s (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 07:58:48 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2] usb: host: ehci-platform: add support for optional external vbus supply
Date: Tue, 20 Feb 2018 13:58:12 +0100
Message-ID: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_04:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some boards, especially when vbus supply requires large current,
and the charge pump on the PHY isn't enough, an external vbus power switch
may be used.
Add support for this optional external vbus supply in ehci-platform.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

---
Changes in v2:
 * Address Roger Quadros comments: move regulator_enable/disable from
ehci_platform_power_on/off to ehci_platform_port_power.
---
 Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
 drivers/usb/host/ehci-platform.c                   | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 3efde12..fc480cd 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -19,6 +19,7 @@ Optional properties:
  - phys : phandle + phy specifier pair
  - phy-names : "usb"
  - resets : phandle + reset specifier pair
+ - vbus-supply : phandle of regulator supplying vbus
 
 Example (Sequoia 440EPx):
     ehci@e0000300 {
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b065a96..05be100 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -46,6 +47,7 @@ struct ehci_platform_priv {
 	struct reset_control *rsts;
 	struct phy **phys;
 	int num_phys;
+	struct regulator *vbus_supply;
 	bool reset_on_resume;
 };
 
@@ -76,6 +78,25 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	return 0;
 }
 
+static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
+				    bool enable)
+{
+	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
+	int ret = 0;
+
+	if (priv->vbus_supply) {
+		if (enable)
+			ret = regulator_enable(priv->vbus_supply);
+		else
+			ret = regulator_disable(priv->vbus_supply);
+		if (ret)
+			dev_err(hcd->self.controller,
+				"failed to %s vbus supply: %d\n",
+				enable ? "enable" : "disable", ret);
+	}
+	return ret;
+}
+
 static int ehci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
@@ -134,6 +155,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
 static const struct ehci_driver_overrides platform_overrides __initconst = {
 	.reset =		ehci_platform_reset,
 	.extra_priv_size =	sizeof(struct ehci_platform_priv),
+	.port_power =		ehci_platform_port_power,
 };
 
 static struct usb_ehci_pdata ehci_platform_defaults = {
@@ -247,6 +269,15 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (err)
 		goto err_put_clks;
 
+	priv->vbus_supply = devm_regulator_get_optional(&dev->dev, "vbus");
+	if (IS_ERR(priv->vbus_supply)) {
+		err = PTR_ERR(priv->vbus_supply);
+		if (err == -ENODEV)
+			priv->vbus_supply = NULL;
+		else
+			goto err_reset;
+	}
+
 	if (pdata->big_endian_desc)
 		ehci->big_endian_desc = 1;
 	if (pdata->big_endian_mmio)
-- 
2.7.4

