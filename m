Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523457979; cv=none;
        d=google.com; s=arc-20160816;
        b=AUCBn17arCzvAUg5de+0df6dxrK0jlg2atUnqHZf+aE/Qe21O97nvlVx4/j/LY4HYw
         JjME0UE9U70Eylkl5EUZAaP3b9vNZXgaf/MBsw4Jmi0BQttct5jVBrJqKVI3QkZJvr2f
         Cw/7CYWK+leykwA0XzKbkpEyK7XPr00ipMoMoevpy6DIlnhgROOoG8lkBoF+GGSP+fts
         /eKQNb7oRKXf53Zjf7hT6kJ/YxMxP4XOfYUBZUpL2s5zEqpXqRkuwarlXEhp402rioXG
         JS9KG6029i+rcgbk5fLWuD5zo/b3pW9NvEKo//sI8hs0SBjI5mZidsKZp4oiX6MQIGUX
         0Ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=9tkFsbKdMCaggJgTdvoDQamniKNS4e5a1WIGQ6JaYE0=;
        b=vnYLyEn3tB8BAmPSPgma85GWKUdsAUcYhf52ZtUKIOIaC8jNaA9683c4zHL5m6fcbD
         +Z+Wyd0/R2D1cDGjjhPPG0GgJ4+MYPsP+4/dB4ecjhKD4ltPRlVxFtFlMsvD7yMo/xM3
         tZ5rf71F+ZoJP8zGXjbXIT4ttSYY4RbQonVOq+nfosM7aGDjQgdxHYauluNzUP8G1rNJ
         X+K+kLcGE7TquPCtrJ08BQ8EXeeHNjP8IBTb7XaqaxuVpOoF8HIfUCNl87C33t/b/BOE
         GXYecke4Gl6MDJphRm1Kvyi+eHtdNGuKGHpGELRdQ2GthOTtTWAbalra/LPJZT1nZYc4
         LUDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XGHtKFjF;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XGHtKFjF;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx4/slHpycYNjRwwlfrfVJJl6TWfE7NkJUZXXjvkO9zMSTPAxBG+9riMhXzHU2F7KYUedbQMLRw==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:46:16 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411144616.GI793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411142859.GB2322@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597461473848122571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 04:28:59PM +0200, Alexandru Moise wrote:
> > Ah, that changed recently.  Can you please check out the current
> > upstream git master?
> > 
> Just did, without my patch I see this crash:

lol I was looking at the old tree, so this is the fix for the new
breakage introduced by the recent change.  Sorry about the confusion.
Joseph, can you please take a look?

Thanks.

-- 
tejun
