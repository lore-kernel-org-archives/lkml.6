Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523466941; cv=none;
        d=google.com; s=arc-20160816;
        b=YxTUwB63qsu4eOnxylN/QRKvYYm5zxELEGQG5l//Vb9CmNOajZdqRqSL3UDSPWeUFT
         JIqH629jHGhozdo0AI11eZS/1JcB8YUJdVUscYbPAVIWMvt7SDmkN0XxZI4BYb+siIyo
         sOtX5psVOPRRafDOVan8IAMHptvpqojMBou303at6nw0EEKMfABHYhJbQGNCP9WWGame
         ibX/krDTtyCX9WFhki/blmTsIGP/Ro8v6iGkXE8iNj4gOzGDU7oJ38yMPbAuvOsQvk81
         3F6BKaFcpgK/chSNjsfPr469FlDav545rPxpXONKB4/BxUbuF3CZkxLkz/F0Ilc5artG
         HttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=LtjK+V7HfaHCJayAEv+h83WuJ/MxLZSre2F8ToIN2r0=;
        b=EvgCbFPT+PoqgkH294tH24ZnhopciXD9SsLrzXGFHR3z+46CnpiZqbR4vCE907rhqk
         fY1AbnOh2yLyX+uPEUQjvk/oRbO7Z4CEPvS/MdJHkn3nUZWBzeeKion9kASLXKwG4ca+
         f7D9cclr0P73OgO3EZs/VB7PCNZ94n4mOsDowpF1mg0jyE9CXl2orLu5Au0wYe4rQMuE
         kVMb47LgHO0fD3C4DpQVtcBq4eopmGMhRsm52qLLeVzlOh0+hOqCPPGHiLhWd4RiPx1X
         W1RxpmNLN4m/BchU9Hr9GY1aaLYTRzDS2BnQY8zieO2ZX0M8Mj8HlwsAXd4A4dxcDANQ
         K9gA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rfkn6+TA;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rfkn6+TA;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx4/GegQm0jXNRceJLJIesKWwUIioc20opNRmhscH4m4746sEN6+55UMhMFxuVvysRT/1+x9kFw==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 10:15:38 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411171538.GN793541@devbig577.frc2.facebook.com>
References: <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
 <20180411145632.GK793541@devbig577.frc2.facebook.com>
 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
 <20180411170018.GL793541@devbig577.frc2.facebook.com>
 <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597470872085639551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 05:06:41PM +0000, Bart Van Assche wrote:
> A simple and effective solution is to dissociate a request queue from the
> block cgroup controller before blk_cleanup_queue() returns. This is why commit
> a063057d7c73 ("block: Fix a race between request queue removal and the block
> cgroup controller") moved the blkcg_exit_queue() call from __blk_release_queue()
> into blk_cleanup_queue().

which is broken.  We can try to switch the lifetime model to revoking
all live objects but that likely is a lot more involving than blindly
moving blkg shootdown from release to cleanup.  Implementing sever
semantics is usually a lot more involved / fragile because it requires
explicit participation from all users (exactly the same way revoking
->queue_lock is difficult).

I'm not necessarily against switching to sever model, but what the
patch did isn't that.  It just moved some code without actually
understanding or auditing what the implications are.

Thanks.

-- 
tejun
