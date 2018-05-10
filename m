Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqrgX2oAlCMyT7e2ZBiDW+YNkrS42TiprKUmx8c2W5GlmsCN29fJbNKSbWHv7ihnXDq8BRr
ARC-Seal: i=1; a=rsa-sha256; t=1525914920; cv=none;
        d=google.com; s=arc-20160816;
        b=FPbghVYTOWj08jboL5bJMDVc++ILtJ7qM9fkgMTDhSN+TnzqfbLmd2XqEKl3xj/5rR
         bOGV+Q2uL1+SMAp0G+g91Vsxft3TmqYJg/XlylZOrYEqPpEkIM7fR9LoGpBoP86VGOjG
         /f8RzOD968z6m5GpGhqxd/oM6QL2cyATn8eA3089kGy2D+Zrdq2WISB1DjdB7vKw4F49
         9E7sY/9CH8gwhM4KJq6t0MJXiV8kV5Lp4bXRfUF09wqtpxcZXzFIOqzu3rteGe25QVED
         tbgFpZ/sWx15sIlhAMT4EHvs0o/glYFWRB0kpFzFoz1jjhEVtPkCKA8ucnL0bmCM6LDD
         WWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=PlPvtAU9Pvl8qqb6zihKkHfLSdVwmplwB4sXqIYL7Dc=;
        b=A5IMgMl3jh1HOdil9LBK5NdaNeagAbUdl7H7IpQcxtP6bWBhNBLpLsz4Fi6B7W9lKM
         I0ds2/DEdfOrtb2Vc2DKwXMDMqBndliGhx0JZPwz6jrz6Kshw5rBgq5OyzJXB2/DouGd
         Od8WUyVymFBy4Lb6jTpO3VytflTXeyxRG23WMEF58LQmQm9vxAXhsRMfa4EWflsTDtTt
         YzC6UtXErgb1grLKGNcZoOnAxhMY1IxLrdQSuuzfVCJO6M7enuKbtxBbsMwTFYA3KNaD
         3YUj7Zy4QK8bkdepnUmC2UQSOKB72N+MjxZcybl41RMskN2KqqN+P08WnKgRD6GFV3hl
         x9Eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 01:15:16 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Tony Luck <tony.luck@intel.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	linux-ia64@vger.kernel.org
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Message-ID: <20180510011516.GZ27853@wotan.suse.de>
References: <20180428001526.22475-1-mcgrof@kernel.org>
 <20180428031810.GA14566@bombadil.infradead.org>
 <20180509010438.GM27853@wotan.suse.de>
 <20180509013935.GA8131@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509013935.GA8131@bombadil.infradead.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1600037763290081020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 06:39:35PM -0700, Matthew Wilcox wrote:
> On Wed, May 09, 2018 at 01:04:38AM +0000, Luis R. Rodriguez wrote:
> > On Fri, Apr 27, 2018 at 08:18:10PM -0700, Matthew Wilcox wrote:
> > > ia64: Add PAGE_KERNEL_RO and PAGE_KERNEL_EXEC
> > > 
> > > The rest of the kernel was falling back to simple PAGE_KERNEL pages; using
> > > PAGE_KERNEL_RO and PAGE_KERNEL_EXEC provide better protection against
> > > unintended writes.
> > > 
> > > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > Nice, should I queue this into my series as well?
> 
> A little reluctant to queue it without anyone having tested it.  Heck,
> I didn't even check it compiled ;-)
> 
> We used to just break architectures and let them fix it up for this kind
> of thing.

History is wonderful.

> That's not really acceptable nowadays, but I don't know how
> we get arch maintainers to fix up their ports now.

OK then in that case I'll proceed with my patches for now and just
document they don't have it. Once and folks test the patch we can
consider it.

  Luis
