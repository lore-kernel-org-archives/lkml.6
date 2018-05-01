Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AB8JxZqkaEKdYygbOsUfbSQm3mgai2WjIiK6vq4ain1hxySU/Dqo9BX/RN4Rr9gIXxDhDTfS325F
ARC-Seal: i=1; a=rsa-sha256; t=1525169724; cv=none;
        d=google.com; s=arc-20160816;
        b=K58xq9FlQsTUIIthSW2aNzDA6LiDNqwwhU9x4urYFB22nBRoMuMdADQNvbjvct75qT
         mFC0sBGwBLnH81lwjIqLVjtF1HKAYxr6TA5tIIswIo9oUOuxXv+ugA0NHRHQK787DYYv
         IR9dACnncuyQQ1qZuC6KAbLkZh61I6JFfR9FWqounS1I1Bc8yaEmq4GSOIwbKbaE5giQ
         18wSj+6IePC19Uo/yiXCnSbjSBVIGQ0D1zvpIMhH5Q+gaT+6yORrTr8KgT31l+zvDjyl
         zuddWGRfodN6RAFHKFIha+DCv2HKII6KEDr0qPShH3oH/gzz+vPSyhGHyqHu7wr1nLrR
         OwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=/aKZZMQgqsN/ScErG8q4xz05TJE9+rlwmqPyNfMdGmE=;
        b=ouENHfYD3JNhpztpnzqPsU01OhK7OZcAiqIjswzEX+5oUnuKfcLBv1P07dSYfpkEsW
         ovV6byN5IALIvGV0VoYbI7aJk/LO7SP3qjRli61HMs6qvlCAoJdboF37D8Nk4y5kKmO5
         zPJbcqnFplRxdFrySO65fBYbUYegLMyVWeTtsL+uLJ4zYbwTRKw1d2DtvXLIktkC4UZX
         WjRrEEZh1593kx+bVfdbYygULUXOJZYO1GJl3WBP5rws9bvArb1oHQMvJP0BwUTQKeQD
         2HB/bIQcxYeDCBNCw37ZXrUfF26PEwwk3CoqPWxbe8FiNnqxQkYm0eFUBvGO97nSyyHJ
         nfbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: general protection fault in n_tty_set_termios
To: syzbot <syzbot+ed02be0ad5f26ef4e31b@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003b1d65056b1d9046@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <8cec3c41-0d79-c882-4fde-8c8ca4841de2@I-love.SAKURA.ne.jp>
Date: Tue, 1 May 2018 19:15:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000003b1d65056b1d9046@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599235269199846482?=
X-GMAIL-MSGID: =?utf-8?q?1599256368798615834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will be essentially same with below one.
ioctl(TIOCVHANGUP) versus ioctl(TCSETS) can race.

#syz dup: KASAN: user-memory-access Write in n_tty_set_termios
