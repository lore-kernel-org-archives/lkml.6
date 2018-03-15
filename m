Return-Path: <SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AG47ELssCylrQ/Lgh8Svvfa1bTpfm5a7R3rqetTdnM0gkbqxbe4zcmijP6dSe3c9DFlUhBQf5rZe
ARC-Seal: i=1; a=rsa-sha256; t=1521132501; cv=none;
        d=google.com; s=arc-20160816;
        b=qIDbHiM94JXcY+Bz2AXOfrlKABKBEUI+YWyhIc6UbEZorOrtQv9gqMS4//wbm3wVEj
         dZLKD4BtiIP65HWg8x+yNEpVOOUUEZJTQ5Tai60HUFnuoQdRfC6fbNAMJYnNQAQ77yfo
         47SFH8jmX11jAug2roVwXvKZ6zxxc4TKBscMVbaVFLxzkbWATRS3F17rEDnrLKR6zGeX
         c4BektnPVKakcJJjRFNKpFkZ/kzJqs3cDU/oCxD6DchRpdMJ06Rndaxin5nk0hMP1afG
         8VEbYn9IdG5fm/347y2xrQpbQxHQr/Ze5B5dAjzN+OEG+ngwQs7xX/yTSvfAkelp/HFE
         UArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=PLGYm2vh8lfmGqTtajBRs06y4nL9ptVFBAhhb5iecU0=;
        b=ZHenMREnrX3iTYmikQ3cbmyzbzCLDu8dTxSljr2uXg89bPPnnIJ/IVjV4J+OGWiYus
         BJhoL6snial2LueKaZkYlCldjIzzEvrXiRSFxsM7YhsnLic7UeL2VVzA6Ayk5niPJbxy
         /B0LIihiHKMd66yelMI7iq3Hqp2FAoufP5YHnIH0SKss0F/PTJ6gxWVRaqpnzzLuq/Xt
         r8TTz9CkfUwo6YqZCpwM+stbQ8Hft/fDuJFCrIbVSaSn65JIQKYpY8Ff9nxwT3ECoiuj
         bkj9lVOpMVjY4fq7bzfHT5bM2J+wXLJOlYmUNYB0w1rQhZXtZmjBHkZtUieoSoN2l0lS
         H5tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ddtq=gf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ddTQ=GF=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C9420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Mar 2018 12:48:16 -0400
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
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180315124816.6aa3d4e2@vmware.local.home>
In-Reply-To: <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595023033727215189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 18:26:00 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> +static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
> +{
> +	struct uprobe_map_info *info;
> +	struct vm_area_struct *vma;
> +	unsigned long vaddr;
> +
> +	uprobe_start_dup_mmap();

Please add a comment here that this function ups the mm ref count for
each info returned. Otherwise it's hard to know what that mmput() below
matches.

-- Steve

> +	info = uprobe_build_map_info(tu->inode->i_mapping,
> +				tu->ref_ctr_offset, false);
> +	if (IS_ERR(info))
> +		goto out;
> +
> +	while (info) {
> +		down_write(&info->mm->mmap_sem);
> +
> +		vma = sdt_find_vma(info->mm, tu);
> +		vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
> +		sdt_update_ref_ctr(info->mm, vaddr, 1);
> +
> +		up_write(&info->mm->mmap_sem);
> +		mmput(info->mm);
> +		info = uprobe_free_map_info(info);
> +	}
> +
> +out:
> +	uprobe_end_dup_mmap();
> +}
> +
