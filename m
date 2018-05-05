Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1754801-1525525805-2-7613203213566533506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525525804; b=NcNxCYezkYhgyNxSse2o3cWG/nQw96fH6QBiwPz46J34QDX9Q7
    B/u+Qex5ta1YwUHdd8nN0/p4ZPRVG2VPMzBFCs0exSkalg5n5Rj6xSor0MsLPAZL
    V3c5bDGCwex4V5dngMaDzqxr4kfVd+tEUNqymwci/f4RKxvf0y0/tZq4pO4ECH5K
    6BD2kt5NNbze0rrIS9V4mXg+19fLCvsU7U3nw4/6mDeSB8uFsgaWL69ZtNFB/+Q0
    UvEQRJGs7JqoZa+ayF7uyr7Ju2NuX6ce91idTdb8+qZHHeCoSKFSd5cPP6RHopm0
    Ply2O67ISsQYTG7ZuNCN/HXgjLxk0i9PbXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:references:date:in-reply-to
    :message-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525525804; bh=lKR9c
    vKd8gz+vHTuL5RDO+0ecb+iTaMaBan48KEFtAw=; b=Dz+CEw23WcS5xN6QCmlcB
    mzzYIXNpuPKlmSjgN5Bppk+/Zps7jCogzwxnPyJIigz9urDU8LahZlpSWuJEbsRT
    4N7NrxMUCI2JumMqTGBktJFO0imF3ERKDryd/FOCUjok0J7FkmPffYDg3YKPyeGn
    lbaoqsWnWKQ9bFt2c1VEZIuamGJmHAwX8C7wpgy+/WWzlhvqLkBIK479S6Q3pztU
    zn09B+RskLDt2Gg3INbFKY7DDmBoFyF9HhYbntGH0idaHPHmy9ush4XFXRJhPawL
    Lw35FKUvN0LXVi9QJ4i6L2lO26S4YEo39tbmwDiEYYP20E8mq8zYJLzJE9t+i/9b
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBIYkOwmlIpzEd/aIlSpn0NwXOdDcKy6eWlxg/lBAVvP71FREQG6ftKAEE+V109GiX353WBreSrcSv4kWtCxALgBPyfS+wRND87eqoBgpcwHbwiH3gCm
    kt09PuNOX8Ocb3EGvP1pyu2amENi6a8Na4LReCj4BbDI6yRg6MlMwEagadphqZ99K24aEi2sUWqKOXQn46xCji0PpCC4ZqYJ57IBmO9EKf0Rxf8hF406/+6G
    L8tBvem8ZTwxexabcK1RcQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=PtDNVHqPAAAA:8 a=DDOyTI_5AAAA:8
    a=36_O_tthXsfO_YNdzxUA:9 a=CjuIK1q_8ugA:10 a=BpimnaHY1jUKGyF_4-AF:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-39-hch@lst.de>
Date: Sat, 05 May 2018 08:09:42 -0500
In-Reply-To: <20180425154827.32251-39-hch@lst.de> (Christoph Hellwig's message
 of "Wed, 25 Apr 2018 17:48:25 +0200")
Message-ID: <87efiq2qqx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1fEwwh-0003mQ-Mg; ; ; mid=<87efiq2qqx.fsf@xmission.com>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=97.119.174.25; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX19dYC5kP696+G8UEjFW7tUYudR+maBogWQ=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: *;Christoph Hellwig <hch@lst.de>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 284 ms - load_scoreonly_sql: 0.06 (0.0%),
 signal_user_changed: 3.4 (1.2%), b_tie_ro: 2.4 (0.8%), parse: 1.63 (0.6%),
 extract_message_metadata: 22 (7.8%), get_uri_detail_list: 3.0 (1.1%),
 tests_pri_-1000: 13 (4.6%), tests_pri_-950: 1.79 (0.6%), tests_pri_-900: 1.46
 (0.5%), tests_pri_-400: 31 (11.0%), check_bayes: 30 (10.5%), b_tokenize: 13
 (4.5%), b_tok_get_all: 8 (2.7%), b_comp_prob: 3.1 (1.1%), b_tok_touch_all:
 4.1 (1.5%), b_finish: 0.72 (0.3%), tests_pri_0: 199 (69.9%),
 check_dkim_signature: 0.66 (0.2%), check_dkim_adsp: 3.7 (1.3%),
 tests_pri_500: 6 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 38/40] ide: remove ide_driver_proc_write
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> The driver proc file hasn't been writeable for a long time, so this is
> just dead code.

It is possible to chmod this file to get at the write method.  Not that
I think anyone does.

It looks like this code was merged in 2.3.99-pre1 with permissions
S_IFREG|S_IRUGO so I don't think the write support was ever finished.

That cap_capable in the write method looks down right scary/buggy.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric



>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ide/ide-proc.c | 46 ------------------------------------------
>  1 file changed, 46 deletions(-)
>
> diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
> index 863db44c7916..b3b8b8822d6a 100644
> --- a/drivers/ide/ide-proc.c
> +++ b/drivers/ide/ide-proc.c
> @@ -528,58 +528,12 @@ static int ide_driver_proc_open(struct inode *inode, struct file *file)
>  	return single_open(file, ide_driver_proc_show, PDE_DATA(inode));
>  }
>  
> -static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
> -{
> -	struct device *dev = &drive->gendev;
> -	int ret = 1;
> -	int err;
> -
> -	device_release_driver(dev);
> -	/* FIXME: device can still be in use by previous driver */
> -	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
> -	err = device_attach(dev);
> -	if (err < 0)
> -		printk(KERN_WARNING "IDE: %s: device_attach error: %d\n",
> -			__func__, err);
> -	drive->driver_req[0] = 0;
> -	if (dev->driver == NULL) {
> -		err = device_attach(dev);
> -		if (err < 0)
> -			printk(KERN_WARNING
> -				"IDE: %s: device_attach(2) error: %d\n",
> -				__func__, err);
> -	}
> -	if (dev->driver && !strcmp(dev->driver->name, driver))
> -		ret = 0;
> -
> -	return ret;
> -}
> -
> -static ssize_t ide_driver_proc_write(struct file *file, const char __user *buffer,
> -				     size_t count, loff_t *pos)
> -{
> -	ide_drive_t	*drive = PDE_DATA(file_inode(file));
> -	char name[32];
> -
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -	if (count > 31)
> -		count = 31;
> -	if (copy_from_user(name, buffer, count))
> -		return -EFAULT;
> -	name[count] = '\0';
> -	if (ide_replace_subdriver(drive, name))
> -		return -EINVAL;
> -	return count;
> -}
> -
>  static const struct file_operations ide_driver_proc_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= ide_driver_proc_open,
>  	.read		= seq_read,
>  	.llseek		= seq_lseek,
>  	.release	= single_release,
> -	.write		= ide_driver_proc_write,
>  };
>  
>  static int ide_media_proc_show(struct seq_file *m, void *v)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
