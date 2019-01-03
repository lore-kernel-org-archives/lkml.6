Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3063CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DB6208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfACWl2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:41:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728480AbfACWl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:41:27 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x03McbpG092066
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 17:41:26 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pspsu37k9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 17:41:26 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 3 Jan 2019 22:41:23 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Jan 2019 22:41:20 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x03MfJRJ31916200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 22:41:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEEC2A4082;
        Thu,  3 Jan 2019 22:41:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B09CA4095;
        Thu,  3 Jan 2019 22:41:19 +0000 (GMT)
Received: from osiris (unknown [9.145.28.170])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Jan 2019 22:41:19 +0000 (GMT)
Date:   Thu, 3 Jan 2019 23:41:18 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Martin Lau <kafai@fb.com>
Cc:     Eugene Syromyatnikov <evgsyr@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: "bpf: Improve the info.func_info and info.func_info_rec_size
 behavior" breaks strace self tests
References: <20190103114613.GB3957@osiris>
 <20190103191158.yu4cjkb3wd3zvpqk@kafai-mbp>
MIME-Version: 1.0
In-Reply-To: <20190103191158.yu4cjkb3wd3zvpqk@kafai-mbp>
X-TM-AS-GCONF: 00
x-cbid: 19010322-0012-0000-0000-000002E16816
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010322-0013-0000-0000-0000211868C8
Message-Id: <20190103224118.GA4491@osiris>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 07:12:05PM +0000, Martin Lau wrote:
> On Thu, Jan 03, 2019 at 12:46:13PM +0100, Heiko Carstens wrote:
> > Hello,
> > 
> > the kernel commit 7337224fc150 ("bpf: Improve the info.func_info and
> > info.func_info_rec_size behavior") breaks one of strace's self tests:
> > 
> > FAIL: bpf-obj_get_info_by_fd-prog-v.gen
> The strace's bpf-obj_get_info_by_fd-prog-v test did fail.  However,
> I failed to see how 7337224fc150 broke it.  How do you trace down to
> commit 7337224fc150 and can you share your test output?
> 
> The failure I can reproduce is EFAULT.  It should have been failing
> as early as "nr_jited_ksyms" is added to "struct bpf_prog_info"
> in linux/bpf.h.

Ah, sorry(!), I forgot to mention an important detail: the test
failure happens only if executed as normal (non-root) user.

With 7337224fc150 ("bpf: Improve the info.func_info and
info.func_info_rec_size behavior") the failure happens. With commit
30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
it passes; which is one commit earlier.

FAIL: bpf-obj_get_info_by_fd-prog-v.gen
=======================================

--- exp	2019-01-03 23:31:49.576949303 +0100
+++ log	2019-01-03 23:31:49.576949303 +0100
@@ -1,8 +1,8 @@
 bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=0, inner_map_fd=0</dev/null>, map_name="test_map", map_ifindex=0}, 48) = 3<anon_inode:bpf-map>
 bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=9, insns=[{code=BPF_ALU64|BPF_K|BPF_MOV, dst_reg=BPF_REG_1, src_reg=BPF_REG_0, off=0, imm=0}, {code=BPF_STX|BPF_W|BPF_MEM, dst_reg=BPF_REG_10, src_reg=BPF_REG_1, off=-4, imm=0}, {code=BPF_ALU64|BPF_X|BPF_MOV, dst_reg=BPF_REG_2, src_reg=BPF_REG_10, off=0, imm=0}, {code=BPF_ALU64|BPF_K|BPF_ADD, dst_reg=BPF_REG_2, src_reg=BPF_REG_0, off=0, imm=0xfffffffc}, {code=BPF_LD|BPF_DW|BPF_IMM, dst_reg=BPF_REG_1, src_reg=BPF_REG_1, off=0, imm=0x3}, {code=BPF_LD|BPF_W|BPF_IMM, dst_reg=BPF_REG_0, src_reg=BPF_REG_0, off=0, imm=0}, {code=BPF_JMP|BPF_K|BPF_CALL, dst_reg=BPF_REG_0, src_reg=BPF_REG_0, off=0, imm=0x1}, {code=BPF_ALU64|BPF_K|BPF_MOV, dst_reg=BPF_REG_0, src_reg=BPF_REG_0, off=0, imm=0}, {code=BPF_JMP|BPF_K|BPF_EXIT, dst_reg=BPF_REG_0, src_reg=BPF_REG_0, off=0, imm=0}], license="BSD", log_level=42, log_size=4096, log_buf="", kern_version=KERNEL_VERSION(57005, 192, 222), prog_flags=0, prog_name="test_prog", prog_ifindex=0, 
 expected_attach_type=BPF_CGROUP_INET_INGRESS}, 72) = 4<anon_inode:bpf-prog>
 bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=3<anon_inode:bpf-map>, info_len=128 => 80, info={type=BPF_MAP_TYPE_ARRAY, id=15, key_size=4, value_size=8, max_entries=1, map_flags=0, name="test_map", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0}}}, 16) = 0
-bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=168 => 152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=0, xlated_prog_insns=NULL, load_time=28281352029, created_by_uid=1000, nr_map_ids=0 => 1, map_ids=NULL, name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0}}}, 16) = 0
-bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=336, xlated_prog_insns=0x3ff8d6f7000, load_time=28281352029, created_by_uid=1000, nr_map_ids=2, map_ids=0x3ff8d6f1000, name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0}}}, 16) = -1 EFAULT (Bad address)
-bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=0, xlated_prog_insns=[], load_time=28281352029, created_by_uid=1000, nr_map_ids=0 => 1, map_ids=[], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0}}}, 16) = 0
-bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=0, xlated_prog_insns=[], load_time=28281352029, created_by_uid=1000, nr_map_ids=2 => 1, map_ids=[15], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0}}}, 16) = 0
+bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=168 => 152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=0, xlated_prog_insns=NULL, load_time=28281352029, created_by_uid=1000, nr_map_ids=0 => 1, map_ids=NULL, name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0, /* bytes 104..151 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) = 0
+bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=336, xlated_prog_insns=0x3ff8d6f7000, load_time=28281352029, created_by_uid=1000, nr_map_ids=2, map_ids=0x3ff8d6f1000, name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0, /* bytes 104..151 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) = -1 EFAULT (Bad address)
+bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=0, xlated_prog_insns=[], load_time=28281352029, created_by_uid=1000, nr_map_ids=0 => 1, map_ids=[], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0, /* bytes 104..151 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) = 0
+bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=152, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=8, tag="\xde\x90\x83\x18\xfb\x16\xd8\x9c", jited_prog_len=0, jited_prog_insns=NULL, xlated_prog_len=0, xlated_prog_insns=[], load_time=28281352029, created_by_uid=1000, nr_map_ids=2 => 1, map_ids=[15], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0, /* bytes 104..151 */ "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) = 0
 +++ exited with 0 +++
bpf-obj_get_info_by_fd-prog-v.gen.test: failed test: ../../strace -a20 -y -v -e trace=bpf ../bpf-obj_get_info_by_fd-prog-v output mismatch
FAIL bpf-obj_get_info_by_fd-prog-v.gen.test (exit status: 1)

