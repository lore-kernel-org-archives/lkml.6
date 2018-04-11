Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523476622; cv=none;
        d=google.com; s=arc-20160816;
        b=IbaykMVovmHk/yjdFuovK/Be56L8prrocZgnSZgf7K/tG4+7Uo3Ow/KAk/Yo78EDEm
         h9eRVFAJTGrAe7oc2FSl0XCYRl17CR2N5Nejy2Dexmz6PPMnIj/NAL2Ise9HPwNyPkU3
         Gb6V+anGqvEK7b3kGFbdK6KlDKcil6TOkOT9cj4RL5xp2gCC7fpJ89ASeJy2LRqTP3Q2
         2WJ7uOcv/bbvSH/VhBjmtfExX1D0E/mqiRSxGhY5Q0pTIB0lCR25D5x58BAXuXa6Axxd
         WGyM2/6pA4s/3ysHPKYffqj/ObIRD3rIj/Sy5gneVl+BBiYif9gDsleT7ow7lUT8tR8N
         vIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=0G4Jw01aM3Z1JJbDP8HVlPCT9wNUZGWilxO1Le/qho4=;
        b=r4HomrhIvQtsbbbKLMg82/ETlTxi7unRUb5er9Kx5mQm/ymUN9f6nSlb9s2qyD+lZE
         TyLG1ryK6fXJR6dewPoyyn09UvfnH7wX2XBu2jh1kqXGrWWQu6IOHE+RE13Znt2nLh7g
         UQpJpFkFKEecxot+06Bj27IpnGCzFFYODg5QGoxAp67fSDJr1LP5cc6LAtJf2+WVDWt1
         lTSoTAmGe4M+d+MfzyZ5SIht+68tiG9mjblQYZ+fGxpbG6s8BLJMLN4KHVmEF67yUvjr
         x2dhCSSuALhzh4Sfsin+KDvHfN3+B6P7EkF8dpNpsiXJ42APGrIXvmp7okSe0vUHcSPF
         D+JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NO7HALrQ;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NO7HALrQ;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx4+rdLIiDmvPsmnQqlMzgV1UVqEOuSVKo44ZdPUUGX1boniHG49/tKLC7kf/oTaUP8+F6FOqiA==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 12:57:00 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411195700.GP793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
 <20180411190027.GA21274@gmail.com>
 <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597481023202996448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 01:55:25PM -0600, Bart Van Assche wrote:
> On 04/11/18 13:00, Alexandru Moise wrote:
> >But the root cause of it is in blkcg_init_queue() when blkg_create() returns
> >an ERR ptr, because it tries to insert into a populated index into blkcg->blkg_tree,
> >the entry that we fail to remove at __blk_release_queue().
> 
> Hello Alex,
> 
> Had you considered something like the untested patch below?

But queue init shouldn't fail here, right?

Thanks.

-- 
tejun
