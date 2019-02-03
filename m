Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30878C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA662083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3s9of6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfBCQ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:58:13 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43020 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfBCQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:58:13 -0500
Received: by mail-wr1-f54.google.com with SMTP id r2so317168wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 08:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jp6ZavyBFvAnCnEbdryleEVxvCmH8tk2pm1gwzh/HDI=;
        b=f3s9of6GfDUh8YgaiJm0uzlsXePN4xqYsrPPMPGd8F+fl1DKtxjdrscIz152CoRz3y
         IzTIAVnp09ZnARd1zWZgt/PWKQs4XfO6yazHhdSKV2AkIVa02PBuV9Th0TmXJKirxssZ
         3xNPUJGidNRO4TyeKIiWHC7axxVGrmVcop8hZumtclJSJs5zJFirh7OnVyyyTWce0/lz
         yAWjxtYgiCTb7XGhZ/yCwK1ftQbjNZd3u7VM91zDVyByHr/Y1P3otAHrbCuVzT6js33W
         d9ftAIAx6R1FwszC5MDXN8G8Ol70FL8borPxkabLlVO4qetvxVjB2WOQTkI/SjnYHffF
         mSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jp6ZavyBFvAnCnEbdryleEVxvCmH8tk2pm1gwzh/HDI=;
        b=GX0g1Jr0yELW9Y1/yL6W/b4MVpYXdJKLZAOKSbWW5TZB0a3fw0WgTwf2Cv3WURVJtO
         xnEKsKhND6FXxfN62J9/CMsVY0bvcMNDeGCRKlgYcAV0/JoGYtIE0v9qfwrBoU3B9t8w
         ktgGkWKIF2WeeUKhK/HJSBfUpCErvBeWw0l7IZ2lGtya59i2mmofnWQuYX9k54x/gmfs
         /DbC6m/F6Lb4u0cD0vS6Nu/vplk8L9Bem5zAbkIPi7A3kRm9q2lx+w8YOvv8fdWLx2Aa
         v5EbWxE1yQQGQ20w3oLoC2AQmfWJEUl46VsczsEed2L+K0/N+0Zm2ObWpo4eWAdY+WUg
         kSOA==
X-Gm-Message-State: AHQUAuaQdUhyxh0amyRAJ9GFMelyiN/vtP7ywlKVLfbK2AlNzN8ZVWpX
        /g5JEZ7GYBDXrJcF+P5HZw==
X-Google-Smtp-Source: AHgI3IYQYRhdw30B69EsGxO+IW/qu6h97bhzjt94Cbkr+2uX4sXli9YxOOFgs/t7fxmf4/NhCr91Cw==
X-Received: by 2002:adf:fbc7:: with SMTP id d7mr5280150wrs.275.1549213089759;
        Sun, 03 Feb 2019 08:58:09 -0800 (PST)
Received: from avx2 ([46.53.242.39])
        by smtp.gmail.com with ESMTPSA id c9sm2848943wrs.84.2019.02.03.08.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 08:58:09 -0800 (PST)
Date:   Sun, 3 Feb 2019 19:58:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] proc: test /proc/*/maps, smaps, smaps_rollup, statm
Message-ID: <20190203165806.GA14568@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start testing VM related fiels found in per-process files.

Do it by jiting small executable which brings its address space
to precisely known state, then comparing /proc/*/maps, smaps,
smaps_rollup, and statm files to expected values.

Currently only x86_64 is supported.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore    |    1 
 tools/testing/selftests/proc/Makefile      |    1 
 tools/testing/selftests/proc/proc-pid-vm.c |  406 +++++++++++++++++++++++++++++
 3 files changed, 408 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -2,6 +2,7 @@
 /fd-002-posix-eq
 /fd-003-kthread
 /proc-loadavg-001
+/proc-pid-vm
 /proc-self-map-files-001
 /proc-self-map-files-002
 /proc-self-syscall
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -6,6 +6,7 @@ TEST_GEN_PROGS += fd-001-lookup
 TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
+TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -0,0 +1,406 @@
+/*
+ * Copyright (c) 2019 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/*
+ * Fork and exec tiny 1 page executable which precisely controls its VM.
+ * Test /proc/$PID/maps
+ * Test /proc/$PID/smaps
+ * Test /proc/$PID/smaps_rollup
+ * Test /proc/$PID/statm
+ *
+ * FIXME require CONFIG_TMPFS which can be disabled
+ * FIXME test other values from "smaps"
+ * FIXME support other archs
+ */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <linux/kdev_t.h>
+
+static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
+{
+	return syscall(SYS_execveat, dirfd, pathname, argv, envp, flags);
+}
+
+static void make_private_tmp(void)
+{
+	if (unshare(CLONE_NEWNS) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			exit(4);
+		}
+		exit(1);
+	}
+	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
+		exit(1);
+	}
+	if (mount(NULL, "/tmp", "tmpfs", 0, NULL) == -1) {
+		exit(1);
+	}
+}
+
+static pid_t pid = -1;
+static void ate(void)
+{
+	if (pid > 0) {
+		kill(pid, SIGTERM);
+	}
+}
+
+struct elf64_hdr {
+	uint8_t e_ident[16];
+	uint16_t e_type;
+	uint16_t e_machine;
+	uint32_t e_version;
+	uint64_t e_entry;
+	uint64_t e_phoff;
+	uint64_t e_shoff;
+	uint32_t e_flags;
+	uint16_t e_ehsize;
+	uint16_t e_phentsize;
+	uint16_t e_phnum;
+	uint16_t e_shentsize;
+	uint16_t e_shnum;
+	uint16_t e_shstrndx;
+};
+
+struct elf64_phdr {
+	uint32_t p_type;
+	uint32_t p_flags;
+	uint64_t p_offset;
+	uint64_t p_vaddr;
+	uint64_t p_paddr;
+	uint64_t p_filesz;
+	uint64_t p_memsz;
+	uint64_t p_align;
+};
+
+#ifdef __x86_64__
+#define PAGE_SIZE 4096
+#define VADDR (1UL << 32)
+#define MAPS_OFFSET 73
+
+#define syscall	0x0f, 0x05
+#define mov_rdi(x)	\
+	0x48, 0xbf,	\
+	(x)&0xff, ((x)>>8)&0xff, ((x)>>16)&0xff, ((x)>>24)&0xff,	\
+	((x)>>32)&0xff, ((x)>>40)&0xff, ((x)>>48)&0xff, ((x)>>56)&0xff
+
+#define mov_rsi(x)	\
+	0x48, 0xbe,	\
+	(x)&0xff, ((x)>>8)&0xff, ((x)>>16)&0xff, ((x)>>24)&0xff,	\
+	((x)>>32)&0xff, ((x)>>40)&0xff, ((x)>>48)&0xff, ((x)>>56)&0xff
+
+#define mov_eax(x)	\
+	0xb8, (x)&0xff, ((x)>>8)&0xff, ((x)>>16)&0xff, ((x)>>24)&0xff
+
+static const uint8_t payload[] = {
+	/* Casually unmap stack, vDSO and everything else. */
+	/* munmap */
+	mov_rdi(VADDR + 4096),
+	mov_rsi((1ULL << 47) - 4096 - VADDR - 4096),
+	mov_eax(11),
+	syscall,
+
+	/* Ping parent. */
+	/* write(0, &c, 1); */
+	0x31, 0xff,					/* xor edi, edi */
+	0x48, 0x8d, 0x35, 0x00, 0x00, 0x00, 0x00,	/* lea rsi, [rip] */
+	0xba, 0x01, 0x00, 0x00, 0x00,			/* mov edx, 1 */
+	mov_eax(1),
+	syscall,
+
+	/* 1: pause(); */
+	mov_eax(34),
+	syscall,
+
+	0xeb, 0xf7,	/* jmp 1b */
+};
+
+static int make_exe(const uint8_t *payload, size_t len)
+{
+	struct elf64_hdr h;
+	struct elf64_phdr ph;
+
+	struct iovec iov[3] = {
+		{&h, sizeof(struct elf64_hdr)},
+		{&ph, sizeof(struct elf64_phdr)},
+		{(void *)payload, len},
+	};
+	int fd, fd1;
+	char buf[64];
+
+	memset(&h, 0, sizeof(h));
+	h.e_ident[0] = 0x7f;
+	h.e_ident[1] = 'E';
+	h.e_ident[2] = 'L';
+	h.e_ident[3] = 'F';
+	h.e_ident[4] = 2;
+	h.e_ident[5] = 1;
+	h.e_ident[6] = 1;
+	h.e_ident[7] = 0;
+	h.e_type = 2;
+	h.e_machine = 0x3e;
+	h.e_version = 1;
+	h.e_entry = VADDR + sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr);
+	h.e_phoff = sizeof(struct elf64_hdr);
+	h.e_shoff = 0;
+	h.e_flags = 0;
+	h.e_ehsize = sizeof(struct elf64_hdr);
+	h.e_phentsize = sizeof(struct elf64_phdr);
+	h.e_phnum = 1;
+	h.e_shentsize = 0;
+	h.e_shnum = 0;
+	h.e_shstrndx = 0;
+
+	memset(&ph, 0, sizeof(ph));
+	ph.p_type = 1;
+	ph.p_flags = (1<<2)|1;
+	ph.p_offset = 0;
+	ph.p_vaddr = VADDR;
+	ph.p_paddr = 0;
+	ph.p_filesz = sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + sizeof(payload);
+	ph.p_memsz = sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + sizeof(payload);
+	ph.p_align = 4096;
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_EXCL|O_TMPFILE, 0700);
+	if (fd == -1) {
+		return 1;
+	}
+
+	if (writev(fd, iov, 3) != sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + len) {
+		return 1;
+	}
+
+	/* Avoid ETXTBSY on exec. */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd);
+	fd1 = open(buf, O_RDONLY|O_CLOEXEC);
+	close(fd);
+
+	return fd1;
+}
+#endif
+
+#ifdef __x86_64__
+int main(void)
+{
+	int pipefd[2];
+	int exec_fd;
+
+	atexit(ate);
+
+	make_private_tmp();
+
+	/* Reserve fd 0 for 1-byte pipe ping from child. */
+	close(0);
+	if (open("/", O_RDONLY|O_DIRECTORY|O_PATH) != 0) {
+		return 1;
+	}
+
+	exec_fd = make_exe(payload, sizeof(payload));
+
+	if (pipe(pipefd) == -1) {
+		return 1;
+	}
+	if (dup2(pipefd[1], 0) != 0) {
+		return 1;
+	}
+
+	pid = fork();
+	if (pid == -1) {
+		return 1;
+	}
+	if (pid == 0) {
+		sys_execveat(exec_fd, "", NULL, NULL, AT_EMPTY_PATH);
+		return 1;
+	}
+
+	char _;
+	if (read(pipefd[0], &_, 1) != 1) {
+		return 1;
+	}
+
+	struct stat st;
+	if (fstat(exec_fd, &st) == -1) {
+		return 1;
+	}
+
+	/* Generate "head -n1 /proc/$PID/maps" */
+	char buf0[256];
+	memset(buf0, ' ', sizeof(buf0));
+	int len = snprintf(buf0, sizeof(buf0),
+			"%08lx-%08lx r-xp 00000000 %02lx:%02lx %llu",
+			VADDR, VADDR + PAGE_SIZE,
+			MAJOR(st.st_dev), MINOR(st.st_dev),
+			(unsigned long long)st.st_ino);
+	buf0[len] = ' ';
+	snprintf(buf0 + MAPS_OFFSET, sizeof(buf0) - MAPS_OFFSET,
+		 "/tmp/#%llu (deleted)\n", (unsigned long long)st.st_ino);
+
+
+	/* Test /proc/$PID/maps */
+	{
+		char buf[256];
+		ssize_t rv;
+		int fd;
+
+		snprintf(buf, sizeof(buf), "/proc/%u/maps", pid);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1) {
+			return 1;
+		}
+		rv = read(fd, buf, sizeof(buf));
+		assert(rv == strlen(buf0));
+		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
+	}
+
+	/* Test /proc/$PID/smaps */
+	{
+		char buf[1024];
+		ssize_t rv;
+		int fd;
+
+		snprintf(buf, sizeof(buf), "/proc/%u/smaps", pid);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1) {
+			return 1;
+		}
+		rv = read(fd, buf, sizeof(buf));
+		assert(0 <= rv && rv <= sizeof(buf));
+
+		assert(rv >= strlen(buf0));
+		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
+
+#define RSS1 "Rss:                   4 kB\n"
+#define RSS2 "Rss:                   0 kB\n"
+#define PSS1 "Pss:                   4 kB\n"
+#define PSS2 "Pss:                   0 kB\n"
+		assert(memmem(buf, rv, RSS1, strlen(RSS1)) ||
+		       memmem(buf, rv, RSS2, strlen(RSS2)));
+		assert(memmem(buf, rv, PSS1, strlen(PSS1)) ||
+		       memmem(buf, rv, PSS2, strlen(PSS2)));
+
+		static const char *S[] = {
+			"Size:                  4 kB\n",
+			"KernelPageSize:        4 kB\n",
+			"MMUPageSize:           4 kB\n",
+			"Anonymous:             0 kB\n",
+			"AnonHugePages:         0 kB\n",
+			"Shared_Hugetlb:        0 kB\n",
+			"Private_Hugetlb:       0 kB\n",
+			"Locked:                0 kB\n",
+		};
+		int i;
+
+		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
+			assert(memmem(buf, rv, S[i], strlen(S[i])));
+		}
+	}
+
+	/* Test /proc/$PID/smaps_rollup */
+	{
+		char bufr[256];
+		memset(bufr, ' ', sizeof(bufr));
+		len = snprintf(bufr, sizeof(bufr),
+				"%08lx-%08lx ---p 00000000 00:00 0",
+				VADDR, VADDR + PAGE_SIZE);
+		bufr[len] = ' ';
+		snprintf(bufr + MAPS_OFFSET, sizeof(bufr) - MAPS_OFFSET,
+			 "[rollup]\n");
+
+		char buf[1024];
+		ssize_t rv;
+		int fd;
+
+		snprintf(buf, sizeof(buf), "/proc/%u/smaps_rollup", pid);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1) {
+			return 1;
+		}
+		rv = read(fd, buf, sizeof(buf));
+		assert(0 <= rv && rv <= sizeof(buf));
+
+		assert(rv >= strlen(bufr));
+		assert(memcmp(buf, bufr, strlen(bufr)) == 0);
+
+		assert(memmem(buf, rv, RSS1, strlen(RSS1)) ||
+		       memmem(buf, rv, RSS2, strlen(RSS2)));
+		assert(memmem(buf, rv, PSS1, strlen(PSS1)) ||
+		       memmem(buf, rv, PSS2, strlen(PSS2)));
+
+		static const char *S[] = {
+			"Anonymous:             0 kB\n",
+			"AnonHugePages:         0 kB\n",
+			"Shared_Hugetlb:        0 kB\n",
+			"Private_Hugetlb:       0 kB\n",
+			"Locked:                0 kB\n",
+		};
+		int i;
+
+		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
+			assert(memmem(buf, rv, S[i], strlen(S[i])));
+		}
+	}
+
+	/* Test /proc/$PID/statm */
+	{
+		char buf[64];
+		ssize_t rv;
+		int fd;
+
+		snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1) {
+			return 1;
+		}
+		rv = read(fd, buf, sizeof(buf));
+		assert(rv == 7 * 2);
+
+		assert(buf[0] == '1');	/* ->total_vm */
+		assert(buf[1] == ' ');
+		assert(buf[2] == '0' || buf[2] == '1');	/* rss */
+		assert(buf[3] == ' ');
+		assert(buf[4] == '0' || buf[2] == '1');	/* file rss */
+		assert(buf[5] == ' ');
+		assert(buf[6] == '1');	/* ELF executable segments */
+		assert(buf[7] == ' ');
+		assert(buf[8] == '0');
+		assert(buf[9] == ' ');
+		assert(buf[10] == '0');	/* ->data_vm + ->stack_vm */
+		assert(buf[11] == ' ');
+		assert(buf[12] == '0');
+		assert(buf[13] == '\n');
+	}
+
+	return 0;
+}
+#else
+int main(void)
+{
+	return 4;
+}
+#endif
