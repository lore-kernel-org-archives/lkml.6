Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AB8JxZpleI3r4QLdQBpCKUqS7kTzo5Or+DwGZeFDyHeDJPSUD3k9IyCtmBpC3nS3WaatO+40o/AX
ARC-Seal: i=1; a=rsa-sha256; t=1525284760; cv=none;
        d=google.com; s=arc-20160816;
        b=Q7B4sdxCd6+JZYyAbTEsuJ1HRRD8MikKh7Df5R4CFPS2yP9wCQ3la1sHo4QQR7NfBe
         2TW5OGLJp1LuPILge4Zbp93pyYtXUC+LGkAqHPKmjRuf302zLGxGKPPFsl7Iol9NxIuC
         3LisbSJfYXB7bpFAlC1jVFPN6NZqwuLQZcZZjHWq4DBE8EVzqg9rXC8gdmz8uumT6jVN
         xfcd+ap5ebMiY+0hj1PnYhSSYb5QRO7rIvz1NM0/1Jf/HSdgomj9d8DwnMnjSZZPRJrS
         Jw97uixK7q7nsWDB6G4w/jRXzGwpEyU1jmO8bRgvoBLx/mN70QqVZIzV492pGWPVHW0/
         E9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=AUu3epC5xw8fncCrKkacavX48fvUm0ItWR3iyLadTtM=;
        b=h4SU3hX6C9RKGm6fV6ik98703Q/GZf6VqW3E1IYQ0L329JlQ/YPhZLgAkay9EUU8Q3
         KURiJ7P8Uor8/HPTKklOwBLvMkWTdEX7DcPkCntfYH7AOn2rqLCkQmiFeTIS1z7OMuxe
         ptYMm8r+5BU+RHx0KUqa/uH1cRHscsp4Y5ahVXqE8eiYHF0NRhT2BfTaEeSrPV0ayV/9
         VH5pktDSKTZDJih2xu7Fvzyt7dvN6jgxFHhTD4Muo+qCgBvWNzjFP05NSo63iHlKtBdO
         vZYiXaeKABNHfI4DdGeiljdMQbPU9RKDztH3TEs5PE6jSQC/0wTpnWWVOSH/zuWF+z0H
         APtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=shV2oxj2;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=shV2oxj2;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Wed, 2 May 2018 19:12:35 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 08/10] staging: lustre: move misc-device registration
 closer to related code.
In-Reply-To: <152514675910.17843.16005951911891583421.stgit@noble>
Message-ID: <alpine.LFD.2.21.1805021911550.24633@casper.infradead.org>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675910.17843.16005951911891583421.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180502_191235_243593_AB287995 
X-CRM114-Status: GOOD (  18.65  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232376014079452?=
X-GMAIL-MSGID: =?utf-8?q?1599376992369734805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> The ioctl handler for the misc device is in  lnet/libcfs/module.c
> but is it registered in lnet/libcfs/linux/linux-module.c.
> 
> Keeping related code together make maintenance easier, so move the
> code.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: James Simmons <jsimmons@infradead.org>

> ---
>  .../staging/lustre/include/linux/libcfs/libcfs.h   |    2 -
>  .../lustre/lnet/libcfs/linux/linux-module.c        |   28 ------------------
>  drivers/staging/lustre/lnet/libcfs/module.c        |   31 +++++++++++++++++++-
>  3 files changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> index 6e7754b2f296..9263e151451b 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> @@ -141,11 +141,9 @@ int libcfs_deregister_ioctl(struct libcfs_ioctl_handler *hand);
>  int libcfs_ioctl_getdata(struct libcfs_ioctl_hdr **hdr_pp,
>  			 const struct libcfs_ioctl_hdr __user *uparam);
>  int libcfs_ioctl_data_adjust(struct libcfs_ioctl_data *data);
> -int libcfs_ioctl(unsigned long cmd, void __user *arg);
>  
>  #define _LIBCFS_H
>  
> -extern struct miscdevice libcfs_dev;
>  /**
>   * The path of debug log dump upcall script.
>   */
> diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
> index c8908e816c4c..954b681f9db7 100644
> --- a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
> +++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
> @@ -166,31 +166,3 @@ int libcfs_ioctl_getdata(struct libcfs_ioctl_hdr **hdr_pp,
>  	kvfree(*hdr_pp);
>  	return err;
>  }
> -
> -static long
> -libcfs_psdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> -{
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -
> -	if (_IOC_TYPE(cmd) != IOC_LIBCFS_TYPE ||
> -	    _IOC_NR(cmd) < IOC_LIBCFS_MIN_NR  ||
> -	    _IOC_NR(cmd) > IOC_LIBCFS_MAX_NR) {
> -		CDEBUG(D_IOCTL, "invalid ioctl ( type %d, nr %d, size %d )\n",
> -		       _IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd));
> -		return -EINVAL;
> -	}
> -
> -	return libcfs_ioctl(cmd, (void __user *)arg);
> -}
> -
> -static const struct file_operations libcfs_fops = {
> -	.owner		= THIS_MODULE,
> -	.unlocked_ioctl	= libcfs_psdev_ioctl,
> -};
> -
> -struct miscdevice libcfs_dev = {
> -	.minor = MISC_DYNAMIC_MINOR,
> -	.name = "lnet",
> -	.fops = &libcfs_fops,
> -};
> diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/lustre/lnet/libcfs/module.c
> index 4b9acd7bc5cf..3fb150a57f49 100644
> --- a/drivers/staging/lustre/lnet/libcfs/module.c
> +++ b/drivers/staging/lustre/lnet/libcfs/module.c
> @@ -95,7 +95,7 @@ int libcfs_deregister_ioctl(struct libcfs_ioctl_handler *hand)
>  }
>  EXPORT_SYMBOL(libcfs_deregister_ioctl);
>  
> -int libcfs_ioctl(unsigned long cmd, void __user *uparam)
> +static int libcfs_ioctl(unsigned long cmd, void __user *uparam)
>  {
>  	struct libcfs_ioctl_data *data = NULL;
>  	struct libcfs_ioctl_hdr *hdr;
> @@ -161,6 +161,35 @@ int libcfs_ioctl(unsigned long cmd, void __user *uparam)
>  	return err;
>  }
>  
> +
> +static long
> +libcfs_psdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	if (_IOC_TYPE(cmd) != IOC_LIBCFS_TYPE ||
> +	    _IOC_NR(cmd) < IOC_LIBCFS_MIN_NR  ||
> +	    _IOC_NR(cmd) > IOC_LIBCFS_MAX_NR) {
> +		CDEBUG(D_IOCTL, "invalid ioctl ( type %d, nr %d, size %d )\n",
> +		       _IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd));
> +		return -EINVAL;
> +	}
> +
> +	return libcfs_ioctl(cmd, (void __user *)arg);
> +}
> +
> +static const struct file_operations libcfs_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= libcfs_psdev_ioctl,
> +};
> +
> +struct miscdevice libcfs_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "lnet",
> +	.fops = &libcfs_fops,
> +};
> +
>  int lprocfs_call_handler(void *data, int write, loff_t *ppos,
>  			 void __user *buffer, size_t *lenp,
>  			 int (*handler)(void *data, int write, loff_t pos,
> 
> 
> 
