Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2701711-1521724085-2-9732336547749131797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521724082; b=mXTsbZkRCjnNEL4gJMNIaFa3S90FzdEq5K7qqjK6gL+k2wp
    uACGjApIJBsBFpK9tKRtI2rh6DjnWV93Ee6ipveLjZuPjTe1wvxCAAKTn9JO8RR0
    W+dwiho9OfNTVFSsnZymJr8SOUmRIHRlfKeOLrg/LOFr+zoS9p59pkmiyr86odVR
    /h3xfiupaxSqgzraok1C7emq5+yNTZGA1GhMAAGVnYRQYOoGGzINX2T8c837nP5R
    SFKWqYwZ/7VClaRq5+uyakPQuKtPVzCnZJ3qYyv0ibTS3T8Q0+CPEG1CZrDFqOtz
    7LdpKSW0vaQt0xjLGJ5CbUTd3/pNcEOb0WVYshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521724082; bh=RkFdU68biRWoW0DiSKUQwM8+/VXvGy6UiJpUzJwTZtQ=; b=j
    SpkyvEgU63JF2Ypzd96PlTtff1WcisnxkkLOSphCBbXhHC6zSz0aec0j3V851JnO
    8Dsu+RQL+f9d2kTOYasAveNLv52A0k36ETeAi/UHNUw3z5Z2A4ggm6pSRsb5ikiv
    mtE7m4+FKF9VO8FipZrggBnMoQ168Id7Dv0PXfwsTuRfWQvBD0BL492R1r/Sjq4E
    JcqGhi1dBXPu5QHXJ5Pw0oesNSDlGDhYvOrK3chYgSVjdAg/tsjsGXq8pgkDXHQp
    AgoNGbIh4D8ucwx6xryEfOuu6eNWMkykdq2Y1M8aZQTlOtwJi057zn5Ux+m0jwcC
    /gln52TMaP14e7LpPmX3Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rWIXzTYg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CNEes2Ug;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rWIXzTYg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CNEes2Ug;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbeCVNHt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 09:07:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33516 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755115AbeCVNHs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 09:07:48 -0400
X-Google-Smtp-Source: AG47ELspHF9YtPMg9EiaxVvLwU4x4qjORSrpOvVjBguQhLrijL0ICIQ6TYj0GKehSy1JQaavxAJi4A==
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Thu, 22 Mar 2018 14:06:39 +0100
Message-Id: <20180322130639.9957-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

devm_regulator_get_optional returns -ENODEV if the regulator isn't
there, so if that's the case we have to make sure not to leave -ENODEV
in the regulator pointer.

Also, make sure we return 0 in that case, but correctly propagate any
other errors. Also propagate the error from _dwc2_hcd_start.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

v2: Only overwrite the error in the pointer after checking it (Heiko
    Stübner <heiko@sntech.de>)
---
 arch/arm/configs/multi_v7_defconfig |  3 +++
 drivers/usb/dwc2/hcd.c              | 11 +++++++----
 scripts/setlocalversion             |  9 ---------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 846ce7bb24bc..33148fcabd17 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1029,3 +1029,6 @@ CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_PCI_LEGACY=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_LOCALVERSION_AUTO=n
+CONFIG_LOCALVERSION=""
+
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dcfda5eb4cac..863aed20517f 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
 {
 	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
-	if (IS_ERR(hsotg->vbus_supply))
+	if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
+		hsotg->vbus_supply = NULL;
 		return 0;
+	} else if (IS_ERR(hsotg->vbus_supply)) {
+		hsotg->vbus_supply = NULL;
+		return PTR_ERR(hsotg->vbus_supply);
+	}
 
 	return regulator_enable(hsotg->vbus_supply);
 }
@@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_vbus_supply_init(hsotg);
-
-	return 0;
+	return dwc2_vbus_supply_init(hsotg);
 }
 
 /*
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..cbc36d3b4d0f 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -161,15 +161,6 @@ res="${res}${CONFIG_LOCALVERSION}${LOCALVERSION}"
 if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
 	# full scm version string
 	res="$res$(scm_version)"
-else
-	# append a plus sign if the repository is not in a clean
-	# annotated or signed tagged state (as git describe only
-	# looks at signed or annotated tags - git tag -a/-s) and
-	# LOCALVERSION= is not specified
-	if test "${LOCALVERSION+set}" != "set"; then
-		scm=$(scm_version --short)
-		res="$res${scm:++}"
-	fi
 fi
 
 echo "$res"
-- 
2.14.3

