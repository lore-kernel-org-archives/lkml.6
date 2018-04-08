Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1850428-1523178560-2-11636447789300463606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523178559; b=Ao1X/oSIB5h4N61Qk/Flawhbx5KuAByqZewrzvwsrePvEvCS7m
    6TDgDNU3WVYZhbxG1rl9F/f74SlgznY0tPvij2snvbZyrM8M/ShXuL6kdLlaIQZl
    nXhEsHhAFAX/ePyjDJbI3MAxEgO4W8xiX4NuGlnllg5TD2mpZIRjC5w1FlXUm8dw
    bekbIotGv117lIh4PIOaky1D7vVsGxtmgkNcdnDX2+c6ZlmME3PpOGUO8vFfT8uF
    crErVhas9vmMccfH3Uc4VxMddYM19zYDT2Ii3AV77DPwk4p+uLPrzxSjK4RA6jms
    dFUP9mz0A5cBIPNF0Ky+rwZoejNuuPmdbEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523178559; bh=g0nYI
    3XciCDWSx+wmdDDFAmEAfBheTKsjF9Lq0Tnqc4=; b=WFLCFqDneVWEyjgQhh7MB
    Pq2dhQJSon7SZd3TSmy27NNS55AvSjaSDiv3AFsoYqh9abXcedOxMvFXTN/7Jrd/
    DOkl2IxK/tOs0yYAmo6YUJdfuF1QbjIqEMB3FSMSBG4zBycrh3BpPpeMkt2kjlvG
    q1sAOmQFgqrcdtU7lR4h7aJZrasFMfyDhmhdk0BT4E7ARE6+Aecy+ZGaHrNu3C7G
    pfkBbuuWPVADUwM3jdRKT7jThd60EIlq6xYAnBs582BorYRwj2TsXLi5mymkYZws
    bnWd/HFD4NbQGTITNsaMSctJCfE6+T/uy9pgJ4dKtPRDu4pUHtFFaaTez4HW9bZx
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEGwQfPWvOomDDWyl4rmA9wdQabKttEFA8GmpKLwBoGVzMBczeUb5Y8QEVfMRW9fY/ZNOLxHV34WFFx0QaxirnDpUbF5hma4hp4V60IPY/sQwEwt47IL
    vcCj3h1IvCOFcqozgJGf6PISx0rCls4Ftb6/Aosy5wpy1F87Xp6ws9u8mPSpBAKXbJL5HcFTSbA1lliNZ16BLKB9vCH6PV2F8gpiFwWIbPZRWu8R8Rc1mbct
    0KtAXpqt5m7YeRtmmIwqEQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=bt8Zh30PAAAA:8
    a=dlI4R5ZWAAAA:8 a=i3X5FwGiAAAA:8 a=DDOyTI_5AAAA:8 a=qG9lFEno9mWciLaZM6MA:9
    a=CjuIK1q_8ugA:10 a=_Et68LT86lDbNqPJMOLW:22 a=mmqRlSCDY2ywfjPLJ4af:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 8 Apr 2018 17:09:03 +0800
From: Baoquan He <bhe@redhat.com>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180408090903.GE19345@localhost.localdomain>
References: <20180408024724.16812-2-bhe@redhat.com>
 <201804081247.F3eqBMih%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201804081247.F3eqBMih%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Brijesh Singh <brijesh.singh@amd.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Wei Yang <richard.weiyang@gmail.com>, Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 kbuild-all@01.org, devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Thanks for telling!

On 04/08/18 at 12:12pm, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16 next-20180406]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180408-110108
> config: parisc-c3000_defconfig (attached as .config)
> compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=parisc 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers//parisc/lba_pci.c: In function 'lba_dump_res':
> >> drivers//parisc/lba_pci.c:173:15: error: incompatible type for argument 1 of 'lba_dump_res'
>      lba_dump_res(r->child, d+2);

I compiled with allyesconfig, don't know why this was missed. Will
change and repost.

>                   ^
>    drivers//parisc/lba_pci.c:162:1: note: expected 'struct resource *' but argument is of type 'struct list_head'
>     lba_dump_res(struct resource *r, int d)
>     ^~~~~~~~~~~~
>    drivers//parisc/lba_pci.c:174:15: error: incompatible type for argument 1 of 'lba_dump_res'
>      lba_dump_res(r->sibling, d);
>                   ^
>    drivers//parisc/lba_pci.c:162:1: note: expected 'struct resource *' but argument is of type 'struct list_head'
>     lba_dump_res(struct resource *r, int d)
>     ^~~~~~~~~~~~
> 
> vim +/lba_dump_res +173 drivers//parisc/lba_pci.c
> 
> ^1da177e Linus Torvalds 2005-04-16  159  
> ^1da177e Linus Torvalds 2005-04-16  160  
> ^1da177e Linus Torvalds 2005-04-16  161  static void
> ^1da177e Linus Torvalds 2005-04-16  162  lba_dump_res(struct resource *r, int d)
> ^1da177e Linus Torvalds 2005-04-16  163  {
> ^1da177e Linus Torvalds 2005-04-16  164  	int i;
> ^1da177e Linus Torvalds 2005-04-16  165  
> ^1da177e Linus Torvalds 2005-04-16  166  	if (NULL == r)
> ^1da177e Linus Torvalds 2005-04-16  167  		return;
> ^1da177e Linus Torvalds 2005-04-16  168  
> ^1da177e Linus Torvalds 2005-04-16  169  	printk(KERN_DEBUG "(%p)", r->parent);
> ^1da177e Linus Torvalds 2005-04-16  170  	for (i = d; i ; --i) printk(" ");
> 645d11d4 Matthew Wilcox 2006-12-24  171  	printk(KERN_DEBUG "%p [%lx,%lx]/%lx\n", r,
> 645d11d4 Matthew Wilcox 2006-12-24  172  		(long)r->start, (long)r->end, r->flags);
> ^1da177e Linus Torvalds 2005-04-16 @173  	lba_dump_res(r->child, d+2);
> ^1da177e Linus Torvalds 2005-04-16  174  	lba_dump_res(r->sibling, d);
> ^1da177e Linus Torvalds 2005-04-16  175  }
> ^1da177e Linus Torvalds 2005-04-16  176  
> 
> :::::: The code at line 173 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
