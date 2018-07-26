Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F06D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F06D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeGZS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:56:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730095AbeGZS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:56:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6QHYcv6132997
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:38:20 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kfg2981pn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 13:38:19 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 26 Jul 2018 18:34:18 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 18:34:14 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6QHYDdo40501260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Jul 2018 17:34:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D802A405B;
        Thu, 26 Jul 2018 20:34:26 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D218A4051;
        Thu, 26 Jul 2018 20:34:23 +0100 (BST)
Received: from [9.77.80.119] (unknown [9.77.80.119])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 20:34:23 +0100 (BST)
Subject: Re: BPF relocation 'perf test' entries failing was: Re: [GIT PULL
 00/27] perf/core improvements and fixes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <20180726131534.GD17940@kernel.org>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Thu, 26 Jul 2018 23:04:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726131534.GD17940@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072617-0028-0000-0000-000002E0AD41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072617-0029-0000-0000-00002398A0C4
Message-Id: <2fbfac01-e103-8daf-6187-b94d1725dbd0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807260181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

I came across the same problem. Does the following patch fix it?
https://lkml.org/lkml/2018/7/26/669

- Sandipan

On Thursday 26 July 2018 06:45 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jul 25, 2018 at 02:59:34PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Hi Ingo,
>>
>> 	Please consider pulling, I'm now investigating why these failed:
>>
>>   38: LLVM search and compile                               :
>>   38.1: Basic BPF llvm compile                              : Ok
>>   38.2: kbuild searching                                    : Ok
>>   38.3: Compile source for BPF prologue generation          : Ok
>>   38.4: Compile source for BPF relocation                   : FAILED!
>>   40: BPF filter                                            :
>>   40.1: Basic BPF filtering                                 : Ok
>>   40.2: BPF pinning                                         : Ok
>>   40.3: BPF prologue generation                             : Ok
>>   40.4: BPF relocation checker                              : FAILED!
>>
>> 	I think these failures are not related to changes in this patch
>> kit. Details about the test environment, versions, etc.
> 
> So, here are more details:
> 
> The relevant bit seems to be:
> 
> libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522
> 
> So this seems to be something that was caught by the kernel verifier and
> now is being caught by libbpf, /me goes to read the tools/lib/bpf
> changelog...
> 
> - Arnaldo
> 
> BPF filter subtest 2: Ok
> 40.3: BPF prologue generation                             :
> --- start ---
> test child forked, pid 13336
> Kernel build dir is set to /lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
> set env: KBUILD_DIR=/lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
> unset env: KBUILD_OPTS
> include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
> set env: NR_CPUS=4
> set env: LINUX_VERSION_CODE=0x41200
> set env: CLANG_EXEC=/usr/lib64/ccache/clang
> set env: CLANG_OPTIONS=-xc 
> set env: KERNEL_INC_OPTIONS= -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
> set env: PERF_BPF_INC_OPTIONS=-I/home/acme/lib/include/perf/bpf
> set env: WORKING_DIR=/lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
> set env: CLANG_SOURCE=-
> llvm compiling command template: echo '/*
>  * bpf-script-test-relocation.c
>  * Test BPF loader checking relocation
>  */
> #ifndef LINUX_VERSION_CODE
> # error Need LINUX_VERSION_CODE
> # error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
> #endif
> #define BPF_ANY 0
> #define BPF_MAP_TYPE_ARRAY 2
> #define BPF_FUNC_map_lookup_elem 1
> #define BPF_FUNC_map_update_elem 2
> 
> static void *(*bpf_map_lookup_elem)(void *map, void *key) =
> 	(void *) BPF_FUNC_map_lookup_elem;
> static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
> 	(void *) BPF_FUNC_map_update_elem;
> 
> struct bpf_map_def {
> 	unsigned int type;
> 	unsigned int key_size;
> 	unsigned int value_size;
> 	unsigned int max_entries;
> };
> 
> #define SEC(NAME) __attribute__((section(NAME), used))
> struct bpf_map_def SEC("maps") my_table = {
> 	.type = BPF_MAP_TYPE_ARRAY,
> 	.key_size = sizeof(int),
> 	.value_size = sizeof(int),
> 	.max_entries = 1,
> };
> 
> int this_is_a_global_val;
> 
> SEC("func=sys_write")
> int bpf_func__sys_write(void *ctx)
> {
> 	int key = 0;
> 	int value = 0;
> 
> 	/*
> 	 * Incorrect relocation. Should not allow this program be
> 	 * loaded into kernel.
> 	 */
> 	bpf_map_update_elem(&this_is_a_global_val, &key, &value, 0);
> 	return 0;
> }
> char _license[] SEC("license") = "GPL";
> int _version SEC("version") = LINUX_VERSION_CODE;
> ' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf -O2 -o -
> llvm compiling command : echo '/*
>  * bpf-script-test-relocation.c
>  * Test BPF loader checking relocation
>  */
> #ifndef LINUX_VERSION_CODE
> # error Need LINUX_VERSION_CODE
> # error Example: for 4.2 kernel, put 'clang-opt=-DLINUX_VERSION_CODE=0x40200 into llvm section of ~/.perfconfig'
> #endif
> #define BPF_ANY 0
> #define BPF_MAP_TYPE_ARRAY 2
> #define BPF_FUNC_map_lookup_elem 1
> #define BPF_FUNC_map_update_elem 2
> 
> static void *(*bpf_map_lookup_elem)(void *map, void *key) =
> 	(void *) BPF_FUNC_map_lookup_elem;
> static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
> 	(void *) BPF_FUNC_map_update_elem;
> 
> struct bpf_map_def {
> 	unsigned int type;
> 	unsigned int key_size;
> 	unsigned int value_size;
> 	unsigned int max_entries;
> };
> 
> #define SEC(NAME) __attribute__((section(NAME), used))
> struct bpf_map_def SEC(maps) my_table = {
> 	.type = BPF_MAP_TYPE_ARRAY,
> 	.key_size = sizeof(int),
> 	.value_size = sizeof(int),
> 	.max_entries = 1,
> };
> 
> int this_is_a_global_val;
> 
> SEC(func=sys_write)
> int bpf_func__sys_write(void *ctx)
> {
> 	int key = 0;
> 	int value = 0;
> 
> 	/*
> 	 * Incorrect relocation. Should not allow this program be
> 	 * loaded into kernel.
> 	 */
> 	bpf_map_update_elem(&this_is_a_global_val, &key, &value, 0);
> 	return 0;
> }
> char _license[] SEC(license) = GPL;
> int _version SEC(version) = LINUX_VERSION_CODE;
> ' | /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=4 -DLINUX_VERSION_CODE=0x41200 -xc   -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h  -I/home/acme/lib/include/perf/bpf -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build -c - -target bpf -O2 -o -
> libbpf: loading object '[bpf_relocation_test]' from buffer
> libbpf: section(1) .strtab, size 115, link 0, flags 0, type=3
> libbpf: skip section(1) .strtab
> libbpf: section(2) .text, size 0, link 0, flags 6, type=1
> libbpf: skip section(2) .text
> libbpf: section(3) func=sys_write, size 104, link 0, flags 6, type=1
> libbpf: found program func=sys_write
> libbpf: section(4) .relfunc=sys_write, size 16, link 8, flags 0, type=9
> libbpf: section(5) maps, size 16, link 0, flags 3, type=1
> libbpf: section(6) license, size 4, link 0, flags 3, type=1
> libbpf: license of [bpf_relocation_test] is GPL
> libbpf: section(7) version, size 4, link 0, flags 3, type=1
> libbpf: kernel version of [bpf_relocation_test] is 41200
> libbpf: section(8) .symtab, size 144, link 1, flags 0, type=2
> libbpf: maps in [bpf_relocation_test]: 1 maps in 16 bytes
> libbpf: map 0 is "my_table"
> libbpf: collecting relocating info for: 'func=sys_write'
> libbpf: relo for 5 value 4 name 21
> libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522
> bpf: failed to load buffer
> Compile BPF program failed.
> test child finished with 0
> ---- end ----
> BPF filter subtest 3: Ok
> 40.4: BPF relocation checker                              :
> --- start ---
> test child forked, pid 13746
> test child finished with -1
> ---- end ----
> BPF filter subtest 4: FAILED!
> [root@seventh ~]#
> 
> 

