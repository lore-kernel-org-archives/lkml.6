Return-Path: <jglisse@redhat.com>
X-Google-Smtp-Source: AG47ELux6CFhxvG2+ggaKb9KUmUN2GOzxdciM+7UDdg4XSwRrrZQ+gSN3Vd8zIOFSvxiedRr0xoP
ARC-Seal: i=1; a=rsa-sha256; t=1520973547; cv=none;
        d=google.com; s=arc-20160816;
        b=FOlXOCUPx3+/UpgMagYZkj+1jtLdTlVLMf5Zo8LYFkWFHyAF783MUp1x61PGl55scX
         EkmXyKHwlu7u0MUph1+Q0R8X02ps5Z1dkD6cisGUjIZ67xaGjKRTThSdPD34/PRiS75w
         BV4hrgUo4tW9yuVgnpPsJxBcrC2qkT/1eyi6m2f2/yXaothplgL/qSG1iYEo3y78qHXN
         LpUVoInsT+hmXF2gXPqLHfU4MDGrWBjKYGRvoVUPAz85CnUDApxPDIwLnR+wpGfhBzq3
         1rWRJwc0MtX2AcmPZSizte+pLsqaE4DHC+Wd/I5U6inn7ywgbSPLY3m9YBBG39Kipt51
         kYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=TTh1MticV3QcDnF/3ur9ke5HYnnlhPUC0+S06yLCOHM=;
        b=D2d1yBLy2QcPuqEXG74hRaJzYN7eOsCKWWlc0MahhLtXvy0tODZpp/XWlS4iOFbC17
         P/NUZNomemG7u8h7BFRzu4a9zPJyi+0m75HdpzcJ56pOFbCJQlDkJWeGN4Xya7CQhJ0U
         Jyt67Smxd2a0JF5wZ8R+RQhrJuNTZaDAhZWPq8CmVVW6jHVWFeF67d3gaWcpSjzFSGoK
         qTVwAtrxkRTHef8ARiBmqAvV0/vTKSt7iLz+MNm6F4zuxlEr0cup0jhftvLcD000BoK8
         X6fW5eMff7fEnurvjQbdSEgThcogk+B2VaPjWsRB1cKrIMUuJchGbY0h3l9DQU2EKgue
         440Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 13 Mar 2018 16:38:59 -0400
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
Subject: Re: [PATCH 2/8] mm: Prefix vma_ to vaddr_to_offset() and
 offset_to_vaddr()
Message-ID: <20180313203859.GH3828@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-3-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180313125603.19819-3-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827168615885864?=
X-GMAIL-MSGID: =?utf-8?q?1594856358699838759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:25:57PM +0530, Ravi Bangoria wrote:
> No functionality changes.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Doing this with coccinelle would have been nicer but this is small
enough to review without too much fatigue :)

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/mm.h      |  4 ++--
>  kernel/events/uprobes.c | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 95909f2..d7ee526 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2275,13 +2275,13 @@ struct vm_unmapped_area_info {
>  }
>  
>  static inline unsigned long
> -offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
> +vma_offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
>  {
>  	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
>  }
>  
>  static inline loff_t
> -vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
> +vma_vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
>  {
>  	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
>  }
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index bd6f230..535fd39 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -748,7 +748,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
>  		curr = info;
>  
>  		info->mm = vma->vm_mm;
> -		info->vaddr = offset_to_vaddr(vma, offset);
> +		info->vaddr = vma_offset_to_vaddr(vma, offset);
>  	}
>  	i_mmap_unlock_read(mapping);
>  
> @@ -807,7 +807,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
>  			goto unlock;
>  
>  		if (vma->vm_start > info->vaddr ||
> -		    vaddr_to_offset(vma, info->vaddr) != uprobe->offset)
> +		    vma_vaddr_to_offset(vma, info->vaddr) != uprobe->offset)
>  			goto unlock;
>  
>  		if (is_register) {
> @@ -977,7 +977,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  		    uprobe->offset >= offset + vma->vm_end - vma->vm_start)
>  			continue;
>  
> -		vaddr = offset_to_vaddr(vma, uprobe->offset);
> +		vaddr = vma_offset_to_vaddr(vma, uprobe->offset);
>  		err |= remove_breakpoint(uprobe, mm, vaddr);
>  	}
>  	up_read(&mm->mmap_sem);
> @@ -1023,7 +1023,7 @@ static void build_probe_list(struct inode *inode,
>  	struct uprobe *u;
>  
>  	INIT_LIST_HEAD(head);
> -	min = vaddr_to_offset(vma, start);
> +	min = vma_vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
>  	spin_lock(&uprobes_treelock);
> @@ -1076,7 +1076,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
>  		if (!fatal_signal_pending(current) &&
>  		    filter_chain(uprobe, UPROBE_FILTER_MMAP, vma->vm_mm)) {
> -			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
> +			unsigned long vaddr = vma_offset_to_vaddr(vma, uprobe->offset);
>  			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
>  		}
>  		put_uprobe(uprobe);
> @@ -1095,7 +1095,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  
>  	inode = file_inode(vma->vm_file);
>  
> -	min = vaddr_to_offset(vma, start);
> +	min = vma_vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
>  	spin_lock(&uprobes_treelock);
> @@ -1730,7 +1730,7 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
>  	if (vma && vma->vm_start <= bp_vaddr) {
>  		if (valid_vma(vma, false)) {
>  			struct inode *inode = file_inode(vma->vm_file);
> -			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
> +			loff_t offset = vma_vaddr_to_offset(vma, bp_vaddr);
>  
>  			uprobe = find_uprobe(inode, offset);
>  		}
> -- 
> 1.8.3.1
> 
