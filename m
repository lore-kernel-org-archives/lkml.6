Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx49JhmEgARymMsEMVscCt1yHh4cBwU4KxHb4sMgUarPgVTnEbkqA09UGF2ns5KNZFcn0Vdjh
ARC-Seal: i=1; a=rsa-sha256; t=1524060999; cv=none;
        d=google.com; s=arc-20160816;
        b=QwW3dbOCGu6eFdWuCeRO8LM2YdSsX+tbi3BWBytMQyax2XkN4Co4ZwoaQPL1RU7ajy
         3jA4QI3WiUR922j6p9gVYnC1xaVSglUGCyk1QY23AETxSyYqHwXwMjgj7Vj7bwQYRaiH
         mEvkZ2SPwfifMtyBiOzmXqeK1pRQpgvOWL0lZH1kQE2Sb/TmBOpVHZjUkaFoWiEUfGcO
         DKiwWddhcT/E1T96m+HyCE8EJI5LZujOcMKK4ZTxfMyNO+1JVH5Uf6me2ojCHfMlEZ6l
         85GwEAkTxNmXGAt2pokq8NGyBwj7kVh0wwSNTKbO48fRUwkOG/XWLkpFLHbd003scAeX
         QQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:message-id:in-reply-to:references:from:subject:cc
         :to:arc-authentication-results;
        bh=WTOEDBi9ShVxmoCC4jT56ZSrh4U4aDp4oZTNzZQRQvQ=;
        b=PCUPw6F3gbE5n4v/nS8c6po+kUMX40ZC5EVdsUxM29/0PvTu1btpqnmd60NpGs9Iue
         syG1HjLUpKY/w3J5nWMkLWg3meQDhvgX5PlJNR5BlgtpionTnrz0FoJ62cAbFRbDSZLb
         0VIDuEmnRdCY9/+7+/Ah4Jktu1dE4HyUoFZU0pvIEGHF2nUOEbXReVeM7Mk4TQhX32wC
         qwM8iKTavUffxalDRHM/N+FWyORPMjwTl1MTuYygFyXniOer+YnewYC5/TaEpVcOZF/5
         RtD82Q0/wqMblvuTgQi7nOOpUXEabPWVipJE2nXopaXKT+TxNRjxqTEFxqHGAFC0kZHW
         isng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
To: ktkhai@virtuozzo.com
Cc: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, chris@chris-wilson.co.uk, longman@redhat.com,
        minchan@kernel.org, hillf.zj@alibaba-inc.com, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v2 01/12] mm: Assign id to every memcg-aware shrinker
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
	<152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
In-Reply-To: <152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
Message-Id: <201804182314.IIG86990.MFVJSFQLFOtHOO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 18 Apr 2018 23:14:45 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009267479229519?=
X-GMAIL-MSGID: =?utf-8?q?1598093787051671361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kirill Tkhai wrote:
> The patch introduces shrinker::id number, which is used to enumerate
> memcg-aware shrinkers. The number start from 0, and the code tries
> to maintain it as small as possible.
> 
> This will be used as to represent a memcg-aware shrinkers in memcg
> shrinkers map.

I'm not reading this thread. But is there reason "id" needs to be managed
using smallest numbers? Can't we use address of shrinker object as "id"
(which will be sparse bitmap, and would be managed using linked list for now)?
