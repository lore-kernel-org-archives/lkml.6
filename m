Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2866101-1525588236-2-16290571850527053386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525588235; b=TaWK78U2zk1XZZsA3rqL+pOvofAeRLvbZVOIoULeoVscU4HybG
    F7aWDGmfFkaejtKvu7GNpK6due9uUBdgNER4to79bLJ/2WMhDKALzwT6ILpqbcas
    h6nultJPk/J1mBp/hJ5vqCDv8udKwrJUVX+vsSsZYhYD9E0VBQu3HfbCXIsQFHGb
    ndoIHA74TdH/kIPW+QA5uQ+DxAkSfwCkPWX2cjDMYScGMb6HS+sslTls65C8NABr
    HnLwK3T/9U7zXxuPSdSYoVhdvRAXH6cVDSK3R3boeol84j1OUUk8nHmWYdu0FN1B
    yhCwgwtBN4Yfs+P0ofVGM3i3PbLi/57luuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525588235; bh=PqKy0
    /U8nMf4oEan8kni6+OqcqHoC6Uh/1sgG/p+4jE=; b=jnCCnXIwNn+zKJSQ8Jwrz
    qOim0Us5hTEx35neMAnikgaaAS0nG+qM4tHlkVgtKEcOptl3K+U4OF0I5jFeYWT3
    CdBF2gqUaT6CmC6E2T/AjRnLckBjdnTicIwAwVSIz32lXIrLwf9ye1Wb8b4jcdFD
    YFAVSBlM1rqbYOMVtIrpD+eCPptYs6HO98/aj5+FqycwP5AP18J7i/wER5D5AUm8
    dowSc6VxWWIvd2c5UrPljdaXHahaOBS4GewlVfjavYTwvmbj7ufU8N8g/MUpP5+6
    nhdufmPIAhfE0NWBKvH5rV2IQ5OPte0RwF83q+vuSQ2xOL5jQ5QFM0cAnWd2m0El
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPegxgn3BaT1OSvUAscIdFyFysv0Ixyoi3qH/T6qKVcffVwrx4Oq5FiLtGCmh/lpedTOn5rBUSivlKAU2vVf0lNmvsv4KCZeMXUqnvMTt436albdWZBi
    hY97t9YIacwgbg90Dg2zFvro4oT5oAmS6lN2K0OXsAbf8sjDJGFL8Fd8OUvGqkjNoAGmH0U1PqYuTqk9X/E471MbC7kKJvwvaVaQgQZpuZRY862TmIlkS48F
    mTwc+h0ZBzIYgeQUATIx+A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=bt8Zh30PAAAA:8
    a=Tn3pIt-pAAAA:8 a=dlI4R5ZWAAAA:8 a=i3X5FwGiAAAA:8 a=DDOyTI_5AAAA:8
    a=bvlTLxzyfkRDMONn7-kA:9 a=CjuIK1q_8ugA:10 a=Q8NeW62Vi6f6ECDh1Cqj:22
    a=_Et68LT86lDbNqPJMOLW:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 14:30:14 +0800
From: Baoquan He <bhe@redhat.com>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180506063014.GG19030@localhost.localdomain>
References: <20180419001848.3041-2-bhe@redhat.com>
 <201804261137.HPgv5SSG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201804261137.HPgv5SSG%fengguang.wu@intel.com>
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
Cc: nicolas.pitre@linaro.org, Brijesh Singh <brijesh.singh@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
 Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, devicetree@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, josh@joshtriplett.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, robh+dt@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, dan.j.williams@intel.com,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 kbuild-all@01.org, devel@linuxdriverproject.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/26/18 at 11:23am, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17-rc2 next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180419-223752
> config: xtensa-common_defconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/xtensa/lib/pci-auto.c:22:0:
>    arch/xtensa/include/asm/pci-bridge.h: In function 'pcibios_init_resource':
> >> arch/xtensa/include/asm/pci-bridge.h:74:15: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
>      res->sibling = NULL;
>                   ^
>    arch/xtensa/include/asm/pci-bridge.h:75:13: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
>      res->child = NULL;

Thanks, below fix can fix it.

diff --git a/arch/xtensa/include/asm/pci-bridge.h b/arch/xtensa/include/asm/pci-bridge.h
index 0b68c76ec1e6..f487b06817df 100644
--- a/arch/xtensa/include/asm/pci-bridge.h
+++ b/arch/xtensa/include/asm/pci-bridge.h
@@ -71,8 +71,8 @@ static inline void pcibios_init_resource(struct resource *res,
 	res->flags = flags;
 	res->name = name;
 	res->parent = NULL;
-	res->sibling = NULL;
-	res->child = NULL;
+	INIT_LIST_HEAD(&res->child);
+	INIT_LIST_HEAD(&res->sibling);
 }
 
 

>                 ^
> 
> vim +74 arch/xtensa/include/asm/pci-bridge.h
> 
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  65  
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  66  static inline void pcibios_init_resource(struct resource *res,
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  67  		unsigned long start, unsigned long end, int flags, char *name)
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  68  {
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  69  	res->start = start;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  70  	res->end = end;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  71  	res->flags = flags;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  72  	res->name = name;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  73  	res->parent = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23 @74  	res->sibling = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  75  	res->child = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  76  }
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  77  
> 
> :::::: The code at line 74 was first introduced by commit
> :::::: 9a8fd5589902153a134111ed7a40f9cca1f83254 [PATCH] xtensa: Architecture support for Tensilica Xtensa Part 6
> 
> :::::: TO: Chris Zankel <czankel@tensilica.com>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
