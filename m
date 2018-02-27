Return-Path: <kernel-hardening-return-12015-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELukZEH0OJ4OFfnspG/GrDGZP5ecqfAC9+R2fH75wrK5ARmwL0SkkXVtREyNZQ2WROEiJS0j
ARC-Seal: i=1; a=rsa-sha256; t=1519765607; cv=none;
        d=google.com; s=arc-20160816;
        b=yx8wVeUfPnP6UkU2/EQ/yZHT7sWbGkI/QxdUhTqgFNP7tFHWMrVyGjsuOTm3idEc/a
         nDSsejk86fuIcrYl+FYWh23JUEbVSJOFdUJLO8EH7lPQ++k3Y0tfL5MuiZ2wWgO7OgrM
         mzP2bmH0ZXLMLT6JDl2qfzloVnddOdzELikDNH/NiB8pN8CUpc/ztyRw0+rgaB5pFuF/
         nPJ3rw9Jxfer1zGRHeoUEbJK7o835OxL/ufpZ3YoRVjfeYaU2bhdf7sBnRhVty+SRcdl
         bg6HgtV1iKrmH4pGo7ELbK27VEmgSv24E7TwLawZCZUF24Cr1+ReI4rM1ULsUeyKJ7aB
         +H7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Kh5nmHhTDy722u/djlZWF2Xtq4P2eo1h+ag83RgksL8=;
        b=DNnh9ZY86f3WD4mB78oFshxMgr/Tpk5ZDHWEiz+D10/ZC9ZOpg+xzvD9bbZahK1AOo
         yZZSLbjFxDl8db20azusXU9AN5nq25OS07zf3gfGb1prtzmrLCNaS5qY62utZxK9hfsw
         knRXYSYKajgIwP8+kqPmOiEvm4YJ9Y+K5jV/6KXh/nLMgmAmqWEGc09FgPDB9NoQc2hn
         1aM6Vo4QnCIYc1kPfEAPCLucXaDp7RKcHtmQlHW3uY6PAlYqfvDHx56lPSACb0VRILtc
         Suf1hH9cTbt35KvdlQZFnUTnXSI/3pG6ZtjMEYnhMBTYMd6V1aknoiGuUow+UnYSbuQw
         TjXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=bjGpzkUj;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Z7Gc46c5;
       spf=pass (google.com: domain of kernel-hardening-return-12015-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12015-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=bjGpzkUj;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Z7Gc46c5;
       spf=pass (google.com: domain of kernel-hardening-return-12015-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12015-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:VciVWq2LbBjDxrBkLODYYLOz8CfU2SVmWKw6ugClm_QGR5-Gro8hbQ>
Date: Wed, 28 Feb 2018 08:06:25 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
Message-ID: <20180227210625.GA2646@eros>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
 <1519706711-18580-2-git-send-email-me@tobin.cc>
 <CAJ1xhMWfAZnQXoYVLLf6ABQ1+JsfLyJZmr95-33LH1DFJ5NjXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ1xhMWfAZnQXoYVLLf6ABQ1+JsfLyJZmr95-33LH1DFJ5NjXA@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593589741225225790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 09:15:03AM +0200, Alexander Kapshuk wrote:
> On Tue, Feb 27, 2018 at 6:45 AM, Tobin C. Harding <me@tobin.cc> wrote:
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
> >                         my $path = "$pwd/$file";
> >                         next if (-l $path);
> >
> > +                       # skip /proc/PID except /proc/1
> > +                       next if ($path =~ /\/proc\/(?:[2-9][0-9]*|1[0-9]+)/);
> > +
> >                         next if (skip($path));
> >
> >                         if (-d $path) {
> > --
> > 2.7.4
> >
> 
> Would something like this do the trick?
> perl -e 'foreach my $dir (`ls -d /proc/[0-9]*`){next if($dir !~
> "/proc/1\$"); print $dir}'
> /proc/1

thanks for the suggestion Alexander.  Here is Tycho's suggestion (from
other email, copied here for reference:

	> substr($path, 0, len("/proc/1/")) eq "/proc/1/"

I originally thought Tycho's suggestion was correct until I read yours
and realized that they both find '/proc/1'.  You filter on the numbered
directories for '/proc/1' (missing the other directories) and Tycho
finds only directories with '/proc/1' as the leading characters.  Both
of these differ to the original regex in that the original skips
numbered directories (under '/proc') that are _not_ '/proc/1' i.e it
allows parsing of all the non-numbered directories and parsing of '/proc/1'.

If my reasoning is correct, perhaps we have at least shown that that the
regex should have a comment :)

Happy to be corrected.

thanks,
Tobin.
