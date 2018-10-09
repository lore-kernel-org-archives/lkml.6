Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ACAECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3BA21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="MOwKMzqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3BA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJJAte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:49:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38695 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbeJJAtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:32 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so3930002ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:content-transfer-encoding;
        bh=VCa5SPCzpimPbRTbr97Ofz4DkAmiTWvAD/fEyiB+m7A=;
        b=MOwKMzqGfYJtmKjxNjBx34yTHLbouxdY01uB+PGmpm+OmRI88yjoMyk0T30iMBQt2/
         F6lZ47N2LNRtmT0fNtsORX8o7Lxar1U0Yomqv67AWRgh0lTVR6Z+FHKMzkierFrODNVf
         SGbaTZV2usuZvTy/wD8+HDeOG8gWC8Ufqpb4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references
         :content-transfer-encoding;
        bh=VCa5SPCzpimPbRTbr97Ofz4DkAmiTWvAD/fEyiB+m7A=;
        b=stHRvrZSyBBPTm4Ehz7+9ciXGbbqPHpZMFkPeGRviyqNiJgDTHWUhJEZfuSjK0XU8y
         MOO6xGQ4K2D8Y34sPCYDIl+xwHpx4HU3qfV1JbuUxMaTpwAO2TxPv9c1+PakVg8a4tZC
         TNr4g8iENH3uihagEuv4A0wMJbStb5utn0/gb3IiBmN7nzdJcTa4jCiiYilG4vegNGou
         TsfAdgxBdLrP7PYuudtEB8xggMmXrUwAoEM9iuRc1ZEdzHHNZOU2qYQ3cZKug1+cYBiN
         iR4lBEOGJYYyEHkbJgLKLh51OQUfzWkuqQqZXg0hjHjTs3wxAaoAAlftNbLKLHBL0KCJ
         TI8A==
X-Gm-Message-State: ABuFfogjiBoumMbhao/2zDgOabyXcxkCqNLULazVrGTfCERc9qn5/4LI
        eCmLRtO9gwGHCRTMrcM6BBTXjp4iTeEt5ZzXCEANx8ANcpf+LUZx/W2E/5H8z4R6vX3eIH0CMJs
        TlG/AsBnSCVXvF2bV
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV63BaILlseUNJBMQ4mnqc1bFNOL9DsF+qsjFoSy9YKefw2VK/7NuGRl6HKhED5F00LhTLdKe6Q==
X-Received: by 2002:a05:660c:487:: with SMTP id a7mr2527459itk.90.1539106289768;
        Tue, 09 Oct 2018 10:31:29 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:28 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mmc-utils: discrete commands for enhanced and extended attribute setting
Date:   Tue,  9 Oct 2018 13:31:10 -0400
Message-Id: <0d4f799fa7347b6733a263ef83cbcd8c1bdd2cfe.1539103468.git.jamesnuss@nanometrics.ca>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enhanced and extended attributes must be set on all required partitions
in a single command instead of one command per partition.

Remove the enhanced and extended attribute setting parameters from the
"gp create" and "enh_area set" commands and create new commands:
* "enh_area set_partitions"
* "enh_area set_user_data"
* "gp set_extended"

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.c      |  42 ++++++++++++---
 mmc_cmds.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++-----------=
----
 mmc_cmds.h |   4 +-
 3 files changed, 167 insertions(+), 48 deletions(-)

diff --git a/mmc.c b/mmc.c
index 655546b..f2c714c 100644
--- a/mmc.c
+++ b/mmc.c
@@ -87,14 +87,42 @@ static struct Command commands[] =3D {
 		"Set the eMMC data sector size to 4KB by disabling emulation on\n<device=
>.",
 	  NULL
 	},
-	{ do_create_gp_partition, -6,
-	  "gp create", "<-y|-n|-c> " "<length KiB> " "<partition> " "<enh_attr> "=
 "<ext_attr> " "<device>\n"
-		"Create general purpose partition for the <device>.\nDry-run only unless=
 -y or -c is passed.\nUse -c if more partitioning settings are still to com=
e.\nNOTE!  This is a one-time programmable (unreversible) change.\nTo set e=
nhanced attribute to general partition being created set\n <enh_attr> to 1 =
else set it to 0.\nTo set extended attribute to general partition\n set <ex=
t_attr> to 1,2 else set it to 0",
+	{ do_create_gp_partition, 4,
+	  "gp create", "<-y|-n|-c> " "<length KiB> " "<partition> " "<device>\n"
+		"Create general purpose partition for the <device>.\n"
+		"Dry-run only unless -y or -c is passed.\n"
+		"Use -c if more partitioning settings are still to come.\n"
+		"NOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
-	{ do_enh_area_set, -4,
-	  "enh_area set", "<-y|-n|-c> " "<start KiB> " "<length KiB> " "<device>\=
n"
-		"Enable the enhanced user area for the <device>.\nDry-run only unless -y=
 or -c is passed.\nUse -c if more partitioning settings are still to come.\=
nNOTE!  This is a one-time programmable (unreversible) change.",
+	{ do_gp_set_extended, 3,
+	  "gp set_extended", "<-y|-n|-c> " "<partition-mask> " "<device>\n"
+		"Set extended attribute on specified general purpose partitions for the =
<device>.\n"
+		"GP4=3Dbit[15:12], GP3=3Dbit[11:8], GP2=3Dbit[7:4], GP1=3Dbit[3:0]\n"  =
=20
+		"e.g setting <partition-mask> to 0x0120 will set extended attribute 0x02=
 on 'GP2'\n"
+		"  partition and extended attribute 0x01 on 'GP3' partition\n"
+		"Dry-run only unless -y or -c is passed.\n"
+		"Use -c if more partitioning settings are still to come.\n"
+		"NOTE!  This is a one-time programmable (unreversible) change.",
+	  NULL
+	},
+	{ do_enh_area_set_user_data, -4,
+	  "enh_area set_user_data", "<-y|-n|-c> " "<start KiB> " "<length KiB> " =
"<device>\n"
+		"Set the size and offset of the enhanced user data area for the <device>=
.\n"
+		"Dry-run only unless -y or -c is passed.\n"
+		"Use -c if more partitioning settings are still to come.\n"
+		"NOTE!  This is a one-time programmable (unreversible) change.",
+	  NULL
+	},
+	{ do_enh_area_set_partitions, 3,
+	  "enh_area set_partitions", "<-y|-n|-c> " "<partition-mask> " "<device>\=
n"
+		"Enable enhanced attribute on specified partitions for the <device>.\n"
+		"User area=3Dbit[0], GP1=3Dbit[1], GP2=3Dbit[2], GP3=3Dbit[3], GP4=3Dbit=
[4]\n"
+		"e.g setting <partition-mask> to 0x03 will set 'User Area' and 'GP1' par=
titions \n"
+		"    with enhanced attribute, and all others without enhanced attribute.=
\n"
+		"Dry-run only unless -y or -c is passed.\n"
+		"Use -c if more partitioning settings are still to come.\n"
+		"NOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
 	{ do_write_reliability_set_register, -2,
@@ -102,7 +130,7 @@ static struct Command commands[] =3D {
 		"Set the write-reliability register (WR_REL_SET) for the <device>.\n"
 		"User area=3Dbit0, GP1=3Dbit1, GP2=3Dbit2, GP3=3Dbit3, GP4=3Dbit4\n"
 		"e.g setting register to 0x03 will set 'User Area' and 'GP1' partitions =
\n"
-		"with write-reliability, and all others without write-reliability.\n"
+		"    with write-reliability, and all others without write-reliability.\n=
"
 		"NOTE!  This is a one-time programmable (irreversible) change.",
 	  NULL
 	},
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 9565bc9..793b7fa 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -967,6 +967,81 @@ int check_enhanced_area_total_limit(const char * const=
 device, int fd)
 	return 0;
 }
=20
+// TODO: check if enhanced attributes set on GP partitions (only allowed e=
ither enhanced or extended attribute)
+int do_gp_set_extended(int nargs, char **argv)
+{
+	__u8 value;
+	__u8 ext_csd[512];
+	__u8 address;
+	int fd, ret;
+	char *device;
+	int dry_run =3D 1;
+	long partition_mask;
+	char *endptr;
+
+	if (nargs !=3D 4) {
+		fprintf(stderr, "Usage: mmc gp set_extended <-y|-n|-c> <partition-mask> =
</path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	if (!strcmp("-y", argv[1])) {
+		dry_run =3D 0;
+        } else if (!strcmp("-c", argv[1])) {
+		dry_run =3D 2;
+	}
+
+	errno =3D 0;
+	partition_mask =3D strtol(argv[2], &endptr, 0);
+	if (errno !=3D 0 || endptr =3D=3D argv[2] || *endptr !=3D 0 || partition_=
mask < 0 || partition_mask > 0xffff) {
+		fprintf(stderr, "Partition mask invalid: %s\n", argv[2]);
+		exit(1);
+	}
+
+	device =3D argv[3];
+	fd =3D open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret =3D read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+
+	/* assert not PARTITION_SETTING_COMPLETED */
+	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED]) {
+		printf(" Device is already partitioned\n");
+		exit(1);
+	}
+
+	value =3D (__u8)partition_mask;
+	address =3D EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0;
+	ret =3D write_extcsd_value(fd, address, value);
+	fprintf(stderr, "Writing 0x%02x to EXT_CSD[%d]\n", value, address);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %s\n",
+			value, address, device);
+		exit(1);
+	}
+
+	value =3D (__u8)(partition_mask >> 8);
+	address =3D EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_1;
+	ret =3D write_extcsd_value(fd, address, value);
+	fprintf(stderr, "Writing 0x%02x to EXT_CSD[%d]\n", value, address);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %s\n",
+			value, address, device);
+		exit(1);
+	}
+
+	if (set_partitioning_setting_completed(dry_run, device, fd))
+		exit(1);
+
+	return 0;
+}
+
 int do_create_gp_partition(int nargs, char **argv)
 {
 	__u8 value;
@@ -975,12 +1050,12 @@ int do_create_gp_partition(int nargs, char **argv)
 	int fd, ret;
 	char *device;
 	int dry_run =3D 1;
-	int partition, enh_attr, ext_attr;
+	int partition;
 	unsigned int length_kib, gp_size_mult;
 	unsigned long align;
=20
-	if (nargs !=3D 7) {
-		fprintf(stderr, "Usage: mmc gp create <-y|-n|-c> <length KiB> <partition=
> <enh_attr> <ext_attr> </path/to/mmcblkX>\n");
+	if (nargs !=3D 5) {
+		fprintf(stderr, "Usage: mmc gp create <-y|-n|-c> <length KiB> <partition=
> </path/to/mmcblkX>\n");
 		exit(1);
 	}
=20
@@ -992,20 +1067,13 @@ int do_create_gp_partition(int nargs, char **argv)
=20
 	length_kib =3D strtol(argv[2], NULL, 10);
 	partition =3D strtol(argv[3], NULL, 10);
-	enh_attr =3D strtol(argv[4], NULL, 10);
-	ext_attr =3D strtol(argv[5], NULL, 10);
-	device =3D argv[6];
+	device =3D argv[4];
=20
 	if (partition < 1 || partition > 4) {
 		printf("Invalid gp partition number; valid range [1-4].\n");
 		exit(1);
 	}
=20
-	if (enh_attr && ext_attr) {
-		printf("Not allowed to set both enhanced attribute and extended attribut=
e\n");
-		exit(1);
-	}
-
 	fd =3D open(device, O_RDWR);
 	if (fd < 0) {
 		perror("open");
@@ -1060,30 +1128,52 @@ int do_create_gp_partition(int nargs, char **argv)
 		exit(1);
 	}
=20
-	value =3D ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE];
-	if (enh_attr)
-		value |=3D (1 << partition);
-	else
-		value &=3D ~(1 << partition);
+	if (set_partitioning_setting_completed(dry_run, device, fd))
+		exit(1);
=20
-	ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
-	if (ret) {
-		fprintf(stderr, "Could not write EXT_CSD_ENH_%x to EXT_CSD[%d] in %s\n",
-			partition, EXT_CSD_PARTITIONS_ATTRIBUTE, device);
+	return 0;
+}
+
+// TODO: check if extended attributes set on GP partitions (only allowed e=
ither enhanced or extended attribute)
+int do_enh_area_set_partitions(int nargs, char **argv)
+{
+	int fd, ret;
+	char *device;
+	int dry_run =3D 1;
+	long partition_mask;
+	char *endptr;
+
+	if (nargs !=3D 4) {
+		fprintf(stderr, "Usage: mmc enh_area set_partitions <-y|-n|-c> <partitio=
n-mask> </path/to/mmcblkX>\n");
 		exit(1);
 	}
=20
-	address =3D EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0 + (partition - 1) / 2;
-	value =3D ext_csd[address];
-	if (ext_attr)
-		value |=3D (ext_attr << (4 * ((partition - 1) % 2)));
-	else
-		value &=3D (0xF << (4 * ((partition % 2))));
+	if (!strcmp("-y", argv[1])) {
+		dry_run =3D 0;
+	} else if (!strcmp("-c", argv[1])) {
+		dry_run =3D 2;
+	}
=20
-	ret =3D write_extcsd_value(fd, address, value);
+	errno =3D 0;
+	partition_mask =3D strtol(argv[2], &endptr, 0);
+	if (errno !=3D 0 || endptr =3D=3D argv[2] || *endptr !=3D 0 || partition_=
mask < 0 || partition_mask > 0x1f) {
+		fprintf(stderr, "Partition mask invalid: %s\n", argv[2]);
+		exit(1);
+	}
+
+	device =3D argv[3];
+	fd =3D open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, (__u8)partit=
ion_mask);
 	if (ret) {
-		fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %s\n",
-			value, address, device);
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n",
+		       	(__u8)partition_mask,
+			EXT_CSD_PARTITIONS_ATTRIBUTE, device);
 		exit(1);
 	}
=20
@@ -1097,7 +1187,7 @@ int do_create_gp_partition(int nargs, char **argv)
 	return 0;
 }
=20
-int do_enh_area_set(int nargs, char **argv)
+int do_enh_area_set_user_data(int nargs, char **argv)
 {
 	__u8 value;
 	__u8 ext_csd[512];
@@ -1108,7 +1198,7 @@ int do_enh_area_set(int nargs, char **argv)
 	unsigned long align;
=20
 	if (nargs !=3D 5) {
-		fprintf(stderr, "Usage: mmc enh_area set <-y|-n|-c> <start KiB> <length =
KiB> </path/to/mmcblkX>\n");
+		fprintf(stderr, "Usage: mmc enh_area set_user_data <-y|-n|-c> <start KiB=
> <length KiB> </path/to/mmcblkX>\n");
 		exit(1);
 	}
=20
@@ -1148,6 +1238,13 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
=20
+	/* assert enhanced attribute is set on user partition */
+	if (!(ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] & EXT_CSD_ENH_USR))
+	{
+		fprintf(stderr, "error: User partition must be set with enhanced attribu=
te first\n");
+		exit(1);
+	}
+
 	align =3D 512l * get_hc_wp_grp_size(ext_csd) * get_hc_erase_grp_size(ext_=
csd);
=20
 	enh_size_mult =3D (length_kib + align/2l) / align;
@@ -1165,7 +1262,7 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
=20
-	/* write to ENH_START_ADDR and ENH_SIZE_MULT and PARTITIONS_ATTRIBUTE's E=
NH_USR bit */
+	/* write to ENH_START_ADDR and ENH_SIZE_MULT */
 	value =3D (enh_start_addr >> 24) & 0xff;
 	ret =3D write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value);
 	if (ret) {
@@ -1223,14 +1320,6 @@ int do_enh_area_set(int nargs, char **argv)
 			EXT_CSD_ENH_SIZE_MULT_0, device);
 		exit(1);
 	}
-	value =3D ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] | EXT_CSD_ENH_USR;
-	ret =3D write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
-	if (ret) {
-		fprintf(stderr, "Could not write EXT_CSD_ENH_USR to "
-			"EXT_CSD[%d] in %s\n",
-			EXT_CSD_PARTITIONS_ATTRIBUTE, device);
-		exit(1);
-	}
=20
 	ret =3D check_enhanced_area_total_limit(device, fd);
 	if (ret)
diff --git a/mmc_cmds.h b/mmc_cmds.h
index cf6c6fb..a8a90c2 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -33,7 +33,9 @@ int do_hwreset_dis(int nargs, char **argv);
 int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
-int do_enh_area_set(int nargs, char **argv);
+int do_gp_set_extended(int nargs, char **argv);
+int do_enh_area_set_user_data(int nargs, char **argv);
+int do_enh_area_set_partitions(int nargs, char **argv);
 int do_write_reliability_set_register(int nargs, char **argv);
 int do_rpmb_write_key(int nargs, char **argv);
 int do_rpmb_read_counter(int nargs, char **argv);
--=20
2.7.4


--=20
This message is intended exclusively for the individual or entity to which=
=20
it is addressed. This communication may contain information that is=20
proprietary, privileged, confidential or otherwise legally exempt from=20
disclosure. If you are not the named addressee, or have been inadvertently=
=20
and erroneously referenced in the address line, you are not authorized to=
=20
read, print, retain, copy or disseminate this message or any part of it. If=
=20
you have received this message in error, please notify the sender=20
immediately by e-mail and delete all copies of the message.
