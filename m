Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx4+iuHIj/Veek3MB1SEBF3h8vIj/m1RoSXEHn8Uwb6ixXPALZ9j5oViZDBmemdhA69/MWtqw
ARC-Seal: i=1; a=rsa-sha256; t=1524654249; cv=none;
        d=google.com; s=arc-20160816;
        b=v+kiG3eDN5Sa7xOWgOfgXDSkisJzuvTuqK7RHBweT/b9iH1iIjrTiFickZLzkPQr0q
         vXrvIBtl12fiPs4OsHONbSDcY6u5pA9ey11f7Rggibt/rSf409EetpwP9eanP/zw1nFZ
         7NN+nv/hH80WsaVWPx4heqbyil7c/j8Mt7XYDAoJV/gucDTMmSXziAGvUPIP/py+FP//
         qfQNh6v+209wFZmwdyxAjwzI/uzng+H7BZAauFwv2cN4HQqCSYMTJ8T/9hRwIvfEWfcF
         E1mghHSgDTCRNjgN74zQlkiTquT1LkaC2J30+DE7KCzwkU9nzSxA5aUVavHfy3M0E2h3
         OoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :arc-authentication-results;
        bh=S8rHe1OQlm6+IgBo6XgxE6BbyMDXl9cvrfFd/a64Ufo=;
        b=LXoqeGGd/qZjoGB+0tAEJYFFGqcgLvBYO7tnNyYsZpXZsKCcg4l31aef1caYt3xvr9
         x7fEkCHOtfUE7ZwyD+8sFQUQx8OakUaT+T35cjT9klnSY8Pq1L8+HnrFxx3+jfUPhjRp
         WdpgVDpH1ClEUEFCbPVEmkILdBBWswNFlHe5IEg2KPykOgXgMHtpaXSWyX3lgLFsknT4
         eCGfuCZr9+sSA7YNxdzIisRLAxfdU8i6xsswRtyzepH3+mQTlXNoeD9CAADFZzmqEwLK
         3SuBqXxCpDscji2MitBt2+kPrwQjPM3lpBJAUGAuER+WjuyyLTOUjDCqdEh3V90U/zxy
         9KxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: kernel panic: n_tty: init_tty
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot
 <bot+57840b4d2cc5c46981d5b9e07c9b7b06d5bcf064@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org
References: <94eb2c0630b4161a5e055d38a2e3@google.com>
 <20171105103434.GC1487@kroah.com>
 <15c6c6bc-6592-8f0c-db84-647c5760f1d2@I-love.SAKURA.ne.jp>
Message-ID: <58c8ea57-81a1-1240-cb35-73dd153e5137@I-love.SAKURA.ne.jp>
Date: Wed, 25 Apr 2018 20:04:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <15c6c6bc-6592-8f0c-db84-647c5760f1d2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1583216279267837963?=
X-GMAIL-MSGID: =?utf-8?q?1598715854384868362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OK. Patch is in tty.git#tty-linus as 903f9db10f18f735.

#syz fix: tty: Don't call panic() at tty_ldisc_init()
