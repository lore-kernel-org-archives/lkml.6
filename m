Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1850428-1523178596-2-17386111499396874027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523178595; b=HuTG4QHrSnenEyje0zTsay+Y9E/eDzb7QEmC5TnH8OZCiKmZX3
    3kZod9lBdCHP77RuwybTLUnQpT5XhULJBaHuyDdzogE4xKCH4WtmPEeKa/wZh0LN
    ZtZoZtphCnDvT7a2KuvZX6U5/mGJpm0LI3hXTLn5A0ZUlMUPuTPpjOcAhH8h7Ju4
    AmD5EiNzdQExqmbQbY8dx9NMOZuT5+OEuafeb/jzSId3nnuqRpmhNXixh0dLls+r
    Inl+fDBiJ0a3IZZ3KjWdqZfhmsAqAkArVzEjP8ssgp/r2TB7SjYFKkKFynvWyTId
    WNeOB0ROlKdiENE0m5ks+IEYtCuQ8aEIGJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523178595; bh=53NeZ
    hSpMCWhvrk4TIJ8DA4Fye9ZN3Agg3H57hHuYBY=; b=ubYhGGaErFGE7L53bG4HM
    ifB1L5ETPcC1Xs/YQIHSb3vvcEJNU1p7dE2TGdP0TrHdrnYr7rbjYPQgRO+QoM1Y
    Ah85+4doGwykdP+g6ZsaDCdpuwX06ORAA/ZNsL5YuNeWav4zGTZcu21yqwPhMg1Y
    ccUakjLhxaSnkvoG6Tk4n3itCvR3XsnErfq5EQx8aID5VAt7hsPenh1kh21AZoqL
    NynaUnm1saaQOn+4BM9Va3AuFcD4wpCQAggj+f+PxT21LIr+Dae+67KTTPiIINfN
    tbL0cLR++Imkt0IUOdFLck1Y1cV/8C6xZuVHOpqUADUM4PmkAuGVO5JxdoCJf1Gj
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfEBRFmpfwSPuyt7Jj+cqg+6SzMz5tXDuburMGhlfmP7AfE8iGInt0i6dQyGtHrvRD1XNXeKzuxh1GtJjMEfqIGr21VON1A78PFfE0XoU+noHOAbW0vkK
    0gkAN63JHYgi0Q46DK7TorM72zFNbx8YW+1/S8+jvO9btHozAZKhtySlOGoIXuZHZ22D5T1cviFd/KVZUyD4ylGaqG8GRnpMIv0vWfXeuBdA1fmZ7fL79XgH
    GlgwU6c0CYpKTQIi62PkeQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=bt8Zh30PAAAA:8
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=i3X5FwGiAAAA:8 a=DDOyTI_5AAAA:8
    a=jK4hYP2Xc9g7ehdouTkA:9 a=CjuIK1q_8ugA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=mmqRlSCDY2ywfjPLJ4af:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 8 Apr 2018 17:09:44 +0800
From: Baoquan He <bhe@redhat.com>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180408090944.GF19345@localhost.localdomain>
References: <20180408024724.16812-2-bhe@redhat.com>
 <201804081223.lLuGQOqa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201804081223.lLuGQOqa%fengguang.wu@intel.com>
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

On 04/08/18 at 01:55pm, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16 next-20180406]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180408-110108
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/sparc/kernel/ioport.c: In function 'sparc_io_proc_show':
> >> arch/sparc/kernel/ioport.c:672:9: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
>      for (r = root->child; r != NULL; r = r->sibling) {
>             ^
>    arch/sparc/kernel/ioport.c:672:37: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
>      for (r = root->child; r != NULL; r = r->sibling) {
>                                         ^

Thanks, will change and repost.

> 
> vim +672 arch/sparc/kernel/ioport.c
> 
> ^1da177e4 Linus Torvalds     2005-04-16  666  
> e7a088f93 Alexey Dobriyan    2009-09-01  667  static int sparc_io_proc_show(struct seq_file *m, void *v)
> ^1da177e4 Linus Torvalds     2005-04-16  668  {
> e7a088f93 Alexey Dobriyan    2009-09-01  669  	struct resource *root = m->private, *r;
> ^1da177e4 Linus Torvalds     2005-04-16  670  	const char *nm;
> ^1da177e4 Linus Torvalds     2005-04-16  671  
> e7a088f93 Alexey Dobriyan    2009-09-01 @672  	for (r = root->child; r != NULL; r = r->sibling) {
> c31f76518 Sam Ravnborg       2014-04-21  673  		if ((nm = r->name) == NULL) nm = "???";
> e7a088f93 Alexey Dobriyan    2009-09-01  674  		seq_printf(m, "%016llx-%016llx: %s\n",
> 685143ac1 Greg Kroah-Hartman 2006-06-12  675  				(unsigned long long)r->start,
> 685143ac1 Greg Kroah-Hartman 2006-06-12  676  				(unsigned long long)r->end, nm);
> ^1da177e4 Linus Torvalds     2005-04-16  677  	}
> ^1da177e4 Linus Torvalds     2005-04-16  678  
> e7a088f93 Alexey Dobriyan    2009-09-01  679  	return 0;
> ^1da177e4 Linus Torvalds     2005-04-16  680  }
> ^1da177e4 Linus Torvalds     2005-04-16  681  
> 
> :::::: The code at line 672 was first introduced by commit
> :::::: e7a088f935180b90cfe6ab0aaae8a556f46885fe sparc: convert /proc/io_map, /proc/dvma_map to seq_file
> 
> :::::: TO: Alexey Dobriyan <adobriyan@gmail.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
