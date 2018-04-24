Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AIpwx4+xZcWV83fdvz1lVZgUSFbijl4Sujk1uKBVEDGxYRiSNxMxRuziC7u4DfSk0G8tYH8HxSlQ
ARC-Seal: i=1; a=rsa-sha256; t=1524592018; cv=none;
        d=google.com; s=arc-20160816;
        b=BepSRwcFACPZllwtr0pFF5NINdgzxpAXSPjb4OGfu8+xuHamjvWqWupX7m0q0FmYp5
         eZnUrrYQbny+eKoEXUUNOBSiei7IWe31vpnt4Wtm0n4CCVU/jY4S/ZFLjL7DAlx115Lo
         mzzSntMEv/2RH8/X4+W6iHCYu6qHgFXucN+DXTgQxXu1h5BoVBFwwLHEmyQMCoiX9Itp
         oZ4yBy8ldI8LJ6e7npCXPb99xqgfuOHZNY2Mg2UkAG9uzE0HaWJIy2ClIJXs2RMlR4U7
         pYksn6li1hTmgLxttylVHGmwqsI84UX2pFhZUfPb7FTqTHZhUOKXjOAie0zrm5HJRfpr
         x12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YqW2hMD1ZiDZj7P8KHsho7hLoT0ChJaQdSoRyKufsqc=;
        b=fKt6rBDKQoX7T4O2IRwLX5TyvjPq7JW5uF8lOfJAn9AfL0R7TGxVv7Af1bBCwWMptE
         klUuvysqiDZMSTAtX/9us1F1K8XfwHbiKvhQrG+DjZQDrrOFybIzu5UcbX4XYh4KPjQm
         blicfJyqi+6KgYcLVcGuJdQxCuMcVcp7W3sO2Fqt8CjaCVLm68UnoA0lqrpVhwe+vJ83
         aLZDK9wOr71IgIfAs+4wWDxZG0q3yxwtCMwfofbs+2ARI+U/x4gVs/RzTp7BCyVFu/mC
         Y1U4wyaW0fvOVzSbZlt0YaytMAiKP16aNEI20BcikPDZLMHiScdYF1gi3ai6g0lBac5E
         XhRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=Nng/qRB9;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=Nng/qRB9;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Tue, 24 Apr 2018 10:46:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	linux- stable <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180424174656.GA11717@roeck-us.net>
References: <20180422135210.432103639@linuxfoundation.org>
 <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
 <20180423165750.GA27986@kroah.com>
 <20180423180137.GA26974@kroah.com>
 <20180423222553.lbxx3cwly2fbvabs@xps>
 <20180424072635.GD18419@kroah.com>
 <20180424172311.meeo6wrsp4rtxxiz@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424172311.meeo6wrsp4rtxxiz@xps>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455883527705799?=
X-GMAIL-MSGID: =?utf-8?q?1598650600458902038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 12:23:11PM -0500, Dan Rue wrote:
> On Tue, Apr 24, 2018 at 09:26:35AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 05:25:53PM -0500, Dan Rue wrote:
> > > I made a few comments inline regarding the reported failures. Also, as
> > > this report is pushing 200 lines now with all of our tests and
> > > environments (about 8*22 test runs), I'm planning on making some changes
> > > in the next few weeks to make it more concise and useful. Any
> > > suggestions or feature requests are most welcome.
> > 
> > How about only reporting problems?  Having tests "pass" is the norm and
> > should always happen, right?  That would make the reports smaller.
> 
> I agree, though I would like to provide a bit of context so that people
> new to the process have some idea about testing breadth and depth - but

I did that initially, but found that it is only confusing. Sure, there
should be a means to look up the actual tests, but for the notification e-mail
only pass/fail is relevant.

I found that even "skipped" is confusing, because people started asking why
tests are being skipped.

Guenter
