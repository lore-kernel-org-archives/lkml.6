Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C381CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A19E213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A19E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ginzinger.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeKZVhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:37:45 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:40140 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbeKZVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:37:45 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Nov 2018 16:37:43 EST
Received: from [31.193.165.228] (port=62140 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Kepplinger@ginzinger.com>)
        id 1gREHz-0005Yd-0f; Mon, 26 Nov 2018 11:38:51 +0100
Received: from martin-laptop.buero.ginzinger.com (10.10.1.120) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Mon, 26 Nov 2018 11:38:50 +0100
X-CTCH-RefID: str=0001.0A0B020B.5BFBCD3B.002E:SCFSTAT16437741,ss=1,re=-4.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Martin Kepplinger <martin.kepplinger@ginzinger.com>
To:     <stable@vger.kernel.org>
CC:     <dedekind1@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubi: fastmap: Check each mapping only once
Date:   Mon, 26 Nov 2018 11:38:42 +0100
Message-ID: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [10.10.1.120]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-ORIGINAL-SUBJECT: [NOSIG][NODISC][PATCH] ubi: fastmap: Check
 each mapping only once
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----1E05C84473C1E90C69B3878BB38A6AB7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------1E05C84473C1E90C69B3878BB38A6AB7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 34653fd8c46e771585fce5975e4243f8fd401914 ]

This commit got merged along with commit 781932375ffc
("ubi: fastmap: Correctly handle interrupted erasures in EBA") upstream but
only the latter has been applied to stable v4.14.54 as commit a23cf10d9abb.
This resulted in a performance regression. Startup on i.MX platforms is
delayed for up to a few seconds depending on the platform.
This fixes ubi fastmap to be of the same performance as it has been before
said fastmap changes.

Fixes: a23cf10d9abb ("ubi: fastmap: Correctly handle interrupted erasures in EBA")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

Richard, although this fixes a major slowdown regression in -stable, do you
consider this "stable" too?

This applies and is tested only for the 4.14 stable tree. It seems to be
equally relevant for 4.9 and 4.4 though.

thanks
                           martin


 drivers/mtd/ubi/build.c   |  1 +
 drivers/mtd/ubi/eba.c     |  4 ++++
 drivers/mtd/ubi/fastmap.c | 20 ++++++++++++++++++++
 drivers/mtd/ubi/ubi.h     | 11 +++++++++++
 drivers/mtd/ubi/vmt.c     |  1 +
 drivers/mtd/ubi/vtbl.c    | 16 +++++++++++++++-
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 18a72da759a0..6445c693d935 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -526,6 +526,7 @@ void ubi_free_internal_volumes(struct ubi_device *ubi)
 	for (i = ubi->vtbl_slots;
 	     i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
 		ubi_eba_replace_table(ubi->volumes[i], NULL);
+		ubi_fastmap_destroy_checkmap(ubi->volumes[i]);
 		kfree(ubi->volumes[i]);
 	}
 }
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index d0884bd9d955..c4d4b8f07630 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -517,6 +517,9 @@ static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnu
 	if (!ubi->fast_attach)
 		return 0;
 
+	if (!vol->checkmap || test_bit(lnum, vol->checkmap))
+		return 0;
+
 	vidb = ubi_alloc_vid_buf(ubi, GFP_NOFS);
 	if (!vidb)
 		return -ENOMEM;
@@ -551,6 +554,7 @@ static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnu
 		goto out_free;
 	}
 
+	set_bit(lnum, vol->checkmap);
 	err = 0;
 
 out_free:
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 5a832bc79b1b..63e8527f7b65 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -1101,6 +1101,26 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	goto out;
 }
 
+int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
+{
+	struct ubi_device *ubi = vol->ubi;
+
+	if (!ubi->fast_attach)
+		return 0;
+
+	vol->checkmap = kcalloc(BITS_TO_LONGS(leb_count), sizeof(unsigned long),
+				GFP_KERNEL);
+	if (!vol->checkmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol)
+{
+	kfree(vol->checkmap);
+}
+
 /**
  * ubi_write_fastmap - writes a fastmap.
  * @ubi: UBI device object
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 5fe62653995e..f5ba97c46160 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -334,6 +334,9 @@ struct ubi_eba_leb_desc {
  * @changing_leb: %1 if the atomic LEB change ioctl command is in progress
  * @direct_writes: %1 if direct writes are enabled for this volume
  *
+ * @checkmap: bitmap to remember which PEB->LEB mappings got checked,
+ *            protected by UBI LEB lock tree.
+ *
  * The @corrupted field indicates that the volume's contents is corrupted.
  * Since UBI protects only static volumes, this field is not relevant to
  * dynamic volumes - it is user's responsibility to assure their data
@@ -377,6 +380,10 @@ struct ubi_volume {
 	unsigned int updating:1;
 	unsigned int changing_leb:1;
 	unsigned int direct_writes:1;
+
+#ifdef CONFIG_MTD_UBI_FASTMAP
+	unsigned long *checkmap;
+#endif
 };
 
 /**
@@ -965,8 +972,12 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi);
 int ubi_update_fastmap(struct ubi_device *ubi);
 int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		     struct ubi_attach_info *scan_ai);
+int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count);
+void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol);
 #else
 static inline int ubi_update_fastmap(struct ubi_device *ubi) { return 0; }
+int static inline ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
+static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
 #endif
 
 /* block.c */
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 3fd8d7ff7a02..0be516780e92 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -139,6 +139,7 @@ static void vol_release(struct device *dev)
 	struct ubi_volume *vol = container_of(dev, struct ubi_volume, dev);
 
 	ubi_eba_replace_table(vol, NULL);
+	ubi_fastmap_destroy_checkmap(vol);
 	kfree(vol);
 }
 
diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index 263743e7b741..94d7a865b135 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -534,7 +534,7 @@ static int init_volumes(struct ubi_device *ubi,
 			const struct ubi_attach_info *ai,
 			const struct ubi_vtbl_record *vtbl)
 {
-	int i, reserved_pebs = 0;
+	int i, err, reserved_pebs = 0;
 	struct ubi_ainf_volume *av;
 	struct ubi_volume *vol;
 
@@ -620,6 +620,16 @@ static int init_volumes(struct ubi_device *ubi,
 			(long long)(vol->used_ebs - 1) * vol->usable_leb_size;
 		vol->used_bytes += av->last_data_size;
 		vol->last_eb_bytes = av->last_data_size;
+
+		/*
+		 * We use ubi->peb_count and not vol->reserved_pebs because
+		 * we want to keep the code simple. Otherwise we'd have to
+		 * resize/check the bitmap upon volume resize too.
+		 * Allocating a few bytes more does not hurt.
+		 */
+		err = ubi_fastmap_init_checkmap(vol, ubi->peb_count);
+		if (err)
+			return err;
 	}
 
 	/* And add the layout volume */
@@ -645,6 +655,9 @@ static int init_volumes(struct ubi_device *ubi,
 	reserved_pebs += vol->reserved_pebs;
 	ubi->vol_count += 1;
 	vol->ubi = ubi;
+	err = ubi_fastmap_init_checkmap(vol, UBI_LAYOUT_VOLUME_EBS);
+	if (err)
+		return err;
 
 	if (reserved_pebs > ubi->avail_pebs) {
 		ubi_err(ubi, "not enough PEBs, required %d, available %d",
@@ -849,6 +862,7 @@ int ubi_read_volume_table(struct ubi_device *ubi, struct ubi_attach_info *ai)
 out_free:
 	vfree(ubi->vtbl);
 	for (i = 0; i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
+		ubi_fastmap_destroy_checkmap(ubi->volumes[i]);
 		kfree(ubi->volumes[i]);
 		ubi->volumes[i] = NULL;
 	}
-- 
2.19.1


------1E05C84473C1E90C69B3878BB38A6AB7
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOHAYJKoZIhvcNAQcCoIIODTCCDgkCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggshMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkq
hkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYh
UPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6
fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1
KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI
03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqc
k39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMB
AAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNV
HQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0
cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
AAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwR
GiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDc
ZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwp
WZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNm
NppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztve
BdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDA
fd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/
cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe
2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxh
csjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggUzMIIEG6AD
AgECAhBNQrEzGzrZ6FVYh1EEYH4+MA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAe
Fw0xODA3MTgwMDAwMDBaFw0yMTA3MTcyMzU5NTlaMDAxLjAsBgkqhkiG9w0BCQEW
H21hcnRpbi5rZXBwbGluZ2VyQGdpbnppbmdlci5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDsMC77L0D+2D8I8X5ubnBhADLgU+HtlwMTFt/WJIhc
kgbvnawYXWrCIpk8F6BJ0R/iFCykPdG7741EmlcHRKOJfhVxjXhwnoGFqnYmurCt
fvZLR3+mT3FWnVv2RAdrXscXH3BpijqqWabdtTbiTvmcl86Zc6mNlVhYZSbDul/E
voIGZotGcGIWrgZxN+8MQJQHKb0KHyWlPVPkrjvEfOJHKKLFsBNSnNMR95Ijg3Sp
h8/8RG490/zRHflGzUlxDSlLyY9YJGzSdDzcFKoYcc4oaaUY5N3uhRna43TLUIQh
6ybt3DKVz1Pw/ikwYJrOsulJrVr3D8KVHdGxq7HYl7jnAgMBAAGjggHfMIIB2zAf
BgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQU/GtSUbHg
14sPDlmo27eQYwtjaS0wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYD
VR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEYGA1UdIAQ/MD0wOwYMKwYBBAGy
MQECAQMFMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQv
Q1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NP
TU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmww
gYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5jb21vZG9j
YS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCoG
A1UdEQQjMCGBH21hcnRpbi5rZXBwbGluZ2VyQGdpbnppbmdlci5jb20wDQYJKoZI
hvcNAQELBQADggEBAGEuG01K1tt5i3gUdQkYem/KpbJUYBZd43QwmoTa0TGXUiYq
b+g/TeGG9QQ1yq+73xOr8fu6oT2608C7EiJc6JmjTs485/OZmTqgYkrLfs71F1kB
3Z59WPf5aoR/pnn5vdfkkoO29V1cKPJR4z+iOG2hOlcK/dXrX8i6mnL5DGIe8l5n
udUPvIbUhbMavrDd6kwhs0oCjylwdKGlFkCpKMn3HPflfDeHuV9Z8Nrpeq/7+Pm0
I/fLPkaYlULASJoJCucMYcedY9rmuro9JhV+NuVXaqLIrQPc1vyKFeRuLHh84M6c
1h1DArdGTykXZUwjXnnHtuOtzjIAzkx2Ns43vEsxggK/MIICuwIBATCBrDCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMT
NENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEE1CsTMbOtnoVViHUQRgfj4wDQYJYIZIAWUDBAIBBQCggeQwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMTI2MTAzODUz
WjAvBgkqhkiG9w0BCQQxIgQgC2DFuUbJ3v0MHdw75CMmpp3t+xLOP8y0PSzC+gWI
c6UweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEA
kr3lEqqszbyIeU8RzYTTUTPBrBDZcQ33NietVGLAGLISPoXOYaBqz6egDPoEtM3L
2ZThiVna0ymFR7bWtL5wKnkPIX/Pod6f/4TPhVHg3SJx0BmKq4bk6yQIMYCvWEU0
ud+0qObYAn5+FICKgvwpR482umhhSq1+RI7D31HY6R3XpdE1+eGoV75m4EYyKet8
OH25FNTuN/mSlATIGJLp83KHOSqMuVwlOakA25tgum2WvSBiF5h9njxPsOdu7dpJ
VCvwuh8ANXAhPFVYEmJPqQCJ1HtSBtlFR3+LvxEqZvDhDhoek4vpecQrOn+6ZfHR
3JM8Kah4Udw6ZgvoW+ixiA==

------1E05C84473C1E90C69B3878BB38A6AB7--

