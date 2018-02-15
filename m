Return-Path: <kernel-hardening-return-11801-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226p7diHNxVwjqYpc7AFH5a/QowBIniZT8UBJV2U2u3JT7bZkxtiqspoptHtkx2hr5DqVjDL
ARC-Seal: i=1; a=rsa-sha256; t=1518714435; cv=none;
        d=google.com; s=arc-20160816;
        b=Yfhd7phEsv8imlAnIPpZ5sg65dvP+71cS+Cicp9UfWOH8l4N++PNXM/rZxaVwnqxXf
         wqeSgglNVWuhCpkdEl9WXZyZgDY9jDy6AXwF0zfbIfCKTI92RNcCwqjwJm+4qgvBy0zZ
         7dLGEDCbspqJ+cL6itYVZ7aztFOEFCVgrVdvNbnfADdyxsJ2KFuvmuHFL4EUrb48PxYn
         JJBvFmoV5wNnXItRIvjkKIUixbAzW9VvIMxVkWmXY7VU6P7AWrZ6u7nhWPkyb0l1QsXc
         Ma39K6NNglx/+sMkwCHm1XCdECHdr3qjeRR0EzfS9Vbqk/3WWYAlkAtp0pHdGkpjzmPV
         rFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Wittpyt+4K07EFftqZPqzlTc8QShN83b1PuIl6MiCBk=;
        b=Z94LbN+XMW3ixgVk9kWCXKh7rvTYNRceALjGh87IzGjBJfnmORWUmBBaeZdq1OzscZ
         uwHCTJGCLq1V7y+Mmj5PzBWyk741aeBPu3jlbnfi1l5gL15geagQ7G+dn70ezSdlRk7H
         NHZc0kqpCB5+ILbpyTNTsL6sxtfhJi/kxbM8EusJNe+VepBoLf9bgFINjKTGtY1hcJev
         yAQupl1XVVPBOOvLjD5W8QeqW1oxOa8rAswfuK4oz6XZyKFIeQBDU6qlvrPh6PBhxL41
         d+XcV8yP9f37wmGdYObiUJf9tXOLHkzJigfviUnIOIeftpOM/CRnp+Ka0Q6Dnl8mQsLO
         yaZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11801-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11801-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11801-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11801-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 15 Feb 2018 11:06:54 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
    Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
    Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
    kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <20180215162303.GC12360@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802151104140.2970@nuc-kabylake>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org> <alpine.DEB.2.20.1802141354530.28235@nuc-kabylake> <20180214201400.GD20627@bombadil.infradead.org> <alpine.DEB.2.20.1802150953080.1902@nuc-kabylake>
 <20180215162303.GC12360@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfHKwXpwVxT9nQzk1tEIUVKF6QzG2hE0J4+c9ka0Hp5Jnw0iIPm/tjcIdfsb72lSOmDFH/J1G2/qv5S/rmKQ3fLruDE39XdV5HY6QNub/+605iTqRenRA
 3iRDKP8w1qFzaCjsbwromIY0TOlhmrv3kA/Wulc4vwmmuGx1mE8ZeycEAIipYCHfL3qusIpElbdgZpuaiUqItKl01xca6RvZ/fRE3whuI16MZpvkKX4QzoyG
 iLJtl4KOIVT75/kVh+gfUWLVH17c8AvXl5q7YCauKzRVMYjjdY25/izyorhI0lx+w+Rm00/9tWuf7w62xOsOPMO0/aP949QI3EUekgQG7Ide1ut6DcsBfmOk
 TGZ8NtUl2qVDjYbmTsbRxviHeUxOFw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592487508385953023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Feb 2018, Matthew Wilcox wrote:

> I dunno.  Yes, there's macro trickery going on here, but it certainly
> resembles a function.  It doesn't fail any of the rules laid out in that
> chapter of coding-style about unacceptable uses of macros.

It sure looks like a function but does magic things with the struct
parameter. So its not working like a function and the capitalization makes
one aware of that.
