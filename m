Return-Path: <kernel-hardening-return-11878-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227ahsxITnw0vlGeu3LrdgHalbiFFK5NiAfbGQLxFiCRm7sc9CnG4hN3npmxRIT2reVIo0RV
ARC-Seal: i=1; a=rsa-sha256; t=1519258944; cv=none;
        d=google.com; s=arc-20160816;
        b=rpDuPFOyPfCE6KBJGG0VCdEd52brOStDcrLm36FgrCRENE/wbYZRBUTHxHLOaCC9fO
         Q1khdrQvN1V2BZfB41GCKIt/prtJPXcT2Yghodd4p6WUqrj0fkt03tTM2TmyWiR5zwLk
         qJkhTnMhCGQCrBsnaxgbU502fO14yo6kWIs0ZtSza4ebbTZbfE4dfqNBYao6Emr6538a
         mi31q+UAl/1QQ/hsixCn+tC9FPm09MZ4YsMecnZ9eUT+MbQX5TlU01F8xJB507oNQvJx
         G4OEkjSs3EVp/xnvk3H/KhArtPlg307vIJavD7n7qv5iHGXfTgHNwSrKtr4BkGVQUgkv
         62jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=JojIbGiSstPvs2b6P3Zb/GxE/oW7Ji2NjTFhH383mp0=;
        b=inxmbCFJPRcRF+SaU/dH2BsZTJ3lVgPjv+xGAJ1jq2yKi2DCvUUNnPnjCV1HUhlYLk
         aZRCKYoNvCnl689QI1ubBIIXHx2xQhyrESBK5TgvWl9n9fIqaA6XkmwlbzSrcNPIWsNY
         FVyA+5tPUAbqYnEN/6MHvBCnVt/h2ffr1vNHtgZyrf1FK1YZC/F3ehzRAC7wm4NLDKkm
         Eljont95QNCiiDh9PmybN8bPijvwoU1zQhw4YAraXXN7HdwlasEbWIv2ZIrIaLMVdukA
         AWFRxl5vdgrCz/Upn53JgWX2ptxY3r2SD0Cmd3BPRA2/92CoAG0503Kfy0eREyTigxFj
         ZLzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ea8gArOx;
       spf=pass (google.com: domain of kernel-hardening-return-11878-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11878-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ea8gArOx;
       spf=pass (google.com: domain of kernel-hardening-return-11878-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11878-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5jL5C1PHzVKwaQXuMm+jB=Wf0x-AN71_19RtzxvgYHHz3g@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
 <CAGXu5j+gvH+X-XyqFbY+X0xtG2mQoL5bO7T2_QaeEyr3-Z5eLw@mail.gmail.com>
 <CA+55aFzsiVMFZVwm92N8L=E+YgOG+fpjwxt7rmz72=yMQGz8rg@mail.gmail.com> <CAGXu5jL5C1PHzVKwaQXuMm+jB=Wf0x-AN71_19RtzxvgYHHz3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 16:22:06 -0800
X-Google-Sender-Auth: 6MTZh-FcM-2AVnUgo0rkklAO8V8
Message-ID: <CA+55aFxyvr-PVWaOe_PGjej4gGMdfF_Moq0a3A9xZ6gGWAQjbQ@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Kees Cook <keescook@chromium.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Patrick McLean <chutzpah@gentoo.org>,
	Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Bruce Fields <bfields@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1593058467372668077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 4:12 PM, Kees Cook <keescook@chromium.org> wrote:
>
> Do you want me to send the patch for this, or do you already have it
> prepared?

I'd rather get something explicitly tested. I tried my earlier patch
with "make allmodconfig" (and a fix to nfsd to make it compile), but
now I'm back to testing hjl's gas updates so it would be better to get
a tested commit with a good commit message.

> The body-fields I had prepared for the nfs were:
>
> Reported-by: Patrick McLean <chutzpah@gentoo.org>
> Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Oh, I think Maciej needs to get more than a "Reported-by:". This was a
really subtle thing that we didn't figure out in the original thread,
so give him a gold star in the form of "Root-caused-by:" or something.

*Fixing* this ends up being a one-liner or so. Finding the cause was
the painful part.

               Linus
