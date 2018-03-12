Return-Path: <ecree@solarflare.com>
X-Google-Smtp-Source: AG47ELugpJ+ed3ET5KLg64PxwzQKLPYnAF2j462kzpLDaw+40YgrwFhC6cwEzfFAHnkunrg0hoOA
ARC-Seal: i=1; a=rsa-sha256; t=1520856131; cv=none;
        d=google.com; s=arc-20160816;
        b=K16RnWEoA8IjZzH3aalcqN/N1Q9c/LXlk5E1zkIUDxq3P3gM5y9Xq8VVxEyT2DZI+U
         q4lQNvTHeIPffbGSFPwzjjFTKgUbbPuvvE2BNjZYEzh6Kop+PtOPCaI8SrNavhaKloAM
         Bfly7pgLW/piA0bX7zVOhX+fDpVKJGCF5FWI4ItPfxmoqPIJ91VwVOpEeBC0HtQhW6Cn
         fQICYso91aSSzRLl6IhutIq+8XCne4rmJYud+fn00Nm+Dny2vjbBkACim3SO0A3PPuv5
         IpA+PIqKP19CKMLnnUmImU7RYVXBZe9guAvSdGJffZnj+2SQdR3RVJtyaH8Lx2Ceaa33
         tP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=KioqapZGwB8AVOA7Jdt1rxD+mNljkAIugFAV8bPdpnY=;
        b=vmpalaIbsCj8gzMyI0lJJQNzzz84+3JAyQokRr2AgwYW4cMNo254ork+1L78JArx6m
         yDbSHpZWTQgM2tIbBrWwVlD4/pehELfNnyRX9WMmlziYI/Vtzo7xh+ojpJQAoJH5weat
         yERaFqE0IZY4gjSVHwyyeXHZXYUAsZKz2Al0MD9S46+dtM/hTR6Vdh8erzB/W83M4KvX
         X/8GpJSZRFzuVnK593OitfjkD0hlZqnfV3KPyj+6r5NlMl1UKk95nf5F0XsrJwTwZ/3y
         U//knV3N3jLwRbRxcMeMTTzsaj60CsgmqS0gDdRpKqjpbfezQTo8sgnbrxbberb1hTqr
         00dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ecree@solarflare.com designates 148.163.129.52 as permitted sender) smtp.mailfrom=ecree@solarflare.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ecree@solarflare.com designates 148.163.129.52 as permitted sender) smtp.mailfrom=ecree@solarflare.com
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Alexei Starovoitov <ast@fb.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>
CC: David Miller <davem@davemloft.net>, Andy Lutomirski <luto@amacapital.net>,
	Alexei Starovoitov <ast@kernel.org>, Djalal Harouni <tixxdz@gmail.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Daniel Borkmann <daniel@iogearbox.net>, Greg
 KH <gregkh@linuxfoundation.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Network Development <netdev@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, kernel-team <kernel-team@fb.com>, Linux API
	<linux-api@vger.kernel.org>
References: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
 <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <20180309.133509.1275903267249306409.davem@davemloft.net>
 <CAGXu5jJcuSojm_KN5+JQ3fV6J09V6dmNB6haqu11xkXTq=nxog@mail.gmail.com>
 <CA+55aFzJEkUGfRkKqc8twaDSdSH_r_OWnFm-e4uNQf4SrJy7-A@mail.gmail.com>
 <77cdc9f5-b51c-a18d-5422-763cc4e76279@fb.com>
From: Edward Cree <ecree@solarflare.com>
Message-ID: <30db1e8e-8eb4-5072-8360-6cafe26db113@solarflare.com>
Date: Mon, 12 Mar 2018 12:02:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <77cdc9f5-b51c-a18d-5422-763cc4e76279@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-MDID: 1520856131-hvWAqeJP+ngV
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594733239069878617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/03/18 18:58, Alexei Starovoitov wrote:
> It's not waiting for the whole thing, because once bpfilter starts it
> stays running/sleeping because it's stateful.
So, this has been bugging me a bit.
If bpfilter takes a signal and crashes, all that state goes away.
Does that mean your iptables/netfilter config just got forgotten and next
 time you run iptables it disappears, so you have to re-apply it all again?
> It needs normal
> malloc-ed memory to keep the state of iptable->bpf translation that
> it will use later during subsequent translation calls.
> Theoretically it can use bpf maps pinned in kernel memory to keep
> this state, but then it's non-swappable. It's better to keep bpfilter
> state in its own user memory.
Perhaps the state should live in swappable kernel memory (e.g. a tmpfs
 thing, which bpfilter could access through a mount).  It'd be read-only
 to userspace, listing the existing rules (in untranslated form), and be
 updated to reflect the new rule after bpfilter has supplied the updated
 translation.
Then bpfilter can cache things if it wants, but the kernel remains the
 ultimate arbiter of the state and maintains it over a bpfilter crash.

Sound reasonable?

-Ed
