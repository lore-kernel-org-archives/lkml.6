Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970764-1526044798-2-15942666586963277681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526044798; b=XusG/uYviB61v4Vt7dCkMUvYVNk+hNuLVmxG/k6dcCOzag+RVm
    36lhox7m1ad/Mw83Ntcyl94XbeFaWjIssRQTAGXYd8/J3vSKwjxmbE6D4wXjnHMY
    FdJm/7Uz7CEGlQWg4b2UZ5ekXwRHN9Fpt/WMNGZhAuy9wtsOP5tddlwLJO0sj7Rr
    zshUkJsv5nIL9+Sv7O9ogHJUooKgSGLD+NQ12hCkNQhOgD+yvmrajD1fwIQ0YQsO
    NOjpn4NsnWxe9ZBj3pbDKPR9nlkDHXV0UPnlqcwaJ/Ojo51Vb3X+feDzj+Lqw86x
    zCGR/Q19waeWnCQ/fgWh1Vmdbg1TPFsUqfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526044798; bh=
    1Y7m5pNyQChSkuMAajeshJzjJ8AQarTjsy+VQe7fL9w=; b=Yr6S5j2BBy0kkz4g
    uQ8Tqh1VFnT9IJPN8dS2f5AgSrwb0Kgm6C4sIqfyz+xkc2+NDwpTTtA2CsWmK6ze
    SDFOkOLuwaldcBgk2nQFj7zRcsTqCqEMa0PmneVSFu9+nKHx4b/GLh+bzT15vwG0
    vo74fdtw7CSQ/hffxnM/jhwmRsmA0JHjUPfsM9y8jAqT3sPR9Hh0zu8Ouc30PIRB
    aPIgqjQ5J3/cZCfyHw+t/aclZLZL8lHezHi0+gXTCIjJZFWdGYPG6KgWxvZsxyH0
    ySQBwHJpZ/19Ur1xNkDgAcxe2DdFM07mLljDqGMftgXiw9GBzZgaOx/pZZ0W5Y6T
    uCvqgg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKej5j+0021stVowPDHpo2OqGjAmLVhonEcNNn/B0/YZmN7TDbolKZ71KDjpZa4F4oWPq6wQd6inavG/3zCo88nUeqdMpChps55jjnGN8ktQL2gE9x/W
    vmxnWDZxfVQKeywg14fm1bXvVEZ0zBsR0MW+hnxPQBumOSglPKWWXWMDmTMckP6s6JJBWPrxzVsBNR4p0wDFS2Bl1y3cA3KtSYHH+Hq0Th0hHSaE6RItc+KU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=qt9Kkuip7a8nvxkIZ3sA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeEKNSp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 09:18:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:43622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753002AbeEKNSn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 11 May 2018 09:18:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="54341720"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/5] usb: typec: mux: Get the mux identifier from function parameter
Date: Fri, 11 May 2018 16:18:34 +0300
Message-Id: <20180511131838.62064-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order for the muxes to be usable with alternate modes,
the alternate mode devices will need also to be able to get
a handle to the muxes on top of the port devices. To make
that possible, the muxes need to be possible to request with
an identifier.

This will change the API so that the mux identifier is given
as a function parameter to typec_mux_get(), and the hard-coded
"typec-mux" is replaced with that value.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c     | 2 +-
 drivers/usb/typec/mux.c       | 6 +++---
 include/linux/usb/typec_mux.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 53df10df2f9d..3753950a798d 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1345,7 +1345,7 @@ struct typec_port *typec_register_port(struct device *parent,
 		goto err_switch;
 	}
 
-	port->mux = typec_mux_get(cap->fwnode ? &port->dev : parent);
+	port->mux = typec_mux_get(parent, "typec-mux");
 	if (IS_ERR(port->mux)) {
 		ret = PTR_ERR(port->mux);
 		goto err_mux;
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index f89093bd7185..7446d6d1e424 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -123,19 +123,19 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 /**
  * typec_mux_get - Find USB Type-C Multiplexer
  * @dev: The caller device
+ * @name: Mux identifier
  *
  * Finds a mux linked to the caller. This function is primarily meant for the
  * Type-C drivers. Returns a reference to the mux on success, NULL if no
  * matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a connection
  * was found but the mux has not been enumerated yet.
  */
-struct typec_mux *typec_mux_get(struct device *dev)
+struct typec_mux *typec_mux_get(struct device *dev, const char *name)
 {
 	struct typec_mux *mux;
 
 	mutex_lock(&mux_lock);
-	mux = device_connection_find_match(dev, "typec-mux", NULL,
-					   typec_mux_match);
+	mux = device_connection_find_match(dev, name, NULL, typec_mux_match);
 	if (!IS_ERR_OR_NULL(mux))
 		get_device(mux->dev);
 	mutex_unlock(&mux_lock);
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 12c1b057834b..79293f630ee1 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -47,7 +47,7 @@ void typec_switch_put(struct typec_switch *sw);
 int typec_switch_register(struct typec_switch *sw);
 void typec_switch_unregister(struct typec_switch *sw);
 
-struct typec_mux *typec_mux_get(struct device *dev);
+struct typec_mux *typec_mux_get(struct device *dev, const char *name);
 void typec_mux_put(struct typec_mux *mux);
 int typec_mux_register(struct typec_mux *mux);
 void typec_mux_unregister(struct typec_mux *mux);
-- 
2.17.0

