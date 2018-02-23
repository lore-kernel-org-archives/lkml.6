Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AH8x224zpHCABZp6OhJEVZpIcFvy6u7RokfXcc3wo33ZsB4g+k3rJwWODBsCT8ODAFh6yFjOSVFD
ARC-Seal: i=1; a=rsa-sha256; t=1519412242; cv=none;
        d=google.com; s=arc-20160816;
        b=N2nZ0TS/6pumOT+79v/mgTvBOZmo0pMA6lr4pcmK0IBlziTrRWWb5qA/YK+imhYoJy
         DrO+Igu3oTrjAjEEun3+VRMoBpQJCV2JlIPzDMzChejZbWYV9tzWZ1lbVuL/sOr4TVBa
         Jm4HFJDuMtUAbINoY+7n6U2j8Jhuak/SMEEnOd7b59PW2Hwyepn8wo5Lfs7Cgn/uQBsi
         0xbUqx6tCCaOPJ+kbzJKsU5wKrNEojy2VuvSCR+k5YiC6MI4oPZOh5f6mnDch8iFGkmc
         xIXIWLeuo5sgCM3oE46i+f5AY8HXTYZ4OFH+cknteBxNGQ1U8LqUYJVkwTnyXXcldzXz
         JPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=TFju8CoLkeEV6eu8jUoOIfDYm0Pn9LwPXiIxBxhwSKs=;
        b=IgOjBesuQeYMDie3z6R3LMHTULLUJ+tVGKWbFz3QpeiYlVw0ZE3vZqTPxWnrSiiZAh
         ClEx2EuBfrV17S5e/yyg3HCYrpeQm8YQlJiyprOn8L3SPsBHBNV7RRherJhD8HfFsvMJ
         771gEqeup5oVH6PxOqHLFLKyPDCEYOofSLBzv5NykR0Z0O26ui1Ckf60jBT8lh1obymJ
         IdAcVZMeffNNZLPeVx3LMMDHPHi9EUpBIagicf32TCORGQVJ2TwaFr1+Jhlb9Ll/UNbi
         ypC2cCuRz9o39vDNJeqfw/9hXGNtynOUjwinTr8xcUBP6zTW+H/UnMYa3Jo0340izCXN
         9Btg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Fri, 23 Feb 2018 13:57:16 -0500 (EST)
Message-Id: <20180223.135716.511559214062584207.davem@davemloft.net>
To: khalid.aziz@oracle.com
Cc: kbuild-all@01.org, akpm@linux-foundation.org,
 dave.hansen@linux.intel.com, corbet@lwn.net, bob.picco@oracle.com,
 steven.sistare@oracle.com, pasha.tatashin@oracle.com,
 mike.kravetz@oracle.com, rob.gardner@oracle.com, mingo@kernel.org,
 nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com,
 kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com,
 allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com,
 vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz,
 punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com,
 ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org,
 minchan@kernel.org, imbrenda@linux.vnet.ibm.com, aarcange@redhat.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com,
 linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com,
 jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, khalid@gonehiking.org
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application
 Data Integrity)
From: David Miller <davem@davemloft.net>
In-Reply-To: <490b8c3b-fc62-b6e7-af28-7c1257e953ce@oracle.com>
References: <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
	<201802231005.WSf8KcHd%fengguang.wu@intel.com>
	<490b8c3b-fc62-b6e7-af28-7c1257e953ce@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1593219211031072797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 23 Feb 2018 11:51:25 -0700

> On 02/22/2018 07:50 PM, kbuild test robot wrote:
>> Hi Khalid,
>> I love your patch! Yet something to improve:
>> [auto build test ERROR on sparc-next/master]
>> [also build test ERROR on v4.16-rc2]
>> [cannot apply to next-20180222]
>> [if your patch is applied to the wrong git tree, please drop us a note
>> to help improve the system]
>> url:
>> https://github.com/0day-ci/linux/commits/Khalid-Aziz/Application-Data-Integrity-feature-introduced-by-SPARC-M7/20180223-071725
>> base:
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git
>> master
>> config: sparc64-allyesconfig (attached as .config)
>> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>          wget
>>          https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>          -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=sparc64
>> All error/warnings (new ones prefixed by >>):
> 
> Hi Dave,
> 
> Including linux/sched.h in arch/sparc/include/asm/mmu_context.h should
> eliminate these build warnings. My gcc version 6.2.1 does not report
> these errors. Build bot is using 7.2.0.
> 
> I can add a patch 12 to add the include, revise patch 10 or you can
> add the include in your tree. Let me know how you would prefer to
> resolve this.

You need to update patch #10 so that your patch series is fully
bisectable.

Thank you.
