Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523458285; cv=none;
        d=google.com; s=arc-20160816;
        b=1DHHD5HmOqXzA0LLRqcgkFy5TvwhPlx1vxLDjDqV4T9bTXrkedQIK/vLdsPOeaWdT3
         KNNna8YgNkIal52mM86SjLwR0dPnGNE2hby1+nLDqPS0XuZlwpfOgX5I3mYnM+9pVyq5
         4B2UVW29MVNEyAc0xROZmWwgeRHMg3TXVviqeiBntxLIyMuVR6ff0BgCCx9VPY0CYwnS
         /Dj+81xZbAbLj+NrrqNzeoFlQABoK98P00XE0TT1cbZVGjGGH5jahAxV6CJapsC9criE
         R4EH6JHnK4b1WuLPiCwtbCYgKPyRO13oqV4/MiC+pERnqOw5MYUqs1ja0WFr+BYkZT1l
         jzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=i9+5GakFxYpJRr7zvzP+WQ4+XZrb0jL0jhJxBrxyCWg=;
        b=mYCRby6LFIOiq0/r+Ke6nfpFrKU+prJu4qcxLevQKj6kt1ogZkb7J8oCeT2DYQJBBf
         yTQGAyO+RQmyVuWzvTfOIVOriYth40CJWiJ3vr2D7ryWcn9Lxji0618HDGaa6h5CKJpG
         Ir9zKWvQr868cIfFp2uAPP91q3+DZ08O+EoupN6XcU0ALfIJhmAw+KYwhYzd4RGeg4lt
         X+qaFexspSCAnbqRgJClxxhAeJFPo3AtMPxZQzU1ZPTvSVb+bCKD9Qz14y8Kr/SLTyrO
         eHY3+TkgHtRLtm9AmeN9c4hCtsjV5p7O6n/RT5JVKpLc/3A3Y46gtK6pbZI+Y4bHnKgr
         Sc8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=do8jN0eM;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=do8jN0eM;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx48bo3pTEyy0aorMxywTZGvj/yM/w1kI4QXgYHAjwffFp1nkRLE4oMvCNk+QH4YADHm8yLZzJA==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:51:23 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411145123.GJ793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411144616.GI793541@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597461795591401263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

(cc'ing Bart)

On Wed, Apr 11, 2018 at 07:46:16AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 11, 2018 at 04:28:59PM +0200, Alexandru Moise wrote:
> > > Ah, that changed recently.  Can you please check out the current
> > > upstream git master?
> > > 
> > Just did, without my patch I see this crash:
> 
> lol I was looking at the old tree, so this is the fix for the new
> breakage introduced by the recent change.  Sorry about the confusion.
> Joseph, can you please take a look?

Oh, it wasn't Joseph's change.  It was Bart's fix for a problem
reported by Joseph.  Bart, a063057d7c73 ("block: Fix a race between
request queue removal and the block cgroup controller") created a
regression where a request_queue can be destroyed with blkgs still
attached.  The original report is..

 http://lkml.kernel.org/r/20180407102148.GA9729@gmail.com

Thanks.

-- 
tejun
