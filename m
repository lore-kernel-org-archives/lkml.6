Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-290911-1526476573-2-9336780818794547383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526476572; b=ZRxo2xv8dnN53SEvC9BLNh3fkq8FsEaaCPZ7iBf39qtVNQq3x0
    Ua1hlMMqHGWZVU1fZbz99fLtGy1ZD+RMO1QJ/6Ucf7oooilBI8P+UEgs7D2Hfqdm
    I5c91vaRNcya224QFnXril1kJQ++0vhojrLxqy/8rC41AzXHOM855VRUjIG7Pr6W
    QasiiVQ4mzxiimBaV/ygXRX3Dffsc8mLw6QHfJfU1AyFWKZVMKGlN1hvWaLJqG8s
    cIZ3VPg0mybgjkAHUiZOjSYn3oHVsaB87Ez+lOXWYHID6REYkF8ghJ4Dy8eCpgU/
    SVUwiItBIqy8Y+Byqo5ZFFY0+BNyr/b4/8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526476572; bh=+UmB5
    g0Pa35OitGw/wEQtdGn6ppNAXlZGvRPwHxQlvc=; b=lrFuTdfVEBkpaJnpUx59d
    zNEZEVb5SHSTIT4nJKLtP7axwTq4E8Ru38Huqf10BJCWEPjm0XMQ2huzsnEtbI98
    +XGGHi+F+VJ24kdWoADOtjdrrNuHtXVtwsKU0e4U6/Ibn5EFNxdhkSvjghHeeLxr
    qaDG5xMsc8QA28Wah6neEy3wRa6KTpngZPyhOIa1lMigrDZmxqZJ8VIHv11pyWKI
    W/wryqmJrINMAvKQEv82+m70Gjkz5SztRS/awtsVctSVezzfAn0Vg2hoIkxqKoZL
    T3GqkjlbmvD4hT2A5lbIjmqLDAZN4ao4c8uPlZOJROquxs0i34234hjSd292jVO2
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=h2IVWlTy x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=h2IVWlTy x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEM1UMxJF0OwyIFDjvWYPT1x5OTZskj+5vmO8B5sQRNQXkkUOrHmAnzQPHufJfSOiBEuVGpQ1kTfUemOFU9gU7JSN+ERLz+c+CVH4/C2Cucnzjgm1+CU
    RzdmPxkZErjOYwpKdONxRl8DKUWe8BuU7aIi7HOqn1v7U4o2K2HswBDalg2e3EkjJH1RFILYPrgQd/sqxMJUgKCLd4rPsX+6/Yj7D2Yx3G/omZjFticuKicQ
    JQaDGoHUXvgYJRJkkBYBhw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8
    a=pYWe2m9xEu1p8991BPAA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [Jfs-discussion] [PATCH 25/42] jfs: simplify procfs code
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <20180516094346.20506-1-hch@lst.de>
 <20180516094346.20506-26-hch@lst.de>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <6e2593f4-6456-7a43-4af5-f3fdd9e78ab7@oracle.com>
Date: Wed, 16 May 2018 08:15:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516094346.20506-26-hch@lst.de>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160136
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
 linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 linux-ide@vger.kernel.org, netfilter-devel@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com, netdev@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/16/2018 04:43 AM, Christoph Hellwig wrote:
> Use remove_proc_subtree to remove the whole subtree on cleanup, and
> unwind the registration loop into individual calls.  Switch to use
> proc_create_seq where applicable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by:  Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>  fs/jfs/jfs_debug.c    | 43 ++++++++++++++-----------------------------
>  fs/jfs/jfs_debug.h    | 10 +++++-----
>  fs/jfs/jfs_logmgr.c   | 14 +-------------
>  fs/jfs/jfs_metapage.c | 14 +-------------
>  fs/jfs/jfs_txnmgr.c   | 28 ++--------------------------
>  fs/jfs/jfs_xtree.c    | 14 +-------------
>  6 files changed, 24 insertions(+), 99 deletions(-)
> 
> diff --git a/fs/jfs/jfs_debug.c b/fs/jfs/jfs_debug.c
> index a70907606025..35a5b2a81ae0 100644
> --- a/fs/jfs/jfs_debug.c
> +++ b/fs/jfs/jfs_debug.c
> @@ -29,7 +29,6 @@
>  
>  #ifdef PROC_FS_JFS /* see jfs_debug.h */
>  
> -static struct proc_dir_entry *base;
>  #ifdef CONFIG_JFS_DEBUG
>  static int jfs_loglevel_proc_show(struct seq_file *m, void *v)
>  {
> @@ -66,43 +65,29 @@ static const struct file_operations jfs_loglevel_proc_fops = {
>  };
>  #endif
>  
> -static struct {
> -	const char	*name;
> -	const struct file_operations *proc_fops;
> -} Entries[] = {
> -#ifdef CONFIG_JFS_STATISTICS
> -	{ "lmstats",	&jfs_lmstats_proc_fops, },
> -	{ "txstats",	&jfs_txstats_proc_fops, },
> -	{ "xtstat",	&jfs_xtstat_proc_fops, },
> -	{ "mpstat",	&jfs_mpstat_proc_fops, },
> -#endif
> -#ifdef CONFIG_JFS_DEBUG
> -	{ "TxAnchor",	&jfs_txanchor_proc_fops, },
> -	{ "loglevel",	&jfs_loglevel_proc_fops }
> -#endif
> -};
> -#define NPROCENT	ARRAY_SIZE(Entries)
> -
>  void jfs_proc_init(void)
>  {
> -	int i;
> +	struct proc_dir_entry *base;
>  
> -	if (!(base = proc_mkdir("fs/jfs", NULL)))
> +	base = proc_mkdir("fs/jfs", NULL);
> +	if (!base)
>  		return;
>  
> -	for (i = 0; i < NPROCENT; i++)
> -		proc_create(Entries[i].name, 0, base, Entries[i].proc_fops);
> +#ifdef CONFIG_JFS_STATISTICS
> +	proc_create_single("lmstats", 0, base, jfs_lmstats_proc_show);
> +	proc_create_single("txstats", 0, base, jfs_txstats_proc_show);
> +	proc_create_single("xtstat", 0, base, jfs_xtstat_proc_show);
> +	proc_create_single("mpstat", 0, base, jfs_mpstat_proc_show);
> +#endif
> +#ifdef CONFIG_JFS_DEBUG
> +	proc_create_single("TxAnchor", 0, base, jfs_txanchor_proc_show);
> +	proc_create("loglevel", 0, base, &jfs_loglevel_proc_fops);
> +#endif
>  }
>  
>  void jfs_proc_clean(void)
>  {
> -	int i;
> -
> -	if (base) {
> -		for (i = 0; i < NPROCENT; i++)
> -			remove_proc_entry(Entries[i].name, base);
> -		remove_proc_entry("fs/jfs", NULL);
> -	}
> +	remove_proc_subtree("fs/jfs", NULL);
>  }
>  
>  #endif /* PROC_FS_JFS */
> diff --git a/fs/jfs/jfs_debug.h b/fs/jfs/jfs_debug.h
> index eafd1300a00b..0d9e35da8462 100644
> --- a/fs/jfs/jfs_debug.h
> +++ b/fs/jfs/jfs_debug.h
> @@ -62,7 +62,7 @@ extern void jfs_proc_clean(void);
>  
>  extern int jfsloglevel;
>  
> -extern const struct file_operations jfs_txanchor_proc_fops;
> +int jfs_txanchor_proc_show(struct seq_file *m, void *v);
>  
>  /* information message: e.g., configuration, major event */
>  #define jfs_info(fmt, arg...) do {			\
> @@ -105,10 +105,10 @@ extern const struct file_operations jfs_txanchor_proc_fops;
>   *	----------
>   */
>  #ifdef	CONFIG_JFS_STATISTICS
> -extern const struct file_operations jfs_lmstats_proc_fops;
> -extern const struct file_operations jfs_txstats_proc_fops;
> -extern const struct file_operations jfs_mpstat_proc_fops;
> -extern const struct file_operations jfs_xtstat_proc_fops;
> +int jfs_lmstats_proc_show(struct seq_file *m, void *v);
> +int jfs_txstats_proc_show(struct seq_file *m, void *v);
> +int jfs_mpstat_proc_show(struct seq_file *m, void *v);
> +int jfs_xtstat_proc_show(struct seq_file *m, void *v);
>  
>  #define	INCREMENT(x)		((x)++)
>  #define	DECREMENT(x)		((x)--)
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 0e5d412c0b01..6b68df395892 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -2493,7 +2493,7 @@ int lmLogFormat(struct jfs_log *log, s64 logAddress, int logSize)
>  }
>  
>  #ifdef CONFIG_JFS_STATISTICS
> -static int jfs_lmstats_proc_show(struct seq_file *m, void *v)
> +int jfs_lmstats_proc_show(struct seq_file *m, void *v)
>  {
>  	seq_printf(m,
>  		       "JFS Logmgr stats\n"
> @@ -2510,16 +2510,4 @@ static int jfs_lmstats_proc_show(struct seq_file *m, void *v)
>  		       lmStat.partial_page);
>  	return 0;
>  }
> -
> -static int jfs_lmstats_proc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, jfs_lmstats_proc_show, NULL);
> -}
> -
> -const struct file_operations jfs_lmstats_proc_fops = {
> -	.open		= jfs_lmstats_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
>  #endif /* CONFIG_JFS_STATISTICS */
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index 1a3b0cc22ad3..fa2c6824c7f2 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -815,7 +815,7 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
>  }
>  
>  #ifdef CONFIG_JFS_STATISTICS
> -static int jfs_mpstat_proc_show(struct seq_file *m, void *v)
> +int jfs_mpstat_proc_show(struct seq_file *m, void *v)
>  {
>  	seq_printf(m,
>  		       "JFS Metapage statistics\n"
> @@ -828,16 +828,4 @@ static int jfs_mpstat_proc_show(struct seq_file *m, void *v)
>  		       mpStat.lockwait);
>  	return 0;
>  }
> -
> -static int jfs_mpstat_proc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, jfs_mpstat_proc_show, NULL);
> -}
> -
> -const struct file_operations jfs_mpstat_proc_fops = {
> -	.open		= jfs_mpstat_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
>  #endif
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index 4d973524c887..a5663cb621d8 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -2998,7 +2998,7 @@ int jfs_sync(void *arg)
>  }
>  
>  #if defined(CONFIG_PROC_FS) && defined(CONFIG_JFS_DEBUG)
> -static int jfs_txanchor_proc_show(struct seq_file *m, void *v)
> +int jfs_txanchor_proc_show(struct seq_file *m, void *v)
>  {
>  	char *freewait;
>  	char *freelockwait;
> @@ -3032,22 +3032,10 @@ static int jfs_txanchor_proc_show(struct seq_file *m, void *v)
>  		       list_empty(&TxAnchor.unlock_queue) ? "" : "not ");
>  	return 0;
>  }
> -
> -static int jfs_txanchor_proc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, jfs_txanchor_proc_show, NULL);
> -}
> -
> -const struct file_operations jfs_txanchor_proc_fops = {
> -	.open		= jfs_txanchor_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
>  #endif
>  
>  #if defined(CONFIG_PROC_FS) && defined(CONFIG_JFS_STATISTICS)
> -static int jfs_txstats_proc_show(struct seq_file *m, void *v)
> +int jfs_txstats_proc_show(struct seq_file *m, void *v)
>  {
>  	seq_printf(m,
>  		       "JFS TxStats\n"
> @@ -3072,16 +3060,4 @@ static int jfs_txstats_proc_show(struct seq_file *m, void *v)
>  		       TxStat.txLockAlloc_freelock);
>  	return 0;
>  }
> -
> -static int jfs_txstats_proc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, jfs_txstats_proc_show, NULL);
> -}
> -
> -const struct file_operations jfs_txstats_proc_fops = {
> -	.open		= jfs_txstats_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
>  #endif
> diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
> index 5cde6d2fcfca..2c200b5256a6 100644
> --- a/fs/jfs/jfs_xtree.c
> +++ b/fs/jfs/jfs_xtree.c
> @@ -3874,7 +3874,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
>  }
>  
>  #ifdef CONFIG_JFS_STATISTICS
> -static int jfs_xtstat_proc_show(struct seq_file *m, void *v)
> +int jfs_xtstat_proc_show(struct seq_file *m, void *v)
>  {
>  	seq_printf(m,
>  		       "JFS Xtree statistics\n"
> @@ -3887,16 +3887,4 @@ static int jfs_xtstat_proc_show(struct seq_file *m, void *v)
>  		       xtStat.split);
>  	return 0;
>  }
> -
> -static int jfs_xtstat_proc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, jfs_xtstat_proc_show, NULL);
> -}
> -
> -const struct file_operations jfs_xtstat_proc_fops = {
> -	.open		= jfs_xtstat_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
>  #endif
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
