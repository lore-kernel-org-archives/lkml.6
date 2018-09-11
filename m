Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA91C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E455220833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E455220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeIKKSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:18:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:20080 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeIKKSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:18:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 22:20:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="256153640"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2018 22:20:23 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fzb67-000FOK-8W; Tue, 11 Sep 2018 13:20:23 +0800
Date:   Tue, 11 Sep 2018 13:20:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     kbuild-all@01.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] crypto: caam/qi2 - add DPAA2-CAAM driver
Message-ID: <201809111311.rqCiSh3E%fengguang.wu@intel.com>
References: <20180910171550.5659-8-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910171550.5659-8-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horia,

I love your patch! Perhaps something to improve:

[auto build test WARNING on cryptodev/master]
[also build test WARNING on v4.19-rc3 next-20180910]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Horia-Geant/crypto-caam-add-DPAA2-DPSECI-driver/20180911-055735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:96:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned long long @@    got restricted unsigned long long @@
   drivers/crypto/caam/regs.h:96:1:    expected unsigned long long
   drivers/crypto/caam/regs.h:96:1:    got restricted __le64 [usertype] <noident>
>> drivers/crypto/caam/regs.h:96:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned long long @@    got restricted unsigned long long @@
   drivers/crypto/caam/regs.h:96:1:    expected unsigned long long
   drivers/crypto/caam/regs.h:96:1:    got restricted __be64 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: too many warnings
--
>> drivers/crypto/caam/caamalg_qi2.c:83:6: sparse: symbol 'dpaa2_caam_iova_to_virt' was not declared. Should it be static?
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
   drivers/crypto/caam/regs.h:95:1:    expected unsigned int
   drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
>> drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32
   drivers/crypto/caam/regs.h:92:1: sparse: too many warnings
   drivers/crypto/caam/caamalg_qi2.c:288:13: warning: 'split_key_sh_done' defined but not used [-Wunused-function]
    static void split_key_sh_done(void *cbk_ctx, u32 err)
                ^~~~~~~~~~~~~~~~~

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
