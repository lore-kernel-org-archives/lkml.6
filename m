Return-Path: <jglisse@redhat.com>
X-Google-Smtp-Source: AG47ELvxYbdZ3hKa8x+YhqbzHD9Lfb+o3zlCxrOsM80gd4pzbjUpq/A0jD3PZi3QKGdGEQ+30O9Y
ARC-Seal: i=1; a=rsa-sha256; t=1520973425; cv=none;
        d=google.com; s=arc-20160816;
        b=x6gDw0w/00Laa5igxcOVdmw9uAdtzPryGFAsO9hq12qMpgSQJ3XYCTUqHpIwJkoAAh
         arig32NRa6BkXcSEuYOmQ9z3q58ePX/IxEG5VtRWqhz91qNkpr7bgE7qsUyMX5izA9cv
         gpNRhHwYy9z8O0MU11MBHLfyIB8go7t8l/Yf/HTr/3cxa9tcdSdoS/qNBcx2s4h6YKJn
         Xt929deufubernjzuKOmhotKW5Uxr7/on9FcYBZuXTqeuz2Rn/9xo3Nj5WATraGdp9lj
         ffnOQxs6KwMaeHvQHMU3K+mQZnCqZDejDY+KNxbknO0zuIXjw+mzYu9tncJszqvEQOKF
         6NcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=T2xh95kiqzQb9maceUwX4mSbBLBoEnn7SIOiBquWiMA=;
        b=bwL/91zhUJzav089cyEXAFl5U5uAKn4qfz3dBJd6Oh4TEB/ChxlA/ERDkEEZJuFW42
         kRKqwDm0GKIsP7Chx20WrsuaXXCE5j1AjuEBVzcv6PfYsAla9VTp/lEi4OVR6+ELICWE
         QdmCNK3jHXg3Hgqp1uBcFQXdnOJByqExyzWWDJJ9MXBJO7HUcxTyt5AABjazEHXvyszb
         7tTzV8Xao6Km8aUrYxlLDLbs4XFRHQKWPryg/EhRo0O4oSDloSu9c345R/Sk+1nCkqHm
         Eosv1CaH4kBj/TVTaKO5xi7hmGzlkiV6j2ZFDWqkIYlyNeeKqA9IcujHTk6IbDUq7Cqs
         qi7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 13 Mar 2018 16:36:57 -0400
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
Subject: Re: [PATCH 1/8] Uprobe: Export vaddr <-> offset conversion functions
Message-ID: <20180313203657.GG3828@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-2-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180313125603.19819-2-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827116225046806?=
X-GMAIL-MSGID: =?utf-8?q?1594856230713962077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:25:56PM +0530, Ravi Bangoria wrote:
> No functionality changes.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/mm.h      | 12 ++++++++++++
>  kernel/events/uprobes.c | 10 ----------
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad06d42..95909f2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2274,6 +2274,18 @@ struct vm_unmapped_area_info {
>  		return unmapped_area(info);
>  }
>  
> +static inline unsigned long
> +offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
> +{
> +	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> +}
> +
> +static inline loff_t
> +vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
> +{
> +	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
> +}
> +
>  /* truncate.c */
>  extern void truncate_inode_pages(struct address_space *, loff_t);
>  extern void truncate_inode_pages_range(struct address_space *,
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ce6848e..bd6f230 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -130,16 +130,6 @@ static bool valid_vma(struct vm_area_struct *vma, bool is_register)
>  	return vma->vm_file && (vma->vm_flags & flags) == VM_MAYEXEC;
>  }
>  
> -static unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
> -{
> -	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> -}
> -
> -static loff_t vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
> -{
> -	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
> -}
> -
>  /**
>   * __replace_page - replace page in vma by new page.
>   * based on replace_page in mm/ksm.c
> -- 
> 1.8.3.1
> 
