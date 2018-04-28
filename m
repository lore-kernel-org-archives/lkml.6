Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AB8JxZqTP396lpSsHha9lpjcGDsLm5z6b7YZtFPgHQt9doTZJcpzbEWQb9ZvJpbllx4OQHAuZyWs
ARC-Seal: i=1; a=rsa-sha256; t=1524905902; cv=none;
        d=google.com; s=arc-20160816;
        b=HL1ZnPZ5vnzOAAhA6grus2qH0nE3+rsxx/0wi8UyYeCEj7an6JtgDdqfdLTRcMoQwr
         V7yx/oiz9iNKfM31svFHy7IhyMexhkHi4OcvLcU5JYFybVZl7IJQoVGgg7c8NUQ0klNb
         yMuDxgQ3L2e/iQRlPTFwQlf4ftiRQLiZOHwHqpq9VQ5z+ahF4vhRaiHRo56ZymCUHKze
         aJW39wjKqhPE+F/j+8mMpJh/HZXyunnkADg3s71Tr0MNkgkJVkRCoHDZNb7rK4MF/WsW
         DvoZ8E5DC52ycnoHxWfK1TNXHZEwg/0v5KaRCVk2zhkWrFZYOQS+UgGoOp5ynP95udmz
         Ms7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=zZ+lfYIc1Dw7TpFgl+0+0KIciNm9QsXZJVjTcfx2yec=;
        b=UoNKNl+spDQsyRmTUTCHryj/xUScA/YQfiD5QnCJvF2VUbcxrEZipni9vDpM2oZEaL
         FbiE6CtdBNomIxDhQK+sTdKTpctTf+lGIT/N2pRSAn+0QhHekq+eGtOMRMNpW5/UpgfS
         fmoGr/UI3PtHSZdGWlMV+8oVEPocmTBwjng3qEI8lQ+Z42Vu41IlW6VeNoF7SBiJLt3c
         uoddBo5y6xaWqtmT9jolhk4Far8pzm5j6yXPGilE2i3zNX37pBCXVf4qCP/q3Cx3E6Dn
         g1EflMUGzFEOME4+WZeSmb3V4BniFRajfdD/xeG+9RzGpHWD6QsUtJRyO/1c/twJ/UMl
         ATYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: INFO: rcu detected stall in blkdev_ioctl
To: syzbot
 <syzbot+369c35474963daf8f8eea897ecf33cb6ad6c7ea2@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <94eb2c05a38090aaeb0560706bb5@google.com>
 <0000000000001554a7056add26c6@google.com>
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, npiggin@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de, x86@kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <18608105-31d3-3d77-ccbb-a25bbe7e55e6@I-love.SAKURA.ne.jp>
Date: Sat, 28 Apr 2018 17:57:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000001554a7056add26c6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586926286498565093?=
X-GMAIL-MSGID: =?utf-8?q?1598979731801864158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Like I noted in a patch at

https://groups.google.com/d/msg/syzkaller-bugs/2Rw8-OM6IbM/PzdobV8kAgAJ

loop module is not thread safe. Can we use more global lock?
