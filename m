Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B073C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C8820020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C8820020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeFTU4h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:56:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:38147 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932602AbeFTU4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:56:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 13:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="49294099"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2018 13:56:34 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fVk9Z-0001Np-LS; Thu, 21 Jun 2018 04:56:33 +0800
Date:   Thu, 21 Jun 2018 04:55:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: security/integrity/iint.c:225:9-16: ERROR: PTR_ERR applied after
 initialization to constant on line 224
Message-ID: <201806210456.jJPVmFK4%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e97f01371f4e1701feeafe484665112cd9ddc2
commit: 0c343af8065be5ceb0c03a876af7c513e960e2ff integrity: Add an integrity directory in securityfs
date:   5 weeks ago


coccinelle warnings: (new ones prefixed by >>)

>> security/integrity/iint.c:225:9-16: ERROR: PTR_ERR applied after initialization to constant on line 224

vim +225 security/integrity/iint.c

   217	
   218	static int __init integrity_fs_init(void)
   219	{
   220		integrity_dir = securityfs_create_dir("integrity", NULL);
   221		if (IS_ERR(integrity_dir)) {
   222			pr_err("Unable to create integrity sysfs dir: %ld\n",
   223			       PTR_ERR(integrity_dir));
 > 224			integrity_dir = NULL;
 > 225			return PTR_ERR(integrity_dir);
   226		}
   227	
   228		return 0;
   229	}
   230	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
