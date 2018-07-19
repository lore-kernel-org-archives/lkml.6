Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFC8C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B32320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B32320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbeGSS77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:59:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:62405 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731960AbeGSS77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:59:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 11:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,375,1526367600"; 
   d="scan'208";a="59031512"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2018 11:15:37 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fgDSi-000NFm-FH; Fri, 20 Jul 2018 02:15:36 +0800
Date:   Fri, 20 Jul 2018 02:14:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     kbuild-all@01.org, agk@redhat.com, snitzer@redhat.com,
        herbert@gondor.apana.org.au, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com,
        broonie@kernel.org, arnd@arndb.de, jonathan.cameron@huawei.com
Subject: Re: [PATCH 4/5] crypto: Add IV generation templates
Message-ID: <201807200243.21tygjmy%fengguang.wu@intel.com>
References: <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on cryptodev/master]
[also build test WARNING on v4.18-rc5 next-20180719]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Xiongfeng-Wang/crypto-add-IV-generation-templates/20180719-034438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> crypto/geniv.c:303:9: sparse: Variable length array is used.
   crypto/geniv.c:568:9: sparse: Variable length array is used.
   crypto/geniv.c:729:9: sparse: Variable length array is used.
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/slab.h:631:13: sparse: not a function <noident>
>> crypto/geniv.c:1482:17: sparse: incorrect type in assignment (different base types) @@    expected unsigned long long [unsigned] [long] [long long] [usertype] <noident> @@    got long] [long long] [usertype] <noident> @@
   crypto/geniv.c:1482:17:    expected unsigned long long [unsigned] [long] [long long] [usertype] <noident>
   crypto/geniv.c:1482:17:    got restricted __le64 [usertype] <noident>
>> crypto/geniv.c:1543:17: sparse: cast to restricted __le64
   crypto/geniv.c:1580:17: sparse: incorrect type in assignment (different base types) @@    expected unsigned long long [unsigned] [long] [long long] [usertype] <noident> @@    got long] [long long] [usertype] <noident> @@
   crypto/geniv.c:1580:17:    expected unsigned long long [unsigned] [long] [long long] [usertype] <noident>
   crypto/geniv.c:1580:17:    got restricted __le64 [usertype] <noident>
>> crypto/geniv.c:1912:32: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: call with no type!

vim +303 crypto/geniv.c

   298	
   299	/* Initialise ESSIV - compute salt but no local memory allocations */
   300	static int crypt_iv_essiv_init(struct geniv_ctx *ctx)
   301	{
   302		struct geniv_essiv_private *essiv = &ctx->iv_gen_private.essiv;
 > 303		AHASH_REQUEST_ON_STACK(req, essiv->hash_tfm);
   304		struct scatterlist sg;
   305		struct crypto_cipher *essiv_tfm;
   306		int err;
   307	
   308		sg_init_one(&sg, ctx->key, ctx->key_size);
   309		ahash_request_set_tfm(req, essiv->hash_tfm);
   310		ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
   311		ahash_request_set_crypt(req, &sg, essiv->salt, ctx->key_size);
   312	
   313		err = crypto_ahash_digest(req);
   314		ahash_request_zero(req);
   315		if (err)
   316			return err;
   317	
   318		essiv_tfm = ctx->iv_private;
   319	
   320		return crypto_cipher_setkey(essiv_tfm, essiv->salt,
   321				    crypto_ahash_digestsize(essiv->hash_tfm));
   322	}
   323	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
