Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZqbHGpKJnJtJ8R2b23Wwq9SX9/aWD4NMkQ42Ym44FWCrrvjps2amOUNXh6u/DCXyLZXLLFq
ARC-Seal: i=1; a=rsa-sha256; t=1524602761; cv=none;
        d=google.com; s=arc-20160816;
        b=DQzRrG1VL6s4sXJGius64hm5tx4X7H+5byimz4OPWReA0Gx0ilqeTVjY1nf2jkdv10
         dYdeDuON0jKBQ2emZv7LHDaD64CfyAqyVUUGIz8HeP8cW8/cxteH3MKh+AB4C0yNtb0n
         CLVLkFlQSMEjNp1jQYfjWwQxOT412CLZM1jAiZ6tPfEvNDoO5rt7OU6Wkuwrr+/5+lt/
         K+HJjslSvQtscaeYMa7x0n6AajWNK0hqmAX5OgQb9Ax144IHZeYlfD1jc4mBijg7DcMd
         k56oS9w0uF5/VccoMKkWG4QDkCDUeqMkvn6bV+F4ugAy/IJVnBQZ8YBJhYyduwBSnY62
         Kz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=ayYshC3SJe/KApPF029AmkQqT39UhQyaW+3cp+jzAjQ=;
        b=WnSc+b5Gbt7NEwb+Frz0CekwOHs7pNA93nmaR/RZ8WeGtrd5xL1CvUfvwNvvVTzgst
         BgdOc8wmKJ2WI91LUnqUdS+djcC01beFs+8Zv973MgOZ20xglPdcJhnl8zvsELPhPm8X
         mq3S9bRRwk9xdYzPrj96oB50gcKyBps9XWvWDKBaW0BtNIM9Jr562Op5IQuu3G+18ECj
         BX9Eh27K8XvxPVswuHjw0MsWNE4F7F877E1gtVxXh2MgtO28HIYUbiZzNGpaB54SuAkh
         QuOxpew6d8MsuRNguBRDJhJZ1aREYi9NdAXkzybv8lgJr5Ho9HxiAj3K1LilqexXKaUH
         TCxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 24 Apr 2018 22:45:59 +0200
To: David Miller <davem@davemloft.net>
Cc: ebiederm@xmission.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2 v1] netns: isolate seqnums to use per-netns
 locks
Message-ID: <20180424204558.GA16013@gmail.com>
References: <20180423102443.16627-1-christian.brauner@ubuntu.com>
 <20180423102443.16627-3-christian.brauner@ubuntu.com>
 <20180424.153925.2063217911734444324.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424.153925.2063217911734444324.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598532193391122395?=
X-GMAIL-MSGID: =?utf-8?q?1598661865295627414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 03:39:25PM -0400, David Miller wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Mon, 23 Apr 2018 12:24:43 +0200
> 
> > +	#ifdef CONFIG_NET
> > +		seqnum = get_ns_uevent_seqnum_by_vpid();
> > +	#else
> > +		seqnum = uevent_seqnum;
> > +	#endif
> 
> Please don't indend the code like this.
> 
> By indenting the CPP directives, which should be at column zero, the
> actual code became double indented.

Ah, sorry. Sent v2 with the indendation fixed just now.

Thanks!
Christian
