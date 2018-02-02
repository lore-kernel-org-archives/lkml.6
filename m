Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x224FnnRP7nudFgGmv55CQls+lqt49beJNAWo6DPtoPB9gaq5WgkWlgsykGxq0qhyvVb10Yjn
ARC-Seal: i=1; a=rsa-sha256; t=1517588242; cv=none;
        d=google.com; s=arc-20160816;
        b=XEzKFYhz41qpg3c2ObspJEoz3EJxsl82nI0kbYX0SBYkhN58GmbMroL/ID4kbSENxh
         D8nMJMApLE8hpDAgW46Gw3pWcXqG7XJjponhDqNMQkaBrF3J4m9pVo1x3iNEPqysR0do
         ems9AbaPSXrOyaJIOQBPVgjMo5OxXYhYpRIPyfbP6Rrjlsc1OOcow6Ha4uIwSrI8u2Cz
         Ox3LBOF89NgFUGRGtcE8LyyA9+M7QavgnqeawRmASGbPv1dJh1EJ9XiPC68i/eSpLdKt
         d2XHAKJ+uuRducCytxrMAL06ipxejW9j1rFw+26CWX1thYTcB28NxFVM4Ts6nRUdZr0D
         pSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=WE22PiTONM2rm/We6eo/fWJNERBaSoDUezvL8PqP+vo=;
        b=WteORwIKMBPU7yup1M7ShK7psGUGzTJ5ttCOIIvUsCiwzrgtTmRowE3CB50xlr/k/C
         mXKPRTqZ7fpPF3iQuiPatIw+lkAaimZrxtzWHeyRfzjjkNPk+WwkE98CUi/5KqGz9I8H
         H5YH8tlA63PsTs/Od2c5r0gvZE4XQbPhDhXfoNf2FwAXRUV14foYk3Vn95PaacxtczQm
         fUWg9tpUi2mE+yHl2OGKi9Q/KhCHtse0GVlzlzoAB1wbd1hUh84LWPj+hEHstKhPEtTT
         m9Eyptj3lPDcGXvmLF0yYfiT74g8lbO0GCcnwacwMpzvinUctLWamBCKzF/C53eLgjyj
         pVgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 2 Feb 2018 09:17:20 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, Rob Herring <robh@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>, Thomas
 Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
Message-ID: <20180202091720.447b8a2c@lwn.net>
In-Reply-To: <20180202161246.GA3188@kroah.com>
References: <20180202154026.15298-1-robh@kernel.org>
	<bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
	<20180202161246.GA3188@kroah.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591306608858219729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Feb 2018 17:12:46 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > What is the correct/acceptable license for documentation?
> > Creative Commons? AFAIK GPL is for source code.
> > 
> > Googling didn't bring the wished-for enlightenment.  
> 
> It depends on what you want to allow the documentation to be used for.
> It's not a simple answer :(

Honestly, GPL (or more permissive) is the only thing that really makes
sense.  Much of the documentation, once processed, includes an awful lot
of stuff directly from the kernel source; there's really no way to say
that it's not a derived product of the kernel.  So the output of "make
htmldocs" or "make pdfdocs" really has to be GPL, suggesting that the
input should be GPL-compatible.

GPL isn't the best license for documentation.  If we were starting today
I'd try to find a way to use CC-SA instead, but that's not where we're at.
And GPL is workable enough, I think.

At least that's how I see it, not that I really know any more than anybody
else.

jon
