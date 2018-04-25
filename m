Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx49d9OIXyQ8bW9qSx+qL5xrBJ66chXU3yblob8Wy3mxErMjzJqHkyheGikOMidxdsUZILllB
ARC-Seal: i=1; a=rsa-sha256; t=1524654492; cv=none;
        d=google.com; s=arc-20160816;
        b=Vo+ZvC13i2qxcPZzJJlBk/YeO0pwP9/cViwjwohFWmnVw0saQcxvRjiulmrFKeLN8p
         HoZ2pREVrT2I5VY97qv1KNu0bGCvlS3Pct6mgtAPwqKZPPm03RpSHne8r8oDkRFDSppY
         2tmyuIYKAjNT2bbgEvSLyF+TgVZo7WQ3SmKGznonsLhIv6EMB+BY4qttfwm/E2Cbcv+c
         H/XY9cum9m5XUwlbO5xTJX6AdBb4/dJp5Ku4P+SDi4X2OHJ3l8dxBZqX/oAzRP8erOb0
         LWHkOi4Gq7SPt1jiZ8/cRQUz1iptfOTVyyuSL/fqCzKrEJAqDCOq7N2zmrBFL6mXPhoz
         nZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=lXImE4Glhfy3L45fwzzgANJbaWOaC4bwp8pFixEJnoE=;
        b=M5JxLRtWnmhaiuLUkasxJgGR8ohJ5kTsBTaHjfdzv0F53Qc8hnN16hkFWxKHdyKnb6
         UFe1XbBG/HLCGKluQo6NQcfyLAvNIHZBHmRbpLttwzhsoyoFVwkBDXpnv0zXsA93sOmO
         Y22EhWCDYf0J+Db95kog2uBP6cp3TRZRAjCCWadAXrbtHIlriws0RE2bAXpJNV4nMFUu
         YERTzA5F3zAoRD3OrPExWdkatJ14e5zFpCF37BYif1ru4bf31d9PJZq8YCzz2JZySU2y
         LFFf3Mtt+OlnRpopqLHDv6Apbk6cbv44s7+OPpuFsnTuT8Fl187+GRN1EqBBaReg2FGm
         +RzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: [PATCH] tty: Avoid possible error pointer dereference at
 tty_ldisc_restore().
To: bot+1a77aeddeaf63317949b59c3df98f139a1ca34f9@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        alan@llwyncelyn.cymru, linux-kernel@vger.kernel.org,
        dvyukov@google.com, hannes@cmpxchg.org, hch@lst.de, mhocko@suse.com
References: <001a1141f0c87da52c055d385a4d@google.com>
 <20171105103404.GB1487@kroah.com>
 <2e8fd7a6-6841-d660-8e1c-17b5a07618fa@I-love.SAKURA.ne.jp>
 <20180405142503.627552ca@alans-desktop>
 <201804162006.GBB48461.FFJFSOMOOQHVLt@I-love.SAKURA.ne.jp>
 <20180423085857.GA20744@kroah.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <3c96eaa7-0bbf-e509-6afd-8cb95d11437f@I-love.SAKURA.ne.jp>
Date: Wed, 25 Apr 2018 20:08:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423085857.GA20744@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597900643311610411?=
X-GMAIL-MSGID: =?utf-8?q?1598716109500700665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OK. Patch is in tty.git#tty-linus as 598c2d41ff44889d.

#syz fix: tty: Avoid possible error pointer dereference at tty_ldisc_restore().
