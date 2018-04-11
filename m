Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523456421; cv=none;
        d=google.com; s=arc-20160816;
        b=ONSfNVUS1A8vjytVL0Mw0rI17INMU7bmEivGYAzRds//2ZKxM52VQpYFyReabhlAvc
         cFO9BSSIJUO7Rfk+Okap1o2iSwrYMv8iY4r+mYAP1xTXe2sqKSMXu+F9TNNDwsuC0jE5
         4Fyy8eQtacA26W/vk3FbIO+dQAtx6rHd6N3kqtSxLpcRmo5jPcvQ4lxX5c1tvttY/ZLK
         s1F1mxdwZPvvatn+N4OsEDXHg0ByE9DE/hr0ZbEMMC5ELK9G2wf2WhdiIRYdsEQv9yCb
         Kk0HkEJs0dw4hZkhq99Z59nkCFw6jbebw1/xWhxpDE8/jtjewaXzcdsoTufL251M6WBg
         HyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=uh6tiAPBbLM4Q7zu8KyCyNy4SPP7dKoKjGYLGQHdgk0=;
        b=a5soXxj38L9qR3wUs3OQtJjANaTi8petnw3pKY2hcjfVc+ZITaOtWrn2xeKZpXv9PP
         HSIJ7W+Q5rwmgidJ1JvSEKOme46Gbmn52TJzLLMusxX+CilibqGttxko+K/8XI04DsFM
         WxUGS6oi/QjY7rarUXYdttCfFAPxewq6acfywQEC5vWVgXKiKILxXwxQGc3VmzKE26ZX
         CoI/k+w6Jo0oaZTKzk3Ie1cBY6xhPVc34H55psRnmU/CcypEFkG28eJZ0elCaOfjLfcF
         NMzpYmryVGfq+1ex2di/NvqmEoNCOM4oM3YRppKIR6cEkJzP9ECiHWl8QpDn0N7vJJPp
         TlVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HetAPmMP;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HetAPmMP;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx492oXQCl44xNTRbEBJJymWdYaxBfmIEmCoGV4auxKf0Jgx1IF0G/s3NmYOyj4UfAcK4U08Vfg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:20:19 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411142019.GG793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411101242.GA2322@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597459840917393424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 12:12:56PM +0200, Alexandru Moise wrote:
> > But we already do this through calling blkcg_exit_queue() from
> > __blk_release_queue().  What's missing?
> 
> Hi,
> 
> It might be the jetlag but I can't see how you end up calling
> blkcg_exit_queue() from __blk_release_queue().
> 
> As I see it the only way to reach blkcg_exit_queue() is from
> blk_cleanup_queue(), which I don't see anywhere in __blk_release_queue().
> 
> I suspect that I'm just fixing a corner case though and
> the general case is what you describe or similar.

Ah, that changed recently.  Can you please check out the current
upstream git master?

Thanks.

-- 
tejun
