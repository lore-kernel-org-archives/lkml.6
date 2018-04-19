Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3240820-1524147526-2-10976849091486421704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524147525; b=oV4V3pS19RPudHOmULNHnSbc/J/8C4WLmWnmscwnYQd/QRBfCX
    S9hFQlNY1eAcSmF3VtpmT17NW88XtEpPEW5nhf5dimUZTrEfNOLOc/f5w1GyQqc6
    +ju++ZY9HbUfYXybm31F2ki9fjVt1jGY6m2JlFyNPEPn5nZseBuiZjO2APZM+IcO
    Ow8CjSarkZSdRvbhGSZCSBm2xs9RbJu7fztZet6uxNA2G8BeXcWmociKHf+Mw0oo
    e3dsBIYCP5hApKCWxyL3vLDwHmXlwCiYW1Np7gGJonG2KZlrcACqBVGwevfyspi0
    h5lnPudiidoeCoCKV4uH5/4xapN//kp4oFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524147525; bh=sH4Di
    N5MVpghPK3/7vw3D90hBVAQsQoGEclSWSS3p1s=; b=vreqczAB5u9XZ8KBSYxNr
    1JjsnDMqBz2acEbImlXIZjGpucBcmSP2y0kl0k3JPPk9juLAGi4KsQzq4DKppZtR
    SFd+nH33jZjtVZiusTkMgIAcEqori2P4cWwPp8go19QbGsSx9s1mbglXwlqhqRep
    ple/Jfp6CCe9+UmcmK0/22F00LGqO8cAB7MG4km+GPbBQUdDEOm/YMzBJ9iYRr1G
    Vo5uEbgcx7tjfXPH1e15Cl4YhiAfUqv1tFKDjSoH5/74/SJOhuWNB+nnd1IaiouM
    puBpOrCmCXu7iOANEBmKVZ5qdBsQ9TeZyeZKxYAKMoclkKSas2syHdte9qd95WhW
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KNUWTaAP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KNUWTaAP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHiAkeWfPCoHBPa+kOYWKwSo26DdbVU8SaJci27mha90+0R78bp/qs02dgg08QHDbApeTVgbH1pADW3C0TBT6ckObmV4mAfZsMtiWTQhmhOHSaW3LaAF
    iAp06fbDGa2f3Zfel+tTx+jWToJrYmPmoY/3IOIN2O9d4WUf/3dAZG0Hn5T16rMSyq07z8N+LP8ZMRbzVjbc6+00kH+uY1FUb5/X2OftdpMaW7W8o1VKhRtL
    70mxiROzoq47t3CHgNw51A==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=X8JSyeVhvdqeyXXyZzAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 19 Apr 2018 17:18:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/39] proc: introduce proc_create_seq_private
Message-ID: <20180419141818.pjys7at4xmz2h6ho@mwanda>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-4-hch@lst.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190128
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
 Corey Minyard <minyard@acm.org>, linux-scsi@vger.kernel.org,
 linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, megaraidlinux.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 linux-ide@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:41:04PM +0200, Christoph Hellwig wrote:
> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> index 2a3f874a21d5..ad35cddcf6af 100644
> --- a/drivers/s390/cio/blacklist.c
> +++ b/drivers/s390/cio/blacklist.c
> @@ -391,28 +391,15 @@ static const struct seq_operations cio_ignore_proc_seq_ops = {
>  	.show  = cio_ignore_proc_seq_show,
>  };
>  
> -static int
> -cio_ignore_proc_open(struct inode *inode, struct file *file)
> -{
> -	return seq_open_private(file, &cio_ignore_proc_seq_ops,
> -				sizeof(struct ccwdev_iter));
> -}
> -
> -static const struct file_operations cio_ignore_proc_fops = {
> -	.open    = cio_ignore_proc_open,
> -	.read    = seq_read,
> -	.llseek  = seq_lseek,
> -	.release = seq_release_private,
> -	.write   = cio_ignore_write,
                   ^^^^^^^^^^^^^^^^
The cio_ignore_write() function isn't used any more so compilers will
complain.

> -};
> -
>  static int
>  cio_ignore_proc_init (void)
>  {
>  	struct proc_dir_entry *entry;
>  
> -	entry = proc_create("cio_ignore", S_IFREG | S_IRUGO | S_IWUSR, NULL,
> -			    &cio_ignore_proc_fops);
> +	entry = proc_create_seq_private("cio_ignore",
> +			S_IFREG | S_IRUGO | S_IWUSR, NULL,
> +			&cio_ignore_proc_seq_ops, sizeof(struct ccwdev_iter),
> +			NULL);
>  	if (!entry)
>  		return -ENOENT;
>  	return 0;

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
