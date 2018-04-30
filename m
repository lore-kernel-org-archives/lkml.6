Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1878097-1525116955-2-13647130349372286492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116954; b=SJBIRnaTWKgn5IX52SGUMO6Li/whfxKs3ck43aJTV7VmS1HKYM
    H5nq6V45fmL/bnnRrKysdpJ4f7ElbtEcu/Xzy5wdqbHazf/acpjsnICuQ4FYb4Zl
    uP7kxDUUAtmCRKUZ3LRpvDSNwB06gxdKjYSH+vbyjAPz+F3DGF+lqgrBblGq4ec0
    2j+cnUA2u1Lp09feBTdmoOfIiKBL1z78jpG/PoVy1lkLxB7mVGR5/ZpN+/4fepIG
    ftTe9ofI/1zAg3txhCiIZr/EAtzMgGZ0xLJM573LGclNwptd/sRF+ZokRoMT4WxP
    YSfzlbbxjgCYDRqY4/v9MgRp0dCGSKREGDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116954; bh=Py2KYQo0HeD73qIhkmfrTO8S/6rQFE
    kXmiCDitE8WJ4=; b=MEctg4h0HyV4IF9h2jhEbK0oKcBgixmVfayoq5dnuVSN4B
    wrM0yBnwQ4Ev8ah3RTXtZiPOKuxw8fKNUTTrJbcDgz4vuZfIAcFJTBkOE3LJXkRc
    X6XvUO1ZwTN+WL1EjNeI7NlEU5JoZc9bLPWVg7a/CVuyVfaTyKjvayXGIJobUSn8
    egMhJIVqtgOh0nKB0YxR87VPqfBCtCYeZA3IwedytS+Ka6XsosuSdlW80jldKfBt
    KQnde0PfpX4nsu5BtEKGis5Feu6JFe+VzNPNREi7IHFpvQYrOgz5waKcsdpG5j95
    ipmGoWDgFljEIic2qrjNmGeDK9EW7BETWtSdlp/g==
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
X-CM-Envelope: MS4wfKLOaCusWH7lHWQLXkKHSdzXWfyDnp60aorJbTllwHXU8ozB261lq0pr4OLv+ECOovllwAT2xzDHFom1UuKl8kG5kn3qpLpiDL80kCOmyWPmDgJ6OBpW
    Tazi1gj+enwMaDCc375xheeRHAeV6/+iAzHh1O9odx332O/D8bAFA1YeCkYwxTC2Fmvp8u2Iche7cXQvIEecTryeTDJ620TKpRuMpx9nXQGSshgVi/5jOieK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=W7VNxgx98Il3nqEb07kA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756423AbeD3T2p (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756406AbeD3T2o (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07C822DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eloy Coto Pereiro <eloy.coto@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.16 092/113] virt: vbox: Use __get_free_pages instead of kmalloc for DMA32 memory
Date: Mon, 30 Apr 2018 12:25:03 -0700
Message-Id: <20180430184019.089903150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit faf6a2a44164c0fb2c2a82692ab9051917514bce upstream.

It is not possible to get DMA32 zone memory through kmalloc, causing
the vboxguest driver to malfunction due to getting memory above
4G which the PCI device cannot handle.

This commit changes the kmalloc calls where the 4G limit matters to
using __get_free_pages() fixing vboxguest not working on x86_64 guests
with more then 4G RAM.

Cc: stable@vger.kernel.org
Reported-by: Eloy Coto Pereiro <eloy.coto@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virt/vboxguest/vboxguest_linux.c |   19 ++++++++++++++++---
 drivers/virt/vboxguest/vboxguest_utils.c |    5 +++--
 2 files changed, 19 insertions(+), 5 deletions(-)

--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -87,6 +87,7 @@ static long vbg_misc_device_ioctl(struct
 	struct vbg_session *session = filp->private_data;
 	size_t returned_size, size;
 	struct vbg_ioctl_hdr hdr;
+	bool is_vmmdev_req;
 	int ret = 0;
 	void *buf;
 
@@ -106,8 +107,17 @@ static long vbg_misc_device_ioctl(struct
 	if (size > SZ_16M)
 		return -E2BIG;
 
-	/* __GFP_DMA32 because IOCTL_VMMDEV_REQUEST passes this to the host */
-	buf = kmalloc(size, GFP_KERNEL | __GFP_DMA32);
+	/*
+	 * IOCTL_VMMDEV_REQUEST needs the buffer to be below 4G to avoid
+	 * the need for a bounce-buffer and another copy later on.
+	 */
+	is_vmmdev_req = (req & ~IOCSIZE_MASK) == VBG_IOCTL_VMMDEV_REQUEST(0) ||
+			 req == VBG_IOCTL_VMMDEV_REQUEST_BIG;
+
+	if (is_vmmdev_req)
+		buf = vbg_req_alloc(size, VBG_IOCTL_HDR_TYPE_DEFAULT);
+	else
+		buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -132,7 +142,10 @@ static long vbg_misc_device_ioctl(struct
 		ret = -EFAULT;
 
 out:
-	kfree(buf);
+	if (is_vmmdev_req)
+		vbg_req_free(buf, size);
+	else
+		kfree(buf);
 
 	return ret;
 }
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -65,8 +65,9 @@ VBG_LOG(vbg_debug, pr_debug);
 void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type)
 {
 	struct vmmdev_request_header *req;
+	int order = get_order(PAGE_ALIGN(len));
 
-	req = kmalloc(len, GFP_KERNEL | __GFP_DMA32);
+	req = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA32, order);
 	if (!req)
 		return NULL;
 
@@ -87,7 +88,7 @@ void vbg_req_free(void *req, size_t len)
 	if (!req)
 		return;
 
-	kfree(req);
+	free_pages((unsigned long)req, get_order(PAGE_ALIGN(len)));
 }
 
 /* Note this function returns a VBox status code, not a negative errno!! */
