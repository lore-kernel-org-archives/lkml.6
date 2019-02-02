Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244FDC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0A620855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfBBSJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 13:09:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:54482 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfBBSJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 13:09:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2019 10:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,553,1539673200"; 
   d="gz'50?scan'50,208,50";a="315816424"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Feb 2019 10:09:56 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gpzjn-0002FA-TK; Sun, 03 Feb 2019 02:09:55 +0800
Date:   Sun, 3 Feb 2019 02:09:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kbuild-all@01.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] swiotlb: Return error from swiotlb_init_with_tbl()
Message-ID: <201902030208.AANz29ca%fengguang.wu@intel.com>
References: <20190131162424.10477-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20190131162424.10477-1-joro@8bytes.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joerg,

I love your patch! Perhaps something to improve:

[auto build test WARNING on swiotlb/linux-next]
[also build test WARNING on v5.0-rc4]
[cannot apply to next-20190201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joerg-Roedel/swiotlb-Return-error-from-swiotlb_init_with_tbl/20190203-013129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git linux-next
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=riscv 

All warnings (new ones prefixed by >>):

   kernel/dma/swiotlb.c: In function 'swiotlb_init_with_tbl':
>> kernel/dma/swiotlb.c:230:17: warning: passing argument 1 of 'memblock_free' makes integer from pointer without a cast [-Wint-conversion]
      memblock_free(io_tlb_list,
                    ^~~~~~~~~~~
   In file included from kernel/dma/swiotlb.c:42:
   include/linux/memblock.h:123:31: note: expected 'phys_addr_t' {aka 'long long unsigned int'} but argument is of type 'unsigned int *'
    int memblock_free(phys_addr_t base, phys_addr_t size);
                      ~~~~~~~~~~~~^~~~
   kernel/dma/swiotlb.c:234:17: warning: passing argument 1 of 'memblock_free' makes integer from pointer without a cast [-Wint-conversion]
      memblock_free(io_tlb_orig_addr,
                    ^~~~~~~~~~~~~~~~
   In file included from kernel/dma/swiotlb.c:42:
   include/linux/memblock.h:123:31: note: expected 'phys_addr_t' {aka 'long long unsigned int'} but argument is of type 'phys_addr_t *' {aka 'long long unsigned int *'}
    int memblock_free(phys_addr_t base, phys_addr_t size);
                      ~~~~~~~~~~~~^~~~

vim +/memblock_free +230 kernel/dma/swiotlb.c

   190	
   191	int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
   192	{
   193		unsigned long i, bytes;
   194	
   195		bytes = nslabs << IO_TLB_SHIFT;
   196	
   197		io_tlb_nslabs = nslabs;
   198		io_tlb_start = __pa(tlb);
   199		io_tlb_end = io_tlb_start + bytes;
   200	
   201		/*
   202		 * Allocate and initialize the free list array.  This array is used
   203		 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
   204		 * between io_tlb_start and io_tlb_end.
   205		 */
   206		io_tlb_list = memblock_alloc_nopanic(
   207					PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
   208					PAGE_SIZE);
   209		io_tlb_orig_addr = memblock_alloc_nopanic(
   210					PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
   211					PAGE_SIZE);
   212		if (io_tlb_list == NULL || io_tlb_orig_addr == NULL)
   213			goto out_fail;
   214	
   215		for (i = 0; i < io_tlb_nslabs; i++) {
   216			io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
   217			io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
   218		}
   219		io_tlb_index = 0;
   220	
   221		if (verbose)
   222			swiotlb_print_info();
   223	
   224		swiotlb_set_max_segment(io_tlb_nslabs << IO_TLB_SHIFT);
   225	
   226		return 0;
   227	
   228	out_fail:
   229		if (io_tlb_list)
 > 230			memblock_free(io_tlb_list,
   231				      PAGE_ALIGN(io_tlb_nslabs * sizeof(int)));
   232	
   233		if (io_tlb_orig_addr)
   234			memblock_free(io_tlb_orig_addr,
   235				      PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
   236	
   237		io_tlb_list      = NULL;
   238		io_tlb_orig_addr = NULL;
   239		io_tlb_end       = 0;
   240		io_tlb_start     = 0;
   241		io_tlb_nslabs    = 0;
   242		max_segment      = 0;
   243	
   244		return -ENOMEM;
   245	}
   246	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RBoJWUc6AAA=

--ZGiS0Q5IWpPtfppv--
