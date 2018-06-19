Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A86C5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504EB20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504EB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755447AbeFSVKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:10:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:61639 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755540AbeFSVKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:10:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 14:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,244,1526367600"; 
   d="scan'208";a="50641549"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Jun 2018 14:10:23 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fVNtO-000J0N-TX; Wed, 20 Jun 2018 05:10:22 +0800
Date:   Wed, 20 Jun 2018 05:09:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@01.org, David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] jffs2: use unsigned 32-bit timstamps consistently
Message-ID: <201806200530.EiSnqUgV%fengguang.wu@intel.com>
References: <20180619155925.4107498-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619155925.4107498-2-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc1 next-20180619]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/jffs2-use-64-bit-intermediate-timestamps/20180620-015800
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> fs/jffs2/dir.c:263:15: sparse: expression using sizeof(void)
>> fs/jffs2/dir.c:263:15: sparse: expression using sizeof(void)
>> fs/jffs2/dir.c:263:15: sparse: expression using sizeof(void)
>> fs/jffs2/dir.c:263:15: sparse: expression using sizeof(void)
>> fs/jffs2/dir.c:263:15: sparse: expression using sizeof(void)
>> fs/jffs2/dir.c:263:15: sparse: expression using sizeof(void)
>> fs/jffs2/dir.c:263:15: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:230:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:230:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:230:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:230:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:230:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:230:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:230:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:403:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:403:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:403:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:403:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:403:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:403:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:403:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:546:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:546:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:546:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:546:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:546:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:546:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:546:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:591:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:591:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:591:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:591:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:591:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:591:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:591:24: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:715:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:715:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:715:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:715:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:715:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:715:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:715:22: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:800:15: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:800:15: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:800:15: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:800:15: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:800:15: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:800:15: sparse: expression using sizeof(void)
   fs/jffs2/dir.c:800:15: sparse: expression using sizeof(void)
--
>> fs/jffs2/fs.c:115:21: sparse: expression using sizeof(void)
>> fs/jffs2/fs.c:115:21: sparse: expression using sizeof(void)
>> fs/jffs2/fs.c:115:21: sparse: expression using sizeof(void)
>> fs/jffs2/fs.c:115:21: sparse: expression using sizeof(void)
>> fs/jffs2/fs.c:115:21: sparse: expression using sizeof(void)
>> fs/jffs2/fs.c:115:21: sparse: expression using sizeof(void)
>> fs/jffs2/fs.c:115:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:116:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:116:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:116:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:116:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:116:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:116:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:116:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:117:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:117:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:117:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:117:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:117:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:117:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:117:21: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:476:45: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:476:45: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:476:45: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:476:45: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:476:45: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:476:45: sparse: expression using sizeof(void)
   fs/jffs2/fs.c:476:45: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/slab.h:631:13: sparse: call with no type!

vim +263 fs/jffs2/dir.c

^1da177e Linus Torvalds      2005-04-16  241  
^1da177e Linus Torvalds      2005-04-16  242  
^1da177e Linus Torvalds      2005-04-16  243  static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct dentry *dentry)
^1da177e Linus Torvalds      2005-04-16  244  {
fc64005c Al Viro             2016-04-10  245  	struct jffs2_sb_info *c = JFFS2_SB_INFO(old_dentry->d_sb);
2b0143b5 David Howells       2015-03-17  246  	struct jffs2_inode_info *f = JFFS2_INODE_INFO(d_inode(old_dentry));
^1da177e Linus Torvalds      2005-04-16  247  	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
^1da177e Linus Torvalds      2005-04-16  248  	int ret;
^1da177e Linus Torvalds      2005-04-16  249  	uint8_t type;
3a69e0cd Artem B. Bityutskiy 2005-08-17  250  	uint32_t now;
^1da177e Linus Torvalds      2005-04-16  251  
^1da177e Linus Torvalds      2005-04-16  252  	/* Don't let people make hard links to bad inodes. */
^1da177e Linus Torvalds      2005-04-16  253  	if (!f->inocache)
^1da177e Linus Torvalds      2005-04-16  254  		return -EIO;
^1da177e Linus Torvalds      2005-04-16  255  
e36cb0b8 David Howells       2015-01-29  256  	if (d_is_dir(old_dentry))
^1da177e Linus Torvalds      2005-04-16  257  		return -EPERM;
^1da177e Linus Torvalds      2005-04-16  258  
^1da177e Linus Torvalds      2005-04-16  259  	/* XXX: This is ugly */
2b0143b5 David Howells       2015-03-17  260  	type = (d_inode(old_dentry)->i_mode & S_IFMT) >> 12;
^1da177e Linus Torvalds      2005-04-16  261  	if (!type) type = DT_REG;
^1da177e Linus Torvalds      2005-04-16  262  
a7cab044 Arnd Bergmann       2018-06-19 @263  	now = JFFS2_NOW();
3a69e0cd Artem B. Bityutskiy 2005-08-17  264  	ret = jffs2_do_link(c, dir_f, f->inocache->ino, type, dentry->d_name.name, dentry->d_name.len, now);
^1da177e Linus Torvalds      2005-04-16  265  
^1da177e Linus Torvalds      2005-04-16  266  	if (!ret) {
ced22070 David Woodhouse     2008-04-22  267  		mutex_lock(&f->sem);
2b0143b5 David Howells       2015-03-17  268  		set_nlink(d_inode(old_dentry), ++f->inocache->pino_nlink);
ced22070 David Woodhouse     2008-04-22  269  		mutex_unlock(&f->sem);
2b0143b5 David Howells       2015-03-17  270  		d_instantiate(dentry, d_inode(old_dentry));
a7cab044 Arnd Bergmann       2018-06-19  271  		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
2b0143b5 David Howells       2015-03-17  272  		ihold(d_inode(old_dentry));
^1da177e Linus Torvalds      2005-04-16  273  	}
^1da177e Linus Torvalds      2005-04-16  274  	return ret;
^1da177e Linus Torvalds      2005-04-16  275  }
^1da177e Linus Torvalds      2005-04-16  276  

:::::: The code at line 263 was first introduced by commit
:::::: a7cab044350466ac53107fa859f1f2cbc4d5112b jffs2: use 64-bit intermediate timestamps

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
