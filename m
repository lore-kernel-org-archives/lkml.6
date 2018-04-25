Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1114201-1524680758-2-15533143332661352049
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524680756; b=q////O4cmrzjXG+TfmIDvWlNghJiccUqTXxzbetRs2cSH/IihF
    u/58VMZgaALkHlD62e+t5vijsx3iibaVPlhWvSTDARfZhrFugXkiOw4exRLty5Ch
    gN3VkaEhqjbndW8AdgRogas4ijgqiTyDHco2j04ujCevLeXrC8rS415cQowDg1Zl
    szvCrKdP27Y89uy8DW8DqN6J/vDwWAxG1OG9VwoyYc6dqLDeSE3ioJaGdIhgnqN+
    NjYuwMt7pCaU0TOkGIlXrVe6E4V+6Oi9qCaP6CydNAgRz2viRqA0vsRkt8B+Ti8O
    6HKne+QqrTU1YTDtKKqgZH8mxPvvmsybe6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524680756; bh=sxMmN
    HaYmhv7E3OWmUZM2IUpvHPz3ZdSZ21mAZ4rprM=; b=WUaocVXifk7kFKTGN/Gow
    r/1UoLtYAHcXqz7R52Ru5BeYoLRyxSwcuBXDVFATzgW/oz0XJqIOBK9ReE54j4VA
    YGeC8fmpWvxd+mZHpIgzc3wVorUJH11p4m+Gqij1dW7C6q16KiMTf7Xdu5sUQv8U
    SAMcAIec1Nh8Y+AdRt26hu8dldgNb+ewkKCLKINwarHFoAF2UkzRr3ambU0cVWLI
    6fcgXV++x9eInSLviz/9Z7tHFuRIcPAD0B2vAY37iuxLTAEMSrP07hNjqpr0D3wI
    Wu98Upzy8I3qbm1Q/RW6l4rIgPARBBrPx4LirdQ+hBZIbRWZolLMqE4ScJXsxFQD
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVU/u3fxoNmdZQe9IwZP4Zhgjs1c3xci9ccVfHqS2iIy05B855sL3NFWuOxqJjzg6jTbSMfGwyXmoc9LNFf6+VzZ49cqoRJ4Ml/tQSdY0rjHzoVg1WS
    bjXDuo2qepa+gyZjlKXE8nZ3Rcl/yTmZnoPD/lME2asMm/jpSk3EUqO2npsrw0vRnkLtV+6B3WTHndd4mnn0ur67LUckQWTikUZ3KcStzmnDQhg0nQHe9BTZ
    02CXhwl88FyWysWXL8zt5Q==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=P-IC7800AAAA:8 a=DDOyTI_5AAAA:8
    a=7KAsyMi3TWwjPTD_GFoA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 25 Apr 2018 20:25:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 27/40] rtc/proc: switch to proc_create_single_data
Message-ID: <20180425182537.GG4813@piout.net>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-28-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180425154827.32251-28-hch@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
 jfs-discussion@lists.sourceforge.net, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-acpi@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, megaraidlinux.pdl@broadcom.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25/04/2018 17:48:14+0200, Christoph Hellwig wrote:
> And stop trying to get a reference on the submodule, procfs code deals
> with release after and unloaded module and thus removed proc entry.
small typo here        ^

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


> ---
>  drivers/rtc/rtc-proc.c | 33 ++-------------------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
> index 31e7e23cc5be..a9dd9218fae2 100644
> --- a/drivers/rtc/rtc-proc.c
> +++ b/drivers/rtc/rtc-proc.c
> @@ -107,40 +107,11 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
>  	return 0;
>  }
>  
> -static int rtc_proc_open(struct inode *inode, struct file *file)
> -{
> -	int ret;
> -	struct rtc_device *rtc = PDE_DATA(inode);
> -
> -	if (!try_module_get(rtc->owner))
> -		return -ENODEV;
> -
> -	ret = single_open(file, rtc_proc_show, rtc);
> -	if (ret)
> -		module_put(rtc->owner);
> -	return ret;
> -}
> -
> -static int rtc_proc_release(struct inode *inode, struct file *file)
> -{
> -	int res = single_release(inode, file);
> -	struct rtc_device *rtc = PDE_DATA(inode);
> -
> -	module_put(rtc->owner);
> -	return res;
> -}
> -
> -static const struct file_operations rtc_proc_fops = {
> -	.open		= rtc_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= rtc_proc_release,
> -};
> -
>  void rtc_proc_add_device(struct rtc_device *rtc)
>  {
>  	if (is_rtc_hctosys(rtc))
> -		proc_create_data("driver/rtc", 0, NULL, &rtc_proc_fops, rtc);
> +		proc_create_single_data("driver/rtc", 0, NULL, rtc_proc_show,
> +				rtc);
>  }
>  
>  void rtc_proc_del_device(struct rtc_device *rtc)
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
