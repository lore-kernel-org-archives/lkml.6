Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AH8x227hu89chfJQhfYdyjif88qxmlqcTM/WK/6hdZtLShHED7lQS66WjECRXWztgrXMiU63yo8X
ARC-Seal: i=1; a=rsa-sha256; t=1519228606; cv=none;
        d=google.com; s=arc-20160816;
        b=mZrp/9JgFnydcyw9MZGBMCLhXw1sb7EAfKwhcc1ZNG3JhyPLln10uQit4NA5LGDQ7V
         NojhICz/hc/CGNZb8R10TQqWF7Fyxvur62PPecKGNoitHGRJ0356BiGqfiePbM5hwXWs
         LyOEE8RsBo3ZbunbojKnePVIy1aBpUsZIcaCv+1FpjP7Ya0vGej00vhHur43N/6v/0mB
         yoXTwQKpOXmq2g4PZSBebDwmzMwuvRShYu1iitbxZD/a52CnwtVDEROnYSLoYPCd6oGj
         b9SRZFV0s85AbMoYhByacWR4T9Oc3xXp5j8Ebgx+hmcLH3+Qhy4YAe7DamuzUg4uOKfZ
         OhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=yvQJQtb3mcQ/upheStOp3aHJxERQv8N55YJQowOtMW8=;
        b=wHFI/XgYyEgTcBok2zT2DHSF2zOgK0mCqc3mCsYNc6X/kBes8oZjISSsw6I7LGBZh/
         meODD9gM0beldXA8q1xFC5Z2U8HkPKfdUGD+gkI1MAspg1ab/wXIDPx/+C3g8T1KqS/w
         v+ef60C9a9kNYZQGV1zYgl/YkBfWLotr6Xj9UUqwUVMaq9BXLHAZTpo3S0nB2JM+dEGC
         xMyVFhVAx1/Q4rgEDv25ivUcB7NI+t9m5QQMZ08kYGn3kllam+pgH8xlFz5nJiS7PWOh
         SY7rrOgEQkHEAZt74eE4A3OYekjXjSolvrXLRcSxEKpr4Pb0pAni/3ZiiwDpoxr8YLlf
         KnNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=yLODnKbh;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=yLODnKbh;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Wed, 21 Feb 2018 10:56:45 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tommi Rantala <tommi.t.rantala@nokia.com>,
	Tahsin Erdogan <tahsin@google.com>,
	Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: backporting "ext4: inplace xattr block update fails to
 deduplicate blocks" to LTS kernels?
Message-ID: <20180221155644.GC9900@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tommi Rantala <tommi.t.rantala@nokia.com>,
	Tahsin Erdogan <tahsin@google.com>,
	Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
References: <f3db4b3f-9cb6-c96c-8d31-f2a5f8b4082c@nokia.com>
 <20180221114000.GB6555@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221114000.GB6555@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592836024079579824?=
X-GMAIL-MSGID: =?utf-8?q?1593026655763273149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 12:40:00PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 19, 2018 at 03:26:37PM +0200, Tommi Rantala wrote:
> > 
> > OK to backport it?
> > I tested it briefly in 4.9, seems to work.

It looks sane, but it would be nice if I can get people who are
backporting ext4 patches to make sure there are no regressions using
one of kvm-xfstests[1] or gce-xfstests[2][3].....

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
[3] https://thunk.org/gce-xfstests

I do run regression tests[4] on stable kernels when I have time, but
it scales much better when other people can help.

[4] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/tag/?h=ext4-4.9.54-1

> I need an ack from the ext4 maintainers before I can take this...

Greg, you can go ahead and take this, but in the future I'd appreciate
it if ext4 backporters could at least run a smoke test (which takes
less than 15 minutes on GCE) before and after the patch, and report no
test regressions.

More aggressive testers can and should run "{kvm,gce}-xfstests auto"
which take overnight, and the really adventurous can use the
lightweight test manager (ltm) which will break up the test run the
job across multiple VM's and do the job in about 2.5 hours or so.  :-)

		      	     	     - Ted
