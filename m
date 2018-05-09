Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZr1Avhs9ObASva5uPPfbJxlUTBHOKbQh2iHE2pefo+PLjoydlnYdjdWCqRguaGnVDEEdoS3
ARC-Seal: i=1; a=rsa-sha256; t=1525844154; cv=none;
        d=google.com; s=arc-20160816;
        b=X+vorL+T/URfC6RHuMmc5MlMg3A2Ak2TrPjoABuRG4hc4xE7qoxUDks5Xw/wvmGzhm
         yd3eGSSoKoSQ0sQCcVZjO+Gz9BwzY141fDJOaIVWnODBcNEUzIbmWqYTi9faIiSVFpC4
         NMK5jburwkJKD27vSbU6oIt95MswHfi0U3uMC6uWupe4pal7wO00fv3vBbHbWPRU7yS9
         EIyxVcbRl9X6xTpxyLS3g7rs+KHAGlLunbcV7jQqlQX/rQlq264lXzWaQoR4eeUHph7m
         enM8lzf+YgxIn1RmpDdY8iejr4MMwIKyTKJ3xalVMfRFRfVTEBWKx4e5FutoNd5lcKgM
         k0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=Bm7y3+5fSB9O4GJfCPDTDYWXNrlrL/GCr79GrFX39b0=;
        b=In1avp7n+s/D5gQmA1wbDt/D+nYjKoHqtdmC79wyh8AoJfl7/g7iB/AdmqxPWk3Ijq
         aGuL6B2cu9oounrEP5HbVNqPMFuAj25wgBLAP0ENyFKK+pLuEAUw7LqAlG0A84tmKKRz
         ZnUrJwrX4R8fdC6cku3Eh55fb9RQaKSD+9J24qVfG6gcUMZc8CCITFzIaSrQ+CKxF5Gs
         /55H80vIJ9IU5KpRhZIRtJRN47QKI+jxLaBDao2my89ep0TTjm8PToxPSBzriX+5060+
         2KYbaFxDtwq5fAhwt1IQ6cMeBDbwKz36Ac1Jm3QDH38lreoKPJqlC5IJ+KAkPjLGQDlp
         1R4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v4 4/7] ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's action
Date: Wed,  9 May 2018 15:35:03 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509053506.9754-1-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
 <20180509053506.9754-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050905-0012-0000-0000-000005D43E19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050905-0013-0000-0000-000019515276
Message-Id: <20180509053506.9754-5-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090056
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549805591967?=
X-GMAIL-MSGID: =?utf-8?q?1599963559977243940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

The function removes the process element from NPU cache.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/pnv-ocxl.h   | 2 +-
 arch/powerpc/platforms/powernv/ocxl.c | 4 ++--
 drivers/misc/ocxl/link.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index f6945d3bc971..208b5503f4ed 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -28,7 +28,7 @@ extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
 extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
 			void **platform_data);
 extern void pnv_ocxl_spa_release(void *platform_data);
-extern int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle);
+extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle);
 
 extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
 extern void pnv_ocxl_free_xive_irq(u32 irq);
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index fa9b53af3c7b..8c65aacda9c8 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -475,7 +475,7 @@ void pnv_ocxl_spa_release(void *platform_data)
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
 
-int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
+int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 {
 	struct spa_data *data = (struct spa_data *) platform_data;
 	int rc;
@@ -483,7 +483,7 @@ int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
 	rc = opal_npu_spa_clear_cache(data->phb_opal_id, data->bdfn, pe_handle);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe);
+EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe_from_cache);
 
 int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr)
 {
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index f30790582dc0..656e8610eec2 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -599,7 +599,7 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
 	 * On powerpc, the entry needs to be cleared from the context
 	 * cache of the NPU.
 	 */
-	rc = pnv_ocxl_spa_remove_pe(link->platform_data, pe_handle);
+	rc = pnv_ocxl_spa_remove_pe_from_cache(link->platform_data, pe_handle);
 	WARN_ON(rc);
 
 	pe_data = radix_tree_delete(&spa->pe_tree, pe_handle);
-- 
2.14.3
