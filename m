Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524191528; cv=none;
        d=google.com; s=arc-20160816;
        b=MaUmQjzt5ZXFrjxF2C5iNnw28W9Igo0fKHtRilxxF+aMaVZ1qrCPkZqvSTIhiq2926
         mGsoWDgY4/djlqPtLYKfQaqXbiQcOzEO98ns9QxPCeKiHSX89pmPyiwEj2VJILYjK3mb
         f+v0ODcd4ewFbxPKUcAclwcUXQsaYb2hDYKtHRTMb5Ckd7JZEECdyjGJ58OYC2DPCbeJ
         oFYtriPlll9SgVCjmylnjUMg2so1Dj/7qFeNfaL3DaN8jX9Q9rY01XTInd7i+bzkrkJU
         vcq8sH+cNmqPp3JLL9OFd7bdjgqkz7JMifQPosgOPzWlbnrAuHDUeHwcfA3M9DS4fqZO
         kr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=HAVucIYY6O8x33eeFod2Lw9sNBcB+e8TJr6ngurtIK8=;
        b=q0iLHMdNEw1yEjpT0CUjKFt734U9gEm95slHLEeWm0+7nBSUWpiyWfdQjsgxvic1nD
         dC20tixZneWM1Jy1uQhyDAQsNtbatjezf0BMvQR1tNX1tPyqN3JWWLPVUzb+U4723ed7
         jsqd7BF6+ITBUu8i6sC+7wPsNpd6paAFF+UuXmyCB4y7rXZqIjAPhDsEE1dDwrjrz1WH
         mTkRIC9LALhdhB3oiwyXe1vfCPG93GY+um7ZaVuNa/1Cr1oXVF4/KA1CIQU8Mqxf8pwR
         jUlQExulgbqKCRPVy6hNN6gLkAZvilLNXXwpDMM4w2BE93wXEjfNMHYCmSqBiNQfkCdU
         0VQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kz27nGh7;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kz27nGh7;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4+SLdG1XKysku+cwrvpCLjimnpLPJQysv6IrpQUc+6pYRJ2iimymOsduAIU8vQ0bXfvi3uZGg==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 20 Apr 2018 11:32:02 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] zram: introduce zram memory tracking
Message-ID: <20180420023202.GA165695@rodete-desktop-imager.corp.google.com>
References: <20180416090946.63057-1-minchan@kernel.org>
 <20180416090946.63057-5-minchan@kernel.org>
 <20180417145921.eac3d6379b5bade6c4f1a091@linux-foundation.org>
 <20180418012636.GA196478@rodete-desktop-imager.corp.google.com>
 <20180418140715.4af4e837d6048a82117c85bd@linux-foundation.org>
 <20180420020921.GA155841@rodete-desktop-imager.corp.google.com>
 <20180420021834.GC6397@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420021834.GC6397@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1598230656450917427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 11:18:34AM +0900, Sergey Senozhatsky wrote:
> On (04/20/18 11:09), Minchan Kim wrote:
> [..]
> > > hm, OK, can we get this info into the changelog?  
> > 
> > No problem. I will add as follows,
> > 
> > "I used the feature a few years ago to find memory hoggers in userspace
> > to notice them what memory they have wasted without touch for a long time.
> > With it, they could reduce unnecessary memory space. However, at that time,
> > I hacked up zram for the feature but now I need the feature again so
> > I decided it would be better to upstream rather than keeping it alone.
> > I hope I submit the userspace tool to use the feature soon"
> 
> Shall we then just wait until you resubmit the "complete" patch set: zram
> tracking + the user space tool which would parse the tracking output?

tl;dr: I think userspace tool is just ancillary, not must.

Although my main purpose is to find idle memory hogger, I don't think
userspace tool to find is must to merge this feature because someone
might want to do other thing regardless of the tool.

Examples from my mind is to see how swap write pattern going on,
how sparse swap write happens and so on. :)
