Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523907996; cv=none;
        d=google.com; s=arc-20160816;
        b=GxEFUtIFdiLWmHyLXiMrKWzHmgyevTB8m6/ACoXpNiZLWbipkhK6frnUwOvLxuZqr0
         5ut10c5ZtonfoffDPcGwFj21fUo4YbHARuEXmI+nELNMucHCvmUNXamKZuSvdbU6uEBu
         aIYBbb0bpJ1YHLfbF5ARw8hRSR8c/JR0A5XgpbsstJ4YTFQqrnGO4UnTbUYEoOr50Jsy
         z0yGmuhRmkNSjr8MLq4jwbIEpf6miE3m/9YEgPGioSDbO7OkmUWUBtnL77tru6AvNRdk
         pYi5r+SluWiKBTvfz9wnDil4c1X760uG1raYN86uIcg2BkzA5avOL8Jh0OTGWbHRN7OZ
         te4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=IPfJZAs2sPWd8NgC553RAae+7OdPDotTUfDoZyJ7wAQ=;
        b=GKSLMlu851JFrufnxn4mFF42JX8NpPNG/Aq2xWqIM/3M24yk8hjACy4s63Ra9nORQ5
         fZ/W/zfBaBR+yLPwlrDtY2CCls+BUksz3Xp70jk29KDn0f/Xj7HSY5KbjGck71+LECLa
         xul8ls/T7AeqS8PqJ/gg8R9usqPn43XCqjtMyrcSDd0JHdMlti0af7XMZhUXEBowoKG4
         jW19CCGc1beZRzykvitiWwKpygfzLPVKohR+haYN3YuLELFnVBAZBWD3V4jvM5g2L9rW
         EI+79hRNnrPB7qMi92VblPcehcur5uYhiLgd/EGC08829xVWPWsCj8WtnGtc5f/exz09
         6heQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QWWAs8us;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QWWAs8us;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AIpwx49kxm5ZqCeu17Jj8uda/ktR9JmfGyzJQzfivMwE8Q19Rii7jKahc44FWXcz6Uq1vGEhwcyixQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 16 Apr 2018 21:46:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Shuah Khan <shuahkh@osg.samsung.com>,
	Andy Lutomirski <luto@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 4.17-rc1 - kernel paging errors running x86 selftests
Message-ID: <20180416194633.elornxpw5rioylfo@gmail.com>
References: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
 <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
 <CA+55aFzotCBw7S=dNzyFjZkNqS7MMeKVgUoK6Dgb9gRPV_ywVQ@mail.gmail.com>
 <8c0a94b7-763d-16be-6401-23a3064ee55a@linux.intel.com>
 <CA+55aFx=pwEJQHhab3gW6+qdom=ccFoWoK-aZokmqtPxNqTd8g@mail.gmail.com>
 <CA+55aFwBT7xEKxoVEEgT3vjg960Tpx+CJo+4238P66Q7w-nM-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwBT7xEKxoVEEgT3vjg960Tpx+CJo+4238P66Q7w-nM-Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597933351387202619?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 16, 2018 at 11:04 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I was going through the bisection, with just a couple more rounds to
> > go, but I guess I don't even need it.
> 
> Ingo/Thomas: I will be just taking this directly, since it's so
> trivial and obvious and I got cc'd on the discussion.

A belated Ack - and thanks for applying the fix!

	Ingo
