Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405846-2-4589439953610746429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405846; b=QTSg2t36hd+NxHapyuJpUvxxi5Or0G+j+fVx+YnUfC0SYTVHuj
    3SpDf8mGIcB70INkxfhJrdx4SzHwM6ClnveLXtzkYkXHHwaFrVkCSoW7lIJPmc8k
    xPOo81IRiEOYasKed/S0zfWTOQCXxTNekrLigqrldyzlU7SO9dCnMg0ZqYDHO6lW
    jXe3SFs0+Zk0dktVMGdmhiOPCwcRiRdrFHHDPxpHsXX/Gr8LBHkCkCWS4HvuK+op
    pby9D2rKmVj31XaGsS6wnK1kBQEtt9AB9BW+/+H6BVbuRmxTuaidOb4P3jdWNzQP
    BwgRXq1NKzQJquqqP8DHmXdHfSNgPZwBBL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405846; bh=QSGZW9gy2eCoIm/S1kwLfHIEd/7tt3
    WraBC2ACdNlnI=; b=XvJXSZaDcm7nZg6hJJDpvW8qDbJyi3a/EYeyo4f2Y28J0S
    clVFGvsX6ihrP8SWW4MP2arb2p6GkEv4tNSEBgE0ZuV9YQkjc+KPgS9mjULcsZjJ
    pQc+yz6b/S2CsPaXfraEoIv+UMFQnn3b7g0TyCxho8TLcs7fNnuTLL6hOHDiUD8C
    BDLM9Olf34eWSB5JbdJkBvonbvq1glK4cdgkfFlEcu5Kg9Z812ofipUvF2YhbiHN
    eNLkECwkiSkpuakapM01QcAHK8X6Cg3C7cxcXYYEknh8108N76Zm5Jv8xM6QvSqK
    6uoTZt54NEpi0aD5YUb/LnNBoGEx1ulTxgvA/JKw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCYbQF/Uef4r9ivDnYcZhchZV0bG+1pDJgJZLhK8nMQS7MlZDRH8W+hnYkLy0pN2u4NGuzgq17DeuBFvIWnk14gsG8anXhX5W2rHKUjktWspOI7agXkL
    y+Kq6dgKEBv4mqfiGAjbMZ0AW0pu67j2/1F+jznXF9n/NmhVXznZT7BQPlgYwJ5Q4Ccovspuree41YyS8TmsgoiG8+ASdIcndSQSdwm8TOO709WBUBr5iswh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=0eQPppVNLSDi1aVsPeUA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754916AbeDVOEB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:04:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754486AbeDVOD6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:03:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 017/164] usb: gadget: udc: core: update usb_ep_queue() documentation
Date: Sun, 22 Apr 2018 15:51:24 +0200
Message-Id: <20180422135136.094442050@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit eaa358c7790338d83bb6a31258bdc077de120414 upstream.

Mention that ->complete() should never be called from within
usb_ep_queue().

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -249,6 +249,9 @@ EXPORT_SYMBOL_GPL(usb_ep_free_request);
  * arranges to poll once per interval, and the gadget driver usually will
  * have queued some data to transfer at that time.
  *
+ * Note that @req's ->complete() callback must never be called from
+ * within usb_ep_queue() as that can create deadlock situations.
+ *
  * Returns zero, or a negative error code.  Endpoints that are not enabled
  * report errors; errors will also be
  * reported when the usb peripheral is disconnected.
