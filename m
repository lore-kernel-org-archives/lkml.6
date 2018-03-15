Return-Path: <SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AG47ELuFnd3yJgbEnzaaIeajf2fN/9LHaFlLtOwEeZBu79KWA9yIzl+EZKlwkirQbhAXciB1snHv
ARC-Seal: i=1; a=rsa-sha256; t=1521132294; cv=none;
        d=google.com; s=arc-20160816;
        b=S4LaiqCZPVLjXeuJ320fdDO94W8BcptaEnJXg+H+jnuIjQUcEMdrFWWj5nbq+lSTwZ
         /SEqrW0KCdKbZVRQi6yfd1c1R9RzefawFGsq0ct/89AdU1E29dlMpyhESR7KV+eh9Fg8
         2JBAXc6mUSOOo3lSw8fb4XFZI2NdzGCLpMJi32RVp8k3sZ1g10Xm0KxgixBr0fACFW18
         +IBRTPaIHjobu8HUq43HIa9T5oALhpR/XST9LUPL7Oji+aox1PgUMIMqm+hSqbqPPikL
         i6Qsp2T+M5Zr5PUNbR2R5zfjSOJ4gyHnOM68PAjcvHvxKcakfw1GGVajoJqTJSrtRPd9
         nVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=irUzNzyTwelT9JS4LWfhHG8DnVdAuEK4MBEWNDWQVUE=;
        b=X/chEv0QOUuY/5bKaIPfLiEEyrP9CcUWmwavqJa+PGHHAAmgNegSQXZIPETbT9lGq2
         foWJx70FIW/xxTXQII6vXXFpI8+wXQNcdqGS3qhXnqlz4M4QUrc6CJHShTFEuYF0Rtvc
         StBsnuKlvJYlFCFuNevyP+ex53AChtxfpKI6HXBHt/mbaHVD67Phm6SCwGgxZLocfJgz
         ciccAtLZj9D5fS65QKt65R/V7U2brrSLFvtuFVHJc/aY3d06/dJahZehta3z5Ohucv0a
         XEUJ7Z1b3IgFN7zF+jkLlmY6n5XmHZu5nB5yWSJWzyAbAxg/gvcYyRlz/5PElsI4ZZS2
         eGXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2C420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Mar 2018 12:44:49 -0400
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
Subject: Re: [PATCH 3/8] Uprobe: Rename map_info to uprobe_map_info
Message-ID: <20180315124449.7d92c06b@vmware.local.home>
In-Reply-To: <20180313125603.19819-4-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-4-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827147158689995?=
X-GMAIL-MSGID: =?utf-8?q?1595022816553879060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 18:25:58 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
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

Also, as these functions have side effects (like you need to perform a
mmput(info->mm), you need to add kerneldoc type comments to these
functions, explaining how to use them.

When you upgrade a function from static to use cases outside the file,
it requires documenting that function for future users.

-- Steve


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
