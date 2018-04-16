Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523901850; cv=none;
        d=google.com; s=arc-20160816;
        b=L/oja2SB9wNwfAzsfdC7NH8UbTMr8/T1XCTdYZxde08SreOIwaEB1RbCkNX13Fx1vF
         McEy7PMuZIp/BmmKVIHsQdXvH5OLwD1L2MyG9KvGC+uTrlQWcPWB5KJVIHWRapDoPmJ8
         bGQJ9OcvLpgUUnf/Nn3nfE5OP734EKw8JH0BTu+7y4cyOjulKQ6yjGGR+D6l1XFqvXw1
         qN6fx4PojUzHq0YyBRaxmLjdMzcvywIZ4l78yBMmNzpzxdy7iNvQ2ORxECGqASgJZRji
         Cnv6z6Du0kOcJyDS6vp/KnGY13jah/kE2O6Y+wG2HNlJvd8mXG3fWLHH3A2n1OK3wuYw
         9oSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=IMl5t+KZtXpZ4U9NbMcpNi7hjQm6LJces1QJgT8pG9M=;
        b=z9+xiSWJyAAT70C/lZ7jEJXBg2sluQ74vVOJgMMltuGFk/+jTF1DPkUodlrSXnJf01
         oTaPpa/uYK66AIbc25uwaBhVcp2qT6CkJwGQ3fWpI5XWn8VpkyRzNiBzzy0ji+M3zH+C
         Ox5IMqZB5owiobF20THYvyJIJOIRFgSWafhiy+EKo9fadi8cP/jUucSEjNR3YRqb0UMy
         MGaZuheBb7GXVKSbfqQudBvJSIhTVchCfZ2U+lQEfMwN33FW5T+PUnEh6CgYImers+kZ
         L1sQWwLhaQRxH3OSVRWsAGjcM7uwny3oBFfG06Sxlh43XaEwEG7lmRieP4eQFTnUs7IY
         U2pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l58m7iM9;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=NKNABGau;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l58m7iM9;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=NKNABGau;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx48Ghqm+zOCkjbJj+yXCVj1IlGB9bI043blA37DHTbARSjeSlDpbbRQNLBhlKWNakByz68pZpWQyhm83v/2Z/8o=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <8c0a94b7-763d-16be-6401-23a3064ee55a@linux.intel.com>
References: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
 <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
 <CA+55aFzotCBw7S=dNzyFjZkNqS7MMeKVgUoK6Dgb9gRPV_ywVQ@mail.gmail.com> <8c0a94b7-763d-16be-6401-23a3064ee55a@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 11:04:09 -0700
X-Google-Sender-Auth: k9E8WT6o4Clx8CY7m6BUZTRC0CM
Message-ID: <CA+55aFx=pwEJQHhab3gW6+qdom=ccFoWoK-aZokmqtPxNqTd8g@mail.gmail.com>
Subject: Re: Linux 4.17-rc1 - kernel paging errors running x86 selftests
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597926906431027068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:58 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> Joerg just found and fixed something that would be poked by the x86
> selftests:
>
> https://lkml.org/lkml/2018/4/16/230

Yup.

And that silly bug explains the all-ones PTE.

I was going through the bisection, with just a couple more rounds to
go, but I guess I don't even need it.

              Linus
