Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeDBPmn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:42:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751749AbeDBPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:42:42 -0400
Date: Mon, 2 Apr 2018 08:43:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>
Cc: rao.shoaib@oracle.com, kbuild-all@01.org, linux-kernel@vger.kernel.org,
        joe@perches.com, willy@infradead.org, brouer@redhat.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] Move kfree_call_rcu() to slab_common.c
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522647064-27167-2-git-send-email-rao.shoaib@oracle.com>
 <201804021616.HByAT8F9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804021616.HByAT8F9%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040215-0040-0000-0000-0000041075BD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008789; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012083; UDB=6.00515781; IPR=6.00791353;
 MB=3.00020376; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 15:42:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040215-0041-0000-0000-0000081187D4
Message-Id: <20180402154332.GQ3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 05:45:48PM +0800, kbuild test robot wrote:
> Hi Rao,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on rcu/rcu/next]
> [also build test WARNING on v4.16 next-20180329]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

I have no idea what is going on with this one, but the other two are due
to not having Tiny RCU support for new-age kfree_rcu().

							Thanx, Paul

> url:    https://github.com/0day-ci/linux/commits/rao-shoaib-oracle-com/Move-kfree_rcu-out-of-rcu-code-and-use-kfree_bulk/20180402-135939
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    include/linux/init.h:134:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/init.h:135:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/init.h:268:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/init.h:269:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/printk.h:200:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:32:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:34:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:37:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:38:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:40:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:42:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:43:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:45:5: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:46:5: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/mem_encrypt.h:49:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/qspinlock.h:53:32: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/workqueue.h:646:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/workqueue.h:647:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/wait_bit.h:41:13: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/numa.h:34:12: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/numa.h:35:13: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/numa.h:62:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/vmalloc.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/vmalloc.h:173:8: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/vmalloc.h:174:8: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/fixmap.h:174:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/fixmap.h:176:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/fixmap.h:178:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/fixmap.h:180:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/apic.h:254:13: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/apic.h:430:13: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/io_apic.h:184:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/smp.h:113:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/smp.h:125:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/smp.h:126:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/percpu.h:110:33: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/percpu.h:112:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/percpu.h:114:12: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/percpu.h:118:12: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/percpu.h:126:12: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/fs.h:63:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/fs.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/fs.h:65:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/fs.h:66:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/memory_hotplug.h:221:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/mmzone.h:1292:15: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/fs.h:2421:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/fs.h:2422:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/fs.h:3329:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/hrtimer.h:497:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/kmemleak.h:29:33: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/kasan.h:29:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/kasan.h:30:6: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/pgtable.h:28:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/slab.h:135:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/slab.h:758:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/mm.h:1753:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/mm.h:1941:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/mm.h:2083:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/mm.h:2671:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/swiotlb.h:39:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/swiotlb.h:124:13: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/swiotlb.h:9:12: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/swiotlb.h:10:12: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/swiotlb.h:11:13: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/swiotlb.h:12:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/dma-contiguous.h:85:5: sparse: attribute 'indirect_branch': unknown attribute
>    arch/x86/include/asm/vdso.h:44:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/cred.h:167:13: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/nsproxy.h:74:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/io.h:47:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/netdevice.h:302:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/netdevice.h:4056:5: sparse: attribute 'indirect_branch': unknown attribute
>    include/linux/ftrace.h:462:6: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:59:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:95:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:120:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:150:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:191:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:231:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:285:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/bpf.h:315:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/xdp.h:28:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/xdp.h:53:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/xdp.h:155:1: sparse: attribute 'indirect_branch': unknown attribute
>    include/trace/events/xdp.h:190:1: sparse: attribute 'indirect_branch': unknown attribute
>    kernel/bpf/core.c:1546:31: sparse: incorrect type in return expression (different address spaces) @@    expected struct bpf_prog_array [noderef] <asn:4>* @@    got sn:4>* @@
>    kernel/bpf/core.c:1546:31:    expected struct bpf_prog_array [noderef] <asn:4>*
>    kernel/bpf/core.c:1546:31:    got void *
>    kernel/bpf/core.c:1550:17: sparse: incorrect type in return expression (different address spaces) @@    expected struct bpf_prog_array [noderef] <asn:4>* @@    got rray [noderef] <asn:4>* @@
>    kernel/bpf/core.c:1550:17:    expected struct bpf_prog_array [noderef] <asn:4>*
>    kernel/bpf/core.c:1550:17:    got struct bpf_prog_array *<noident>
> >> kernel/bpf/core.c:1558:9: sparse: cast removes address space of expression
>    kernel/bpf/core.c:1621:34: sparse: incorrect type in initializer (different address spaces) @@    expected struct bpf_prog **prog @@    got struct bpf_prog *struct bpf_prog **prog @@
>    kernel/bpf/core.c:1621:34:    expected struct bpf_prog **prog
>    kernel/bpf/core.c:1621:34:    got struct bpf_prog *[noderef] <asn:4>*<noident>
>    kernel/bpf/core.c:1644:31: sparse: incorrect type in assignment (different address spaces) @@    expected struct bpf_prog **existing_prog @@    got struct bpf_prog *struct bpf_prog **existing_prog @@
>    kernel/bpf/core.c:1644:31:    expected struct bpf_prog **existing_prog
>    kernel/bpf/core.c:1644:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>
>    kernel/bpf/core.c:1666:15: sparse: incorrect type in assignment (different address spaces) @@    expected struct bpf_prog_array *array @@    got struct bpf_prog_astruct bpf_prog_array *array @@
>    kernel/bpf/core.c:1666:15:    expected struct bpf_prog_array *array
>    kernel/bpf/core.c:1666:15:    got struct bpf_prog_array [noderef] <asn:4>*
>    kernel/bpf/core.c:1672:31: sparse: incorrect type in assignment (different address spaces) @@    expected struct bpf_prog **[assigned] existing_prog @@    got structstruct bpf_prog **[assigned] existing_prog @@
>    kernel/bpf/core.c:1672:31:    expected struct bpf_prog **[assigned] existing_prog
>    kernel/bpf/core.c:1672:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>
>    include/trace/events/bpf.h:59:1: sparse: Using plain integer as NULL pointer
>    include/trace/events/bpf.h:95:1: sparse: Using plain integer as NULL pointer
>    include/trace/events/bpf.h:120:1: sparse: Using plain integer as NULL pointer
>    include/trace/events/bpf.h:191:1: sparse: Using plain integer as NULL pointer
>    include/trace/events/bpf.h:231:1: sparse: Using plain integer as NULL pointer
>    include/trace/events/bpf.h:285:1: sparse: Using plain integer as NULL pointer
>    include/trace/events/bpf.h:315:1: sparse: too many warnings
> 
> vim +1558 kernel/bpf/core.c
> 
> 324bda9e6c Alexei Starovoitov 2017-10-02  1542  
> 324bda9e6c Alexei Starovoitov 2017-10-02  1543  struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
> 324bda9e6c Alexei Starovoitov 2017-10-02  1544  {
> 324bda9e6c Alexei Starovoitov 2017-10-02  1545  	if (prog_cnt)
> 324bda9e6c Alexei Starovoitov 2017-10-02 @1546  		return kzalloc(sizeof(struct bpf_prog_array) +
> 324bda9e6c Alexei Starovoitov 2017-10-02  1547  			       sizeof(struct bpf_prog *) * (prog_cnt + 1),
> 324bda9e6c Alexei Starovoitov 2017-10-02  1548  			       flags);
> 324bda9e6c Alexei Starovoitov 2017-10-02  1549  
> 324bda9e6c Alexei Starovoitov 2017-10-02  1550  	return &empty_prog_array.hdr;
> 324bda9e6c Alexei Starovoitov 2017-10-02  1551  }
> 324bda9e6c Alexei Starovoitov 2017-10-02  1552  
> 324bda9e6c Alexei Starovoitov 2017-10-02  1553  void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
> 324bda9e6c Alexei Starovoitov 2017-10-02  1554  {
> 324bda9e6c Alexei Starovoitov 2017-10-02  1555  	if (!progs ||
> 324bda9e6c Alexei Starovoitov 2017-10-02  1556  	    progs == (struct bpf_prog_array __rcu *)&empty_prog_array.hdr)
> 324bda9e6c Alexei Starovoitov 2017-10-02  1557  		return;
> 324bda9e6c Alexei Starovoitov 2017-10-02 @1558  	kfree_rcu(progs, rcu);
> 324bda9e6c Alexei Starovoitov 2017-10-02  1559  }
> 324bda9e6c Alexei Starovoitov 2017-10-02  1560  
> 
> :::::: The code at line 1558 was first introduced by commit
> :::::: 324bda9e6c5add86ba2e1066476481c48132aca0 bpf: multi program support for cgroup+bpf
> 
> :::::: TO: Alexei Starovoitov <ast@fb.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
