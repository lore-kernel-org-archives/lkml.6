Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517944438; cv=none;
        d=google.com; s=arc-20160816;
        b=BriUKog3XSpq9zgsZDrLsaTXtq6rd2bVK0xsgJ5/qwqTv1VDWDFYHwPMWMRHOrSGAM
         cQDn40tJnpsiZNejz/HtNpdcEAGvRDo+6qLLVCYOHoeubUloNu4M29rTXPx5PpSu6rrQ
         WSTki94zvunHKaRgCOzZJKq5ZoRbcX6/CEFmA03KskIJGx/N3YYaGkJst2M43sstxNTH
         BwwaBqc9ZauNkZ7L5GCQQMqHxx3p0jcmIyv9JOs/O7X8F2GqEcXHQ9AN2oWAjJ2j1gqD
         9IeYY9nfMGWsE2vT1aeH1SWOk2z0eQAuLxfUDgj5sGedbSiPMcAdr9iEao7KUvqJ3zZP
         8SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=V8+oVW7nZy1Ao/tCJDOT9+orbqYilvKj3ah0OKv9Os8=;
        b=vesHvZrO3kxAfOp8cGu7jFEcQbYZ6KKcpxLlcUt6VGS4t1AEBxJk497uReUgw7hdII
         QpRBTgGNNP5EL1tvjZWx4k5G3fWEdvcPLSWsprTdduId5tasuqaThnk+vQa7NWoLN+Lb
         7FlpJ7l/gM1fQ6fTo/GrJXMZ5H4pGSR17YTG4mulGqLBM+URkMI02sN3cEupTbQAJkdI
         K9ess61n10zYvyvu5UitfOAq3GxSjaKWqf1rzF/o9kjd/mgrf9HFYIhPEXVsTonE/vpP
         MwOUsD7pbrdfJAW5+uD9y+nPf5qL3yw7rnjYhTxBp26AT/fiw0PzOncPG04SiFuCtPIt
         eZBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Dm+BiGPY;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Dm+BiGPY;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x2270RcAEiB0CdE/VNz0XhJ1Ggx28fxUnJ2umz+i7Dv4Ii2Osimg/iBMejgSnwHP2dTEtgQURLA==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Feb 2018 11:13:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, whiteheadm@acm.org,
	Hugh Dickins <hughd@google.com>, dave.hansen@linux.intel.com,
	jikos@kernel.org, Borislav Petkov <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	eduval@amazon.com, labbott@redhat.com,
	Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180206191355.GA7424@roeck-us.net>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517643438.31953.108.camel@infradead.org>
 <CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
 <20180206190233.GA10476@kroah.com>
 <1517944227.3677.15.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517944227.3677.15.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591680107758232664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 07:10:27PM +0000, David Woodhouse wrote:
> 
> 
> On Tue, 2018-02-06 at 11:02 -0800, Greg Kroah-Hartman wrote:
> > .
> > > 
> > > David
> > >   I believe I got the patch(es) you mention in in the stable 4.15.1 kernel:
> > > 
> > > Pull x86/pti updates from Thomas Gleixner: "Another set of melted
> > > spectrum related changes"
> > > (commit 6304672b7f0a5c010002e63a075160856dc4f88d).
> > > 
> > > Unfortunately, the symptoms I reported remain on at least the i486 and i686.
> > 
> > Can you try 4.15.2-rc1?  Or how about Linus's kernel tree now?  There
> > was a lot of spectrum patches merged just this week that were not in
> > 4.15.1.
> 
> No, for the 486 it *should* have worked. The interesting commit
> is fec9434a12 ("x86/pti: Do not enable PTI on CPUs which are not
> vulnerable to Meltdown") which is indeed pulled in with the merge
> commit that Matthew mentions.
> 

I disagree.

$ git describe
v4.15.1-61-g7ab5513e4cbc
$ git log --oneline v4.15.1.. | grep Melt
3472b3689bab x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown

Guenter
