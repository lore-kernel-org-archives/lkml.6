Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2671386-1527002211-2-10744163420373451395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.046, HEADER_FROM_DIFFERENT_DOMAINS 0.248,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527002210; b=KR+Y+yWvalkr+LetphVb7P117Qs1Pc1tTjZ+xMT3fm7NEhE/Wm
    /bFD6gfpZ8cUbhSufi7wQE5jS0zUUefxtWSPnSJA9K7+ZdulX9R8ZlvH0QpSW+qR
    7q4KA6qqb7h87/fbWqSyLuD6a4ijIaRbgqQp5TKjk12nb8RvU4Xo/VXWDI3NN0iu
    RNIh8S1aZ0ld2mBrE1EwTpd68ZdlMP2gyDjdnfqisRPlrW4Ot51ImTzsj/8z4z9j
    EhrYzuY0nTeQoMXrq66dOEGWvpA/JuviNoRKXFmIRDitMPhiFcF6VOlym9h5Y4Rb
    xMqJ2UQENyNfHIKe35+9qlm7sMQayTM5buuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    fm2; t=1527002210; bh=GpNHBnJmC08z5STCCqGkA85DxJolZSq/wy7iXTQl/z
    Q=; b=QDLR/qnzs0xCuAD5ImXoh6VjstrnT+Mwd1BDkc5hGc3Im6QQaPHPrgnbDQ
    Ra3FUzeFb0DhV8HVLTjuXXug9wibzOM/v83nHE573zig05GAD1185HzZxOC5KgXU
    BQNfG/FXFCzN+8VF5gm/wkoDG4hQux7E1Y5PDcFOmLBFAUq2edzlGlB7wmaKS/KS
    q97TnwbzKz27vMUiLBbPFvGVazeaF+MjqPA3ds5s+7EqpiIRvMnjKknH1eJZ+FCk
    up64DfCkaKK4PZHWQX0XtACFoAI9+PE75ZnULFi4nTNX5NzhOAMOXcozkmPII2kw
    IujM5JdMka0kv3dhuwDUzoQooX9w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAao6frloqBFn5BLUgWiS7RVt1YrmcrWsXWWUPAEeUC+KekZ5TtYbdG3sw3gcETKckI+NTYl0jvtKxlcB3yxqsAh/o2pTJCzhTqpdIngnlh25ScNe21x
    uccJkk56q/UuKWSIuFwCrY7egfbU2LB0BSTiWgDFdp+L/+hJ9LesXfdQtG8+qUDo6d9K8gXhYZlkusgTH9Z2HSFfIraBn0KHLvArd9bOx8ojmSNysTAvS4cA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=VUJBJC2UJ8kA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=YTbf48PZ1ptmbRm-fuAA:9
    a=NcSl5bKOO4E0YWyy:21 a=TzpTpNhVnBU85Nj5:21 a=x8gzFH9gYPwA:10
    a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeEVPQf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:16:35 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:52894 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751412AbeEVPQ0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 11:16:26 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRWlGSWpSXmKPExsUSt3Opsa6HCUu
  0weddghbNi9ezWXSt3slicXnXHDaLz71HGC0WLWtltniy8AyTxendJQ7sHptWdbJ5zDsZ6LF/
  7hp2j53fG9g9Pm+SC2CNYs3MS8qvSGDNOLPiOnNBs0DFkQuLWRsYn/N2MXJxCAmsZ5TY+/sJe
  xcjJ5BTIfH983ZWEJtXIFPi4fRHTCA2p4C7xMUF5xkhatwkdq3fABZnE7CQmHziARuIzSKgKj
  HxKUSvsECoROf/XWC2iMAGRontK0JBbGaBOone329ZIOYLSpyc+YQFIi4hcfDFC2aI+QYSpxc
  0gsUlBOwlpr+/ChTnALL1JRqPxUKEDSW+z/oGVWIu0bR1JuMERsFZSKbOQjJ1ASPTKkbLpKLM
  9IyS3MTMHF1DAwNdQ0NjXRNdIwNTvcQq3SS91FLd5NS8kqJEoKxeYnmxXnFlbnJOil5easkmR
  mB0MADBDsanx5IPMUpyMCmJ8oY9ZY4W4kvKT6nMSCzOiC8qzUktPsQow8GhJMH76A1QTrAoNT
  21Ii0zBxinMGkJDh4lEV6Gt0Bp3uKCxNzizHSI1ClGRSlxXiWQhABIIqM0D64NlhouMcpKCfM
  yAh0ixFOQWpSbWYIq/4pRnINRSZg3AWQKT2ZeCdz0V0CLmYAWX1wOtrgkESEl1cC49ti7y2EH
  VysFTty94wn7zJC/+hX6e2LmPrv78GVZaDej3RyrmKdP4iZkss6fu8mjpprr2PTi038izsiod
  e1z5/ZW0zq5ua/px4FaF9XNMbmHV0c1tGzfYpO2+/d/8+1Nb9793yh9fFluZsgKXynPY59jn5
  xX354S/pNtWrijtoxI01a/FuvtSizFGYmGWsxFxYkAN1tY7wgDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-6.tower-246.messagelabs.com!1527002184!1043199!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <c398d1fcc81017b9cc694a00d2c1f655874dfeac.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 May 2018 16:16:23 +0100
Subject: [PATCH 1/2] power: supply: Add fwnode pointer to power_supply_config
 struct
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 22/05/2018 13:35:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To allow users of the power supply framework to be hw description
agnostic, this commit adds the ability to pass a fwnode pointer,
via the power_supply_config structure, to the initialisation code
of the core, instead of explicitly specifying of_ndoe. If that
fwnode pointer is provided then it will automatically resolve down
to of_node on platforms which support it, otherwise it will be NULL.

In the future, when ACPI support is added, this can be modified to
accommodate ACPI without the need to change calling code which
already provides the fwnode handle in this manner.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/power/supply/power_supply_core.c | 4 +++-
 include/linux/power_supply.h             | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ecd68c2..f57ab0a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/thermal.h>
 #include "power_supply.h"
 
@@ -874,7 +875,8 @@ static void psy_unregister_cooler(struct power_supply *psy)
 	psy->desc = desc;
 	if (cfg) {
 		psy->drv_data = cfg->drv_data;
-		psy->of_node = cfg->of_node;
+		psy->of_node =
+			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0c9a572..b21c4bd9 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -199,6 +199,8 @@ enum power_supply_notifier_events {
 /* Run-time specific power supply configuration */
 struct power_supply_config {
 	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
+
 	/* Driver private data */
 	void *drv_data;
 
-- 
1.9.1

