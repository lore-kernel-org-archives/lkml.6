Return-Path: <jglisse@redhat.com>
X-Google-Smtp-Source: AG47ELs6C9jXHK/2FgpiwKE/Fx7SP3QW06mzhvkscqiP5OE7uvCs3Bathx3IGm0XEgNHGYak2JYo
ARC-Seal: i=1; a=rsa-sha256; t=1520973632; cv=none;
        d=google.com; s=arc-20160816;
        b=dzSnU+cS1lL30+rQS4E+HG9QpOtLGmcbMyEFZiD8LTp5mOsoyOpsl1a/Ma4gYeKJ85
         K/COYyGglNXAIpdV2pUgq9lJBkeQUDyTK1QZS0KqsxRZY7k/qRNdi4mSrZp4GFm9CZLm
         5lRkmE0/4QLOiqMo0hNvhPESqr9jsXyaTpCJw8D624HksUTt3c5zwmOsRay/otz1ht8P
         lho3M7I+US0RP5CF5nP/lLI7ddLUA2A6huKDcUZJ6FpWl+BzAnYqF71KghCvGXpIYCyu
         R1ZTcSrBUNzUKi9wS5Ayo38zNuBi4Kzw/50qZ+Ivmi6Zagg7ORIzFZcxlghKbeumfBPX
         voYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=VRwfZojKpGUIQiHt2dY2LP6pFodr3goutHh/hV6oSQA=;
        b=s406219YTniNsPz0Cv6ouUwMcvQl8fbaTbXe9HUJZ+6zFCUDR1eLU97aDn2DMdLPmE
         yy3VOVKZ/ByGt4rZMMZ7ngYGiFEeMBFBh62eUeqqbWWGlFD3zb1Y4EAAo9HKaKlEAFHW
         7JmSYI0ocRJ0PCP0+ISG3UmAh2GpJjV734jQ5U3B5l3R8YpXO6SzC0Wgilhj4m4Re0Il
         5/9bk/ObFVz8kqdJ6k6FqysEBp5ssyQruPuII1wuQdsAhJ1Bsp5PXU+77FBoIDND4sOH
         jwJsFxkJaOD9ZL90QuTtquAh2FEZCcRa4yXT/31fLSK72ckIGuF5kTW8bCKdPEb6PwNM
         bfbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 13 Mar 2018 16:40:25 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	srikar@linux.vnet.ibm.com, acme@kernel.org,
	ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
	corbet@lwn.net, dan.j.williams@intel.com,
	gregkh@linuxfoundation.org, huawei.libin@huawei.com,
	hughd@google.com, jack@suse.cz, jolsa@redhat.com,
	kan.liang@intel.com, kirill.shutemov@linux.intel.com,
	kjlx@templeofstupid.com, kstewart@linuxfoundation.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhocko@suse.com, milian.wolff@kdab.com,
	mingo@redhat.com, namhyung@kernel.org,
	naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com,
	pombredanne@nexb.com, rostedt@goodmis.org, tglx@linutronix.de,
	tmricht@linux.vnet.ibm.com, willy@infradead.org,
	yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 4/8] Uprobe: Export uprobe_map_info along with
 uprobe_{build/free}_map_info()
Message-ID: <20180313204024.GJ3828@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-5-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180313125603.19819-5-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827156987945249?=
X-GMAIL-MSGID: =?utf-8?q?1594856447452913573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:25:59PM +0530, Ravi Bangoria wrote:
> These exported data structure and functions will be used by other
> files in later patches.
> 
> No functionality changes.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/uprobes.h |  9 +++++++++
>  kernel/events/uprobes.c | 14 +++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 0a294e9..7bd2760 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -109,12 +109,19 @@ enum rp_check {
>  	RP_CHECK_RET,
>  };
>  
> +struct address_space;
>  struct xol_area;
>  
>  struct uprobes_state {
>  	struct xol_area		*xol_area;
>  };
>  
> +struct uprobe_map_info {
> +	struct uprobe_map_info *next;
> +	struct mm_struct *mm;
> +	unsigned long vaddr;
> +};
> +
>  extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>  extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>  extern bool is_swbp_insn(uprobe_opcode_t *insn);
> @@ -149,6 +156,8 @@ struct uprobes_state {
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  					 void *src, unsigned long len);
> +extern struct uprobe_map_info *uprobe_free_map_info(struct uprobe_map_info *info);
> +extern struct uprobe_map_info *uprobe_build_map_info(struct address_space *mapping, loff_t offset, bool is_register);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 081b88c1..e7830b8 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -695,23 +695,15 @@ static void delete_uprobe(struct uprobe *uprobe)
>  	put_uprobe(uprobe);
>  }
>  
> -struct uprobe_map_info {
> -	struct uprobe_map_info *next;
> -	struct mm_struct *mm;
> -	unsigned long vaddr;
> -};
> -
> -static inline struct uprobe_map_info *
> -uprobe_free_map_info(struct uprobe_map_info *info)
> +struct uprobe_map_info *uprobe_free_map_info(struct uprobe_map_info *info)
>  {
>  	struct uprobe_map_info *next = info->next;
>  	kfree(info);
>  	return next;
>  }
>  
> -static struct uprobe_map_info *
> -uprobe_build_map_info(struct address_space *mapping, loff_t offset,
> -		      bool is_register)
> +struct uprobe_map_info *uprobe_build_map_info(struct address_space *mapping,
> +					      loff_t offset, bool is_register)
>  {
>  	unsigned long pgoff = offset >> PAGE_SHIFT;
>  	struct vm_area_struct *vma;
> -- 
> 1.8.3.1
> 
