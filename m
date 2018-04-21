Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AB8JxZpLwLTCDd0nSKEUxxCLBZ2AZ1yEHCmrvAWzhPOPaJ1HxHy7CKOqisqODr/BM29wpadMa1fN
ARC-Seal: i=1; a=rsa-sha256; t=1524307304; cv=none;
        d=google.com; s=arc-20160816;
        b=uurd+F2u991v5KMMsLN2FmJkPUNxu0lqEvQH355t4fDArHi8kmCjzRDUpjQ9McPLT3
         p5+wJ2iITHqm/jgpj9eBIA/RrNe2mmV4AqQa9HkODoTiemHBvCI0nojmnOl76dRaNKrf
         M8tFLu4vx9RYUi4mGNT4vJas/xtJr7IoyyA6bcdl3ceTVjQUYXwvXgz+o/Qs1O5zPjsY
         ZxMgIU3Lwzid2eTbEM2k6wERk2T/TjDs2KuWdsluJPm5f/C+19qg2Qf4dlcxzsElJr6r
         rBjBQfqruTA902AXsNNL5xDiSZBobfmPY+5O8bcno9VCbSQAAGQo5NDVTnt8TPAu53Ir
         R64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=+EQWhNLpvIZUKZM4TqXi6L6cfymXTPaq/XGQtDtte0w=;
        b=uB/puxe9vFcVXF5CiTnu9mI7hn/k07HIFbz8AU41anwD8vSBtWu2zkVoOdxUpaXn/Y
         TtSGZsqaCjFGHMB9lBX5MMrgsR8clODspFaYFS5bWxYbCSvIViENOBrER+esSITw5RxS
         VkA7RL2HvIaSOdMu5UMu6uLEO475cdX/NDJiDq6IwRWqMY+YgwDFaTxl47akSmJtzez3
         DVYk0h0eeEMDsP2LIsqjGcZO2cpv2KPXtwULV64RrmyQonZEdFdfRrx3M9JqAV/xrOLK
         Qo26P3mo4vxEqDY8DwRDgPibcGd3EzHo4HaHo8FVa9OOEBrySEUagc5eiupJoKCJ38M4
         yI9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: WARNING: refcount bug in put_pid_ns
To: syzbot <syzbot+66a731f39da94bb14930@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <001a113f8bf6c849030568bb75d3@google.com>
Cc: gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pombredanne@nexb.com,
        tglx@linutronix.de
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <44a322fa-6341-4b88-7f54-705c039f1538@I-love.SAKURA.ne.jp>
Date: Sat, 21 Apr 2018 19:41:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <001a113f8bf6c849030568bb75d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596487607739609259?=
X-GMAIL-MSGID: =?utf-8?q?1598352055916545205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/04/01 5:47, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 9dd2326890d89a5179967c947dab2bab34d7ddee (Fri Mar 30 17:29:47 2018 +0000)
> Merge tag 'ceph-for-4.16-rc8' of git://github.com/ceph/ceph-client
> syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=66a731f39da94bb14930

OK. The patch was sent to linux.git as commit 8e04944f0ea8b838.

#syz fix: mm,vmscan: Allow preallocating memory for register_shrinker().
