Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AB8JxZoJpXbvS9YCAsKjygvIvalsnZf0xtmguEnLQKiXdWjzGUoR7gst+iJwJ45Uh/Q3tOX314H/
ARC-Seal: i=1; a=rsa-sha256; t=1525004278; cv=none;
        d=google.com; s=arc-20160816;
        b=O9i/YjeJGE9lI3a8uuNikECb3iHhig1de5/tT04ZT2ii2w3kyjmNA1lHCpWhAKTRC8
         XDb48wGmJBeH7jks1q+H92ahHq4M31rH1svtD1nPsWF8K49p5lDVVy98tG9pJe0mH13B
         wNL2U+AvgaHA3ygYhKB9m9eZgOnorOa8LiiQSgLt9lNUQiBlgYpMEusIXiHiyAUSBfqN
         ZOOcf0ROd3lubX/L0pI/L1A6/GTMEFLC6QKd0sbD6qrBjZC/CbdCB69s2vZ3Ee1kvm9V
         StqR1pp5V7A9jtVJYQT+FgMTrlWXV2NSxFDYGxjtD+hJlYQGjfDPLJJGpcTACcCsHuxF
         sHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uy4pvjEmXjfMYNQYHmejbj9m9s/yHyt4I4zYYSaKKhw=;
        b=MRjSurVR3T4S+8zEY6VPh3e+42+Jw0akCk/WFh+rR9Jh62XkT7oFjFWccJS0SEUfg1
         TynPJ+qWYr4QhnRtUpwaxSE0aFrQXkUuNai6qQxxdsfrzzfJjPgeSzz+SmJdCaJMHsn2
         3w460khdmvMU5X4eU418qQ+BBCC8RYRuAUASRTCZ6PZgBEamor3O0PKP4Wq7hJFTpFB4
         K0WYfuvhODxS77gqvXaZaKeED1al+NB4Z9RgPAWP5UllnRaWOTwGRn+0SOmxdoNaoGuy
         XJZe5Gzl0C4mPtwmj0n2TErYwC7SSpQ3zE+Ag97ApV7fQrL2Au4uGaWxefokbXvyvPA9
         +4TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,343,1520924400";
   d="scan'208";a="46935548"
Date: Sun, 29 Apr 2018 20:17:45 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, LKP <lkp@01.org>,
	gkohli@codeaurora.org
Subject: Re: [crng_reseed] WARNING: inconsistent lock state
Message-ID: <20180429121745.6csnvc2jjay6ozfc@wfg-t540p.sh.intel.com>
References: <20180429022606.267zucef42hm37m7@wfg-t540p.sh.intel.com>
 <CA+55aFwwsHmfn7i9TjQW73RYDctBdt4QBgyUG-OJ=+on_n0f_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+55aFwwsHmfn7i9TjQW73RYDctBdt4QBgyUG-OJ=+on_n0f_Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599045662105370125?=
X-GMAIL-MSGID: =?utf-8?q?1599082886039349847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 03:07:06AM +0000, Linus Torvalds wrote:
>On Sat, Apr 28, 2018 at 7:26 PM Fengguang Wu <fengguang.wu@intel.com> wrote:
>
>> FYI this happens in mainline kernel 4.17.0-rc2.
>> It looks like a new regression.
>
>> It occurs in 3 out of 3 boots.
>
>> There is another "[  294.642506] BUG: sleeping function called from
>> invalid context at mm/slab.h:421" at the bottom of this long dmesg:
>
>This should be fixed by commit 6c1e851c4edc ("random: fix possible sleeping
>allocation from irq context").

Yes that fixes the bug. Sorry for the late report!

Regards,
Fengguang
