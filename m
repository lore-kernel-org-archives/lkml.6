Return-Path: <mhocko@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1785790-1523969370-2-6128749506980569125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.135.220.15', Host='mx2.suse.de', Country='DE', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: mhocko@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523969370; b=TAld6T6uEiF6L4a10buOtyfuJbACb7JmjKdHKiTkfJM1Q0nlaM
    Fy35TEl+RBZBMQOvgrUCT6SbeTU4jJ2Xy0zR7VaPHh98BKN9a218a3aof//YwfbO
    G1cafjLW+jqchPO3IXyZzGpgIitesXMV0X2kWmiEs2sUg+u5U6EsDJa/7esdjGb/
    q23ZKMd5KMmwFRiIi2DqbTshrwzH9p3J+uCssDviutNAVWuGPYmAfVJv2bjqQL9E
    dQoTyaQhrzi58vKBy/RNozc+5Zsx4OYrMXQmS+nJvDUN0JA3cxwmcvTHpKVxguNt
    BY2PLdrKE7s3Z4/8RBa32Szp9F20ovIQE6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1523969370; bh=y343F4aYQckCDTsGz6PMr86Q7hypPBVSS7Fh6LuHq5w=; b=Y
    DU8LBsTeuu8ZCVs3sXAC6TBqZexiJjQMZT2kEkZ6ZDeXCatnvXZK3usyEdiBerEY
    Epo+MyaD6khn79Iu4QVO8DioPaKSqczRqUH9jfZSeK4vi/Y7cgrfiasRIjIHW2Ad
    6+BJTl3WqLE7S4aURgigAEiH6ABDi3uOwg2Qt2cEsVwo97b2/dSg89yreezYidqZ
    sqDYGZb704zgPqZY02dhCHYeiTlwNzKhlH1nK3cOIUZKFmio4hsvYB8+82eUxo9I
    Az3qhsZmugbWy707XimURRpxNpVi1OthrN8+Y/Dh+vRM0LXmmSVtHq2WuF+Q34Hs
    EVUAy1OBzTOgaeE2WiNvA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=mhocko@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=none smtp.mailfrom=mhocko@kernel.org smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJVaMRWIYqR7J7CkRxyLVCOCJ5poKgCRSUkb1H0ki+ol++HPSy4CEl3/olFRzKep/uyIF7rwihiPElBB1m+SugAxFvkm2GP79lp0G5hWdko//oiYQuUV
    GCIw+94jdgH262CVYLLKZ5bvY8DYiIUVIjKuPcha+UEAEwjQaRHzKlNyBB4gNfrR/ze3ExG6oRnSyg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=uEuDQZVrWKuLCe7byFjfVg==:117
    a=uEuDQZVrWKuLCe7byFjfVg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=XDS4CVwrf6oz_BVxQH0A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Tue, 17 Apr 2018 14:49:24 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180417124924.GE17484@dhcp22.suse.cz>
References: <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm>
 <20180416170010.GA11034@amd>
 <20180417104637.GD8445@kroah.com>
 <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 14:24:54, Petr Mladek wrote:
[...]
> Back to the trend. Last week I got autosel mails even for
> patches that were still being discussed, had issues, and
> were far from upstream:
> 
> https://lkml.kernel.org/r/DM5PR2101MB1032AB19B489D46B717B50D4FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com
> https://lkml.kernel.org/r/DM5PR2101MB10327FA0A7E0D2C901E33B79FBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com
> 
> It might be a good idea if the mail asked to add Fixes: tag
> or stable mailing list. But the mail suggested to add the
> unfinished patch into stable branch directly (even before
> upstreaming?).

Well, I think that poking subsystems which ignore stable trees with such
emails early during review might be quite helpful. Maybe people start
marking for stable and we do not need the guessing later. I wouldn't
bother poking those who are known to mark stable patches though.
-- 
Michal Hocko
SUSE Labs
