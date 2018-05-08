Return-Path: <bhe@redhat.com>
X-Google-Smtp-Source: AB8JxZqQd0ZbpLepWvuwcwVV8C82VQN4BZMmw0WxgH5OGhr0kY3o9gB9UGZbYCo9Cl+hcTjnKrZ2
ARC-Seal: i=1; a=rsa-sha256; t=1525781554; cv=none;
        d=google.com; s=arc-20160816;
        b=dJwZFKy7OCD1RoEB9gO59qMI5jdSbK2lgKvFFBg+0YpSOHZB+V9NeakqObs7hzViRd
         1OP21sszICJBFIR6fEyTqVxbaz9ot8gGSM8pMtR+mXgBljxeoKiGNsQ7Dz9y/e1u+O/q
         N7waGyzw4S8OsomM4HQ2hkol47vReO4vFg6sp4qqtR20emZiCgLZyLkxsKfLmCaci3ZG
         wOEls2gN59d+jLKAYRfwbf7elJ3x0O4i1fbSkjeh+IrHGcr6lsDckuZf7/3HUShfP7ZD
         PPptnz758KA9heurimLCnuVOgZPTX/177DgLUhjXc7/MZKOpTfyLnwGbE9mjKhmPzBRK
         DemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=GNTg95ry3MWmLSLl+fK4euOt87HvKTRH0oDL61VQvN4=;
        b=rm3iifOrsmva8L5TLCOB7SFMcsYe47F970ZSdTXIzgopSs8IS56yWJX10sXrIpKZcy
         dXWuAlQeRDNeVcB1+stCq+lMlbTgAFqaZc7MExealHZPK2pqWK+DKmtBpUK+grE9pOxm
         jclXS4pCcF4/9/B2eb03GqF5yN7wGbBIRkD+GtFjgNKimCTgqh2mzv8JQS+CeRlJOSxe
         NkCJxEBkbDad+Xo5FavKhqnCbi7aB5AjelPyhgmYswAwQHZR/YAbjRNvcEp1iKrCTJYU
         6xn3Gcfse6/GXJ0pIdJv6hgfIQ2owGiepWlK33st2drSHLuzRGjBfCfPRG1havsjQ3jY
         gYXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bhe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=bhe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bhe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=bhe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 8 May 2018 20:12:26 +0800
From: Baoquan He <bhe@redhat.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, robh+dt@kernel.org,
	dan.j.williams@intel.com, nicolas.pitre@linaro.org,
	josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de,
	patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
	haiyangz@microsoft.com, sthemmin@microsoft.com,
	dmitry.torokhov@gmail.com, frowand.list@gmail.com,
	keith.busch@intel.com, jonathan.derrick@intel.com,
	lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
	brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
	gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
	richard.weiyang@gmail.com, devel@linuxdriverproject.org,
	linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
	yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
	davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
	gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
	seanpaul@chromium.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180508121226.GJ30581@MiWiFi-R3L-srv>
References: <20180507063224.24229-2-bhe@redhat.com>
 <201805072210.H1bsHs9Y%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805072210.H1bsHs9Y%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598131700389744779?=
X-GMAIL-MSGID: =?utf-8?q?1599897918974995660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/18 at 11:50pm, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17-rc4 next-20180504]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180507-144345
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):

Thanks, below patch can fix it:


diff --git a/arch/arm/plat-samsung/pm-check.c b/arch/arm/plat-samsung/pm-check.c
index cd2c02c68bc3..5494355b1c49 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -46,8 +46,8 @@ typedef u32 *(run_fn_t)(struct resource *ptr, u32 *arg);
 static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
 {
 	while (ptr != NULL) {
-		if (ptr->child != NULL)
-			s3c_pm_run_res(ptr->child, fn, arg);
+		if (!list_empty(&ptr->child))
+			s3c_pm_run_res(resource_first_child(&ptr->child), fn, arg);
 
 		if ((ptr->flags & IORESOURCE_SYSTEM_RAM)
 				== IORESOURCE_SYSTEM_RAM) {
@@ -57,7 +57,7 @@ static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
 			arg = (fn)(ptr, arg);
 		}
 
-		ptr = ptr->sibling;
+		ptr = resource_sibling(ptr);
 	}
 }
 

> 
>    arch/arm/plat-samsung/pm-check.c: In function 's3c_pm_run_res':
> >> arch/arm/plat-samsung/pm-check.c:49:18: error: invalid operands to binary != (have 'struct list_head' and 'void *')
>       if (ptr->child != NULL)
>           ~~~~~~~~~~ ^~
> >> arch/arm/plat-samsung/pm-check.c:50:19: error: incompatible type for argument 1 of 's3c_pm_run_res'
>        s3c_pm_run_res(ptr->child, fn, arg);
>                       ^~~
>    arch/arm/plat-samsung/pm-check.c:46:13: note: expected 'struct resource *' but argument is of type 'struct list_head'
>     static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
>                 ^~~~~~~~~~~~~~
> >> arch/arm/plat-samsung/pm-check.c:60:7: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
>       ptr = ptr->sibling;
>           ^
> 
> vim +49 arch/arm/plat-samsung/pm-check.c
> 
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  45  
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  46  static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  47  {
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  48  	while (ptr != NULL) {
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12 @49  		if (ptr->child != NULL)
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12 @50  			s3c_pm_run_res(ptr->child, fn, arg);
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  51  
> 05fee7cf arch/arm/plat-samsung/pm-check.c Toshi Kani 2016-01-26  52  		if ((ptr->flags & IORESOURCE_SYSTEM_RAM)
> 05fee7cf arch/arm/plat-samsung/pm-check.c Toshi Kani 2016-01-26  53  				== IORESOURCE_SYSTEM_RAM) {
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  54  			S3C_PMDBG("Found system RAM at %08lx..%08lx\n",
> 840eeeb8 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  55  				  (unsigned long)ptr->start,
> 840eeeb8 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  56  				  (unsigned long)ptr->end);
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  57  			arg = (fn)(ptr, arg);
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  58  		}
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  59  
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12 @60  		ptr = ptr->sibling;
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  61  	}
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  62  }
> 549c7e33 arch/arm/plat-s3c/pm-check.c     Ben Dooks  2008-12-12  63  
> 
> :::::: The code at line 49 was first introduced by commit
> :::::: 549c7e33aeb9bfe441ecf68639d2227bb90978e7 [ARM] S3C: Split the resume memory check code from pm.c
> 
> :::::: TO: Ben Dooks <ben-linux@fluff.org>
> :::::: CC: Ben Dooks <ben-linux@fluff.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
