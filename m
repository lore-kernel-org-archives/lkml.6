Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406074-2-4937658072613441197
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
    1524406073; b=cQfZRagmsCBwSFpTBz45FegrRLyhHKOGBdgI5vTu5SOkJnpdoT
    iuCzg+vg185Za6g5te3tflwo7cuFSGNKfRzIrNtung8BDWsiq5C32+Q3bf4AI8He
    12XhSLhHkqhOeCJJc8MOWP697Ytq+5kPUB7qB4LwGhLb9b8lrviBQjzhhG0JXSwS
    iIph42Ab1c/aUB6u+Xl75QYNsM4Jmtf2X95mIlvCLSRQ2HyUKGwdnETDOHTglcTc
    YLD6YWcPJVDGOE3UMQj9yXd5BANxgYZRrjhQ09vUNroLr0x7mAqP8l2Ixgh8tmAI
    xMH7xvXzcxlhBKwD9Iv+k9Hhs+LBuK3Os1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406073; bh=BLtzvs839yJUBnnVGTm2Mvl7oqWUrQ
    vpu6/dV/IWk0k=; b=CtYnhl6/WCBx1zJelKEfdTHVdIasCge1WiXtWoCD8WbvBz
    p1KEYlMwBjlyJZuHyJG+E5GM8r9wSjp3D7LIGu4kmoCOgyN0MnFcLNseuPPMnzgR
    2Sopmob/Vmnvlh5SSew/r2pJkvfkRwhRhpfrVGH5djG/tETPALlJt3bdQWWCoLuv
    VRIvhKiir53mbZTF9O9V6YBhj3qk5MzA714gtWIGoGN9OAiid8op9sAKvl6Tabg5
    Q/xkFbqvXd5ByXaieFO1R2B/YxzDF80KxP/kUVEAPDsAtWLZfCjWICh37GWed1bS
    wzYaHKlLzf8oriBxQlvSe6oChGyBGrfX7hDW3QOQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfE5NM97ZkfcY94V/b5q4l8TZg1P2dQhn0cK8f66mjDv7+YJhyMSf97wjw/OkD5sN/MajlUqyejAs3kfkVvogsJm9fF+69WoFG58eWxj9iDvk4KK18zXL
    tn7lAc0Cwp6IJ2tMFskzOTv3bZu7h59ShnEMrUrS3loDC75RKinWlz+sSTxroElkmBKuicmqP5rFO+v6qOaRsx/dZkZq+L9FIm80FUOJN56jd+yfIQxT+mTf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=ag1SF4gXAAAA:8
    a=YvqfFwD5_RFpRMaw3JwA:9 a=2m6rng-JJC1-PvOC:21 a=CiGoPWG6XneuAviE:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=dVHiktpip_riXrfdqayU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755845AbeDVOHq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:07:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755840AbeDVOHo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:07:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 098/164] nfit: skip region registration for incomplete control regions
Date: Sun, 22 Apr 2018 15:52:45 +0200
Message-Id: <20180422135139.424378947@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit 0731de476a37c33485af82d64041c9d193208df8 upstream.

Per the ACPI specification the only functional purpose for a DIMM
Control Region to be mapped into the system physical address space, from
an OSPM perspective, is to support block-apertures. However, there are
some BIOSen that publish DIMM Control Region SPA entries for pre-boot
environment consumption.  Undo the kernel policy of generating disabled
'ndblk' regions when this configuration is detected.

Cc: <stable@vger.kernel.org>
Fixes: 1f7df6f88b92 ("libnvdimm, nfit: regions (block-data-window...)")
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2316,7 +2316,7 @@ static int acpi_nfit_init_mapping(struct
 	struct acpi_nfit_system_address *spa = nfit_spa->spa;
 	struct nd_blk_region_desc *ndbr_desc;
 	struct nfit_mem *nfit_mem;
-	int blk_valid = 0, rc;
+	int rc;
 
 	if (!nvdimm) {
 		dev_err(acpi_desc->dev, "spa%d dimm: %#x not found\n",
@@ -2336,15 +2336,14 @@ static int acpi_nfit_init_mapping(struct
 		if (!nfit_mem || !nfit_mem->bdw) {
 			dev_dbg(acpi_desc->dev, "spa%d %s missing bdw\n",
 					spa->range_index, nvdimm_name(nvdimm));
-		} else {
-			mapping->size = nfit_mem->bdw->capacity;
-			mapping->start = nfit_mem->bdw->start_address;
-			ndr_desc->num_lanes = nfit_mem->bdw->windows;
-			blk_valid = 1;
+			break;
 		}
 
+		mapping->size = nfit_mem->bdw->capacity;
+		mapping->start = nfit_mem->bdw->start_address;
+		ndr_desc->num_lanes = nfit_mem->bdw->windows;
 		ndr_desc->mapping = mapping;
-		ndr_desc->num_mappings = blk_valid;
+		ndr_desc->num_mappings = 1;
 		ndbr_desc = to_blk_region_desc(ndr_desc);
 		ndbr_desc->enable = acpi_nfit_blk_region_enable;
 		ndbr_desc->do_io = acpi_desc->blk_do_io;
