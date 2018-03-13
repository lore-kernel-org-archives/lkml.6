Return-Path: <jglisse@redhat.com>
X-Google-Smtp-Source: AG47ELsPw/q3d8ufrlvklof0kAV6GvEDRzniRqiWkD0KiVkqFDmjpR3CqjNhFlkHWtdTQoGZkvX/
ARC-Seal: i=1; a=rsa-sha256; t=1520973594; cv=none;
        d=google.com; s=arc-20160816;
        b=R91b6tp6rr/1Y2wAevfRjsz6UbCdBVq1XZ5daveAS0xA67pDUoIbah+WvrUOm49uzp
         /y8sEy3z3IfJRVRh1rln9N+aCAXzuANaJDzSKIebYvldcj8WsD4Z7ORTgpegHwvUugIV
         2fTHYCmrKwaC7p6/u7LdzxQqY/S/ZrvKV0NN7erl6aSf0t2OHRqHLMvXIJkxWuU+vqRM
         a97+aOX1sL8eL7jJXNNTZagIXcV+FS4svbYhbV/ARtiUn6dGYqSGQf6k6hWVLPxg8msF
         /NfEItpujkvi9ae7PzCI5ptGp4iEa9UtlIH9J62iDEHjEjJA2QgknFi89Mn6kcQwbEHV
         H+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=4MgTano73Vkvdif8eacjc3Od2Lw+Jg4WN6BbC9Sa/14=;
        b=GltgcPrffe1VqiVAyhq9iOqnZKA7P7qCDZ/z/t1yvTyF6OvI+QhweT80SxYU/XxTyS
         NCITvZLiaDsu3l1lmClFjCQeh+AyqZ7I24ooVaUjMPGi718X8xnCJvMe81b2yJ+7G1i7
         GO91toBB5uYPguv60Xg/NVc+bZbE4HBCOsykiZCbaZLcotmHzVWATgPBw20pICBJOZKG
         brWTHBbpsITvboOL+150wIFcejYcCq8+9Pmg9+cKZtXuCG0Z4rvPB/GifFn9O6aQK2Mu
         0fUNObDD/hn5pb6OBvwft9tpxSaVmrCrK6q6fCXletRcJU6UqEDd3SyxgGhkXiL3e+bp
         ANQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 13 Mar 2018 16:39:49 -0400
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
Subject: Re: [PATCH 3/8] Uprobe: Rename map_info to uprobe_map_info
Message-ID: <20180313203949.GI3828@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-4-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180313125603.19819-4-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827147158689995?=
X-GMAIL-MSGID: =?utf-8?q?1594856408108211662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:25:58PM +0530, Ravi Bangoria wrote:
> map_info is very generic name, rename it to uprobe_map_info.
> Renaming will help to export this structure outside of the
> file.
> 
> Also rename free_map_info() to uprobe_free_map_info() and
> build_map_info() to uprobe_build_map_info().
> 
> No functionality changes.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Same coccinelle comments as previously.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  kernel/events/uprobes.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 535fd39..081b88c1 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -695,27 +695,29 @@ static void delete_uprobe(struct uprobe *uprobe)
>  	put_uprobe(uprobe);
>  }
>  
> -struct map_info {
> -	struct map_info *next;
> +struct uprobe_map_info {
> +	struct uprobe_map_info *next;
>  	struct mm_struct *mm;
>  	unsigned long vaddr;
>  };
>  
> -static inline struct map_info *free_map_info(struct map_info *info)
> +static inline struct uprobe_map_info *
> +uprobe_free_map_info(struct uprobe_map_info *info)
>  {
> -	struct map_info *next = info->next;
> +	struct uprobe_map_info *next = info->next;
>  	kfree(info);
>  	return next;
>  }
>  
> -static struct map_info *
> -build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
> +static struct uprobe_map_info *
> +uprobe_build_map_info(struct address_space *mapping, loff_t offset,
> +		      bool is_register)
>  {
>  	unsigned long pgoff = offset >> PAGE_SHIFT;
>  	struct vm_area_struct *vma;
> -	struct map_info *curr = NULL;
> -	struct map_info *prev = NULL;
> -	struct map_info *info;
> +	struct uprobe_map_info *curr = NULL;
> +	struct uprobe_map_info *prev = NULL;
> +	struct uprobe_map_info *info;
>  	int more = 0;
>  
>   again:
> @@ -729,7 +731,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
>  			 * Needs GFP_NOWAIT to avoid i_mmap_rwsem recursion through
>  			 * reclaim. This is optimistic, no harm done if it fails.
>  			 */
> -			prev = kmalloc(sizeof(struct map_info),
> +			prev = kmalloc(sizeof(struct uprobe_map_info),
>  					GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
>  			if (prev)
>  				prev->next = NULL;
> @@ -762,7 +764,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
>  	}
>  
>  	do {
> -		info = kmalloc(sizeof(struct map_info), GFP_KERNEL);
> +		info = kmalloc(sizeof(struct uprobe_map_info), GFP_KERNEL);
>  		if (!info) {
>  			curr = ERR_PTR(-ENOMEM);
>  			goto out;
> @@ -774,7 +776,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
>  	goto again;
>   out:
>  	while (prev)
> -		prev = free_map_info(prev);
> +		prev = uprobe_free_map_info(prev);
>  	return curr;
>  }
>  
> @@ -782,11 +784,11 @@ static inline struct map_info *free_map_info(struct map_info *info)
>  register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  {
>  	bool is_register = !!new;
> -	struct map_info *info;
> +	struct uprobe_map_info *info;
>  	int err = 0;
>  
>  	percpu_down_write(&dup_mmap_sem);
> -	info = build_map_info(uprobe->inode->i_mapping,
> +	info = uprobe_build_map_info(uprobe->inode->i_mapping,
>  					uprobe->offset, is_register);
>  	if (IS_ERR(info)) {
>  		err = PTR_ERR(info);
> @@ -825,7 +827,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
>  		up_write(&mm->mmap_sem);
>   free:
>  		mmput(mm);
> -		info = free_map_info(info);
> +		info = uprobe_free_map_info(info);
>  	}
>   out:
>  	percpu_up_write(&dup_mmap_sem);
> -- 
> 1.8.3.1
> 
