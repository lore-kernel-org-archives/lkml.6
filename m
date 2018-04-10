Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-814531-1523400639-2-7412926937270818670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400639; b=n028QV5FJQIVlFuvRUOzhKUntfZtwDkVCWxagVr9vT3Q5+CISn
    xDyKO2XATOgVu3qrZsMNdL8Jk5+Ru06hCIDzg/d0eKcHOJg+fdouSLUBuG2qoGsZ
    WTbe3VFP0tNQUslVjtOY1WqS5McridL5laqZaKrr4J/33RMBmNx417c5TPPcSFw7
    VhO3i2XyjJi5qQBoT9SMihJ1zEMOAbf4wynmpimvOVSN1Z8slHYmPmLQ4ZyjgTg9
    t9hjq6iZ5o0tLuwnnF2H7+CgMKposelXE+up08gT9rtNwyRfkb/tFvECjVLzRYZg
    1drSH/tJpk0gTNGaZb9pnrCTe5FYS++Zz6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523400639;
    bh=O/1+VwZvrcMSZ9obwTV+STsd1e6jm5UklGjfMFcEXhQ=; b=qg8kI1FHpypY
    ShTcZfwPE0pW4GV45P4sDT4mWLHGcjwQKccdTD/dG/1mvSe6JU0GMyD4hq1tPGrA
    OGwLJfYSeR8+8Ekvh9iYV5FLTTpbS1JoOpFznEgx+U+T9fVKLUmDUY9mXSCLhDN6
    bffkoDcfP0EA+6fYq+sMk2P0Ar/geCySlmFkzXWXn3wnt5zNpIUhpFZdQGTZl8dG
    v//L5aNBOizCdEH7cVLlMt2fgT/xZJEybnFJ+c8Sa+MUjwpbzWdEVgosGEp66frB
    fo/izfDp8nc3h9ocF6p4dbDVMIwhIrZRmRx1paRS1qizHff2xAJ6j5efjOyYBwcM
    bDnQEeFOmw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPA0JhEoykIfuYvZ3P9LKFwGvJ/r+H+eFo8rToGDqfrdh6C0ILm6yrrWgY8VeBYhM9f9vG1Gw5LMEfFKno5nO249W23f6/H2FsibFWxeO44DzIxUSRPc
    lLaDLVryjDc0odajcdyWnobL4Bx0iaYaoL48MiBtCKBguNxbJBXLCXMzGDRQAaN87wV8Q7dX2noXFjuWLT9yISqC91Kdu0eM1Pnmtb/cCQ9TD8HVKN2dE9sD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=1FL4lf_29kGO0JYtru8A:9
    a=tQDV35Sbf7FbmtH7:21 a=aUgsENKXxGY_7Mnw:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756229AbeDJWtM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:49:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:36187 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbeDJWtL (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 18:49:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="46829025"
Subject: [PATCH 1/5] libnvdimm, dimm: handle EACCES failures from label reads
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 15:39:14 -0700
Message-ID: <152339995442.16061.14476943382736126807.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new support for the standard _LSR and _LSW methods neglected to also
update the nvdimm_init_config_data() and nvdimm_set_config_data() to
return the translated error code from failed commands. This precision is
necessary because the locked status that was previously returned on
ND_CMD_GET_CONFIG_SIZE commands is now returned on
ND_CMD_{GET,SET}_CONFIG_DATA commands.

If the kernel misses this indication it can inadvertently fall back to
label-less mode when it should otherwise avoid all access to locked
regions.

Cc: <stable@vger.kernel.org>
Fixes: 4b27db7e26cd ("acpi, nfit: add support for the _LSI, _LSR, and...")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/dimm_devs.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index e00d45522b80..8d348b22ba45 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -88,9 +88,9 @@ int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
 int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
+	int rc = validate_dimm(ndd), cmd_rc = 0;
 	struct nd_cmd_get_config_data_hdr *cmd;
 	struct nvdimm_bus_descriptor *nd_desc;
-	int rc = validate_dimm(ndd);
 	u32 max_cmd_size, config_size;
 	size_t offset;
 
@@ -124,9 +124,11 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
 		cmd->in_offset = offset;
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
 				ND_CMD_GET_CONFIG_DATA, cmd,
-				cmd->in_length + sizeof(*cmd), NULL);
-		if (rc || cmd->status) {
-			rc = -ENXIO;
+				cmd->in_length + sizeof(*cmd), &cmd_rc);
+		if (rc < 0)
+			break;
+		if (cmd_rc < 0) {
+			rc = cmd_rc;
 			break;
 		}
 		memcpy(ndd->data + offset, cmd->out_buf, cmd->in_length);
@@ -140,9 +142,9 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
 int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 		void *buf, size_t len)
 {
-	int rc = validate_dimm(ndd);
 	size_t max_cmd_size, buf_offset;
 	struct nd_cmd_set_config_hdr *cmd;
+	int rc = validate_dimm(ndd), cmd_rc = 0;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 
@@ -164,7 +166,6 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 	for (buf_offset = 0; len; len -= cmd->in_length,
 			buf_offset += cmd->in_length) {
 		size_t cmd_size;
-		u32 *status;
 
 		cmd->in_offset = offset + buf_offset;
 		cmd->in_length = min(max_cmd_size, len);
@@ -172,12 +173,13 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 
 		/* status is output in the last 4-bytes of the command buffer */
 		cmd_size = sizeof(*cmd) + cmd->in_length + sizeof(u32);
-		status = ((void *) cmd) + cmd_size - sizeof(u32);
 
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-				ND_CMD_SET_CONFIG_DATA, cmd, cmd_size, NULL);
-		if (rc || *status) {
-			rc = rc ? rc : -ENXIO;
+				ND_CMD_SET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
+		if (rc < 0)
+			break;
+		if (cmd_rc < 0) {
+			rc = cmd_rc;
 			break;
 		}
 	}
