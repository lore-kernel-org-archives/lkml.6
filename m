Return-Path: <kernel-hardening-return-11997-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsT6bmDmJu3C6xD2Vhfmw3uVQniFUWbjpF0y4FajW3tKeuDR0bdMnkpmC9+65XugpIFm0j5
ARC-Seal: i=1; a=rsa-sha256; t=1519713012; cv=none;
        d=google.com; s=arc-20160816;
        b=Ytrbp3ifztZrGMLWw4nfgnpdGeB2zbmsPrSI1ejvtp++BsEt/JyD7y7H6BLi7nGBIj
         1zSTAPKrpN6XJmV5w7yjBx4A+F7fxahzWj5vUyzop0L02pFbuFWygnkvXS8rKcWTSBDc
         zf7T+28zyQussZm6KEda1wdjXWTs89dPdEOv9LiWnHJUy/y1FY0TjQOdKmjnNV0HTLia
         5uNIvZ1bMG+DYwu7nC4BVM/Tdi1JVLTjcekSsEjX4pEp8kuj6EdF2Mi0mTTMNs2fSCen
         0vccMwBcJQj/9lRWDr9ynka4zoZBvGrwvg4FhCGrXcxMoYcnXjLOj2tBGsTs4+v4IxEz
         vk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=/m4NgtXgGjgVsuDosvminHhJw1Hv/qXXgQlFgXzvjEY=;
        b=uao5YwX/2er+YK9SKxvUKHXhIJUEycHAjZlTZifX1Lvx8XuNipQbF8QMDCfxNz4eDx
         p5eXRq1JMfr9Qn06WzdY3wtGr2Dm1/GeqfXX1SKu2p6VhFj75KNZDb/Y9x6dZZIX7Lgb
         kRTPRrKXuFhTdcWOBhETL2oXn1gIw31Qw0ezh1cpG2jI+38Nc5iMtayfAuwXZmKRAKXD
         Qj0DS3uBQvealiVOvwHnTO2swfOWrH77L0d64RrjLeqWq0nBMAs7gR4UvGYJ84PpyhbK
         H8K7JElXVs5M67e2Q/5HXMC+m5ZJe8oosoVfTQE+SuqjcCZ6k92GWotTe1+e6zCKEJ8C
         a1QA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=FYQehMql;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=kGY3gYoY;
       spf=pass (google.com: domain of kernel-hardening-return-11997-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11997-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=FYQehMql;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=kGY3gYoY;
       spf=pass (google.com: domain of kernel-hardening-return-11997-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11997-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:4fqUWtGOBCIs2RDpS7KvXF3mMCmraBklCYRxkixU6PPS3bSqVq2LYA>
Date: Tue, 27 Feb 2018 17:29:50 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
Message-ID: <20180227062950.GK15131@eros>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
 <1519706711-18580-2-git-send-email-me@tobin.cc>
 <20180227050931.4h64hkxglv3ekzsp@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227050931.4h64hkxglv3ekzsp@cisco>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593534592471702330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:09:31PM -0700, Tycho Andersen wrote:
> Hi Tobin,
> 
> On Tue, Feb 27, 2018 at 03:45:09PM +1100, Tobin C. Harding wrote:
> > When the system is idle it is likely that most files under /proc/PID
> > will be identical for various processes.  Scanning _all_ the PIDs under
> > /proc is unnecessary and implies that we are thoroughly scanning /proc.
> > This is _not_ the case because there may be ways userspace can trigger
> > creation of /proc files that leak addresses but were not present during
> > a scan.  For these two reasons we should exclude all PID directories
> > under /proc except '1/'
> > 
> > Exclude all /proc/PID except /proc/1.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  scripts/leaking_addresses.pl | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> > index 6e5bc57caeaa..fb40e2828f43 100755
> > --- a/scripts/leaking_addresses.pl
> > +++ b/scripts/leaking_addresses.pl
> > @@ -10,6 +10,14 @@
> >  # Use --debug to output path before parsing, this is useful to find files that
> >  # cause the script to choke.
> >  
> > +#
> > +# When the system is idle it is likely that most files under /proc/PID will be
> > +# identical for various processes.  Scanning _all_ the PIDs under /proc is
> > +# unnecessary and implies that we are thoroughly scanning /proc.  This is _not_
> > +# the case because there may be ways userspace can trigger creation of /proc
> > +# files that leak addresses but were not present during a scan.  For these two
> > +# reasons we exclude all PID directories under /proc except '1/'
> > +
> >  use warnings;
> >  use strict;
> >  use POSIX;
> > @@ -472,6 +480,9 @@ sub walk
> >  			my $path = "$pwd/$file";
> >  			next if (-l $path);
> >  
> > +			# skip /proc/PID except /proc/1
> > +			next if ($path =~ /\/proc\/(?:[2-9][0-9]*|1[0-9]+)/);
> 
> Can't we just do,
> 
> substr($path, 0, len("/proc/1/")) eq "/proc/1/" ?
> 
> seems much easier to read than the regex.

This is much better.  I guess it's true what they say, be careful after
reading a book about hammers, everything will look like a nail.


	Tobin
