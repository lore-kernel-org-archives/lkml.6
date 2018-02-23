Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3019937-1519393671-2-16510768190427513895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519393671; b=H4B6riP7lJ+EDqevZKAxDE5apLoLjDacxxzgUbRT0eHVrSh
    cob5KTXYHSunmpmhMTD03PiwrhUeewYffvgU7Gxp4XnL4j5Ukm48voPUA3PozIKw
    nGbqnkBzV+JiHPJ7XMpezEuZfiZs9Gfcb8g83trgIKgFJfvpBhehCFVSs6ld1ItM
    gRDHuzhUrckN58zgSQIMSao+pLH3zXc12ep2uUnt8lpQYYqvVJWBuaRl9d3l3sZp
    HDy7XsY7MYEPm029ulAQnseGJk7JDW6UnA4vX2HdBjhV+bqAtjNHQWDBODQrrBbS
    wLY/kesRPD8tnFhGaMWPY7ydyvlqjZb7ZTX0w3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519393671; bh=jH9fNTCS0skX9CMVHPq9ppvttE7Xr1ktk3Vf+sbwo8E=; b=F
    J38arBRPTGnMy8YNQ7KNmXzh5QFwTFpVDZoCh6RmkDrlUaAwV8LT2x/RUvJVAiZw
    3mId+H35BHrnJdzAccNs8SQZ+2HiP0mdw6UyorpFR7dkv6utyXOPJUYh8yLM/8pv
    baTBBC9DkTvsVjm+sPBRbLdPYWTQ0eJ6hIR5QaAV/ptRUep9kqe5EVVpl6xmkNzF
    TgBmI9Fdzpopi10ujfbpDcwk4XzAs2Ya+bBwv549gvG9L8KcdJRnlQyn5xXK5qIj
    RDrAhRST8CdfUeCjrdbE0bM+gInxKWIJDNMED15oZfRqdoBtTfdQkqA3Xu/YB75I
    9DXYOCMq2mdc2lQs1GJXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeBWNrh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 08:47:37 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50200 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751437AbeBWNrf (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Feb 2018 08:47:35 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Roger Quadros" <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3] usb: host: ehci-platform: add support for optional external vbus supply
Date: Fri, 23 Feb 2018 14:46:51 +0100
Message-ID: <1519393611-31367-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
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

---
Changes in v3:
 * Address Felipe Balbi comments: reduce indentation in
   ehci_platform_port_power.
 * Address Roger Quadros and Alan Stern comments: platforms can have one
   external vbus supply per port, so add support to get as many optional
   regulator as implemented ports on the host controller.

Changes in v2:
 * Address Roger Quadros comments: move regulator_enable/disable from
   ehci_platform_power_on/off to ehci_platform_port_power.
---
 Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
 drivers/usb/host/ehci-platform.c                   | 52 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 3efde12..cd576db 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -19,6 +19,7 @@ Optional properties:
  - phys : phandle + phy specifier pair
  - phy-names : "usb"
  - resets : phandle + reset specifier pair
+ - portN_vbus-supply : phandle of regulator supplying vbus for port N
 
 Example (Sequoia 440EPx):
     ehci@e0000300 {
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index b065a96..8e9f201 100644
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
 
@@ -71,11 +74,57 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	if (retval)
 		return retval;
 
+	n_ports = HCS_N_PORTS(ehci->hcs_params);
+	priv->vbus_supplies = devm_kcalloc(&pdev->dev, n_ports,
+					   sizeof(struct regulator *),
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
+			if (retval == -ENODEV)
+				priv->vbus_supplies[portnum] = NULL;
+			else
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
@@ -134,6 +183,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
 static const struct ehci_driver_overrides platform_overrides __initconst = {
 	.reset =		ehci_platform_reset,
 	.extra_priv_size =	sizeof(struct ehci_platform_priv),
+	.port_power =		ehci_platform_port_power,
 };
 
 static struct usb_ehci_pdata ehci_platform_defaults = {
-- 
2.7.4

