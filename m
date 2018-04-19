Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2833786-1524134426-2-9109121565851903032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524134425; b=TNwYjqlki4A2MPGZ3DuT1qxa+yflKswItEigpQE+GfCRDscvz4
    E53+g0WCCBK6m/4HwjpZfnVbjjwmhODkvb8H8N41thkNZ2RbEnZ1RfmDW/FnOcyt
    rUNxKiPDftMD3yIlbbSgRzm/piKgsHSqj+tuqrKHnYntBPfOgIuVR3YVHa4GCxP+
    xs3zVZiC9KTmHwjlF+jtoGMGRDgoR9lq/a6ZlIlBUQjqcwnX7E1zRqfRdn1FZSj9
    K9zN1CpHTRD+5unMBsK10s5g9nfNU/4sLEX/Se/kDNGcOLsgBCJAHrGlbCqRRzOc
    l1uOa7YVTiBI94VBL/kiUevkBS/NUaIYkdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524134425; bh=mbq8U
    Z/sOFnssudNnZQhjAHy5GHIXqBakibabIYsB/8=; b=GkdxjJveF+IO9UYdXd/tJ
    T/n6vjsGdB68niQCPTlPkNMlAluNA1fqlcRmxwCa0xLSPFPvD1CC/3AbFLftcqyc
    uOUlVqme4n1AX6N1Z2c/2PUwxZ26Xme6QJp3CMEqiSUpsUtLsO9r8L7iSlUKy59C
    1dfL+94TR7jLFTj8XwJ0uOfHYDTUi3Zjg32dt2G1fVUAQzGwEU81dIVJjjTkv5zZ
    JsFizxFU8F+QcPG/DJwFoh/tYCOkpxhCIH934sUzGvd9XwGIVZNyL4VrUByDJziO
    okxwKX05oQsGK7lnzjp1Z2lYtpRsvY/VB2emFpLSOOsY6191Whj3s7NDTHDeW5dl
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfILo5dc+e1JtEzWZqcfna4kKSiRxsKHenkGkmr0k/2k8jCpOMmbRGGPIHNCXyuFQ6WazGzwnFxxc4dnikYUdR68BVzQxWwYX4Fd3jCJZBC3HSZ7KZE25
    Y28KBkRcyn9jKD3LAhjW12yPvnNRG6Dwn+ml0RbeGrxY3Gr7BEbBuBe9yf1yhysuOtYa6ls3QK4KaXMuywQLDwk9AMxc7kzvXJ1+AN9YistNYLB4BL6WlUvc
    7ydfPH3xFsZ29mHiqg37Tg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=xUXEEbovFiWBLQY28vQA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH v2] staging: pi433: cleanup tx_fifo locking
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
References: <4dba7594-2661-edd5-24ba-cffdf24021c5@smarthome-wolf.de>
 <20180419102530.5927-1-Valentin.Vidic@CARNet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Openpgp: preference=signencrypt
Message-ID: <20b592c2-33b1-f2f6-875e-39402e5ab058@smarthome-wolf.de>
Date: Thu, 19 Apr 2018 12:40:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419102530.5927-1-Valentin.Vidic@CARNet.hr>
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
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Luca_S=c3=b6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 =?UTF-8?Q?Simon_Sandstr=c3=b6m?= <simon@nikanor.nu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Marcus Wolf <marcus.wolf@wolf-entwicklungen.de>

Am 19.04.2018 um 12:25 schrieb Valentin Vidic:
> pi433_write requires locking due to multiple writers.  After acquiring
> the lock check if enough free space is available in the kfifo to write
> the whole message. This check should prevent partial writes to tx_fifo
> so kfifo_reset is not needed anymore.
> 
> pi433_tx_thread is the only reader so it does not require locking
> after kfifo_reset is removed.
> 
> Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> ---
> v2: print a warning if partial fifo write happens
> 
>  drivers/staging/pi433/pi433_if.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index d1e0ddbc79ce..2a05eff88469 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -87,7 +87,7 @@ struct pi433_device {
>  
>  	/* tx related values */
>  	STRUCT_KFIFO_REC_1(MSG_FIFO_SIZE) tx_fifo;
> -	struct mutex		tx_fifo_lock; // TODO: check, whether necessary or obsolete
> +	struct mutex		tx_fifo_lock; /* serialize userspace writers */
>  	struct task_struct	*tx_task_struct;
>  	wait_queue_head_t	tx_wait_queue;
>  	u8			free_in_fifo;
> @@ -589,19 +589,15 @@ pi433_tx_thread(void *data)
>  		 * - size of message
>  		 * - message
>  		 */
> -		mutex_lock(&device->tx_fifo_lock);
> -
>  		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
>  		if (retval != sizeof(tx_cfg)) {
>  			dev_dbg(device->dev, "reading tx_cfg from fifo failed: got %d byte(s), expected %d", retval, (unsigned int)sizeof(tx_cfg));
> -			mutex_unlock(&device->tx_fifo_lock);
>  			continue;
>  		}
>  
>  		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
>  		if (retval != sizeof(size_t)) {
>  			dev_dbg(device->dev, "reading msg size from fifo failed: got %d, expected %d", retval, (unsigned int)sizeof(size_t));
> -			mutex_unlock(&device->tx_fifo_lock);
>  			continue;
>  		}
>  
> @@ -634,7 +630,6 @@ pi433_tx_thread(void *data)
>  				   sizeof(device->buffer) - position);
>  		dev_dbg(device->dev,
>  			"read %d message byte(s) from fifo queue.", retval);
> -		mutex_unlock(&device->tx_fifo_lock);
>  
>  		/* if rx is active, we need to interrupt the waiting for
>  		 * incoming telegrams, to be able to send something.
> @@ -818,7 +813,7 @@ pi433_write(struct file *filp, const char __user *buf,
>  	struct pi433_instance	*instance;
>  	struct pi433_device	*device;
>  	int                     retval;
> -	unsigned int		copied;
> +	unsigned int		required, available, copied;
>  
>  	instance = filp->private_data;
>  	device = instance->device;
> @@ -833,6 +828,16 @@ pi433_write(struct file *filp, const char __user *buf,
>  	 * - message
>  	 */
>  	mutex_lock(&device->tx_fifo_lock);
> +
> +	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
> +	available = kfifo_avail(&device->tx_fifo);
> +	if (required > available) {
> +		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available",
> +			required, available);
> +		mutex_unlock(&device->tx_fifo_lock);
> +		return -EAGAIN;
> +	}
> +
>  	retval = kfifo_in(&device->tx_fifo, &instance->tx_cfg,
>  			  sizeof(instance->tx_cfg));
>  	if (retval != sizeof(instance->tx_cfg))
> @@ -855,8 +860,8 @@ pi433_write(struct file *filp, const char __user *buf,
>  	return copied;
>  
>  abort:
> -	dev_dbg(device->dev, "write to fifo failed: 0x%x", retval);
> -	kfifo_reset(&device->tx_fifo); // TODO: maybe find a solution, not to discard already stored, valid entries
> +	dev_warn(device->dev,
> +		 "write to fifo failed, non recoverable: 0x%x", retval);
>  	mutex_unlock(&device->tx_fifo_lock);
>  	return -EAGAIN;
>  }
> 


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
