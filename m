Return-Path: <jgg@ziepe.ca>
ARC-Seal: i=1; a=rsa-sha256; t=1517522896; cv=none;
        d=google.com; s=arc-20160816;
        b=zg1FSlYR+/cldNDSheg6iAETKLuhvz4fNnylUhg+1c8+gb8noX46t8fVHT0ndUGFCY
         O9M/NciZZUgL0MDjEWq8Wwww+YqpZ1W8oj28zHkVFJRruTkOswkn1xpF0DH3+eAzaJUd
         FAC0JBEV2jvmDbjXI0P2VA7VGcYfQuNbkML8AGVInY2l4+fMY0uqKuhtkoA1KpKV+iN8
         2FE2IYpVmFAfBGaRviZXoEOlpEQ5DQxreqWyxoOTDG87bjRUYG6pp+BtEO3ww7hXI7D+
         iAc8hvprp1qzKC9oqt1vtPbaV7En0WrD/Y1RKCKmgYllySkFU3gPR5sIl+pUiW1jTTTo
         2YOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=d1bLGtWN4ZmMjRea31yc5lLOWObmrhZ2R6NZqg1HRHo=;
        b=ZVLifKafVC4yn2ER4moOgOnoo9tBO11Eu1iqEX+UpC2urAbEWYJYYpnsdaIjRlD22r
         JmcWEH2lhaAwgvSHrs2IS96vYwsmBE02fVuS2IUyRUEFLkPAHy2J4JlNX6VD7IGRhv81
         2kcvts1+f1Za0R9OU97y/d0B8eNl4+Qg6nq5GlAHyQFS36qjxkk0+mFRBYMP9GC6LhVn
         EcwuydPk94+OYbTgW5IklV8cCWvfsXaPcGZVJuGKT19sAFv923MQmjqj1ZAfI6pVDt8R
         JbORNVKKbgFWTaRr773i60fxyp2EF0WJNT7CWj8eD3zkDV92aq7/SBwFkmLgOogEzVv8
         Vlvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=KWvLKdIi;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ziepe.ca header.s=google header.b=KWvLKdIi;
       spf=pass (google.com: domain of jgg@ziepe.ca designates 209.85.220.65 as permitted sender) smtp.mailfrom=jgg@ziepe.ca
X-Google-Smtp-Source: AH8x225qxOO+QiF9Dj+yfR1TVmKD77Rx0pncsuGKog91qrLoVeqXMr1BIRQgABB3KBPbL0n1cODMyQ==
Date: Thu, 1 Feb 2018 15:08:11 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] Documentation/ABI: update infiniband sysfs interfaces
Message-ID: <20180201220811.GA17053@ziepe.ca>
References: <20180201133233.GA21266@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201133233.GA21266@mordor.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591205652334607577?=
X-GMAIL-MSGID: =?utf-8?q?1591238088884046422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 07:02:33PM +0530, Aishwarya Pant wrote:
> Add documentation for core and hardware specific infiniband interfaces.
> The descriptions have been collected from git commit logs, reading
> through code and data sheets. Some drivers have incomplete doc and are
> annotated with the comment '[to be documented]'.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
>  Documentation/ABI/testing/sysfs-class-infiniband | 755 +++++++++++++++++++++++
>  1 file changed, 755 insertions(+)

Wow this looks really great

Should this patch delete some of the old documentation?

> diff --git a/Documentation/ABI/testing/sysfs-class-infiniband b/Documentation/ABI/testing/sysfs-class-infiniband

Lots, maybe even all of of this is considered stable..

> +sysfs interface for Broadcom NetXtreme-E RoCE driver
> +----------------------------------------------------
> +
> +What:		/sys/class/infiniband/bnxt_reX/fw_rev
> +What:		/sys/class/infiniband/bnxt_reX/hw_rev
> +What:		/sys/class/infiniband/bnxt_reX/hca_type

These are actually common to all drivers

 /sys/class/infiniband/XXX/fw_rev, etc

Jason
