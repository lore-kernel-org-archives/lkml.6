Return-Path: <pebolle@tiscali.nl>
X-Google-Smtp-Source: AB8JxZp59o9WmxXKEJ3ywKibPlZl3Ks/H8+3CyzVIcJ5OaarA3BWBSpkt925mY9h63SMKQHoPKTn
ARC-Seal: i=1; a=rsa-sha256; t=1526633050; cv=none;
        d=google.com; s=arc-20160816;
        b=UBUDAjLTQkwVSLJBIYXO9J7K4mda8oorekJBseOzhPkRy1/CKXbxUpUYEnAXL8UEfz
         anTDmtJGIGrL0YSlwWSCHjwfn9G0b6A/4s3EZGUUfaCaYC4XBvRheIQXAoWqFp0wSU40
         rYYlYbT0ivlBDT8xyIdqz4jmPui6ZpwGK/k1O9nZDTKJzrfZcAp89lDgd3Fnt3wyuNs5
         +UbVqKgCVqCQbVI5GulU2URQV6rarpZx/K2mNK4jyKbjOUuBbtRkXIAAjUMwnApShfmb
         AOAYzzr8QxpzRAnk1w3jXd2ZcHcojJDgwjcleJ5NmGBtyq00/dTw4ZoAFJcouFQy8Dnv
         /uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=cjT7puj4Yz0DPinl9q5mllHbIrP3/Us41du77ucsyEc=;
        b=UPlcWw/GhtI2GSGuR8r88Vejom2mMSbxtmp92piETX/Kp8NY322ZbIwADa2zJE7XdD
         A6JoP8HMHw+6srWi2pg6A+dzc3UGkuxjMQi1Rz56zk8nBudo9RVQJdGSeow5W9v1TBKU
         Kiew2teHhubBuBUbZYANlzQVksd8rVa8GXbHsDA1CK9Qfptu3WaDRG9AAgmwkZNG3SZk
         9BiEB9NDquf8MYNtG0YxasC/vm1paxDiU2RctSTVltB3k7ZyoyChJxzgtmlnXa4v3Zl1
         /3vm6SHIjuQiVAtJGUKNZ4oNAwUjxLP56B8e91TPUPew9jgSJqpQI8kdZDp8rVQcSSZO
         9Uzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 194.109.24.25 is neither permitted nor denied by best guess record for domain of pebolle@tiscali.nl) smtp.mailfrom=pebolle@tiscali.nl
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 194.109.24.25 is neither permitted nor denied by best guess record for domain of pebolle@tiscali.nl) smtp.mailfrom=pebolle@tiscali.nl
Message-ID: <4e7091873e8a220c454a7ce5a3f52edc5b5c3e3a.camel@tiscali.nl>
Subject: Re: [PATCH 38/42] isdn: replace ->proc_fops with ->proc_show
From: Paul Bolle <pebolle@tiscali.nl>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  linux-acpi@vger.kernel.org,
 drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 18 May 2018 10:43:46 +0200
In-Reply-To: <20180516094346.20506-39-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
	 <20180516094346.20506-39-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB6YgMplMqSV6ybdh2qxdjXGwROvDDBp3OOmh9D5hR3uu/4cRLKqNAZc/n7EBVCQ1yFAgWHrTiXbvBEewQW2bC7Mt5PIP5/SWK34tza9oJK9Whl3QxPF
 bi+FsdhlHHTVvmlIPPICAv3mkuDTXsgzZN6NaQKqFcsAho9oLfS6uKYv5Wsn49VSw8dmsldzxr0sP+3mDsdSEdSf1u78mBIF6F0Idia74ITCgXx7MlidTkMl
 VxG9AUtIwjq/7eAH2t7/1bA9tXUsb8/yaPlSz8eFP5Z9U8U98HPU5aQOqfrpGJV1Z9+Yf/8FafDpN5hLA+jngK8lhyxQWAhJQepOXVCxW79Fr9zzi5kxbpNf
 tg6IdZYR+RyJxWzEi5IP/PcZyhtqa0RhdCPkZ+P6jdOPusFp/BZ59Dce6PmCFRBFtjSrvgWnGAU0HkfS9IZFvy2+aU4IiRb/eJ8Yqej6NPVMExLnrGRy5QdQ
 aNVwaqm8SRCGURfpfuZApplCwvJSIOlhCfc+l6JmG1d4aQM7Omw8DhHIx7QO8GvMtY6+1GCcW3rTTMN52NCfDf9Ojqfg65IYWgA9I3IMRZ8EkZkMVDhV29tZ
 9y4Sf89ykYi8b8APbWZgv0/X+NHvgNK1laNAKUzALtFgGB/zAJJ07jcfR9klhbM9coC96CEqOPjsNdFuoVyIJjJkigTWzvJW0kqpPm+ZErUfUIu0WlErJcLc
 dBTZvSnWNMcB48ZgAfZ+nBs/lpiSss4IsePrKCY+0pr7a7EWiaBPGKHBzFhDTZGZ/rqRLGoED+t1VSB+YImEZRUNs6+1KXy9Vw4t462lTo3eyiVS+mm3t/Mo
 A2MrnMmgmNDdR5bB/zH0Q+Emc50yVY+ZoYkT0OM4PX0jdA+uEh5bWo8RoTvKzwpyPB4TPP6daRdZrLSUyPyFeJI8QDxtGxbnGQ6ug0q8Hi7FcIqAU306muup
 I97kuD6ifWJ9F684Gen72EOl+C3bcL8yMRiLsv8TpdWGKf0uH7SXq7rDp5ctk+8+VVUpsw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600613511718087956?=
X-GMAIL-MSGID: =?utf-8?q?1600790777544316743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Christoph,

(I don't think the patches of this series ever hit the ISDN related addresses
still found in MAINTAINERS. And now I might be a bit late.) 

Christoph Hellwig schreef op wo 16-05-2018 om 11:43 [+0200]:
> diff --git a/drivers/isdn/gigaset/capi.c b/drivers/isdn/gigaset/capi.c
> index ccec7778cad2..dac5cd35e901 100644
> --- a/drivers/isdn/gigaset/capi.c
> +++ b/drivers/isdn/gigaset/capi.c
> @@ -2437,19 +2437,6 @@ static int gigaset_proc_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> -static int gigaset_proc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, gigaset_proc_show, PDE_DATA(inode));
> -}
> -
> -static const struct file_operations gigaset_proc_fops = {
> -	.owner		= THIS_MODULE,
> -	.open		= gigaset_proc_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> -
>  /**
>   * gigaset_isdn_regdev() - register device to LL
>   * @cs:		device descriptor structure.
> @@ -2478,8 +2465,7 @@ int gigaset_isdn_regdev(struct cardstate *cs, const char *isdnid)
>  	iif->ctr.register_appl = gigaset_register_appl;
>  	iif->ctr.release_appl  = gigaset_release_appl;
>  	iif->ctr.send_message  = gigaset_send_message;
> -	iif->ctr.procinfo      = gigaset_procinfo;

Is this intentional? You didn't touch the procinfo method in the other ISDN
drivers, as far as I can see.

(If it was intentional, gigaset_procinfo() can of course be removed.)

> -	iif->ctr.proc_fops = &gigaset_proc_fops;
> +	iif->ctr.proc_show     = gigaset_proc_show,
>  	INIT_LIST_HEAD(&iif->appls);
>  	skb_queue_head_init(&iif->sendqueue);
>  	atomic_set(&iif->sendqlen, 0);

Thanks,


Paul Bolle
