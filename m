Return-Path: <kernel-hardening-return-11877-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225YYBckTImaiwEYKQIDvn/wNTZ/FiWkIwmFMg/tCoDVoScENHTkwlnGCn/ol9rnhKgbapA9
ARC-Seal: i=1; a=rsa-sha256; t=1519258370; cv=none;
        d=google.com; s=arc-20160816;
        b=zyOddE4SmOVomcSYIxTUDXeSZcdiG7dJST/cazg/49uzpkYdjtC3Y0DKyIJkeTQGJh
         ylT4BgaQyjZVrwZ5T13QWiNtF0huvH08oCpb92gF9nXzShgYCtl533f77boq/nuTb+VK
         6X2wT7VCUQjbkjZHu1THRjYZrKdr6BIcQBttqH+pGkTCRhsdC86NePntmgksJntqJpJ7
         ZcCQjNRHO65NnvgqDnhPnNdN6cu33bxdB081L/sKabLgxEPJtNzocG0B5jiMQgGaIB+1
         b9y4X0GatsFnyKP9gsO1BFm3jDKG0g+g7qIg6XEcG3Q/0qIWwlqXWWtpkNRxcM50qKiB
         97dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=LIqqfmZLToZvVj85MdDRoSONsfyhFTQ8iaMCoTLBk+M=;
        b=Y/Qvr6NCYA97P8VJ3ykWTB/JQxWBIk33Wiq0fv8zzAUIx29w5XqYAUzIVvDxMthm5/
         EqeRiAhhxIkC4Vnr8BuIHoGnlHG5215l7e4YdAMxnWNVLKTW3kWNUkkOmIeyZwGrV6gU
         cs0drNvllV0pC8UdnhBe7TN8noruE+vb0nV5CfxT7AxfORcjWCYQIU7DBXophwA9uC/y
         9IEbxorxfZuiIk2TBd/ikbP/D7NMo/Z5t1eqef2XRs0gqPwl06AAyTaLB/NdLzBHYrt1
         s4wrqLkeVJRb7qngrD21RaCtdPkHI3WNbD1HGt3nIb4oTTqtiIZqmFfU8O4IxcUfrzij
         I4Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=KOEusPSy;
       dkim=pass header.i=@chromium.org header.s=google header.b=jr7G0jpg;
       spf=pass (google.com: domain of kernel-hardening-return-11877-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11877-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=KOEusPSy;
       dkim=pass header.i=@chromium.org header.s=google header.b=jr7G0jpg;
       spf=pass (google.com: domain of kernel-hardening-return-11877-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11877-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFzsiVMFZVwm92N8L=E+YgOG+fpjwxt7rmz72=yMQGz8rg@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
 <CAGXu5j+gvH+X-XyqFbY+X0xtG2mQoL5bO7T2_QaeEyr3-Z5eLw@mail.gmail.com> <CA+55aFzsiVMFZVwm92N8L=E+YgOG+fpjwxt7rmz72=yMQGz8rg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 16:12:29 -0800
X-Google-Sender-Auth: 3ckkiz7SMS8Neh8YNX-CZEnbJI0
Message-ID: <CAGXu5jL5C1PHzVKwaQXuMm+jB=Wf0x-AN71_19RtzxvgYHHz3g@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1593057865071841866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 3:24 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Feb 21, 2018 at 2:52 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>> I'll play with Linus's suggestion and see what we get.
>
> It may be just as well to just include <linux/compiler_types.h> from
> <linux/kconfig.h> and be done with it.

Hah, yeah, that would certainly solve it too. :)

> I do hate including unnecessary stuff because it makes builds slower,
> but kernel header files probably don't get much more core than
> <linux/compiler_types.h>.

It also has the benefit of not letting it "go wrong" in the first
place. (And the separate fix for nfs isn't needed...)

Do you want me to send the patch for this, or do you already have it
prepared? The body-fields I had prepared for the nfs were:

Reported-by: Patrick McLean <chutzpah@gentoo.org>
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: 3859a271a003 ("randstruct: Mark various structs for randomization")

-Kees

-- 
Kees Cook
Pixel Security
