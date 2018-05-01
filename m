Return-Path: <jglisse@redhat.com>
X-Google-Smtp-Source: AB8JxZqKxPMUedba2DlCNpacBy1OZMZUXnDTFdAjQJn+eANCscBM5RY1pKgPnXOmhAbWCf4tQzTs
ARC-Seal: i=1; a=rsa-sha256; t=1525133161; cv=none;
        d=google.com; s=arc-20160816;
        b=hJytOHQNfRoC+vuVg/x7Qhi2RorZ3qHQEKcq5B8mVDrg6yB5zG0ghR/LJryH4zukAq
         A8JRqbeJ4hsCbFSxvTi9f/gDZHecWulZlS6VKXHpL4x+7dVrGrglJzvZ3epZIJii9UMK
         J6H98Mdi5wAKi85J1IWE7V6WLamgmomTQXvf1RX7sj50SdACmqqSH5T+uBsw/eoXBjMW
         tv/AVoI1dyHgy9p1ZBPUVK2KLVKRUZPnmaUSptuhn47qNXsHskO+TQNJmtAiU2kkk1L8
         Lz6SpY2Tf102zfAGdJ2wvxPlAjce1wKqj9U3kKARfV33aA/hZH/ejHi3ABKoSVUV0nPn
         MqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=th6+3+/w/8IMfCR2lR2H+4RGOZHVexO24U0LOZrmZC4=;
        b=gIBbfj6c2FTzDJRR268O/u2MvyflJtKYsQefwAw5Q0plT+U/fJzIkC/8VfvuOH2WRq
         7ojzsof4v31talppEpyGmI1oDTrZWOBYoffOmyUqlKIgrcyf+bi+Nc2TIDbcog4T3D3a
         2IoKnrlSWXp8qJ5/izMyLUYgVHY/M8uaC7VoEgPVH2B/0SMNdFoNkCRDiD04yPb387uI
         PXJbcJ6Oa4TPkndxIlTvAO6qZAt3A0uxtQMaXJm7M9nJKJzUyr9fnT7Ous2Q9VpfKab8
         nNA3YIzKUS9JrSqZpK0dzc7Q+5K10ebnUrK4gO0QIb5ybLD94fsw3fdmc4P2/x9AbJ6C
         MpMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jglisse@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jglisse@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Mon, 30 Apr 2018 18:05:58 -0600
From: Jerome Glisse <jglisse@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?utf-8?B?0JzQuNGF0LDQuNC7INCd0L7RgdC+0LI=?= <drdeimosnn@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: stable 4.16.5 hmm build error
Message-ID: <20180501000557.GA3373@redhat.com>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
 <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com>
 <20180427073004.GA12770@kroah.com>
 <CAK8P3a37b+3oW8vKS=pYi897uK3qySt0Cd=jvufqLc+h+ATkBA@mail.gmail.com>
 <20180427083006.GB25242@kroah.com>
 <CAK8P3a2b81P_i2fX+RukhKiVwSUah2y5yPkQYUYU-Tr7yM3cog@mail.gmail.com>
 <20180427115147.GA29227@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427115147.GA29227@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598847241183995427?=
X-GMAIL-MSGID: =?utf-8?q?1599218029640674431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 01:51:47PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 27, 2018 at 10:44:58AM +0200, Arnd Bergmann wrote:
> > On Fri, Apr 27, 2018 at 10:30 AM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Fri, Apr 27, 2018 at 10:17:42AM +0200, Arnd Bergmann wrote:
> > >> On Fri, Apr 27, 2018 at 9:30 AM, Greg Kroah-Hartman
> > >>
> > >> which you backported as 25df8b83e867 into linux-4.16.y after v4.16.4.
> > >> After that originally landed in mainline, I found another build error that
> > >> I fixed with commit
> > >>
> > >> 9d8a463a7016 ("mm/hmm: fix header file if/else/endif maze, again")
> > >
> > > Why does that commit reference:
> > >     Fixes: 8900d06a277a ("mm/hmm: fix header file if/else/endif maze")
> > >
> > > when there is no such commit in the tree?
> > 
> > This must have happened when the commit that introduced it came through
> > the -mm tree and got a new commit ID between the time I sent the fix
> > and Linus picking up the patch from Andrew. I try to hand-edit the
> > 'Fixes' line when I know it's a patch in -mm to say 'Fixes: mmotm ("...")'
> > but I missed that his time.
> > 
> > >> This fixes the issue that Randy is reporting now, please add that into
> > >> v4.16.5.
> > >
> > > I tried, but it does not apply cleanly:
> > >         $ p1 < ../mm-hmm-fix-header-file-if-else-endif-maze-again.patch
> > >         checking file include/linux/hmm.h
> > >         Hunk #1 FAILED at 376.
> > >         Hunk #2 succeeded at 498 (offset -52 lines).
> > >         1 out of 2 hunks FAILED
> > >
> > > Am I missing some other commit that went in inbetween the above patches?
> > 
> > There were several other commits from Jérôme inbetween. I don't
> > immediately see where the conflict came from, but as my patch is
> > basically a revert of Jérôme's, and it was working in v4.16.4, maybe
> > it's best if you drop the backport of b28b08de436a for now, let him
> > comment on whether we still need it. I had not seen the build error
> > he referred to in his commit and we know that it does cause a
> > new one.
> 
> That's a good idea, now reverted, thanks.
> 

Sorry for the delay, i was at LSF and then on PTO, now i am traveling
again :) I will look into that latter in May and post proper backport
of all HMM related patches (i need to do that for much earlier kernel
before HMM was upstream).

Will test for this build error.

Thanks
Jérôme
