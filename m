Return-Path: <dvlasenk@redhat.com>
X-Google-Smtp-Source: AH8x227iNxjxLpvYApc5f7+oLIXmdyGRu11scLlkJYeno40O4SILa/RBfd7jO9nT5h8Ng/M4Br8v
ARC-Seal: i=1; a=rsa-sha256; t=1518196633; cv=none;
        d=google.com; s=arc-20160816;
        b=JOlywXUmpgZrAxOkyoAOQPcSGqafj3cR8wKz0jZFcsO0Q0zrVjKK3OAk5l+9Yk3hkv
         IwqEOn+7JW9TgI1EjBSpvBNTQRFdste6P9rPFkHaRr30Orl9/fI3W12JQ7k3ZDtcF/YF
         85vxsEWnDAnm0Nz1mvOeMUv8mPm9p/+uMcDkJWpAayePa0+Dra8wLkgeY8Y+Cps9gH/u
         iFWnTL2g1OrIzEhgum2au6qiD1Pau43Ep++ubeQiBnIwDYPlAytbxEr/v7ix+mC2AtGk
         /sHlA9X608H+VHA3EWWF213680m1CCl7AnPNvyV83oGk1blpfY6LqdfLGtpsWqFgn55o
         dV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=XysxeZXMVtIeH/HMNCFjDBPdoEFWF2teWOQsdBNbsjM=;
        b=hLVUpglsBSBpxoVJiGTmri8XHKFx8yWffO0rtBu7Ynt3UCebFT0Sanng5DpwvXPDNw
         cXeD0zH2igDbU4BLS6GCEMKdUE2jZqBjPN3O4wumiTM+nPNnbY70CbbDHaOnT0Q1CT7j
         xDQXReyuZ+x6O7hpnti44Uv9JOruW9wMT2j0KTqAD2vOmZGCgTV140mdzQ8ho14ACDjU
         i35BH4vjJ9vcUda0Y1vjQYBk1eAlwg8hn/uy4uq9zh7yzirQjjpCCl7cuNdDYKZWXb+n
         MgZRcahN5Jlp2A/rM8pLsT2DQo0q4gtpPzpeJOf7VChAZA3/pYerBsjv/T0dC3U4gAV7
         Thhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dvlasenk@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dvlasenk@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dvlasenk@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dvlasenk@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH 09/31] x86/entry/32: Leave the kernel via trampoline stack
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers
 <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst
 <brgerst@gmail.com>, David Laight <David.Laight@aculab.com>,
 Eduardo Valentin <eduval@amazon.com>, Greg KH <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
 Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Joerg Roedel <jroedel@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-10-git-send-email-joro@8bytes.org>
 <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <aa52108c-4874-9810-8ff5-e6415189cd73@redhat.com>
Date: Fri, 9 Feb 2018 18:17:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzB9H=RT6YB3onZCephZMs9ccz4aJ_jcPcfEkKJD_YDCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904027044040?=
X-GMAIL-MSGID: =?utf-8?q?1591944553023634995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 06:05 PM, Linus Torvalds wrote:
> On Fri, Feb 9, 2018 at 1:25 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> +
>> +       /* Copy over the stack-frame */
>> +       cld
>> +       rep movsb
> 
> Ugh. This is going to be horrendous. Maybe not noticeable on modern
> CPU's, but the whole 32-bit code is kind of pointless on a modern CPU.
> 
> At least use "rep movsl". If the kernel stack isn't 4-byte aligned,
> you have issues.

Indeed, "rep movs" has some setup overhead that makes it undesirable
for small sizes. In my testing, moving less than 128 bytes with "rep movs"
is a loss.
