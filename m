Return-Path: <dan.j.williams@intel.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525881872; cv=none;
        d=google.com; s=arc-20160816;
        b=AGpUBi0AFDHQtTRDELUAIrItN4pE0R7s/vIxlyRQEY1z41HLX7vrwCtj4IkYkDksmU
         zftGJxHVf8haPy99qNp7FY3Bj3iaPez+P1vAipzqhIS/pBrCeWIcVNs6jvPk5pure7x8
         j3tiA2yysyR9e3O3MbIJwzdbzgE5nupueTyB5eRK6Vpb5Wggau3bJtmYAg1w7Q9iU186
         y7h3agJCiTZw/i8V7HfgTGwNO+Jxjqogp/xXIrFLNxrj3o+jsXcaJHyohMCeG/f25SzP
         p/fCOayORf/ImKerbx55qiiZKs6X5bPN1BTdsUkP3Rek2jarqktc5vjLHgkvLJmwqrxb
         N0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=F9N3q6UDAy0S2TViuKqJoCtjHRmk7EhIOgLmLomhDUQ=;
        b=Ds9r6nrEBXR2jl7agO2sj9hIUd1+U4fiqAkQjzYYdETQyvXiB4CrT4yA34lqun/P0E
         X6jkWEYRccPtEZ5rXPfSQFIKZwJebhLSUtvHgpAtwKUWLCkfLIhmHWbrqJ1QBP0/GngO
         GStb2Ti234HKZbn0OGeLMm7GR/kuO3rDFm4jpfA+gj6Ejkqx5bavnLdJ71xlcwK2K55S
         dJJa3ZKRNbBl8IDdAjq8T/ZGtn8NERXbFnDWndd5wabz14VvR9r9WyDvaa5A0jss6SRb
         rfeEdUCfBFJBF3berHuCOUdy2I/XD1noL+PtqHKmE7SubK/bguB5i/gSIvl5N9K488BP
         BPYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=YvTomC4w;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=YvTomC4w;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Google-Smtp-Source: AB8JxZp8dZ3FIpsx3ahMY2j+ViByMNicA6Ar87XvI8qjk3YXtYnUKGwzV6n68cTqPkVU16+xPsHQXux4aZx39iBxouE=
MIME-Version: 1.0
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org> <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk> <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk> <20180509204727.7ff38021@canb.auug.org.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 9 May 2018 09:04:31 -0700
Message-ID: <CAPcyv4jtNXhMwCqpbKkHe5e-nDPK+2Wq=maFsB_SMSGyg7fw5w@mail.gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600003109861123526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 3:47 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
>> > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>> > > I think this is an excellent idea, copying in Stephen for his input.
>> > > I'm currently on holiday but unless someone convinces me it's a terrible
>> > > idea I'm willing to at least give it a go on a trial basis once I'm back
>> > > home.
>>
>> > Since Stephen merges all -fixes branches first, before merging all the
>> > -next branches, he already generates that as part of linux-next. All
>> > he'd need to do is push that intermediate state out to some
>> > linux-fixes branch for consumption by test bots.
>
> Good idea ... I will see what I can do.
>
>> True.  It's currently only those -fixes branches that people have asked
>> him to merge separately which isn't as big a proportion of trees as have
>> them (perhaps fortunately given people's enthusiasm for fixes branches
>> that don't merge cleanly with their development branches) so we'd also
>> need to encourage people to add them separately.
>
> I currently have 44 such fixes branches.  More welcome!

Please add:

    git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
libnvdimm-fixes

We currently merge this into libnvdimm-for-next for -next coverage,
and resolve any conflicts vs new development. Do you want to see those
conflicts? Otherwise I would recommend only pulling libnvdimm-for-next
for -next and libnvdimm-fixes for this new -next-fixes effort.
