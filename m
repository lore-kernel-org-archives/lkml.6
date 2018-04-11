Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523476968; cv=none;
        d=google.com; s=arc-20160816;
        b=y/rM2gdwweO3xUSAw4MuofozbbrMa40a7vB2DTPxDyRWVJcOCUTgYfV3emjBZVr8vJ
         WqkK/NBmDDw+HanZdGUiL3hDvidFztrO8WLDJ8CExot3ETl0ZygAYiELv3P3kmdh9aJ0
         8iIwhQq2laz+XX8NLn9UJ8dPTxRUXEM8fkoqctyar6GWWnPgmALyq1z4xUg5Oh1P3REY
         7uMWF05nD1il56DY8eAzl+uqIYGh2S+RADH8MF6GFPMib/M9EqV57vlrA1CnvMNOehaw
         6NUaGjC6oK0+XAeQh7tv2pmu5jKWlt2kMmR5h8oZNN4ujfqS8mAPXTTgIqIEHKFQJY4B
         TIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=3YblijLOLfe55AXEfCl6feQPQFwBPib9WExUPz/7CGg=;
        b=e+JlimaW6RF1R2hsNOGjac1MsihDUQ3FcFfgMyQUBDS/wlkUjtzkoThuNNRzQ290+n
         uSJW8Ha8AvHIjcBFTZqkjunCkHnUSNCJMbMUy/S/KzMVGMZl2eTN4cC3JUaSuZspbQmI
         /nnLWcjMYUXv+URAF5rIEcExQ9zuB/CoT4SPUFOVSziBRGMb1MSrn9EPgZ0GTW0/N4tL
         8aV6Jn8HnNDsnCurGaCHvUeDMzGVf7HqkKuhGgRThml7vebCQYqxdv/nivDKmhz60ESI
         mwOikYKTg2JxGcS1mXHwkRcOOFDp94VhYQ/mJWJJR9afnhlhweRKiRyfTpLFvcY7hVCc
         3iVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qk2/T0Kx;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qk2/T0Kx;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx48nZxXb7RnAVDloja8EYU1Z3RM+7bPDwIFnLd8ra8BL3n+6+ye0lybNV+wWCxQZCyF964/zLQ==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 13:02:45 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411200245.GQ793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
 <20180411190027.GA21274@gmail.com>
 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
 <20180411195700.GP793541@devbig577.frc2.facebook.com>
 <6e2d8be78572fef5fe8f2e0e7ecbdea5839dc198.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e2d8be78572fef5fe8f2e0e7ecbdea5839dc198.camel@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597481385285255280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 08:00:29PM +0000, Bart Van Assche wrote:
> On Wed, 2018-04-11 at 12:57 -0700, tj@kernel.org wrote:
> > On Wed, Apr 11, 2018 at 01:55:25PM -0600, Bart Van Assche wrote:
> > > On 04/11/18 13:00, Alexandru Moise wrote:
> > > > But the root cause of it is in blkcg_init_queue() when blkg_create() returns
> > > > an ERR ptr, because it tries to insert into a populated index into blkcg->blkg_tree,
> > > > the entry that we fail to remove at __blk_release_queue().
> > > 
> > > Hello Alex,
> > > 
> > > Had you considered something like the untested patch below?
> > 
> > But queue init shouldn't fail here, right?
> 
> Hello Tejun,
> 
> Your question is not entirely clear to me. Are you referring to the atomic
> allocations in blkg_create() or are you perhaps referring to something else?

Hmm.. maybe I'm confused but I thought that the fact that
blkcg_init_queue() fails itself is already a bug, which happens
because a previously destroyed queue left behind blkgs.

Thanks.

-- 
tejun
