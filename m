Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F14F20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F14F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJ3Usi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:48:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726886AbeJ3Usi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:48:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UBsN4v005291
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:55:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nemq4x26x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:55:26 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 30 Oct 2018 11:55:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Oct 2018 11:55:14 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9UBtD3D54788334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 11:55:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4CADA4053;
        Tue, 30 Oct 2018 11:55:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61D62A4059;
        Tue, 30 Oct 2018 11:55:10 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.185])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Oct 2018 11:55:10 +0000 (GMT)
Date:   Tue, 30 Oct 2018 13:55:08 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [mm] 68c37ccedc:
 BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code
References: <20181029131501.GP24195@shao2-debian>
 <20181029154711.df59cb8d6150a55f5cfef67d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029154711.df59cb8d6150a55f5cfef67d@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18103011-0020-0000-0000-000002DCCEF9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103011-0021-0000-0000-0000212C1C10
Message-Id: <20181030115507.GA29437@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 03:47:11PM -0700, Andrew Morton wrote:
> On Mon, 29 Oct 2018 21:15:01 +0800 kernel test robot <rong.a.chen@intel.com> wrote:
> 
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 68c37ccedcde10514898f4ba3b28c0de85c590d1 ("mm: nobootmem: remove bootmem allocation APIs")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 2G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> >
> > +-----------------------------------------------------------------------------+------------+------------+
> > |                                                                             | 6881a1e729 | 68c37ccedc |
> > +-----------------------------------------------------------------------------+------------+------------+
> > | boot_successes                                                              | 4          | 0          |
> > | boot_failures                                                               | 0          | 4          |
> > | BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code | 0          | 4          |
> > +-----------------------------------------------------------------------------+------------+------------+
> 
> Well that's irritating.
> 
> Does the problem remain when the entire patch series is applied?

There is no more commit 68c37ccedcde in linux-next, so I've tried to
reproduce with next-20181029 and the attached .config. I've also checked
commit "mm: nobootmem: remove bootmem allocation APIs" in the yesterday's
linux-next.

Both are booting just fine on my machine. 

I've built the kernel with gcc 5.4.0 (Ubuntu) and gcc 7.3.0 (Debian).

 
> mm-remove-config_no_bootmem.patch
> mm-remove-config_no_bootmem-fix.patch
> mm-remove-config_have_memblock.patch
> mm-remove-config_have_memblock-fix.patch
> mm-remove-config_have_memblock-fix-2.patch
> mm-remove-config_have_memblock-fix-3.patch
> mm-remove-bootmem-allocator-implementation.patch
> mm-nobootmem-remove-dead-code.patch
> memblock-rename-memblock_alloc_nid_try_nid-to-memblock_phys_alloc.patch
> memblock-remove-_virt-from-apis-returning-virtual-address.patch
> memblock-replace-alloc_bootmem_align-with-memblock_alloc.patch
> memblock-replace-alloc_bootmem_low-with-memblock_alloc_low.patch
> memblock-replace-__alloc_bootmem_node_nopanic-with-memblock_alloc_try_nid_nopanic.patch
> memblock-replace-alloc_bootmem_pages_nopanic-with-memblock_alloc_nopanic.patch
> memblock-replace-alloc_bootmem_low-with-memblock_alloc_low-2.patch
> memblock-replace-__alloc_bootmem_nopanic-with-memblock_alloc_from_nopanic.patch
> memblock-add-align-parameter-to-memblock_alloc_node.patch
> memblock-replace-alloc_bootmem_pages_node-with-memblock_alloc_node.patch
> memblock-replace-__alloc_bootmem_node-with-appropriate-memblock_-api.patch
> memblock-replace-alloc_bootmem_node-with-memblock_alloc_node.patch
> memblock-replace-alloc_bootmem_low_pages-with-memblock_alloc_low.patch
> memblock-replace-alloc_bootmem_pages-with-memblock_alloc.patch
> memblock-replace-__alloc_bootmem-with-memblock_alloc_from.patch
> memblock-replace-alloc_bootmem-with-memblock_alloc.patch
> mm-nobootmem-remove-bootmem-allocation-apis.patch
> memblock-replace-free_bootmem_node-with-memblock_free.patch
> memblock-replace-free_bootmem_late-with-memblock_free_late.patch
> memblock-rename-free_all_bootmem-to-memblock_free_all.patch
> memblock-rename-__free_pages_bootmem-to-memblock_free_pages.patch
> mm-remove-nobootmem.patch
> memblock-replace-bootmem_alloc_-with-memblock-variants.patch
> mm-remove-include-linux-bootmemh.patch
> mm-remove-include-linux-bootmemh-fix.patch
> mm-remove-include-linux-bootmemh-fix-2.patch
> mm-remove-include-linux-bootmemh-fix-3.patch
> docs-boot-time-mm-remove-bootmem-documentation.patch
> 

-- 
Sincerely yours,
Mike.

