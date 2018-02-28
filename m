Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837142-2-994161054894923784
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837141; b=drcmnZ8y7An2bUfOU5k8buq7yFC98hfrTSvBRtRRuy/NCQ+
    V3Z9JnxHhnA3Ge8wKexfUVeV21okPSg03gklTYRaZ0qSyOQ9Yj3bcnK8YDUI49vl
    8QJHBSuI0TWyDDWHg0Ay7GIhnbl4jbL1I3T+rKdk7AX5mX6kgJw8qcX1y5DB+04E
    aSsY3dJva4GhdVCLqOM+14pSqaCtSoSrb2Xd+YDQnQsv2wUZieW6glGglxQazRZC
    oTj9EiFAR3Bq98cVWh0diV2HgepuzsfrqzASRBBtP/ei+VbnckNjdL5MSb5kKXX5
    zRTQy0i5+idXtsrBcykaFYXSegp8Dpm0z1kVcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837141; bh=SH4O5bM8Mt4doxtgNUw
    XnZV2VLx6GM9MKH9494xvjYc=; b=hmwK6lkjIqLHO/6DN48e77+yCUfh+xWmrnX
    K88Q+fUa2nWvdiBHPLItjeKdQ2GiVdTfl1MHNEIcboW3+bae2AAdK83hURKzBCGi
    NNgWgNHqwpcCFBlnYikOsxdmixXMqsXtixwk0BjjiBjaH9sqk1AnEIluv/vjJLeV
    myOqZL2//t/2g7M22CsTXZ9/8eI+rUzK8gNDEfr8thTMSVHp8daBT+PweDx1HyiJ
    /YON50eFAn1PHVl+Uow4H2ewUkQO6ADx1WQPaCuGzfQTIBsBuQ7jUeJIy0PACi6R
    WRv0TnFbCiftQmHHxBv8zLV0eYj4xzlIgYSkWfhvhjqjAXTTj+A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932780AbeB1Pwf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34402 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1Pwe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Colin Ian King" <colin.king@canonical.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.979753141@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 020/254] usb: gadget: don't dereference g until after
 it has been null checked
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit b2fc059fa549fe6881d4c1f8d698b0f50bcd16ec upstream.

Avoid dereferencing pointer g until after g has been sanity null checked;
move the assignment of cdev much later when it is required into a more
local scope.

Detected by CoverityScan, CID#1222135 ("Dereference before null check")

Fixes: b785ea7ce662 ("usb: gadget: composite: fix ep->maxburst initialization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/composite.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -103,7 +103,6 @@ int config_ep_by_speed(struct usb_gadget
 			struct usb_function *f,
 			struct usb_ep *_ep)
 {
-	struct usb_composite_dev	*cdev = get_gadget_data(g);
 	struct usb_endpoint_descriptor *chosen_desc = NULL;
 	struct usb_descriptor_header **speed_desc = NULL;
 
@@ -175,8 +174,12 @@ ep_found:
 			_ep->maxburst = comp_desc->bMaxBurst + 1;
 			break;
 		default:
-			if (comp_desc->bMaxBurst != 0)
+			if (comp_desc->bMaxBurst != 0) {
+				struct usb_composite_dev *cdev;
+
+				cdev = get_gadget_data(g);
 				ERROR(cdev, "ep0 bMaxBurst must be 0\n");
+			}
 			_ep->maxburst = 1;
 			break;
 		}
