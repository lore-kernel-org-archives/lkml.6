Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx495ZZ74q0akiy6KAJYy88P8F0ERiZCA6mbpD9o0fOD3Ytyx0UqTDFV9tpaDjvXk4nk3eKL0
ARC-Seal: i=1; a=rsa-sha256; t=1524362721; cv=none;
        d=google.com; s=arc-20160816;
        b=OqFG3FflSxQ8sxDhPSFF4S1mkVU06L5zMTBy0p5zCXk5ccQGj2jauVBNCMEeRIYMiP
         3/E6AAMDk/lJ7lJRfLxrO+OC1I5je8Gs3jqKokw8jIq7XQMoDWXV3uWiVEqZFD9nUMXy
         c65Y6iXkr3lRLhGrt2Sk326ghDEPrwSLVC9jZM4rKcX0qUc8hzUTLBf0obZCoDA5GD5j
         YxcKk3KV5Wn3/mQyyHtm8i1Vxkm7h2yDQ7AJuG5Q3GboYtBYml9xZc1yWUiSDaFLbr1B
         uiSv3K2wZjtTaIm+rzh+1LoRwUnCg3bmk75QXSe+BZ/MA6fjRlAT1q4IAwB/uNVccLOn
         knLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=ERYaOdOyT6xPG/Bw0VWiLO6cTkJQ8tPhdROS/b5P9GE=;
        b=YAFPv9WJont2JW/Sq4DXqGO5f6rQ2ZuHLNJxlCr92GJerx+iWf0pOMvb6J3oYnK7Jn
         c/EBGqmUg6blINdAoupvuoTJqDGFduqZjrJC5+SmGKNJuwUbLDpAUo3eNrjFBhzwAaJ3
         KxBpxtcGjvlULdLOVKn/5rDz3f9lHjWRrRwed7zN0JOigOy/EMPoZY9aOR9ZU07+02Sq
         eOE1QDH0ZHkebhWKnuSGum0PvtrBwb79i3znKJr5hiZdqe8zRkDw2ovw3gB9ajk37SM0
         PKvGoIs/hRD+G/RKDiQ2rJbkRHDMsRs9l1J13TsA+q+PzDUfoEFmcEm3grYBDYmpAEb2
         nWcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: INFO: rcu detected stall in __process_echoes
To: syzbot <syzbot+108696293d7a21ab688f@syzkaller.appspotmail.com>,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        syzkaller-bugs@googlegroups.com
References: <001a1140e920eb829905687391d6@google.com>
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        linux-kernel@vger.kernel.org, tchibo@google.com, tglx@linutronix.de
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9b7f3efc-cfde-df21-1071-a566c970f81e@I-love.SAKURA.ne.jp>
Date: Sun, 22 Apr 2018 11:04:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <001a1140e920eb829905687391d6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596163843273194959?=
X-GMAIL-MSGID: =?utf-8?q?1598410165346350178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/03/28 16:01, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 3eb2ce825ea1ad89d20f7a3b5780df850e4be274 (Sun Mar 25 22:44:30 2018 +0000)
> Linux 4.16-rc7
> syzbot dashboard link: https://syzkaller.appspot.com/bug?extid=108696293d7a21ab688f
> 
> So far this crash happened 10 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4941573204738048
> syzkaller reproducer: https://syzkaller.appspot.com/x/repro.syz?id=5314352743710720
> Raw console output: https://syzkaller.appspot.com/x/log.txt?id=5561943247028224
> Kernel config: https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
> compiler: gcc (GCC) 7.1.1 20170620

Reproducer and result are essentially same with another report. Thus,

#syz dup: INFO: rcu detected stall in n_tty_receive_char_special
