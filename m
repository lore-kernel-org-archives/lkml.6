Return-Path: <rahul.lakkireddy@chelsio.com>
X-Google-Smtp-Source: AIpwx49jhS7vpZPde/WHGD3pkciawYljAXunlJN4MzDeeoylIsYkVdLb2jZ5/4JuO2qKn2MxD25x
ARC-Seal: i=1; a=rsa-sha256; t=1524149798; cv=none;
        d=google.com; s=arc-20160816;
        b=DF4xAnLXfn5UoQTuyzdzShWom0Q1gQ6TDYxj8Jz5PZjRroaw9Es0buKUpLq/WQxfjS
         kGGT2xrIb5SxmjQcwTLAznfI6jvnn3M1eUIqiaWC1WEexVyLiz8a9pQP5xHsCUQ27/Zy
         4HxtPHHm2yt9wHABzzSsCd/mq2OoF80QdacKkyFgP2n8Hy2M4iWBPcW5i/EW65HT8Ix/
         /q+fkOrcXzAaSYwEIuG6gI+AlJSOVYdDmJDrptU017vSxXV2Awp9AlK7ShA0L/8q+0Z9
         Lvxmrn+Cg3NSKgkRoKafegtJulODDPKVUCtLj49o7Gnz78wiAb5Xr7+enPiu/rEuCExA
         Bxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1EAUrQ32NQrr2oOiohA5oMzHmKglMkQZL3LEDZlXgFo=;
        b=PEQSk8lJ8fGef+nCk9FHgYvYDQKgYtGdbftpBVBzB9Hd/C0Kfm9SSyjmHxezTBB7Mt
         synH9RMr8eCKQTIQ3xaSYuVvPZtez6YBD5pT4bqDcwEK2WMQY+1siG3K3Dk3prvfyJD2
         P1aOXI37f/WNWdPxu6d4KZrGTprIfE0p/AdiRZ3N5RrByGFDMSUHNFIju/XsXBA2Wz8A
         HIKBowV3HxIJ3lj00LrRaw6hq5M94U/lQEc+pdlYInnJpZww1yuQuGu9/vJb/gVORstc
         Ef01u0OA/jU1DU5l5beXNtcQEOd+KnSSTU69giOx01V1XWTh1cd6PGOA9mFZDayM/LuS
         yvHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rahul.lakkireddy@chelsio.com designates 12.32.117.8 as permitted sender) smtp.mailfrom=rahul.lakkireddy@chelsio.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rahul.lakkireddy@chelsio.com designates 12.32.117.8 as permitted sender) smtp.mailfrom=rahul.lakkireddy@chelsio.com
Date: Thu, 19 Apr 2018 20:26:06 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: Re: [PATCH net-next v4 1/3] vmcore: add API to collect hardware dump
 in second kernel
Message-ID: <20180419145605.GA30325@chelsio.com>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
 <e69b49f1406d2dcd9cd68e4300939e96cd745559.1523950324.git.rahul.lakkireddy@chelsio.com>
 <20180419082456.GA8617@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419082456.GA8617@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1598186898718647299?=
X-GMAIL-MSGID: =?utf-8?q?1598186898718647299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, April 04/19/18, 2018 at 13:54:56 +0530, Greg KH wrote:
> On Tue, Apr 17, 2018 at 01:14:17PM +0530, Rahul Lakkireddy wrote:
> > +config PROC_VMCORE_DEVICE_DUMP
> > +	bool "Device Hardware/Firmware Log Collection"
> > +	depends on PROC_VMCORE
> > +	default y
> 
> Only things that require the machine to keep working should be 'default
> y', please remove this, it's an option.
> 

Ok. Will fix this.

> > +	help
> > +	  Device drivers can collect the device specific snapshot of
> > +	  their hardware or firmware before they are initialized in
> > +	  crash recovery kernel. If you say Y here, the device dumps
> > +	  will be added as ELF notes to /proc/vmcore
> 
> Which exact "device drivers" are you referring to here?
> 

The API is generic enough to collect any type of device's dump. Any
driver that wants to collect its underlying hardware/firmware dump
can use the API. In our case, cxgb4 driver collects dumps of the
underlying Chelsio network devices.

Thanks,
Rahul
