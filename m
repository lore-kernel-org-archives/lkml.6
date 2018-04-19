Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3818510-1524163280-3-14139712977221687079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524163280; b=KUWyLUo4uwDKRnRC4/ubh4PJn5laoM+ND45qC7QEttPz+wOahZ
    vqWndYyarrazlwRe2o+veruuh2CtIjnBTfLJRmY/YsELiMbyHcyZ35EuROtw9S8W
    eel66ABpSwEM6t4phGdi2N1yo6aGLs89YimN/3QBDHiBYyPuGmD+ijS6REllzRew
    qliXhN1+QM4OLzVQq5OJpkVmMDdhCOYs5PPCayUYlRp7g/GM/GHZiwPIjdWpujqd
    fXMuXmMkyadlIsTJx5Vtw7C1/CASRFKNnL1q8M5uLX2AgqxAIbjyYBlFTCk0pRph
    Z4C/W405VzbKzTWpr7RLotpH9c793VEChlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524163280; bh=4WYYF
    ihNZUbeVsLhJgaRX7EZ9U9tp7q942XBEMl9tAs=; b=ZPPKTUnMukJH0AgtnD67N
    SLKKFhIb8rtGyKdA3p9RNQNUQnYwX9lUubHiWkGMQ35fxw+lSczNWp/6B73sj8JY
    mVuXZPPun1D5bU5QMCp7gk4rwAVwXpvEb47OWnf7BYczzsQV93M3yHT01km2lLhr
    mrRxMcExR6kNT6uC4WuETHODQMV26XAbTit35gfxmmmDnyZczor14ocdBap1N45e
    w4X68N54zjGtXsbcBdbf34q1R45s95TYC7NEbOubemd9ibvAu5RbAmoERT7ARwRs
    aGzKw6HNBWkEUANqpBC8Z4OJFjpOz4tAropAywo9PbjnYaWSA0q35utK2ocNP3nj
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D5yVdTi6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YOkJfBBS;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=D5yVdTi6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YOkJfBBS;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDaOg6qFz1TEEgev3a9b666RdNiyK9HEnK3XOcslMN+HsmMHorb+5shgYVNkgb9lmTl8Sb7m2rO+WHGN5Ec4dVA7+WqQHlRsNNey9pP1wnG9U1W1DRRB
    j4ZL9Gfp6wZstAIrmPEphE6NXihEW7gkGg45m2YOJPEYYlA962ORCo/8/uNOBh9F3Nx5sEDOimRrMccQqB2XigE1uhykzDz4ExFtDQMjCqm3ETgmK9iQ2beQ
    +wOuuMV39vsRgIIAaNV8Gg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=qPpclGfRe28GyI7zN0sA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+7j+TebZtqDSINc39WxHkYrG12G+cXvG71NyW2hQeUeKVRqYYK2xXnJ+j65hRcWpW25pzZRg==
Date: Thu, 19 Apr 2018 21:41:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/39] proc: introduce proc_create_seq{,_data}
Message-ID: <20180419184106.GA2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:41:03PM +0200, Christoph Hellwig wrote:
> Variants of proc_create{,_data} that directly take a struct seq_operations
> argument and drastically reduces the boilerplate code in the callers.

> +static int proc_seq_open(struct inode *inode, struct file *file)
> +{
> +	struct proc_dir_entry *de = PDE(inode);
> +
> +	return seq_open(file, de->seq_ops);
> +}
> +
> +static const struct file_operations proc_seq_fops = {
> +	.open		= proc_seq_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
> +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> +		void *data)
> +{
> +	struct proc_dir_entry *p;
> +
> +	p = proc_create_data(name, mode, parent, &proc_seq_fops, data);
> +	if (p)
> +		p->seq_ops = ops;
> +	return p;
> +}

Should be oopsable.
Once proc_create_data() returns, entry is live, ->open can be called.

> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -44,6 +44,7 @@ struct proc_dir_entry {
>  	struct completion *pde_unload_completion;
>  	const struct inode_operations *proc_iops;
>  	const struct file_operations *proc_fops;
> +	const struct seq_operations *seq_ops;
>  	void *data;
>  	unsigned int low_ino;
>  	nlink_t nlink;

"struct proc_dir_entry is 192/128 bytes now.
If someone knows how to pad array to certain size without union
please tell.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
