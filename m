Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1771605-1518708041-2-2924991066942658680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708041; b=mQF2NEFYPIVXz901j/QDvb0PSvXvsN2YtyLQoQqsnQ+cXUO
    gxBjLgClXAfSeQVqGtWHTXnxNVSCASexjaSBT12NOW6nIhnbp8F4WekkIlu/5k6+
    STQkiXUbvT15tn+nsV0dlNorrekc7cl6a7uTLnvQC/hq1ztCOYblLrynQ2p0ty7y
    qTVSusagoTf4QluMbTNmyZ/IZ8Iv14Jc5xnOpyfvYyNFDh2W9z7Z+WQvsv3HbyRu
    kR00S2q9vPm2mQrcr4R5eKnnxM7nWAx/NQ8ARJK6rFrm/OZZthEoppGASB0tFdHC
    PbBRjaqU1eh1bJFw8VZpFx7HJrO8Pc8exp6LBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708041; bh=7M6RUmuMzAcDETTABmMNC/ceam
    puH4X+sKwxh3wTPlQ=; b=kJesYBYo82/sAl4rmZ7RFRAwsvIDyWp411YawoCecC
    tsWzXLnp3YTSgU9HoslsrNhRyb56/JOFu1TiBA2Y5WSHoxx28l2NBOON23x7vrjr
    +zkw+XSIR9EMW3DG4Vre8Z2gCXJlI+JT2T83yvmaQPt9I+q+sjLPmqoaw2AOf0ZI
    AOF2+EY+YyaIlpoePA6yKky8+gd49JdC+3GaZ4IetT7+UHf8tid/10+XC6ZsPJXl
    oi75f22cqgNyuO/+9L5IO95UxyEl7bsVBKrIw6fIKJD7XuuDWu1PGMeljkeXPBg5
    PJJEIUmPFkUqZk3l71T1DVpKbF3+mXEah9hgPdz4f5Cw==
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
        id S1161804AbeBOPUh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:20:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161799AbeBOPUg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:20:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Opasiak <k.opasiak@samsung.com>,
        Yuyang Du <yuyang.du@intel.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 20/45] usbip: vhci-hcd: Add USB3 SuperSpeed support
Date: Thu, 15 Feb 2018 16:17:11 +0100
Message-Id: <20180215144120.217309674@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuyang Du <yuyang.du@intel.com>

commit 1c9de5bf428612458427943b724bea51abde520a upstream.

This patch adds a USB3 HCD to an existing USB2 HCD and provides
the support of SuperSpeed, in case the device can only be enumerated
with SuperSpeed.

The bulk of the added code in usb3_bos_desc and hub_control to support
SuperSpeed is borrowed from the commit 1cd8fd2887e162ad ("usb: gadget:
dummy_hcd: add SuperSpeed support").

With this patch, each vhci will have VHCI_HC_PORTS HighSpeed ports
and VHCI_HC_PORTS SuperSpeed ports.

Suggested-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: Yuyang Du <yuyang.du@intel.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vhci_hcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -279,7 +279,7 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh(
 				" ClearPortFeature: USB_PORT_FEAT_POWER\n");
-			dum->port_status[rhport] = 0;
+			dum->port_status[rhport] &= ~USB_PORT_STAT_POWER;
 			dum->resuming = 0;
 			break;
 		case USB_PORT_FEAT_C_RESET:
