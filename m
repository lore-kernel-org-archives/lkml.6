Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C28C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C15621872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfADJ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:26:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbfADJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:26:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x049QEFJ033617
        for <linux-kernel@vger.kernel.org>; Fri, 4 Jan 2019 04:26:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pt3ygamqj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 04:26:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 4 Jan 2019 09:25:31 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 4 Jan 2019 09:25:27 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x049PQ9D63504452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Jan 2019 09:25:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD5EAE051;
        Fri,  4 Jan 2019 09:25:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11CD9AE055;
        Fri,  4 Jan 2019 09:25:26 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Jan 2019 09:25:26 +0000 (GMT)
Date:   Fri, 4 Jan 2019 10:25:24 +0100
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
 <20190103224118.GA4491@osiris>
 <20190103235248.kxvhhwq4brcdxzps@kafai-mbp>
MIME-Version: 1.0
In-Reply-To: <20190103235248.kxvhhwq4brcdxzps@kafai-mbp>
X-TM-AS-GCONF: 00
x-cbid: 19010409-0016-0000-0000-0000023FCBC3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010409-0017-0000-0000-00003299CFB1
Message-Id: <20190104092524.GC4396@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901040084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 11:52:51PM +0000, Martin Lau wrote:
> On Thu, Jan 03, 2019 at 11:41:18PM +0100, Heiko Carstens wrote:
> > On Thu, Jan 03, 2019 at 07:12:05PM +0000, Martin Lau wrote:
> > > On Thu, Jan 03, 2019 at 12:46:13PM +0100, Heiko Carstens wrote:
> > > > Hello,
> > > > 
> > > > the kernel commit 7337224fc150 ("bpf: Improve the info.func_info and
> > > > info.func_info_rec_size behavior") breaks one of strace's self tests:
> > > > 
> > > > FAIL: bpf-obj_get_info_by_fd-prog-v.gen
...
> I am running against linux-next.  I don't see how root and non-root affect
> thing here.  I guess the test has been running without jit so far?

Yes, it was disabled. Enabling jit and adding your memset fix leads to
what you report with 2) below.

> 1) root or not, if jit is enabled,
>    without the memset() fix in the bpf-obj_get_info_by_fd.c in my last email,
>    they all failed:
>    [root@arch-fb-vm1 tests]# ./bpf-obj_get_info_by_fd-prog-v.gen.test
>    BPF_OBJ_GET_INFO_BY_FD prog 2 failed: Bad address
>    bpf-obj_get_info_by_fd-prog-v.gen.test: skipped test: ../bpf-obj_get_info_by_fd-prog-v exited with code 77
> 
>    Please fix this first.
> 
> 2) After having the memset fix:
>    Root or not, for jited program, if I run
>    ./bpf-obj_get_info_by_fd-prog-v.gen.test, they failed.  If I read the
>    init.sh correclty, it fails because there is a diff between the
>    ./bpf-obj_get_info_by_fd-prog-v stdout and the "strace -o log".  I think
>    "strace -o log" only has the /* bytes 104..151 */ part if some bytes
>    are non-zero?
> 
>    Regardless, the test program "bpf-obj_get_info_by_fd.c" is telling
>    the kernel that the userspace "info" is in size 168 bytes.
>    The kernel then tells as much details as possible about
>    a bpf prog in "info".  I don't see a ABI breakage here.
> 
>    I believe the test just happens to work so far because it has been running
>    without jit?
> 
>    If I run it with jit enabled:
> -bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=168, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=35, tag="\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=0 => 110, jited_prog_insns=NULL, xlated_prog_len=0 => 120, xlated_prog_insns=[], load_time=2476906063975, created_by_uid=0, nr_map_ids=0 => 1, map_ids=[], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0}}}, 16) = 0
> -bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=168, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=35, tag="\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=0 => 110, jited_prog_insns=NULL, xlated_prog_len=0 => 120, xlated_prog_insns=[], load_time=2476906063975, created_by_uid=0, nr_map_ids=2 => 1, map_ids=[36], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0}}}, 16) = 0
> +bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=168, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=35, tag="\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=0 => 110, jited_prog_insns=NULL, xlated_prog_len=0 => 120, xlated_prog_insns=[], load_time=2476906063975, created_by_uid=0, nr_map_ids=0 => 1, map_ids=[], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0, /* bytes 104..167 */ "\x01\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) = 0
> +bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4<anon_inode:bpf-prog>, info_len=168, info={type=BPF_PROG_TYPE_SOCKET_FILTER, id=35, tag="\xda\xbf\x02\x07\xd1\x99\x24\x86", jited_prog_len=0 => 110, jited_prog_insns=NULL, xlated_prog_len=0 => 120, xlated_prog_insns=[], load_time=2476906063975, created_by_uid=0, nr_map_ids=2 => 1, map_ids=[36], name="test_prog", ifindex=0, netns_dev=makedev(0, 0), netns_ino=0, /* bytes 104..167 */ "\x01\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"}}}, 16) = 0
> 
>   The diff comes in as early as byte 104-th which is the nr_jited_ksyms == 1.
> 
>   Please fix the test program.  A protential fix is in bpf-obj_get_info_by_fd.c
>   to printf the non-zero "/* bytes 104..1xx */..." the same way as the
>   "strace -o log" does.

Thanks a lot for looking into this!
Eugene, Dmitry will you take care of fixing this?

