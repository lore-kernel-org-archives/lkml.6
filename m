Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9841A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADFC208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADFC208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeG3K14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:27:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbeG3K1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:27:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6U8nAp7037290
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 04:53:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2khx243qpe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 04:53:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 30 Jul 2018 09:53:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 09:53:52 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6U8rpPj41287796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 08:53:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E9034C044;
        Mon, 30 Jul 2018 11:54:04 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0AA44C046;
        Mon, 30 Jul 2018 11:54:03 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jul 2018 11:54:03 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jakub.kicinski@netronome.com
Cc:     heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3] perf build: Build error in libbpf with EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
Date:   Mon, 30 Jul 2018 10:53:23 +0200
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18073008-0008-0000-0000-00000259CD2D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073008-0009-0000-0000-000021C05B07
Message-Id: <20180730085323.75738-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 531b014e7a2f ("tools: bpf: make use of reallocarray")
causes a compiler error when building the perf tool in the linux-next
tree.  Compile file tools/lib/bpf/libbpf.c on a FEDORA 28
installation with gcc compiler
version: gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
shows this error message:

[root@p23lp27] # make V=1 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
[...]
make -f /home6/tmricht/linux-next/tools/build/Makefile.build
	dir=./util/scripting-engines obj=libperf
libbpf.c: In function ‘bpf_object__elf_collect’:
libbpf.c:811:15: error: ignoring return value of ‘strerror_r’,
		declared with attribute warn_unused_result [-Werror=unused-result]
     strerror_r(-err, errmsg, sizeof(errmsg));
               ^
cc1: all warnings being treated as errors
mv: cannot stat './.libbpf.o.tmp': No such file or directory
/home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for target 'libbpf.o' failed

Replace all occurrences of strerror() by calls to strerror_r().
To keep the compiler quiet also use the return value from strerror_r()
otherwise a 'variable set but not use' warning which is treated as error
terminates the compile.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 73465caa33ba..e040c6b5fde9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -468,8 +468,10 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	} else {
 		obj->efile.fd = open(obj->path, O_RDONLY);
 		if (obj->efile.fd < 0) {
-			pr_warning("failed to open %s: %s\n", obj->path,
-					strerror(errno));
+			char errmsg[STRERR_BUFSIZE];
+			char *cp = strerror_r(errno, errmsg, sizeof(errmsg));
+
+			pr_warning("failed to open %s: %s\n", obj->path, cp);
 			return -errno;
 		}
 
@@ -808,10 +810,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 						      data->d_size, name, idx);
 			if (err) {
 				char errmsg[STRERR_BUFSIZE];
+				char *cp = strerror_r(-err, errmsg,
+						      sizeof(errmsg));
 
-				strerror_r(-err, errmsg, sizeof(errmsg));
 				pr_warning("failed to alloc program %s (%s): %s",
-					   name, obj->path, errmsg);
+					   name, obj->path, cp);
 			}
 		} else if (sh.sh_type == SHT_REL) {
 			void *reloc = obj->efile.reloc;
@@ -1097,6 +1100,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 	for (i = 0; i < obj->nr_maps; i++) {
 		struct bpf_map *map = &obj->maps[i];
 		struct bpf_map_def *def = &map->def;
+		char *cp, errmsg[STRERR_BUFSIZE];
 		int *pfd = &map->fd;
 
 		if (map->fd >= 0) {
@@ -1124,8 +1128,9 @@ bpf_object__create_maps(struct bpf_object *obj)
 
 		*pfd = bpf_create_map_xattr(&create_attr);
 		if (*pfd < 0 && create_attr.btf_key_type_id) {
+			cp = strerror_r(errno, errmsg, sizeof(errmsg));
 			pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
-				   map->name, strerror(errno), errno);
+				   map->name, cp, errno);
 			create_attr.btf_fd = 0;
 			create_attr.btf_key_type_id = 0;
 			create_attr.btf_value_type_id = 0;
@@ -1138,9 +1143,9 @@ bpf_object__create_maps(struct bpf_object *obj)
 			size_t j;
 
 			err = *pfd;
+			cp = strerror_r(errno, errmsg, sizeof(errmsg));
 			pr_warning("failed to create map (name: '%s'): %s\n",
-				   map->name,
-				   strerror(errno));
+				   map->name, cp);
 			for (j = 0; j < i; j++)
 				zclose(obj->maps[j].fd);
 			return err;
@@ -1292,6 +1297,7 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 	     char *license, u32 kern_version, int *pfd, int prog_ifindex)
 {
 	struct bpf_load_program_attr load_attr;
+	char *cp, errmsg[STRERR_BUFSIZE];
 	char *log_buf;
 	int ret;
 
@@ -1321,7 +1327,8 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 	}
 
 	ret = -LIBBPF_ERRNO__LOAD;
-	pr_warning("load bpf program failed: %s\n", strerror(errno));
+	cp = strerror_r(errno, errmsg, sizeof(errmsg));
+	pr_warning("load bpf program failed: %s\n", cp);
 
 	if (log_buf && log_buf[0] != '\0') {
 		ret = -LIBBPF_ERRNO__VERIFY;
@@ -1620,6 +1627,7 @@ int bpf_object__load(struct bpf_object *obj)
 
 static int check_path(const char *path)
 {
+	char *cp, errmsg[STRERR_BUFSIZE];
 	struct statfs st_fs;
 	char *dname, *dir;
 	int err = 0;
@@ -1633,7 +1641,8 @@ static int check_path(const char *path)
 
 	dir = dirname(dname);
 	if (statfs(dir, &st_fs)) {
-		pr_warning("failed to statfs %s: %s\n", dir, strerror(errno));
+		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("failed to statfs %s: %s\n", dir, cp);
 		err = -errno;
 	}
 	free(dname);
@@ -1649,6 +1658,7 @@ static int check_path(const char *path)
 int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 			      int instance)
 {
+	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
 	err = check_path(path);
@@ -1667,7 +1677,8 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 	}
 
 	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
-		pr_warning("failed to pin program: %s\n", strerror(errno));
+		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("failed to pin program: %s\n", cp);
 		return -errno;
 	}
 	pr_debug("pinned program '%s'\n", path);
@@ -1677,13 +1688,16 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 
 static int make_dir(const char *path)
 {
+	char *cp, errmsg[STRERR_BUFSIZE];
 	int err = 0;
 
 	if (mkdir(path, 0700) && errno != EEXIST)
 		err = -errno;
 
-	if (err)
-		pr_warning("failed to mkdir %s: %s\n", path, strerror(-err));
+	if (err) {
+		cp = strerror_r(-err, errmsg, sizeof(errmsg));
+		pr_warning("failed to mkdir %s: %s\n", path, cp);
+	}
 	return err;
 }
 
@@ -1730,6 +1744,7 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 
 int bpf_map__pin(struct bpf_map *map, const char *path)
 {
+	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
 	err = check_path(path);
@@ -1742,7 +1757,8 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 	}
 
 	if (bpf_obj_pin(map->fd, path)) {
-		pr_warning("failed to pin map: %s\n", strerror(errno));
+		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("failed to pin map: %s\n", cp);
 		return -errno;
 	}
 
-- 
2.16.4

