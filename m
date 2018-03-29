Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322486-2-14067649805168471704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322485; b=G+rXKf23b33nsg33e+6rFPIfwzAq6veGRlWGX2dc/wlBQ04G+k
    4pjAFZlA2lFGfUG8zffYygfcXdVIXJhIiC4incFNUC7kef/NzAh357uUcQD3lOmE
    Iv8kFEw48JNOytHPmMKgJJMZwk4htKKrtL1xQdTDL02m9wHIh8xbds0JCSPPV3qe
    rvdxoF8HuN7j9UIPX0z/qe3ZH9VT32n+coe4M/zpC3yCQu1tyQS6FApOUjI/9SMj
    jZi4Lt1HY5Wex4uqJD1M5D3uOLolIjYuUcuvABsp9V3oNuK1mmeomD7yZ/eCJ2o8
    rZvhzWOtU3gnoMvv+kQex6RWdMWTJT2fIDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522322485; bh=
    onxN5iPZW7Lt8ch2U53qU4HRStc7gkcGDk3ruYV5jbs=; b=i9T5utvmVRFuFP/8
    BhEfb9ByuN8/TUG4UKe75WAmRQeDkKq5SBgkbDjp/aBIWiXIqQn51+niaPT+NMoL
    k/mro1klznQCH0Ljjsw3UWaZIjkaR2UYweoyQ13ux8qL9ZN6GRXm5DyK06X5W6eV
    CBhjsT48MHQ1AGsp/jXOcvnxHgu16RrNMrtRMj8SgoSJ0d/Ocdpva74344QWbDwp
    pZQu3Kxze5ga0n5T6fXbuacOaVadep13QPRNe/QAEJqyjL5CNo7mlWxJP7P10qnD
    zWsiBxoC87V9NCIqGCeivjSbCQiNzXGbXo76H8kR4/LdKcVhPXKaxA5UsWXfhven
    SRRg0Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNppocrhJFDqjBQOO6ftPGXAJPEWJl4DC1yppinW1sAYAeHUP3MC0wTVM/P3s3/PHrWVSQxpoQslS/bu7qcjkfJY00QhZdZ7pKDsyXmZZ1nOR+25wnu5
    2CM2dm9DZ8MIb5iJp96VCFFrbKYmIqt6G8uPTgt2YbeHgIAR+Y/WUmcrM94zP+1PHFPYVf3UN3zvU1XHlb1/HpQEjtIOVgQp9cj1vBATykhi0f3VTmoQs63P
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=OdSsmgxJ-UETYCq5LY4A:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeC2LVV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 07:21:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752154AbeC2LVU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 29 Mar 2018 07:21:20 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/3] virt: vbox: Use __get_free_pages instead of kmalloc for DMA32 memory
Date: Thu, 29 Mar 2018 13:21:15 +0200
Message-Id: <20180329112116.26488-2-hdegoede@redhat.com>
In-Reply-To: <20180329112116.26488-1-hdegoede@redhat.com>
References: <20180329112116.26488-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is not possible to get DMA32 zone memory through kmalloc, causing
the vboxguest driver to malfunction due to getting memory above
4G which the PCI device cannot handle.

This commit changes the kmalloc calls where the 4G limit matters to
using __get_free_pages() fixing vboxguest not working on x86_64 guests
with more then 4G RAM.

Cc: stable@vger.kernel.org
Reported-by: Eloy Coto Pereiro <eloy.coto@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 19 ++++++++++++++++---
 drivers/virt/vboxguest/vboxguest_utils.c |  5 +++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 82e280d38cc2..398d22693234 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -87,6 +87,7 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 	struct vbg_session *session = filp->private_data;
 	size_t returned_size, size;
 	struct vbg_ioctl_hdr hdr;
+	bool is_vmmdev_req;
 	int ret = 0;
 	void *buf;
 
@@ -106,8 +107,17 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
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
 
@@ -132,7 +142,10 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 		ret = -EFAULT;
 
 out:
-	kfree(buf);
+	if (is_vmmdev_req)
+		vbg_req_free(buf, size);
+	else
+		kfree(buf);
 
 	return ret;
 }
diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index bad915463359..bf4474214b4d 100644
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
-- 
2.17.0.rc1
