Return-Path: <kernel-hardening-return-12109-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuEd5VH1K83tXfgRVfdYokkSSQWZd5BYyaIDEFmnqorXXBsEfXFAJJaoVIoy0e/OtZFPBCx
ARC-Seal: i=1; a=rsa-sha256; t=1520277359; cv=none;
        d=google.com; s=arc-20160816;
        b=kDdIUJXr58ul7Y1qH/3phoKebEbOTzZG36GqqcSDUIWTKYqlafgqhZo87fWesehu+h
         I4tX33bXIbLb7kHLnZbBuxEd8IAtXTF08RMIIyCeaDy8iuL8H5PhD07dUKxhkp2rNBFo
         pmelEyV81FxSGWuTEqLbkmaOHN1174TP1s+eqOBrfVp4hoKjOrBI/kSjfKtB3L8a/kRV
         ccbrTt6Za6OK1bvG+5NgBXv5iAy2N5ufDnkLLUdAPe/jGextznWUMPugrzsJY6gVIhAW
         Q9ONMXprwTFkEUGzUZhL6FNd/2tm2QymdHKBUFUcP1tD5hscVW5nc2q9cvt3OkC3ZrEm
         icTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=f7IgiULnIYeZ6kEsjRk+2hgR8EmZep/65W9g0gbSj4w=;
        b=SsjgdebBR6+/c4MC2fb1wzj5iWrLjg4H1QQI6UsK3wzgzlkh/OFYfr7IWgRRhWAAYq
         AHwfKm11cXvJypDZKoSClHI3Pp5rWKCNriNscMcNgandOBWjc8T5Am53Bvh+/Sw3VdCB
         dfQi44UVGWBQ87NqwcoiqZ6yF40ZJVKCJ9m+yqm6V4bBDOXBcNd0u1ME7n+fsT8IEmUu
         QaEiSISQRVsPpMTGLnoBlP03H2vLyhzWt7aNW86cEIGNiMjnpBzRY/DBkBCykAZQWZxe
         gWdPVFhQY3x5y/24Wyvog//ijMceFGJw5YUlIDEX0d/nUNcGbphIdy379Ew/qNhVNXlZ
         SbFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HHUkD6/U;
       dkim=pass header.i=@chromium.org header.s=google header.b=d1OMBbQg;
       spf=pass (google.com: domain of kernel-hardening-return-12109-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12109-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HHUkD6/U;
       dkim=pass header.i=@chromium.org header.s=google header.b=d1OMBbQg;
       spf=pass (google.com: domain of kernel-hardening-return-12109-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12109-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAK7LNASKHOb5GNPu9XHWxyq-iucxTRkw99_7wL4zgm5HNc6_SA@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
 <CA+55aFz-AD8rWb66rjN-YhAtPXukMiGSFfW3nBMCp8k1RYUvOQ@mail.gmail.com> <CAK7LNASKHOb5GNPu9XHWxyq-iucxTRkw99_7wL4zgm5HNc6_SA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 5 Mar 2018 11:15:35 -0800
X-Google-Sender-Auth: 95GxM90fk6sDNH7e8HQPESv9RTY
Message-ID: <CAGXu5jJo+c4d+=57rFiHaFrOHxDHVSZzMhWSMqNQe+tcw0-4zQ@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Patrick McLean <chutzpah@gentoo.org>,
	Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Bruce Fields <bfields@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1594126352313945662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:27 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Sorry for chiming in late.
>
> I noticed this thread today,
> honestly, the commit made me upset.
>
>
> Can I suggest another way to make it less fragile?
> __attribute((...)) can be placed after 'struct'.
>
>
> So, we can write:
>
>
> struct __randomize_layout path {
>         struct vfsmount *mnt;
>         struct dentry *dentry;
> };
>
>
>   instead of
>
>
> struct path {
>         struct vfsmount *mnt;
>         struct dentry *dentry;
> } __randomize_layout;

Ugh. I had tried this after the struct _name_, not after "struct"
itself. This does fix it, though it remains fragile, as you mention.

> If we force the former notation,
> the undefined __randomize_layout results in a build error
> instead of silent broken code generation.
>
>
> It is true somebody can still place
> __randomize_layout after the closing brace,
> but can we check this by coccicheck or checkpatch.pl?
> (we can describe it in coding style documentation, of course)
>
>
> IMHO, we should not (ab)use include/linux/kconfig.h
> to bring in misc things.

I'm happy to send a patch that reverts the other changes and relocates
all the markings...

Linus, how would you like this to go?

-Kees

-- 
Kees Cook
Pixel Security
