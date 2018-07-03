Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E1F23CE9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1F23CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933142AbeGCJgf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:36:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:31768 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753973AbeGCJgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:36:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 02:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,302,1526367600"; 
   d="scan'208";a="52269056"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2018 02:36:25 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1faHjU-0007u7-6I; Tue, 03 Jul 2018 17:36:24 +0800
Date:   Tue, 3 Jul 2018 17:35:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     kbuild-all@01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 8/8] module: replace the existing LSM hook in
 init_module
Message-ID: <201807031757.qpz6yHPo%fengguang.wu@intel.com>
References: <1530542283-26145-9-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530542283-26145-9-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on integrity/next-integrity]
[also build test WARNING on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mimi-Zohar/kexec-firmware-support-system-wide-policy-requiring-signatures/20180703-011114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> security/loadpin/loadpin.c:178:40: sparse: mixing different enum types
   security/loadpin/loadpin.c:178:40:     int enum kernel_load_data_id  versus
   security/loadpin/loadpin.c:178:40:     int enum kernel_read_file_id

vim +178 security/loadpin/loadpin.c

   175	
   176	static int loadpin_load_data(enum kernel_load_data_id id)
   177	{
 > 178		return loadpin_read_file(NULL, id);
   179	}
   180	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
