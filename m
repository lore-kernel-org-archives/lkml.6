Return-Path: <willemdebruijn.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525899964; cv=none;
        d=google.com; s=arc-20160816;
        b=a/BkqU9kvrLHtwrBMGSRTQlwLbwG/qzS0Cl5q0Y/PsK5FuCvefrtx7IIaFKEXt+JSC
         a3IEwpHD/9+O8UedrHn+2P98oRAhqd4xizatHuibF9Khkxlwsis8WMyATQrtKPIrzs8U
         Tcp7c4wZWuU00VAXCir++FQd3wr6sQdkhHgB/V+vTzwlWNFiXHmzLQLwU+hF5B+Fzc5S
         A9118dqI3oZR+/J54eE/EQft4zR1SUm4kYvavLkEcbVEiO1LxFPkwq9ojR2tco7s2+Zb
         qgdaF6hfo/8mKLeX+n1KkGu9Cgp9n4dnPUpXwZFcT0qZMSDm7V0UgJk71ShtNaUs0eH4
         F5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=MbB/QpxobEKZnO1BbUyXCpu5CSSZvpY8T5jJ5hATrBg=;
        b=Pk8WRH0vT0GkkaaBIUmnT5AIjpGA42t1vhbaE4qY8QFqu2CP9Slolq+c5kTG0Ce+z9
         C7X6n4kB7PX7dOxjoxWFd3rX7+LR4bCdNQZ3Cj299W4jRKxPohsSNhgf83lknsvCw7vg
         CnHjPB7uw5/rIqx+MeUVNtnOSI/Sp+t31902CCcnijB9CbmTa/hWX5kdX/HdWyoGXI8s
         0/cD4ViJeTvsx3/8GfB92SV60r2dFJPIX95a5s7CI71pRpDP/StMxidn61n6lXGDvA4U
         60VurlVz+RcrUv/wgKsOttZrmbkcubglmPFXHnKukuWegftcLSCVrqskEHBjdaB2NeG0
         LIdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hYYNNXE0;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hYYNNXE0;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpnrFTJVyLlZ0M1wNb6rFZmLJeUdt+qPmPE0KaLfYXJsxwgM4iuc06z4y1Rho+1cuSD+6H4i7OGR/bF6xO0ryk=
MIME-Version: 1.0
In-Reply-To: <e7be4d14-be04-c40d-82ad-2050876f9ce9@gmail.com>
References: <94eb2c0ce3aa27cfa40561ec2dc3@google.com> <CANn89iLEt2e0X-zj0f_05R-oN7sX7fKUWbNz_DJSeKXJMSwUBQ@mail.gmail.com>
 <1515048794.131759.4.camel@gmail.com> <20180509073754.GG711@sol.localdomain>
 <CAF=yD-Je0ej2XDcfyEKano4R-og5oGjPvP36X4dSmpYshzBuKA@mail.gmail.com>
 <CAF=yD-KGO=+=j3yTr4H8cF_WH3RGtnyMDgYRzd7da-r7D=U=GQ@mail.gmail.com>
 <CAF=yD-JPmU-q1iUoxtmyQa4BM=fU3CMR3BUDGNMg-4v8=2_deA@mail.gmail.com> <e7be4d14-be04-c40d-82ad-2050876f9ce9@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 9 May 2018 17:05:23 -0400
Message-ID: <CAF=yD-LwxT6+9U-qCcYEVsPUeL+eVG_aSUZzEM7spwHGb7AQgQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __dev_queue_xmit
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Eric Biggers <ebiggers3@gmail.com>,
	syzbot <syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com>,
	alexander.deucher@amd.com, Andrey Konovalov <andreyknvl@google.com>,
	Anoob Soman <anoob.soman@citrix.com>, chris@chris-wilson.co.uk,
	David Miller <davem@davemloft.net>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, Mike Maloney <maloney@google.com>, mchehab@kernel.org,
	netdev <netdev@vger.kernel.org>, "Rosen, Rami" <rami.rosen@intel.com>,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>, syzkaller-bugs@googlegroups.com,
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588636556567233283?=
X-GMAIL-MSGID: =?utf-8?q?1600022081761631595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 3:36 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 05/09/2018 12:21 PM, Willem de Bruijn wrote:
>
>> Indeed. The skb shared info struct is zeroed by dev_validate_header
>> as a result of dev->hard_header_len exceeding skb->end - skb->data.
>>
>> Not exactly sure yet how this can happen. The hard header length space
>> is accounted for during allocation as reserved memory. But,
>> packet_alloc_skb does call skb_reserve(), moving skb->data
>> effectively beyond this reserved region.
>>
>> It may be incorrect to pass skb->data to dev_validate_header, as that
>> does not point to the start of the ll_header anymore. Still figuring out what
>> the right fix is..
>>
>
> I believe the bug happens if the sock_wmalloc() call at line 1921 has to sleep.
>
> device can change (or at lest dev->hard_header_len can change)
>
> So we need to bailout if reserved/hhlen had changed.
>
> Or revert some patches, since dev_hold() and dev_put() are no longer high cost,
> since it is now using per cpu counter.

Oh nice, another bug :/

That seems quite plausible.

This reproducer does not modify hard_header_len, however.
It sends a long array of zero byte requests with sendmmsg to
eventually exceed so_rcvbuf of the error queue. Hard header
length is 116 throughout.
