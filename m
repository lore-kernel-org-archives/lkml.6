Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517815181; cv=none;
        d=google.com; s=arc-20160816;
        b=qUPgSMtlUmERZZLIUFycSk545B3qUyA+/eqIqZU20dvnavupiH38h2vMTk2vbU27CW
         H/w0LTrVFUC5bHSyCbEQ+VCxmHpC8x7qMHl5QdPGRB7DRRvPv5vkWlTLgh3QQ+z6LI75
         vDTxeq4+Mt3SVXxI+yzeB3cDJ1biKX0pPIWJpds7Xaoos9oUIQ0TMa3J/teXa8bgYJ6T
         GQHA8KBE7yFD5OmvV+EDGjz/DhS9v4g5J8bOUKrJvVibIIE8ScgxjoYSi9uyJu/vPNTu
         AehXClWHOlY6xVfqlsoHuYrfjMhDMEhqREtTcrKhZYdvr0732WMY084jBh0o6+gzXjRs
         qkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lBvA/n2jcDejt/woGcsRBBlG1crV3kIN7hOBvjKHrmY=;
        b=UWQXg3M/a6zTVgRTblK7rKMHg/2IVNPXWerRav3TJ0LcLa96dyr9BA4XGC+4I1F+VT
         INggL8VCFeo1/Okr5G7b7CwcfBrZ+OYagYjo2LthZsd++huQme/JHLXkFQlcJ5TYr6sf
         rzm4RZzCwCQK6iX3W+eI/Cug4EmCDPhtc+VZQKqzSEqf2mSqdA7rQJtlx7il61t7Mk8h
         uFEMWEdWAmsanOyaE4TqBRJwmqgEz6EqMrk9jtYy3hQ73mek5QBTbKJFJpQw9lIksJf8
         Q1aHAqTi81QQxNdrWx08lb4AaG2ZWheBiqstQt1rMdQ5ILFuDqAfUPNtlfG/3P9v5ULV
         LbHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kB8dkfz3;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kB8dkfz3;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224mmL2EAL6bjPKFc8LjEZTzYS+QWPFxJK5CxI6MiuHMiJ1koCyyuqmPERlQSHHC2Yp+v8xUPw==
Date: Mon, 5 Feb 2018 12:49:34 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Hal Rosenstock <hal@dev.mellanox.co.il>
Cc: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] Documentation/ABI: update infiniband sysfs interfaces
Message-ID: <20180205071934.GA9185@mordor.localdomain>
References: <20180201133233.GA21266@mordor.localdomain>
 <64f953cc-7831-1164-28b5-5319e72e600f@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64f953cc-7831-1164-28b5-5319e72e600f@dev.mellanox.co.il>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591205652334607577?=
X-GMAIL-MSGID: =?utf-8?q?1591544571181673945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 12:48:18PM -0500, Hal Rosenstock wrote:
> On 2/1/2018 8:32 AM, Aishwarya Pant wrote:
> > Add documentation for core and hardware specific infiniband interfaces.
> > The descriptions have been collected from git commit logs, reading
> > through code and data sheets. Some drivers have incomplete doc and are
> > annotated with the comment '[to be documented]'.
> > 
> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-infiniband | 755 +++++++++++++++++++++++
> >  1 file changed, 755 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-infiniband b/Documentation/ABI/testing/sysfs-class-infiniband
> > index a86abe66a316..2e150169633b 100644
> > --- a/Documentation/ABI/testing/sysfs-class-infiniband
> > +++ b/Documentation/ABI/testing/sysfs-class-infiniband
> > @@ -1,3 +1,194 @@
> > +sysfs interface common for all infiniband devices
> > +-------------------------------------------------
> > +
> > +What:		/sys/class/infiniband/<device>/node_type
> > +What:		/sys/class/infiniband/<device>/node_guid
> > +What:		/sys/class/infiniband/<device>/sys_image_guid
> > +Date:		Apr, 2005
> > +KernelVersion:	v2.6.12
> > +Contact:	linux-rdma@vger.kernel.org
> > +Description:
> > +		node_type:	(RO) Node type (CA, RNIC, usNIC, usNIC UDP,
> > +				switch or router)
> > +
> > +		node_guid:	(RO) Node GUID
> > +
> > +		sys_image_guid:	(RO) System image GUID
> > +
> > +
> > +What:		/sys/class/infiniband/<device>/node_desc
> > +Date:		Feb, 2006
> > +KernelVersion:	v2.6.17
> > +Contact:	linux-rdma@vger.kernel.org
> > +Description:
> > +		(RW) Update the node description with information such as the
> > +		node's hostname, so that IB network management software can tie
> > +		its view to the real world.
> > +
> > +
> > +What:		/sys/class/infiniband/<device>/fw_ver
> > +Date:		Jun, 2016
> > +KernelVersion:	v4.10
> > +Contact:	linux-rdma@vger.kernel.org
> > +Description:
> > +		(RO) Display firmware version
> > +
> > +
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/lid
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/rate
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/lid_mask_count
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/sm_sl
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/sm_lid
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/state
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/phys_state
> > +What:		/sys/class/infiniband/<device>/ports/<port-num>/cap_mask
> > +Date:		Apr, 2005
> > +KernelVersion:	v2.6.12
> > +Contact:	linux-rdma@vger.kernel.org
> > +Description:
> > +
> > +		lid:		(RO) Port LID
> > +
> > +		rate:		(RO) Port data rate (active width * active
> > +				speed)
> > +
> > +		lid_mask_count:	(RO) Port LID mask count
> > +
> > +		sm_slL		(RO) Subnet manager SL for port's subnet
> 
> Typo sm_sl:
> 
> > +
> > +		sm_lid:		(RO) Subnet manager LID for port's subnet
> > +
> > +		state:		(RO) Port state (DOWN, INIT, ARMED, ACTIVE or
> > +				ACTIVE_DEFER> +
> > +		phys_state:	(RO) Port physical state (Sleep, Polling,
> > +				LinkUp, etc)
> > +
> > +		cap_mask:	(RO) Port capability mask
> 
> 2 bits here are settable: IsCommunicationManagementSupported and IsSM.

Hi

Sorry, I don't quite understand this. cap_mask is a read only value which
indicates the supported functions. So the two bits-
IsCommunicationManagementSupported and IsSM, should not be setttable?

Aishwarya

<snip>
