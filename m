Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524971237; cv=none;
        d=google.com; s=arc-20160816;
        b=phPKT7Gb8Z/4nh+XeX4OKng8l78KFUNHfCGLfaMUKoEV2vt4b1/d9QwrqD+b+MLbR8
         KWrifYAGSUUKCJRGYAZmeySrBw2JZ5eoBWa4bwvb3Mv2rBEq+MQjty3RQ/2T6OYFncUx
         o9JYepx589rF94Fg0gedELAg/Zf6j8ct4yq28k+o6i5sGPlK18DxWORtm0qUHB1Ox7bV
         fYTk2x/dJn3hwPZP5z1GDBd1thoNf4cBBZLjIAl96NVSFuPdsrSuyqoB39+n7me38+/u
         kAVI388//DnRcYIbIUPHMGufJOZID3+1UxTvY1fDaO+9lZl8le3dz8wyTzvjIfRHL0r/
         iRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=lYsbfi8VOB8U3XhWkKqQA15TMBC2jk9ePOJBqEZQQGg=;
        b=g0gONg0Oc0EE2h+EdhLjXjHsK612NOsQjSSsecKizCeXcFPnDZ3iNODnvhYX08p4iQ
         aJbU6mM0mM1IVFbaGm0lgrMGsRrAQr/cFXx5J4SCyhKHgu94PoN2pzIoql6+PQcAis04
         Apnb4Zrm0hidPUiVMn+bzDruFj9iFTQvXuf9eaYCjujb05Fh+eVyz0ish5qMXJmtIubv
         ATel79Of+++iaSHhjow9wUt39U8dGT7Gz1cmvComvyFq4e4SO3gBwR54uPozAc9VKz5u
         vN86WvmfRrSo3hw7RecgOj7QZEWekHtuLzUhuy1NzK+j8UlgKxBpH2aZlmBKEud7P7AK
         S/Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=P4JzoAfW;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=P4JzoAfW;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZpNS+zreHKNDRJWZt1o/DWjrLAfcxUMKbm2ZW5lCRPxJ8tLqScm16r5sWv27/PZgRmrm3/F6W6ChIwrTq4ZXtw=
MIME-Version: 1.0
References: <20180429022606.267zucef42hm37m7@wfg-t540p.sh.intel.com>
In-Reply-To: <20180429022606.267zucef42hm37m7@wfg-t540p.sh.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Apr 2018 03:07:06 +0000
Message-ID: <CA+55aFwwsHmfn7i9TjQW73RYDctBdt4QBgyUG-OJ=+on_n0f_Q@mail.gmail.com>
Subject: Re: [crng_reseed] WARNING: inconsistent lock state
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, LKP <lkp@01.org>, gkohli@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599045662105370125?=
X-GMAIL-MSGID: =?utf-8?q?1599048240462254949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 7:26 PM Fengguang Wu <fengguang.wu@intel.com> wrote:

> FYI this happens in mainline kernel 4.17.0-rc2.
> It looks like a new regression.

> It occurs in 3 out of 3 boots.

> There is another "[  294.642506] BUG: sleeping function called from
> invalid context at mm/slab.h:421" at the bottom of this long dmesg:

This should be fixed by commit 6c1e851c4edc ("random: fix possible sleeping
allocation from irq context").

                 Linus
