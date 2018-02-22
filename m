Return-Path: <kernel-hardening-return-11880-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227bAiqWJD6PL2nOMYk1CiuZAqB3EaQYCmIHrDBnMZryHR1e00ySsbF63QRrd8I0RWNhkxNw
ARC-Seal: i=1; a=rsa-sha256; t=1519259253; cv=none;
        d=google.com; s=arc-20160816;
        b=i5vUigRGw5KFuhEvUcWyio9/Drflkn7FgK/o2Znu1zvkOWmEP8e0sO/4fDQClnceZj
         XXo5YhPIdc12dl8vAnu50OK7Zs1PkoWyyPWkriqfAnIIR8ahsGtDXqDvQsK0kjfg4OwN
         LakFtCmDam6XmRSEhNKhbXn8t8ibbOXQxGXk1KJigwSFlMnr9rRcuzCQMfE3KoValw+7
         iE93R0Mkpmsxe8EANL8NDYcuJPA3CNvyS9JAjbkdzNVlAQPJqmaI54uI76X/Xqb4/ZPb
         Hd2e97LY3t4kjBgly9Y4kbeIUVPAeq8mj1/kOSe7/J8+yjlZVmNVt9KIDC+JSTuI+hYU
         NCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=wV8bVpYXdRz9+I5TMfwrWaVFqWMH/jUSTJH0n8Dntv8=;
        b=CRcMv/TPGknzv1VORCJAZoKDzyCYW3t1yq5sVT97FzElhltgdfuktPHvvCuMh6L3dc
         VdsjIvMVMiacj7qXDtr23DUrrtUGLKQeaDN/DlQK7ELYOr7vjutIJ4FaavsxLv66tMje
         TxXePwLPG/OhBWva3H7raAt6U/5BVDFsfY890JUvC0eShUQ5rNgYxhiemWqnf6akfKFb
         cMu/db2plU0m7Uxd/NrylbHHg+MoceIG5pg4OoEv7ecJkSJgB0ZemaBjyYyxmtw41Rb3
         zHIPZQDuJW5qbJmMKB5xd8nW4NwQ6+MmM+Uf2VJKwubI2E4PhbgWGX24jhF+1OojIN++
         yvAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NEfuapR0;
       dkim=pass header.i=@chromium.org header.s=google header.b=N5fwDp+N;
       spf=pass (google.com: domain of kernel-hardening-return-11880-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11880-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NEfuapR0;
       dkim=pass header.i=@chromium.org header.s=google header.b=N5fwDp+N;
       spf=pass (google.com: domain of kernel-hardening-return-11880-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11880-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAGXu5jJRtiPNTZdA_RBUR=Xy6xcstqJUn_KoQtT4t=8jkucFQg@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
 <CAGXu5j+gvH+X-XyqFbY+X0xtG2mQoL5bO7T2_QaeEyr3-Z5eLw@mail.gmail.com>
 <CA+55aFzsiVMFZVwm92N8L=E+YgOG+fpjwxt7rmz72=yMQGz8rg@mail.gmail.com>
 <CAGXu5jL5C1PHzVKwaQXuMm+jB=Wf0x-AN71_19RtzxvgYHHz3g@mail.gmail.com>
 <CA+55aFxyvr-PVWaOe_PGjej4gGMdfF_Moq0a3A9xZ6gGWAQjbQ@mail.gmail.com> <CAGXu5jJRtiPNTZdA_RBUR=Xy6xcstqJUn_KoQtT4t=8jkucFQg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 16:27:12 -0800
X-Google-Sender-Auth: D3T4L54ElyuYQwwi47nZPDxXjlw
Message-ID: <CAGXu5jJZh5AY5pTJXL2qn3=oMCvebNrx-BdQYnHtafnO6ywWWg@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Patrick McLean <chutzpah@gentoo.org>,
	Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Bruce Fields <bfields@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1593058790840400230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 4:23 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 21, 2018 at 4:22 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, Feb 21, 2018 at 4:12 PM, Kees Cook <keescook@chromium.org> wrote:
>>>
>>> Do you want me to send the patch for this, or do you already have it
>>> prepared?
>>
>> I'd rather get something explicitly tested. I tried my earlier patch
>> with "make allmodconfig" (and a fix to nfsd to make it compile), but
>> now I'm back to testing hjl's gas updates so it would be better to get
>> a tested commit with a good commit message.
>>
>>> The body-fields I had prepared for the nfs were:
>>>
>>> Reported-by: Patrick McLean <chutzpah@gentoo.org>
>>> Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>
>> Oh, I think Maciej needs to get more than a "Reported-by:". This was a
>> really subtle thing that we didn't figure out in the original thread,
>> so give him a gold star in the form of "Root-caused-by:" or something.
>
> Oops, I just sent this out. I will adjust a re-send. I couldn't find a
> documented field name for this...

With the "root-cause" hint, I see we have used:

2    Root-cause-analysis-by:
2    Root-caused-by:
1    Root-cause-found-by:

I'll go with your "Root-caused-by" to tip the scale. :)

-Kees

-- 
Kees Cook
Pixel Security
