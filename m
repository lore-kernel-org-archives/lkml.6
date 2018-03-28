Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522234975; cv=none;
        d=google.com; s=arc-20160816;
        b=CeBXjuyCfRy8F8V4TQFvl4hdcXYe7abruGXjQuWhRkAJdR3XlcvnPa3Ok+KsuCW5rP
         H/EE+BjFEYfQmMmZxSBu6HgJK0GGKXtNGYwrTawWOAhRIH7TN4s4LDpmD8Xe0BzQbW5+
         L+1GKjs59dOZoSiJBUhVtMZzbGCTj5fE0eus8air0+ZjWFkeTTSLUKIQM96BSlFFAS88
         8YPArodF0ESeJThhj2L65xnQRaVg2HL7LLD9h+YStjaUgn82H6jErBiKV0jsoq6cVLrl
         OFELiY92DJ35sf2DnoC1x7BXjd4/BQS/zi4S7/hyHYCDLCov0fT/JOHb0mJLR3vvfGEE
         sQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=I7z03aN7o54iOjTct1aVNAMWe5IVxzDI9plbMhl2kd4=;
        b=HUAPxLv7Z1TJJ5l7YC7qE78OEsYQjd3hCcbt7fkvxOyz+Q3exdXIpUXWWQaQ82858P
         FmjcXh/7l8VxmfiPk4xjr35SWJbStdYLRcYD8b6Ms4F4ZiguHontfpD1jHIVSx3jRuOf
         +x9dZxi68cEi1sju8I8P/thTwQCWdCeQZD5SjnaXeLdtBeDoafPaLSjCtQQYz9v8xbfX
         Es1YerKaazVk4kdmiLMkG7zqnWE+ekMA1c0AsZkGh4UksJZYGB4o9w+kT+xxRdAZjk9p
         nz8VAnykfCLEasE4uPbcRc4fgzpAIPVbx0SsKuZ5avQT4VNEbW5+ZcldyOavibmrPb6U
         yYvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ncmmt1bT;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ncmmt1bT;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+owVL2BYF1b/LHktGGP3ShbOoAj2FfAM5B7K156ptdcMzDhJCFxoc/hvpAqjeLNdMKLgDw7w==
Date: Wed, 28 Mar 2018 14:02:51 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	stummala@codeaurora.org, gregkh@linuxfoundation.org,
	sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
	penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
	longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
	ying.huang@intel.com, mgorman@techsingularity.net,
	shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH 01/10] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180328110251.5wl3kwjhcuizyz6n@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
 <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
 <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
 <20180327091504.zcqvr3mkuznlgwux@esperanza>
 <5828e99c-74d2-6208-5ec2-3361899dd36a@virtuozzo.com>
 <20180327154828.udezpkwkwzcftnqn@esperanza>
 <635e8bdf-9280-c872-49c3-d3e293e1b332@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635e8bdf-9280-c872-49c3-d3e293e1b332@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596179061331959389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 01:30:20PM +0300, Kirill Tkhai wrote:
> On 27.03.2018 18:48, Vladimir Davydov wrote:
> > On Tue, Mar 27, 2018 at 06:09:20PM +0300, Kirill Tkhai wrote:
> >>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>>>> index 8fcd9f8d7390..91b5120b924f 100644
> >>>>>> --- a/mm/vmscan.c
> >>>>>> +++ b/mm/vmscan.c
> >>>>>> @@ -159,6 +159,56 @@ unsigned long vm_total_pages;
> >>>>>>  static LIST_HEAD(shrinker_list);
> >>>>>>  static DECLARE_RWSEM(shrinker_rwsem);
> >>>>>>  
> >>>>>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> >>>>>> +static DEFINE_IDA(bitmap_id_ida);
> >>>>>> +static DECLARE_RWSEM(bitmap_rwsem);
> >>>>>
> >>>>> Can't we reuse shrinker_rwsem for protecting the ida?
> >>>>
> >>>> I think it won't be better, since we allocate memory under this semaphore.
> >>>> After we use shrinker_rwsem, we'll have to allocate the memory with GFP_ATOMIC,
> >>>> which does not seems good. Currently, the patchset makes shrinker_rwsem be taken
> >>>> for a small time, just to assign already allocated memory to maps.
> >>>
> >>> AFAIR it's OK to sleep under an rwsem so GFP_ATOMIC wouldn't be
> >>> necessary. Anyway, we only need to allocate memory when we extend
> >>> shrinker bitmaps, which is rare. In fact, there can only be a limited
> >>> number of such calls, as we never shrink these bitmaps (which is fine
> >>> by me).
> >>
> >> We take bitmap_rwsem for writing to expand shrinkers maps. If we replace
> >> it with shrinker_rwsem and the memory allocation get into reclaim, there
> >> will be deadlock.
> > 
> > Hmm, AFAICS we use down_read_trylock() in shrink_slab() so no deadlock
> > would be possible. We wouldn't be able to reclaim slabs though, that's
> > true, but I don't think it would be a problem for small allocations.
> > 
> > That's how I see this. We use shrinker_rwsem to protect IDR mapping
> > shrink_id => shrinker (I still insist on IDR). It may allocate, but the
> > allocation size is going to be fairly small so it's OK that we don't
> > call shrinkers there. After we allocated a shrinker ID, we release
> > shrinker_rwsem and call mem_cgroup_grow_shrinker_map (or whatever it
> > will be called), which checks if per-memcg shrinker bitmaps need growing
> > and if they do it takes its own mutex used exclusively for protecting
> > the bitmaps and reallocates the bitmaps (we will need the mutex anyway
> > to synchronize css_online vs shrinker bitmap reallocation as the
> > shrinker_rwsem is private to vmscan.c and we don't want to export it
> > to memcontrol.c).
> 
> But what the profit of prohibiting reclaim during shrinker id allocation?
> In case of this is a IDR, it still may require 1 page, and still may get
> in after fast reclaim. If we prohibit reclaim, we'll fail to register
> the shrinker.
> 
> It's not a rare situation, when all the memory is occupied by page cache.

shrinker_rwsem doesn't block page cache reclaim, only dcache reclaim.
I don't think that dcache can occupy all available memory.

> So, we will fail to mount something in some situation.
> 
> What the advantages do we have to be more significant, than this disadvantage?

The main advantage is code simplicity.
