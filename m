Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517560029; cv=none;
        d=google.com; s=arc-20160816;
        b=Nr8TAJPDj++p9gJsnkaCZks7zyBgUXJGAXaX5usagiMvxtYsKajgSHgVH9Ptj3wUjF
         dMAiTmRp48A3PTofQD+p2EvM+XfJlCI+ns5wgn++sqjdQf+/4nbJrZYyktAgB0NFNtZx
         HaR24Wqo75aka4qzxzSSEiCV3+WuIWqreOy9pDnHJulLM0x+CW2GXBSrPEQ/K02DsUAq
         maUas5SSHD/eXt5Oevwr1N22igY4wQbLgboJ/VBbI5R6ku/TiiOaAYUqcuHrhChlF5Mv
         6y/Ij0/8haXlM2RBPGycvM+paw7Igw0WAK2qdyDbxjPUazYM6firnn8qsUGFe9qvTTg1
         KIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=P3eTdtMfZdo4Vl5+gTBFwQI7BxYPg2rD4Q8jorKkGog=;
        b=T+KjCVVf0BvAJI2YEzvBQ12jFR32YJ1XXiazNojh3dHSpFFm2h4A5breIoz+kp0EaZ
         hu/mAXfU4Vw+F7hkMTvx9xegvaxp0qJ1M0m7C1TlsznTJ7UJh0vQi0r/j9I5VO0V0NqU
         eeP47FdkaGcHQxqRTyVRUGd7B8yg6VU7FmXXHfePmHMDOqI/Eie/vZYIek3fcATFlvd3
         XsdqaFfcWfuVS/HvIUfwsjQ4XlObJnozPqPFzro299Zl9cM697leMq39PgoqJy3BLv64
         7STWyd8HdeHbJHvk9/YziV8hblXcqFBssUlquJHO20OYnsRBTnDWKClt5J6xKbbF/49k
         49Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U4zYhJ3G;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U4zYhJ3G;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226vNMb0vWlszw9pccPM3tEwYcGfBUh1LZIdWNXg0PIC9XNVvQo821XeupN/2UcYy3MsEpcmWw==
Date: Fri, 2 Feb 2018 13:56:59 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] Documentation/ABI: update infiniband sysfs interfaces
Message-ID: <20180202082659.GA1458@mordor.localdomain>
References: <20180201133233.GA21266@mordor.localdomain>
 <20180201220811.GA17053@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201220811.GA17053@ziepe.ca>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591205652334607577?=
X-GMAIL-MSGID: =?utf-8?q?1591277024910388834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:08:11PM -0700, Jason Gunthorpe wrote:
> On Thu, Feb 01, 2018 at 07:02:33PM +0530, Aishwarya Pant wrote:
> > Add documentation for core and hardware specific infiniband interfaces.
> > The descriptions have been collected from git commit logs, reading
> > through code and data sheets. Some drivers have incomplete doc and are
> > annotated with the comment '[to be documented]'.
> > 
> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> >  Documentation/ABI/testing/sysfs-class-infiniband | 755 +++++++++++++++++++++++
> >  1 file changed, 755 insertions(+)
> 
> Wow this looks really great
> 
> Should this patch delete some of the old documentation?

Yeah, I should do that because the documentation in
Documentation/infiniband/sysfs.txt is out of date.

> 
> > diff --git a/Documentation/ABI/testing/sysfs-class-infiniband b/Documentation/ABI/testing/sysfs-class-infiniband
> 
> Lots, maybe even all of of this is considered stable..

Okay, I guess it should belong to the stable directory then.

> 
> > +sysfs interface for Broadcom NetXtreme-E RoCE driver
> > +----------------------------------------------------
> > +
> > +What:		/sys/class/infiniband/bnxt_reX/fw_rev
> > +What:		/sys/class/infiniband/bnxt_reX/hw_rev
> > +What:		/sys/class/infiniband/bnxt_reX/hca_type
> 
> These are actually common to all drivers
> 
>  /sys/class/infiniband/XXX/fw_rev, etc

Would make sense to define these at one place- hw_rev, hca_type, board_id are
common to a lot of the drivers.

Aishwarya

> 
> Jason
