Return-Path: <kernel-hardening-return-12775-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48tslShUfmprfarE8WwF0QOSao8uU5OapUDxDvSE4CCp4vaQvdrOJgC+5bGA4/TJxOjEez9
ARC-Seal: i=1; a=rsa-sha256; t=1522176133; cv=none;
        d=google.com; s=arc-20160816;
        b=mTz9RQQBXENczqFOsv5STe7HYY782QMBttHjpGOCg6g6g9ueuVfxX97GbqrLmA4chC
         gWIDhJ5N9H07uSjP6MLjYMXnZhyOoqqZaPBo+8Q4XON0z1oj15dbtPyxtosabLtsPIIi
         nd7nC+dfs1Gtxnosv79xigKiDznYZXj+ZXiTu7mWyrHvO0T2eCZx02Ykd16ixhpIXnR9
         Zw4Eyw27AJbWXOPUPkpN6hqcWcl9GLsq+9EUH0BXiuOJDCmSy6/AIdD1MAKHQQTdAZBY
         f6kzmJINyM+FsKJ+kGaa4OqpHklM4Ai28MICMi2V+9IzPHvASO8BkPsV8o4G9w4UAj/Y
         6hBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=zzwyGbGJ0khH1vfsmQHZDoK5fugQnQSGNRSfqtGStRE=;
        b=CIIMCFunQUtpWMNFSJGeLdRMNOdMJSHf157axdeaFE1iDqyzxTwrX2PsVrwWvbZtJ5
         2naYvsvZcGoUGVWRv7iAa2znhkfULHYmfhTOlubx03RUBAmoG2fgeSyTz4FygOQo6lHG
         kyWUIifG4o5mjlsLrRyEoysYMRFH/SxlyevOqHwB3R1DHgxM7P907Lkcq3nzOqVb5JJK
         tb7XblcR1ecUaaUalE1CNtualBZxufRgxrJRsxFG3ZVqmkfRnRkd9Y2CFbC9ga16HNMC
         EGus0teBQ3bMtZ7ertJahvu/twQT79omBnC2WS2OkL7DPA3rq2MItDUnlVRTUswDGgs0
         gyxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12775-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12775-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12775-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12775-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="38601888"
Date: Wed, 28 Mar 2018 02:39:15 +0800
From: kbuild test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6] kernel.h: Retain constant expression output for
 max()/min()
Message-ID: <201803280107.bZw8jIAt%fengguang.wu@intel.com>
References: <20180326221554.GA45166@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326221554.GA45166@beast>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596040250176531135?=
X-GMAIL-MSGID: =?utf-8?q?1596117360576445317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kees,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc7 next-20180327]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kees-Cook/kernel-h-Retain-constant-expression-output-for-max-min/20180327-110916
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


vim +124 drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c

29c8d9eb Adit Ranadive 2016-10-02  114  
29c8d9eb Adit Ranadive 2016-10-02  115  void pvrdma_uar_free(struct pvrdma_dev *dev, struct pvrdma_uar_map *uar)
29c8d9eb Adit Ranadive 2016-10-02  116  {
29c8d9eb Adit Ranadive 2016-10-02  117  	struct pvrdma_id_table *tbl = &dev->uar_table.tbl;
29c8d9eb Adit Ranadive 2016-10-02  118  	unsigned long flags;
29c8d9eb Adit Ranadive 2016-10-02  119  	u32 obj;
29c8d9eb Adit Ranadive 2016-10-02  120  
29c8d9eb Adit Ranadive 2016-10-02  121  	obj = uar->index & (tbl->max - 1);
29c8d9eb Adit Ranadive 2016-10-02  122  	spin_lock_irqsave(&tbl->lock, flags);
29c8d9eb Adit Ranadive 2016-10-02  123  	clear_bit(obj, tbl->table);
29c8d9eb Adit Ranadive 2016-10-02 @124  	tbl->last = min(tbl->last, obj);

:::::: The code at line 124 was first introduced by commit
:::::: 29c8d9eba550c6d73d17cc1618a9f5f2a7345aa1 IB: Add vmw_pvrdma driver

:::::: TO: Adit Ranadive <aditr@vmware.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
