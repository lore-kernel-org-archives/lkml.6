Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2558661-1519898037-2-2640090931121619775
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519898037; b=as9BHkTR9RYZu9FoaNH9EiG/moD9eSXcQ9QR9iv1m2SJuXi
    Oy+UCq0c+OKE73zMi5avZlfZvoYyyW3wHRxQFlovwmD0RcwvA67Qs2IgEuundd4o
    UVjreftxTpF9h/Red82XMYks/ujkfN7TOcgWC/YtBVDJfyocKQYl+ZxtkhsI8c/y
    txIgWWu5IwAAgi0uMJrfial2ViwrcsCcWll0W6F1IoVgD4Tsl5hr6j4rbpb2rIkM
    Wja4Hx1XbkV0C3djYjQo4zrBPxu5IBuM+LL3+pXNiFAxT0vb+/RobE6TXDKfoVBb
    aydmyEjMnKBBOij7RcnvkBcVZXnc4l70XDryltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519898037; bh=a3mIoNSP3WC5rjAcg4mIh4KdEr
    Ew+R0XXdtn6bZPB+4=; b=JFOcpiTgDgKLClpasJA6LptIPAbjiJdvoSbyi1p/AE
    cMmPz25hYl7rGM9JiZ6VQTjRv8mP3V+hf4vBf5Gtzpt0Ib/1lHeu4X27naF0QljH
    Jbl+02B+/bGyhpc6bXKWwTC8XliX0l9nDcYxfmCqJrx2HNmPM6Kx0e0KteFvNsFN
    pwWL6QT1g50tlYlsDvuYMiey//Ees81xsARY3k+a0CQlqBDIMFU4jwj6q8iLi0Vk
    Az/DpttsdX5hLQIoAHphhRf7U9hI75HBoDIMTfNBe+9xcijHrUDgh9U4UpCIsoXL
    SUq00LoKImtXTo3vknfg6Wu5ykVBI0LEgFFenZLu2S2A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967146AbeCAJxc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 04:53:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14938 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967296AbeCAJx1 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 04:53:27 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Roger Quadros" <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v4 2/2] usb: host: ehci-platform: add support for optional external vbus supply
Date: Thu, 1 Mar 2018 10:51:39 +0100
Message-ID: <1519897899-8577-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some boards, especially when vbus supply requires large current,
and the charge pump on the PHY isn't enough, an external vbus power switch
may be used.
Add support for optional external vbus supply per port in ehci-platform.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/host/ehci-platform.c | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b065a96..e0dace7 100644
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
+	struct regulator **vbus_supplies;
 	bool reset_on_resume;
 };
 
@@ -56,7 +58,8 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	struct platform_device *pdev = to_platform_device(hcd->self.controller);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-	int retval;
+	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
+	int portnum, n_ports, retval;
 
 	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
 
@@ -71,11 +74,56 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	if (retval)
 		return retval;
 
+	n_ports = HCS_N_PORTS(ehci->hcs_params);
+	priv->vbus_supplies = devm_kcalloc(&pdev->dev, n_ports,
+					   sizeof(*priv->vbus_supplies),
+					   GFP_KERNEL);
+	if (!priv->vbus_supplies)
+		return -ENOMEM;
+
+	for (portnum = 0; portnum < n_ports; portnum++) {
+		struct regulator *vbus_supply;
+		char id[20];
+
+		sprintf(id, "port%d_vbus", portnum);
+
+		vbus_supply = devm_regulator_get_optional(&pdev->dev, id);
+		if (IS_ERR(vbus_supply)) {
+			retval = PTR_ERR(vbus_supply);
+			if (retval != ENODEV)
+				return retval;
+		} else {
+			priv->vbus_supplies[portnum] = vbus_supply;
+		}
+	}
+
 	if (pdata->no_io_watchdog)
 		ehci->need_io_watchdog = 0;
 	return 0;
 }
 
+static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
+				    bool enable)
+{
+	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
+	int ret;
+
+	if (!priv->vbus_supplies[portnum])
+		return 0;
+
+	if (enable)
+		ret = regulator_enable(priv->vbus_supplies[portnum]);
+	else
+		ret = regulator_disable(priv->vbus_supplies[portnum]);
+
+	if (ret)
+		dev_err(hcd->self.controller,
+			"failed to %s vbus supply for port %d: %d\n",
+			enable ? "enable" : "disable", portnum, ret);
+
+	return ret;
+}
+
 static int ehci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
@@ -134,6 +182,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
 static const struct ehci_driver_overrides platform_overrides __initconst = {
 	.reset =		ehci_platform_reset,
 	.extra_priv_size =	sizeof(struct ehci_platform_priv),
+	.port_power =		ehci_platform_port_power,
 };
 
 static struct usb_ehci_pdata ehci_platform_defaults = {
-- 
2.7.4

