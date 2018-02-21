Return-Path: <kernel-hardening-return-11873-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225WansRqXYgWB58VmkPfDdVPwH23v68TunGnrwzWkRQYnzvHQGXjK4pl1Q95URRSKxbwThO
ARC-Seal: i=1; a=rsa-sha256; t=1519253567; cv=none;
        d=google.com; s=arc-20160816;
        b=ghFoKsynmm1hlsXqthBgi5iCxCE9JtlogavBDQxf6Damaiub3aMvW3ZucwqerHrgjb
         u9lnbqBq0BCSrbmA9hxyfPG8Xr2dt8DpPVP8utkVyvNYpUVmjaFbShac8XbCiAi2Xm1s
         y/K70F2AFkX27vJy66W9Ijlv6v/jmQqVAn2R6p5CqucgXWYYhBUlLXLtQr+M4Vfwtgy3
         pxmyYTSZHE6olWmczFlelm8HO+ZU5OImTxTOxF4207MjNPygaCYzLtLdDGR0kcQfPy0L
         EnbBkX6TFlqN/ewxJcl5wPbOCB+uxmSWo/9DzZoXYSHdOGh1C0rfffQwssdroFmv7MFV
         qF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=kxuew4ZTQoRJczPeXLjkxx+3FTRYrWN0FHbH9qCtb0U=;
        b=Z8M1SlhLIoc1BLR2brTQDSaQJUL9dwPWKX96SgVcSmAJ37Z67gAbZXPrp0vLDwLU/E
         wtSz+AS3/jco2CO3eQj26yTnYxVH+oDiuBPMmstVRBPVRIQbvW9LBhEcWe0CbNXfN8jG
         Z9FWBfd4+k0Ht2x7nB/0cI2P6vydsvfWS+W7Ss4xshlPwclfVo0KNSa0IbEfzwxSna5s
         5yqrNUMJetQRI9VmZswyv8dTTo4s1FhhplUX5SugFOMTmfXriza2+IamnEj5TPdchMsd
         uAQXecyssqxR7a7aaKupdiE5JkgbbkwGCtsrig1VwG0TxdTcO8eJLZ708HmJRn6aurfJ
         MjPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RxmxLw0j;
       dkim=pass header.i=@chromium.org header.s=google header.b=bXuYaeG8;
       spf=pass (google.com: domain of kernel-hardening-return-11873-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11873-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=RxmxLw0j;
       dkim=pass header.i=@chromium.org header.s=google header.b=bXuYaeG8;
       spf=pass (google.com: domain of kernel-hardening-return-11873-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11873-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 14:52:28 -0800
X-Google-Sender-Auth: qELG3FgQLBFWbnPLAxsXge1mJNw
Message-ID: <CAGXu5j+gvH+X-XyqFbY+X0xtG2mQoL5bO7T2_QaeEyr3-Z5eLw@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Patrick McLean <chutzpah@gentoo.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Bruce Fields <bfields@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1593052828374787895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 2:19 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> One can see that offsets used to access various members of struct path are
> different, and also that the original file from step 3 contains an object
> named "__randomize_layout".
>
> This is caused by a fact that the current version of nfs4xdr.c includes
> linux/fs_struct.h as the very first included header which then includes
> linux/path.h as the very first included header, which then defines
> struct path, but without including any files on its own.
>
> This results in __randomize_layout tag at the end of struct path
> definition being treated as a variable name (since linux/compiler-gcc.h
> that defines it as a type attribute has not been included yet).

Oh, well done! That would explain the code offset I was seeing when
the plugin on, but no-op, since the variable would still exist.

I'll play with Linus's suggestion and see what we get.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
