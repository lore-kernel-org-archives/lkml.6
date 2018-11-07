Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA797C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6772086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6772086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbeKGL5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:57:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:63564 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbeKGL5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:57:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 18:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="gz'50?scan'50,208,50";a="278938016"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2018 18:29:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gKDaW-0002PE-1G; Wed, 07 Nov 2018 10:29:00 +0800
Date:   Wed, 7 Nov 2018 10:28:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/fddi/defza.h:238:1: warning: "/*" within comment
Message-ID: <201811071008.bBrDLdPP%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8053e5b93eca9b011f7b79bb019bf1eeaaf96c4b
commit: 61414f5ec9834df8aa4f55c90de16b71a3d6ca8d FDDI: defza: Add support for DEC FDDIcontroller 700 TURBOchannel adapter
date:   3 weeks ago
config: mips-decstation_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 61414f5ec9834df8aa4f55c90de16b71a3d6ca8d
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All warnings (new ones prefixed by >>):

   In file included from drivers/net/fddi/defza.c:53:0:
>> drivers/net/fddi/defza.h:238:1: warning: "/*" within comment [-Wcomment]
    /* Command constants. */
     
   drivers/net/fddi/defza.c: In function 'fza_tx_smt':
   drivers/net/fddi/defza.c:787:45: warning: unused variable 'skb_data_ptr' [-Wunused-variable]
     struct fza_buffer_tx __iomem *smt_tx_ptr, *skb_data_ptr;
                                                ^~~~~~~~~~~~

vim +238 drivers/net/fddi/defza.h

   234	
   235	#define FZA_RING_CMD		0x200400	/* command ring address */
   236	#define FZA_RING_CMD_SIZE	0x40		/* command descriptor ring
   237							 * size
 > 238	/* Command constants. */
   239	#define FZA_RING_CMD_MASK	0x7fffffff
   240	#define FZA_RING_CMD_NOP	0x00000000	/* nop */
   241	#define FZA_RING_CMD_INIT	0x00000001	/* initialize */
   242	#define FZA_RING_CMD_MODCAM	0x00000002	/* modify CAM */
   243	#define FZA_RING_CMD_PARAM	0x00000003	/* set system parameters */
   244	#define FZA_RING_CMD_MODPROM	0x00000004	/* modify promiscuous mode */
   245	#define FZA_RING_CMD_SETCHAR	0x00000005	/* set link characteristics */
   246	#define FZA_RING_CMD_RDCNTR	0x00000006	/* read counters */
   247	#define FZA_RING_CMD_STATUS	0x00000007	/* get link status */
   248	#define FZA_RING_CMD_RDCAM	0x00000008	/* read CAM */
   249	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--9amGYk9869ThD9tj--
