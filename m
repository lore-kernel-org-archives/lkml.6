Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AB8JxZrcFEpEBIFAKARaz4W6dXF9kVNatQhSI3RyDs82FexGSN6m+wO3c2eo1si+wwShIbmWh9Sf
ARC-Seal: i=1; a=rsa-sha256; t=1525439382; cv=none;
        d=google.com; s=arc-20160816;
        b=hjx6XVHwputdhg/5Bo3mDAOznU4NTEXAMvYAxj/Z8N7+uiLDBFxmZnB3d1BfhV9K26
         +rpXyFgQ7we+O+BNtZB+tb3OAH7pZSVJ6iywn4hT/m5WXSqsxrLh2C5huGGdht4FkVdZ
         uEnyTHupdII9sjouMI//Hkh1CKUjbtK1tP64UizEXzBrtPiUBZBK8C71pLo4v7PMQfAU
         FPj0IbWz646nF4btMd0L74mtveG74gvtPHF8nupzi87dYPw0whcEkgyqasmD2FPffAAk
         Qou6q/F9vmx+BGo1UvkVT5DfBuUSKNgJMm4XUwoyxhOuFful2baNtwHcdSkRfNGQ8nf2
         vftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Wn/mkkNBp24gBDog1qNFaewBMS+Jyl3cxfSlVK/I1Ns=;
        b=lmTJK84Z4xVde67K+DhpeHcepCdf7v6I6v3by6ljPQrhToM5Nb8b18NmJBeLJKNJ/x
         Zu1V9X/fVfT+0RGcHi3vXBe8osxHKtHnWNVSQqtTIkzyM6UDROlMv10I7DFkHtyh9WSW
         YrD9C+oLvwlXCJN8JI+/k9Y/BSl7c6kLLWyEdifKKiDjivdsc7FpIRdBw6ngy3qVoHnV
         y7sMDzhQ4rLP6ygA72zc1ZmOAOFC+8SwSn4Cfv5ZtrJG0jkV9yIvpRiehLOicf43mfUB
         hWHaeYL4fhfjIFFJSrWPAiS1Aqed0HZcNOXQl5LMDFnMdyCb5t12wq4Yt+pgRDYuf5Me
         o9OA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=uWCfUOiU;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=uWCfUOiU;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Fri, 4 May 2018 09:09:32 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jani Nikula <jani.nikula@intel.com>
Cc: David Howells <dhowells@redhat.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180504130932.GI29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jani Nikula <jani.nikula@intel.com>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
References: <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <20180503144612.GJ18390@sasha-vm>
 <20180503165446.GB30522@ZenIV.linux.org.uk>
 <20180503173422.GR18390@sasha-vm>
 <20180503182039.GC30522@ZenIV.linux.org.uk>
 <8669.1525427874@warthog.procyon.org.uk>
 <87fu377gbu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu377gbu.fsf@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599539125768451123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 03:31:17PM +0300, Jani Nikula wrote:
> On Fri, 04 May 2018, David Howells <dhowells@redhat.com> wrote:
> > Sasha Levin via Ksummit-discuss wrote:
> >
> >> 	Cc: stable@vger.kernel.org # commit-id-of-(2)
>
> This has been documented since
> 
> commit 8e9b9362266dd16255473c080d846b13e27247bf
> Author: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Date:   Sun Dec 6 12:24:31 2009 +0100
> 
>     Doc/stable rules: add new cherry-pick logic
> 
> in v2.6.33 so seems like there should have been enough time to fix the
> tools.

The problem is that it's not being *used* that way.  In fact, that
documentation is arguably out of date.  When it does get used, it's
used to indicate which kernels the stable patch applies.  You have to
go pretty far back before you find that suggested usage.  Run:

git log --grep stable@kernel.org | grep -i cc: | grep stable | grep \#

and see for yourself.  The first couple of hits:

    Cc: stable@kernel.org # 3.11
    Cc: stable@kernel.org # 4.8+
    Cc: stable@kernel.org # 4.8+
    Cc: stable@kernel.org # 4.13+
    Cc: stable@kernel.org # 4.8+
    Cc: stable@kernel.org   # 4.13 - together with 890da9cf0983
    Cc: stable@kernel.org # 4.13
    Cc: stable@kernel.org # 4.13
    Cc: stable@kernel.org   # v4.8+
    Cc: stable@kernel.org # v4.10+
    Cc: stable@kernel.org # v4.10+
    Cc: stable@kernel.org # v4.10+
    Cc: stable@kernel.org  # reverted commits were marked for stable
    Cc: stable@kernel.org   # for the backport of the original commit
    Cc: stable@kernel.org # v4.8+

At this point, my suggestion would be to delete the text added by the
above-mentioned commit, and add a new syntax.  We're much more willing
to support multiple headers, so something like this:

Stable-prereq: DEADBEEF1234: subsystem: bork bork bork....

With multiple Stable-preeq: lines allowed, where the order is
significant, might be one way to do things.

	     	      	      	    - Ted
