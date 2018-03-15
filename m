Return-Path: <SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AG47ELvqtP/XYAH66b1mu+ntoTZjohgGAsJw8tkNensWr2MqZvRkEaVa7/UObjUvx+v8yyPRwYnA
ARC-Seal: i=1; a=rsa-sha256; t=1521131580; cv=none;
        d=google.com; s=arc-20160816;
        b=j7Y4YrZ8BtgIhIHhDZ28f8EMCiIbCZUtB13UNRTyRZufJ6knl4M1M+xa86XXfN6+ts
         APmIJcWlrc71wEQ0Wa6TluVOa26CkkHt6q4k7FcYkbIamoEiNv7DxLmYrePzIpFxOo4f
         zxbyRAA+Ki8OvBP/bFGjBVzxbtMgXODbQdVpPDxlrky1/YnUchYr+jW3FyLw2GVzT1Sb
         3QauaLUu8BH/lIRiN8Z4UFkZuT36uqvvT6T5oT3QIVuGUw0NsxB18rvyAxsHV8bQ00CM
         4AI9pv20qd06NkBD7Dgjyw78aJRC+9eEpSeuttJBExAMQKXmhrMOzVaySNljl/acdEqP
         J6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=hVGw4AyqMQxV2Q6S23g/OTAIRXdEJV1epeYv2NjCvo8=;
        b=z30sBqm7q23bdWYtzlPiSM97bXyqkgkoMO/yLdYjlrsF322VfrdWwb7ppFIL1DMVnK
         O8cC4hQgce0y2AaSP6NCoUmvDnpCCClEIHJ6IkzKYwgrRMTGIenakjN4qBUL9dYJ24TE
         nU8C8Ff/O+DSIIFVX9+9v3QBsoHfxFx10cWsxVzLHC+gBLab/6cpPzz1b0yMpfVSomE+
         Wy5CgUdg6H01KTPeH9H0aSioZqmB21C3RUou+W3yzxZ4nxCsOdPLsvFRAMyYxTr12dLH
         nL8ZW4mYIBzkuC1lLbLsEUriTKmoFuJlqZA9oq39GbCWeFRO9FgKi1bjpaU1zfbpoR0c
         YMBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3461E204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Mar 2018 12:32:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 srikar@linux.vnet.ibm.com, acme@kernel.org, ananth@linux.vnet.ibm.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
 gregkh@linuxfoundation.org, huawei.libin@huawei.com, hughd@google.com,
 jack@suse.cz, jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
 kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
 kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
 tglx@linutronix.de, tmricht@linux.vnet.ibm.com, willy@infradead.org,
 yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 4/8] Uprobe: Export uprobe_map_info along with
 uprobe_{build/free}_map_info()
Message-ID: <20180315123255.17a8d997@vmware.local.home>
In-Reply-To: <20180313125603.19819-5-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-5-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827156987945249?=
X-GMAIL-MSGID: =?utf-8?q?1595022068030953763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 18:25:59 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> These exported data structure and functions will be used by other
> files in later patches.

I'm reluctantly OK with the above.

> 
> No functionality changes.

Please remove this line. There are functionality changes. Turning a
static inline into an exported function *is* a functionality change.

-- Steve

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
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
