Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655684-2-6638818609309366098
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655683; b=GmMWnm6R7tHtnel1vS5u5tCm419gLUYGtqMpFzu8qwT1wLhQ1P
    9/49AAP6MZHdJVGNDxblkHmFZiSCq59+AfUuTuEXgWt8ezqIwCSCer9BDPEPeMj9
    syfk0M1sbWlR/NmRdydmSOmVUa0RN1nJxxcZ5ttQdbfq5dcG6AQLoZeF7CJVueFi
    +nDsD/xsxBuNTshpaF4Zl3Qzy1git0XNZXma43uFn3fWKoc7620AYXyEcaIOeDdd
    6Ii9ku3BK6uSGCoSxYnbBKgu3zz3XtsLgfyjd7MzQD1tmRjLNcnuTRj54Do7RyNh
    +4tG2ZoNhPziflyDk8t9TDPwLVo83n8fcAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655683; bh=F7DJl
    bgohEXiJKkP3KochKecLcp/H7pV1B1Vf6VCMLQ=; b=kfdkMfYuNmk1vZFHdwDm1
    iQV+oNE56JMGpZYwScSbdd4ZFzJSCWk7XzCbvcQfCztvJmOCidk+S1zYOJkVi9+g
    hp3F5id63KdoKD7ml5y7Pwyw+AJtV8qfMCw9Xm8RrgXN0AnebbzlFf+WcIjk+TUz
    DUQ6e+8CLi8WvuhMzd/pPDVl1dUAcQ2P/97ofrAP84VBAi5pvx1N6lJ5vyCuuCaY
    aWcJrn6AKA5WN5iGpHNozESbVn8FGRCIjbYVxEeU1eDKqwjAt5IqlrnczK2j5vjP
    xevN3jdk6kjFB4euA3bGFEj5VIBlRiNFQsak4fo3blS2KFBphpa32Q7q5/7LgyCy
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfKi8qduPrKYT7ol2XZMO2bzy0rJ0YPfBgO0dzGKNXZOPH9WXBp8QTk6TvYkMB2u6fOJXsYdTIxaGZGKtR+Zi2gvnsna8/y24jlPDzxNLuTIHz4GCU5bo
    luXn3l6SWvXApgVQXqwwmdrSnJLBrwIuYx9u9OO8tjA9B2XAHbfLAq4Fanpc38avXz1UqzUhEs+5QNzhWZWz7eYAUax0VQxN4A67sr9/1Pc3w6sGjW8k7nK4
    YEUOUkY47QJ6l1M7rLDzZw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=XlBROPzbXkfQguRk6UYA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 7 May 2018 09:14:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180507011429.GG30581@MiWiFi-R3L-srv>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
 <20180426011837.GA79340@WeideMacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180426011837.GA79340@WeideMacBook-Pro.local>
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
 devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>, dan.j.williams@intel.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, josh@joshtriplett.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, robh+dt@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Wei Yang,

On 04/26/18 at 09:18am, Wei Yang wrote:
> On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
> >The struct resource uses singly linked list to link siblings. It's not
> >easy to do reverse iteration on sibling list. So replace it with list_head.
> >
> 
> Hi, Baoquan
> 
> Besides changing the data structure, I have another proposal to do the reverse
> iteration. Which means it would not affect other users, if you just want a
> reverse iteration.
> 
> BTW, I don't think Andrew suggest to use linked-list directly. What he wants
> is a better solution to your first proposal in
> https://patchwork.kernel.org/patch/10300819/.
> 
> Below is my proposal of resource reverse iteration without changing current
> design.

I got your mail and read it, then interrupted by other thing and forgot
replying, sorry.

I am fine with your code change. As I said before, I have tried to change
code per reviewers' comment, then let reviewers decide which way is
better. Please feel free to post formal patches and joining discussion
about this issue.

Thanks
Baoquan

> 
> From 5d7145d44fe48b98572a03884fa3a3aa82e3cef9 Mon Sep 17 00:00:00 2001
> From: Wei Yang <richard.weiyang@gmail.com>
> Date: Sat, 24 Mar 2018 23:25:46 +0800
> Subject: [PATCH] kernel/resource: add walk_system_ram_res_rev()
> 
> As discussed on https://patchwork.kernel.org/patch/10300819/, this patch
> comes up with a variant implementation of walk_system_ram_res_rev(), which
> uses iteration instead of allocating array to store those resources.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  include/linux/ioport.h |   3 ++
>  kernel/resource.c      | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..473f1d9cb97e 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -277,6 +277,9 @@ extern int
>  walk_system_ram_res(u64 start, u64 end, void *arg,
>  		    int (*func)(struct resource *, void *));
>  extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +		    int (*func)(struct resource *, void *));
> +extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>  		    void *arg, int (*func)(struct resource *, void *));
>  
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 769109f20fb7..d4ec5fbc6875 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -73,6 +73,38 @@ static struct resource *next_resource(struct resource *p, bool sibling_only)
>  	return p->sibling;
>  }
>  
> +static struct resource *prev_resource(struct resource *p, bool sibling_only)
> +{
> +	struct resource *prev;
> +	if (NULL == iomem_resource.child)
> +		return NULL;
> +
> +	if (p == NULL) {
> +		prev = iomem_resource.child;
> +		while (prev->sibling)
> +			prev = prev->sibling;
> +	} else {
> +		if (p->parent->child == p) {
> +			return p->parent;
> +		}
> +
> +		for (prev = p->parent->child; prev->sibling != p;
> +			prev = prev->sibling) {}
> +	}
> +
> +	/* Caller wants to traverse through siblings only */
> +	if (sibling_only)
> +		return prev;
> +
> +	for (;prev->child;) {
> +		prev = prev->child;
> +
> +		while (prev->sibling)
> +			prev = prev->sibling;
> +	}
> +	return prev;
> +}
> +
>  static void *r_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>  	struct resource *p = v;
> @@ -401,6 +433,47 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
>  	return 0;
>  }
>  
> +/*
> + * Finds the highest iomem resource existing within [res->start.res->end).
> + * The caller must specify res->start, res->end, res->flags, and optionally
> + * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
> + * This function walks the whole tree and not just first level children until
> + * and unless first_level_children_only is true.
> + */
> +static int find_prev_iomem_res(struct resource *res, unsigned long desc,
> +			       bool first_level_children_only)
> +{
> +	struct resource *p;
> +
> +	BUG_ON(!res);
> +	BUG_ON(res->start >= res->end);
> +
> +	read_lock(&resource_lock);
> +
> +	for (p = prev_resource(NULL, first_level_children_only); p;
> +		p = prev_resource(p, first_level_children_only)) {
> +		if ((p->flags & res->flags) != res->flags)
> +			continue;
> +		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
> +			continue;
> +		if (p->end < res->start || p->child == iomem_resource.child) {
> +			p = NULL;
> +			break;
> +		}
> +		if ((p->end >= res->start) && (p->start < res->end))
> +			break;
> +	}
> +
> +	read_unlock(&resource_lock);
> +	if (!p)
> +		return -1;
> +	/* copy data */
> +	resource_clip(res, p->start, p->end);
> +	res->flags = p->flags;
> +	res->desc = p->desc;
> +	return 0;
> +}
> +
>  static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  				 bool first_level_children_only,
>  				 void *arg,
> @@ -422,6 +495,27 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  	return ret;
>  }
>  
> +static int __walk_iomem_res_rev_desc(struct resource *res, unsigned long desc,
> +				 bool first_level_children_only,
> +				 void *arg,
> +				 int (*func)(struct resource *, void *))
> +{
> +	u64 orig_start = res->start;
> +	int ret = -1;
> +
> +	while ((res->start < res->end) &&
> +	       !find_prev_iomem_res(res, desc, first_level_children_only)) {
> +		ret = (*func)(res, arg);
> +		if (ret)
> +			break;
> +
> +		res->end = res->start?(res->start - 1):0;
> +		res->start = orig_start;
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Walks through iomem resources and calls func() with matching resource
>   * ranges. This walks through whole tree and not just first level children.
> @@ -468,6 +562,25 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  				     arg, func);
>  }
>  
> +/*
> + * This function, being a variant of walk_system_ram_res(), calls the @func
> + * callback against all memory ranges of type System RAM which are marked as
> + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> + * higher to lower.
> + */
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(struct resource *, void *))
> +{
> +	struct resource res;
> +
> +	res.start = start;
> +	res.end = end;
> +	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +
> +	return __walk_iomem_res_rev_desc(&res, IORES_DESC_NONE, true,
> +				     arg, func);
> +}
> +
>  /*
>   * This function calls the @func callback against all memory ranges, which
>   * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
> -- 
> 2.15.1
> 
> 
> -- 
> Wei Yang
> Help you, Help me
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
