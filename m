Return-Path: <linux-kernel.bfrz@manchmal.in-ulm.de>
X-Google-Smtp-Source: AG47ELtnC0kvm4DanPAB1sfhyK5yJQu33HVF2w4RnDitrjGOwkoppbiyXNnPoOVRVkZnk4+LvdN+
ARC-Seal: i=1; a=rsa-sha256; t=1521307639; cv=none;
        d=google.com; s=arc-20160816;
        b=qhMDguBh2Oye2b4mLaf+98s4Qq1xsWQROUWxFMcUaNzxDTd/ID4ttafHVRUSKSeKFu
         0yLHl3eZimduB750MhUi/yQAW705ucQMOzKO9U7fiwph1RWawCQUWHtkwO7D8wkIEswm
         XgMWJ3VwqoUZK4wdIbjHiyfmg8FS5eWLEUwh9kjBZHu+Fsme3S6sCE5vXLItaacxQCwR
         mHv+kZ/svkApPXvH1OtAt0V/gPRpuQi+N1fGyEblpIP5D+DZG7sltxdXzHPxRItBmNhn
         n5lo4FIo17A1XlbBhXZccOE9gt0oIjKK9xfjJ1fyYhjEL0N1ZyahMYm8AnNKEx9CCKV5
         qxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=jeyRRtj+8yDwtAq7VFaelFJB7fu2dogmaVkVi2HnhNw=;
        b=Jyvz0IwZVZzosFYb2FR6yhzgoIubSx70ugSaudwCjMCl/v1/1iY6aXB2GeIwxqA5NE
         YjThwC7uR59/tUZWTFsSB53MeRmxgMy40cOmhbQakxJ8gJIEtG1Tdx78Mci6dZYwEUX+
         3n2+NHuFyUNTAsTa934hBEM2uKWvuOepvOCZ05njEfDLwqRUWOfQKbNB8lcv6YGeIw8d
         +fPiq9krnwgHlIYgKCmJSHVhG1UbGRiBPEWreMfPugMgn0eNKQemD5JDacrdm3OiWQhS
         ocPb548RIbN8aDphCa0L9g19NznZvcUtDDfZR0Tb7dZNngLj87Fo5y905999mVyd1wF2
         dP3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of linux-kernel.bfrz@manchmal.in-ulm.de designates 217.10.9.201 as permitted sender) smtp.mailfrom=linux-kernel.bfrz@manchmal.in-ulm.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of linux-kernel.bfrz@manchmal.in-ulm.de designates 217.10.9.201 as permitted sender) smtp.mailfrom=linux-kernel.bfrz@manchmal.in-ulm.de
Date: Sat, 17 Mar 2018 18:27:15 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
	Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
Message-ID: <1521305582@msgid.manchmal.in-ulm.de>
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
 <1521139304@msgid.manchmal.in-ulm.de>
 <20180316123049.GC25079@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316123049.GC25079@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309090147375870?=
X-GMAIL-MSGID: =?utf-8?q?1595206679714274583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg Kroah-Hartman wrote...

> On Thu, Mar 15, 2018 at 07:55:42PM +0100, Christoph Biedl wrote:

> > > commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.

> > On big-endian systems, this change intruduces severe corruption,
> > resulting in complete loss of the data on the used block device.

> That sucks.  Can you test Linus's tree to verify the problem is there?
> I'll gladly revert this if Linus's tree also gets the revert, I don't
> want you to hit this when you upgrade to a newer kernel.

Confirmed: The problem is, err ... was in Linus' tree as well. The
rather recent commit 8f5fd927c3a7 reverted the change, after that
everything is as expected again.

Looking at the original commit, I don't have a clue why things go wrong
so horribly - otherwise don't be afraid of my data. I took this as a
chance to verify my data recovery procedure, with success.

    Christoph
