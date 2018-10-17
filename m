Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F587ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8D221476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFUNhOKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8D221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeJRCYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:24:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35887 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRCYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:24:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so12941505pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nTQRd5ucsrdGmOHMMgLwwde7mUOK7l8LFNWnracXA0=;
        b=mFUNhOKdKh6nX92un91/h56/D8m4gYXpdT9pWNINUxK0P8A4TQVRAy1KGRuHCwgFRQ
         x2sQ26xm29oZgLNY4DVuEjyTdk7ZRJyVh5Q98G5I3k2cymedWKiTDokd3ymffcNGwF8T
         1FJuck3ue45Yz75d1NCjyZZCk2U7Xwq3e1n1xI6AWl/VQOvUf6lwi1ZZQ0C3UaskZF5k
         oqyExsC311m4XaaDIdgt+x0Pp5nWJ7u2eKMtF2EvYJ7MBP0W5EVZqeu3duB0L8DWl076
         aIs4pVc93YR/qDPzo7cT19Oz0oMgmBTwSzYm7ll605o2yX2d2xfuenBmmec1LD/lJnQi
         9d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nTQRd5ucsrdGmOHMMgLwwde7mUOK7l8LFNWnracXA0=;
        b=AQu2qjh2fE1XNHIZ4Crg4orC1cDqtGxUm+uD/Bad0faYiCy4tzKTo3WPrHkcYEGzOk
         VMpTuK6hc2nvn1haarcvdvMNzGJr0ojra3ZnHTaGOGdCdmFC8CJ92udp1cPA+q0jkQwH
         QiXb1zGGRZ4a7zv5AcHAVBVTCrcYgY71cqNtXJr0Aoq88fCdO5yH0XNh6ke/yxcHywpe
         h4Qh6c0zXfC043cDHZDjqIKiMtLD4S/nz5Qz91Yz9MuSSkWII3oe9hSqW5YA8ffCS7bb
         4Xhwgqc/9P2+/uIwq33hHyJZt3/Svtg1aKnUL6PxCEW6N5reaFrYY727zOzIfHZZRG2p
         Qi9g==
X-Gm-Message-State: ABuFfogU+EbAJpB42pmJE4X6Wax2W73PFIfQnh2pqfPLDFmsn5tCR2zL
        po2ND0hz7Ne54jRmiantFApG9AkdeiU=
X-Google-Smtp-Source: ACcGV61ZKdJnRGgZP5pOgU4AJOr9QZextC25ODLKGQmifal2ChCHxF1q08M7OGwdzDsdBVx4cjXuwg==
X-Received: by 2002:a63:2f42:: with SMTP id v63-v6mr11281949pgv.202.1539800855652;
        Wed, 17 Oct 2018 11:27:35 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i188-v6sm19302024pfc.127.2018.10.17.11.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 11:27:34 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] tools: Add 'firmware' category and add ihex2fw tool
Date:   Wed, 17 Oct 2018 11:27:18 -0700
Message-Id: <20181017182718.32740-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5620a0d1aacd ("firmware: delete in-kernel firmware") removed
ihex2fw tool together with the rest of the contents of firmware/
folder. Since that tool is quite useful for doing .ihex -> .fw
converstion, restore its original source code to tools/firmware

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 tools/Makefile           |   7 +-
 tools/firmware/Makefile  |  13 ++
 tools/firmware/ihex2fw.c | 281 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+), 3 deletions(-)
 create mode 100644 tools/firmware/Makefile
 create mode 100644 tools/firmware/ihex2fw.c

diff --git a/tools/Makefile b/tools/Makefile
index be02c8b904db..4a2d31c48e03 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -13,6 +13,7 @@ help:
 	@echo '  cgroup                 - cgroup tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
 	@echo '  firewire               - the userspace part of nosy, an IEEE-1394 traffic sniffer'
+	@echo '  firmware               - Firmware tools'
 	@echo '  freefall               - laptop accelerometer program for disk protection'
 	@echo '  gpio                   - GPIO tools'
 	@echo '  hv                     - tools used when in Hyper-V clients'
@@ -59,7 +60,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi: FORCE
+cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi firmware: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -136,7 +137,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean:
+cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -174,6 +175,6 @@ clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
-		gpio_clean objtool_clean leds_clean wmi_clean
+		gpio_clean objtool_clean leds_clean wmi_clean firmware_clean
 
 .PHONY: FORCE
diff --git a/tools/firmware/Makefile b/tools/firmware/Makefile
new file mode 100644
index 000000000000..d329825aa31b
--- /dev/null
+++ b/tools/firmware/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for firmware tools
+
+CFLAGS = -Wall -Wextra -g
+
+all: ihex2fw
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $^
+
+clean:
+	$(RM) ihex2fw
+
+.PHONY: all clean
\ No newline at end of file
diff --git a/tools/firmware/ihex2fw.c b/tools/firmware/ihex2fw.c
new file mode 100644
index 000000000000..b58dd061e978
--- /dev/null
+++ b/tools/firmware/ihex2fw.c
@@ -0,0 +1,281 @@
+/*
+ * Parser/loader for IHEX formatted data.
+ *
+ * Copyright © 2008 David Woodhouse <dwmw2@infradead.org>
+ * Copyright © 2005 Jan Harkes <jaharkes@cs.cmu.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <stdint.h>
+#include <arpa/inet.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+#define _GNU_SOURCE
+#include <getopt.h>
+
+
+struct ihex_binrec {
+	struct ihex_binrec *next; /* not part of the real data structure */
+        uint32_t addr;
+        uint16_t len;
+        uint8_t data[];
+};
+
+/**
+ * nybble/hex are little helpers to parse hexadecimal numbers to a byte value
+ **/
+static uint8_t nybble(const uint8_t n)
+{
+	if      (n >= '0' && n <= '9') return n - '0';
+	else if (n >= 'A' && n <= 'F') return n - ('A' - 10);
+	else if (n >= 'a' && n <= 'f') return n - ('a' - 10);
+	return 0;
+}
+
+static uint8_t hex(const uint8_t *data, uint8_t *crc)
+{
+	uint8_t val = (nybble(data[0]) << 4) | nybble(data[1]);
+	*crc += val;
+	return val;
+}
+
+static int process_ihex(uint8_t *data, ssize_t size);
+static void file_record(struct ihex_binrec *record);
+static int output_records(int outfd);
+
+static int sort_records = 0;
+static int wide_records = 0;
+static int include_jump = 0;
+
+static int usage(void)
+{
+	fprintf(stderr, "ihex2fw: Convert ihex files into binary "
+		"representation for use by Linux kernel\n");
+	fprintf(stderr, "usage: ihex2fw [<options>] <src.HEX> <dst.fw>\n");
+	fprintf(stderr, "       -w: wide records (16-bit length)\n");
+	fprintf(stderr, "       -s: sort records by address\n");
+	fprintf(stderr, "       -j: include records for CS:IP/EIP address\n");
+	return 1;
+}
+
+int main(int argc, char **argv)
+{
+	int infd, outfd;
+	struct stat st;
+	uint8_t *data;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "wsj")) != -1) {
+		switch (opt) {
+		case 'w':
+			wide_records = 1;
+			break;
+		case 's':
+			sort_records = 1;
+			break;
+		case 'j':
+			include_jump = 1;
+			break;
+		default:
+			return usage();
+		}
+	}
+
+	if (optind + 2 != argc)
+		return usage();
+
+	if (!strcmp(argv[optind], "-"))
+		infd = 0;
+	else
+		infd = open(argv[optind], O_RDONLY);
+	if (infd == -1) {
+		fprintf(stderr, "Failed to open source file: %s",
+			strerror(errno));
+		return usage();
+	}
+	if (fstat(infd, &st)) {
+		perror("stat");
+		return 1;
+	}
+	data = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, infd, 0);
+	if (data == MAP_FAILED) {
+		perror("mmap");
+		return 1;
+	}
+
+	if (!strcmp(argv[optind+1], "-"))
+		outfd = 1;
+	else
+		outfd = open(argv[optind+1], O_TRUNC|O_CREAT|O_WRONLY, 0644);
+	if (outfd == -1) {
+		fprintf(stderr, "Failed to open destination file: %s",
+			strerror(errno));
+		return usage();
+	}
+	if (process_ihex(data, st.st_size))
+		return 1;
+
+	return output_records(outfd);
+}
+
+static int process_ihex(uint8_t *data, ssize_t size)
+{
+	struct ihex_binrec *record;
+	uint32_t offset = 0;
+	uint32_t data32;
+	uint8_t type, crc = 0, crcbyte = 0;
+	int i, j;
+	int line = 1;
+	int len;
+
+	i = 0;
+next_record:
+	/* search for the start of record character */
+	while (i < size) {
+		if (data[i] == '\n') line++;
+		if (data[i++] == ':') break;
+	}
+
+	/* Minimum record length would be about 10 characters */
+	if (i + 10 > size) {
+		fprintf(stderr, "Can't find valid record at line %d\n", line);
+		return -EINVAL;
+	}
+
+	len = hex(data + i, &crc); i += 2;
+	if (wide_records) {
+		len <<= 8;
+		len += hex(data + i, &crc); i += 2;
+	}
+	record = malloc((sizeof (*record) + len + 3) & ~3);
+	if (!record) {
+		fprintf(stderr, "out of memory for records\n");
+		return -ENOMEM;
+	}
+	memset(record, 0, (sizeof(*record) + len + 3) & ~3);
+	record->len = len;
+
+	/* now check if we have enough data to read everything */
+	if (i + 8 + (record->len * 2) > size) {
+		fprintf(stderr, "Not enough data to read complete record at line %d\n",
+			line);
+		return -EINVAL;
+	}
+
+	record->addr  = hex(data + i, &crc) << 8; i += 2;
+	record->addr |= hex(data + i, &crc); i += 2;
+	type = hex(data + i, &crc); i += 2;
+
+	for (j = 0; j < record->len; j++, i += 2)
+		record->data[j] = hex(data + i, &crc);
+
+	/* check CRC */
+	crcbyte = hex(data + i, &crc); i += 2;
+	if (crc != 0) {
+		fprintf(stderr, "CRC failure at line %d: got 0x%X, expected 0x%X\n",
+			line, crcbyte, (unsigned char)(crcbyte-crc));
+		return -EINVAL;
+	}
+
+	/* Done reading the record */
+	switch (type) {
+	case 0:
+		/* old style EOF record? */
+		if (!record->len)
+			break;
+
+		record->addr += offset;
+		file_record(record);
+		goto next_record;
+
+	case 1: /* End-Of-File Record */
+		if (record->addr || record->len) {
+			fprintf(stderr, "Bad EOF record (type 01) format at line %d",
+				line);
+			return -EINVAL;
+		}
+		break;
+
+	case 2: /* Extended Segment Address Record (HEX86) */
+	case 4: /* Extended Linear Address Record (HEX386) */
+		if (record->addr || record->len != 2) {
+			fprintf(stderr, "Bad HEX86/HEX386 record (type %02X) at line %d\n",
+				type, line);
+			return -EINVAL;
+		}
+
+		/* We shouldn't really be using the offset for HEX86 because
+		 * the wraparound case is specified quite differently. */
+		offset = record->data[0] << 8 | record->data[1];
+		offset <<= (type == 2 ? 4 : 16);
+		goto next_record;
+
+	case 3: /* Start Segment Address Record */
+	case 5: /* Start Linear Address Record */
+		if (record->addr || record->len != 4) {
+			fprintf(stderr, "Bad Start Address record (type %02X) at line %d\n",
+				type, line);
+			return -EINVAL;
+		}
+
+		memcpy(&data32, &record->data[0], sizeof(data32));
+		data32 = htonl(data32);
+		memcpy(&record->data[0], &data32, sizeof(data32));
+
+		/* These records contain the CS/IP or EIP where execution
+		 * starts. If requested output this as a record. */
+		if (include_jump)
+			file_record(record);
+		goto next_record;
+
+	default:
+		fprintf(stderr, "Unknown record (type %02X)\n", type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct ihex_binrec *records;
+
+static void file_record(struct ihex_binrec *record)
+{
+	struct ihex_binrec **p = &records;
+
+	while ((*p) && (!sort_records || (*p)->addr < record->addr))
+		p = &((*p)->next);
+
+	record->next = *p;
+	*p = record;
+}
+
+static int output_records(int outfd)
+{
+	unsigned char zeroes[6] = {0, 0, 0, 0, 0, 0};
+	struct ihex_binrec *p = records;
+
+	while (p) {
+		uint16_t writelen = (p->len + 9) & ~3;
+
+		p->addr = htonl(p->addr);
+		p->len = htons(p->len);
+		if (write(outfd, &p->addr, writelen) != writelen)
+			return 1;
+		p = p->next;
+	}
+	/* EOF record is zero length, since we don't bother to represent
+	   the type field in the binary version */
+	if (write(outfd, zeroes, 6) != 6)
+		return 1;
+	return 0;
+}
-- 
2.17.1

