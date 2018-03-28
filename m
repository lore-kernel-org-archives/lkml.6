Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3254598-1522271378-2-8370344755285958740
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522271377; b=VA2UA3Q1UxJdxAb5pFfTwIDTtn92QXDhW91uvtVps6KwQ2m
    wKds84B55sPWi6j360vXAMewrgs14YNL3S0oop32kXAAmdodcaJ2otRI4KazFLXa
    iHB5WFLHS8tvW1jbWLyzXRZTgcpfpQ46Qvumw9ZfIax5QI4y8xLjYZu4Y4tqSRET
    lcbCYQz05UooThhI7GJJf7kTUgj98toOgRrjzv9/R9KzOI1WTjwB/NXKiyZHeu7m
    g4Hw6kGTPKLB8QNK2hLkr+T2Ln4Kmp2nhxyl2uLsYlGiTslMnar9EvJIvDzvdDfm
    NO1zeTrLu9BMOVnlJl07LuTY9s78T40RsSyjBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1522271377; bh=96rRo/fDDYHnP1/PSQ662Q6k6l
    T1ZJ1Fmiy/+mEF/Sc=; b=ewDHXNE+BZFx+nvaNYHeEHSNClQla1QDzOveLrU5sG
    8xi6bNYmiT3L8wXePOwEpWCXxmnbESWa/XjBv0SrN6prUuxkw52+Y7AYyHLGPfNN
    UMxeA7AjcZ0IgPtSjrxRKa2LqV7GJETcHD3hlemrc8eCOheyayYmPhjJUsj1HEDY
    AcfXfCl/i6O8zyUbM4dLPzpaNwT2mDe6SlENPRvB1vbKN17j5fsK9stl/ABibvla
    mOt9Jip6+GWVTV0G8/06lEK9dhbg48TS1rYLohWXm7ztq7Gt97fGBo9zZke+MzgV
    pHnc5xhH76eQIBIu6LVejPCkQWORUdtrbAWLZP5d4ojA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvUuZNHevM0iNrltulQT+Mdfs1RLVtx2YmfSyox0pNpBmztNInzMfnyyHENbgZzhkPWf56cWR/G8L4ZnMM2n0uF3Ev6oU5OZUWeqjIAorODkzBJikCf
    HQ/y63kgs+TsheSuVjob+Rtqn0UhqCEdMWVRY6im4jVFBwX7wVgQLSYTahs9gfWFEcg5NSxbFo/06DaLDqjF27FSX3avc73y/xaH+5ajnc14fdViqTNfRChs
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=_pk2tWmQS3vvo9kbq-wA:9
    a=5ccPfdAk5ExgIYUb:21 a=qd4mkpXpD2Gt4qCy:21 a=QEXdDO2ut3YA:10
    a=HUqATDVKn4QA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeC1VJe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 17:09:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:10394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbeC1VJd (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 17:09:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,373,1517904000";
   d="scan'208";a="215599235"
Subject: [PATCH] acpi, nfit: rework NVDIMM leaf method detection
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Mar 2018 14:00:27 -0700
Message-ID: <152227082782.1504.17033843515446218287.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some BIOSen do not handle 0-byte transfer lengths for the _LSR and _LSW
(label storage read/write) methods. This causes Linux to fallback to the
deprecated _DSM path, or otherwise disable label support.

Introduce acpi_nvdimm_has_method() to detect whether a method is
available rather than calling the method, require _LSI and _LSR to be
paired, and require read support before enabling write support.

Cc: <stable@vger.kernel.org>
Fixes: 4b27db7e26cd ("acpi, nfit: add support for the _LS...")
Suggested-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   41 +++++++++++++++++++++--------------------
 drivers/acpi/nfit/nfit.h |    5 ++---
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 4530d89044db..12fb414fa678 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -196,7 +196,7 @@ static int xlat_nvdimm_status(struct nvdimm *nvdimm, void *buf, unsigned int cmd
 		 * In the _LSI, _LSR, _LSW case the locked status is
 		 * communicated via the read/write commands
 		 */
-		if (nfit_mem->has_lsi)
+		if (nfit_mem->has_lsr)
 			break;
 
 		if (status >> 16 & ND_CONFIG_LOCKED)
@@ -483,7 +483,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 			min_t(u32, 256, in_buf.buffer.length), true);
 
 	/* call the BIOS, prefer the named methods over _DSM if available */
-	if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE && nfit_mem->has_lsi)
+	if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE && nfit_mem->has_lsr)
 		out_obj = acpi_label_info(handle);
 	else if (nvdimm && cmd == ND_CMD_GET_CONFIG_DATA && nfit_mem->has_lsr) {
 		struct nd_cmd_get_config_data_hdr *p = buf;
@@ -1653,12 +1653,23 @@ static void acpi_nvdimm_notify(acpi_handle handle, u32 event, void *data)
 	device_unlock(dev->parent);
 }
 
+static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
+{
+	acpi_handle handle;
+	acpi_status status;
+
+	status = acpi_get_handle(adev->handle, method, &handle);
+
+	if (ACPI_SUCCESS(status))
+		return true;
+	return false;
+}
+
 static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 		struct nfit_mem *nfit_mem, u32 device_handle)
 {
 	struct acpi_device *adev, *adev_dimm;
 	struct device *dev = acpi_desc->dev;
-	union acpi_object *obj;
 	unsigned long dsm_mask;
 	const guid_t *guid;
 	int i;
@@ -1731,25 +1742,15 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 					1ULL << i))
 			set_bit(i, &nfit_mem->dsm_mask);
 
-	obj = acpi_label_info(adev_dimm->handle);
-	if (obj) {
-		ACPI_FREE(obj);
-		nfit_mem->has_lsi = 1;
-		dev_dbg(dev, "%s: has _LSI\n", dev_name(&adev_dimm->dev));
-	}
-
-	obj = acpi_label_read(adev_dimm->handle, 0, 0);
-	if (obj) {
-		ACPI_FREE(obj);
-		nfit_mem->has_lsr = 1;
+	if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
+			&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
 		dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
+		nfit_mem->has_lsr = true;
 	}
 
-	obj = acpi_label_write(adev_dimm->handle, 0, 0, NULL);
-	if (obj) {
-		ACPI_FREE(obj);
-		nfit_mem->has_lsw = 1;
+	if (nfit_mem->has_lsr && acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
 		dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
+		nfit_mem->has_lsw = true;
 	}
 
 	return 0;
@@ -1838,10 +1839,10 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 			cmd_mask |= nfit_mem->dsm_mask & NVDIMM_STANDARD_CMDMASK;
 		}
 
-		if (nfit_mem->has_lsi)
+		if (nfit_mem->has_lsr) {
 			set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
-		if (nfit_mem->has_lsr)
 			set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
+		}
 		if (nfit_mem->has_lsw)
 			set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
 
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 50d36e166d70..ac9c49463731 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -171,9 +171,8 @@ struct nfit_mem {
 	struct resource *flush_wpq;
 	unsigned long dsm_mask;
 	int family;
-	u32 has_lsi:1;
-	u32 has_lsr:1;
-	u32 has_lsw:1;
+	bool has_lsr;
+	bool has_lsw;
 };
 
 struct acpi_nfit_desc {
