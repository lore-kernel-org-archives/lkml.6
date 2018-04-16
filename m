Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523903672; cv=none;
        d=google.com; s=arc-20160816;
        b=P4ohc+hIjQq8Vhy1S0a1NS4oQT2qJA9vEAtKD9uA2WLKH2MzaPWD+DMDYqRnRG456r
         vWsmmCfc2xYfjaSb+TgtKMZ/YttWbjj4C1hCGeeRPy2s+184MMEdn/pYa5dUXdcUC+P6
         Q9rJ43TxEZEJb0jmI4zkyacpMVJUh9ChnUBsfUZGTTzKcIeu6hU9lUn+GTyxyRRPbIu6
         DpFLLfVLYV0uXn7U36HQgNtTJ7bpbZppXVgrGD8NtdiY2vBItg4leAW5xCwJre/s4g85
         FSCd5rp1XApHQ7wM6VxLooLrD0DGCZoV6JG7YHrrdJpRO5qibVDL00xonr6ED8WU6Fsd
         al+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Bu6ftlY3u7yFDGrqsvX7xniZDWYuLywlyBaGEIfq4so=;
        b=0lOSj/jt43iKZIneMSn0g9K3TMKOTTWv9TFaDqsDQBs19F1fgsrtCqDhP0Xl+tOvsA
         jTpi3eC3AaagM9X1PXR4smPEzA6r28JIgB82seaUaiWZ45tMBPoGkpNm6jgs2ySQYGD7
         LNRj4dtIF3kNYoQ8WHJvjZ1pZWSHBn/WBlyGtnY1TuePH7nGGxQxDD+9/XYR5mz1g8j8
         iKERTty8ZY74FwJpYcRg4YJzPFW+rsPnD0FL1wbdp/SuxuwEvx1E/OvFQvfHo65HJh5R
         7pKsqPnY783j0l3w3gFOCGCrd1P1qh0AFnOT5hATYkaSLyrh4xuLHcXSO1amz4cWwFBa
         IpXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Lc3oUCsR;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ci8rIjdA;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Lc3oUCsR;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ci8rIjdA;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/J6l6b9INxo9EZyzDOStlqelPaKYwFLD10eh99nFrB8PHF5bb76ddsQSDgrjfVF1xJh8QpilBqAn+ugYPo2I4=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFwBT7xEKxoVEEgT3vjg960Tpx+CJo+4238P66Q7w-nM-Q@mail.gmail.com>
References: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
 <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
 <CA+55aFzotCBw7S=dNzyFjZkNqS7MMeKVgUoK6Dgb9gRPV_ywVQ@mail.gmail.com>
 <8c0a94b7-763d-16be-6401-23a3064ee55a@linux.intel.com> <CA+55aFx=pwEJQHhab3gW6+qdom=ccFoWoK-aZokmqtPxNqTd8g@mail.gmail.com>
 <CA+55aFwBT7xEKxoVEEgT3vjg960Tpx+CJo+4238P66Q7w-nM-Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 11:34:32 -0700
X-Google-Sender-Auth: hCkK23HMJzSLFPpJYxvO6mJNdYc
Message-ID: <CA+55aFzmcwNjgvjwyVEeTYmBmdP5Ed+FNZXKJFpWx4g_+F7G1Q@mail.gmail.com>
Subject: Re: Linux 4.17-rc1 - kernel paging errors running x86 selftests
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597928817865843336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:15 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ingo/Thomas: I will be just taking this directly, since it's so
> trivial and obvious and I got cc'd on the discussion.

.. and I also verified that it actually fixes the problem Shuah
reported. Not that there really was any question about it, but hey,
after bisecting it I decided to just test the fix too.

I know, I know. What are users for? I must be slipping.

               Linus
