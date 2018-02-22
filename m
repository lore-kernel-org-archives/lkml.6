Return-Path: <kernel-hardening-return-11879-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226T6lKJw9Q69Wief1oaD2LWzhe0nUASIBn4cOb3PErzSQ7mKOpDKydZPAMKIERd3DJF6+/j
ARC-Seal: i=1; a=rsa-sha256; t=1519259026; cv=none;
        d=google.com; s=arc-20160816;
        b=KjTWjcR/KidvkBk9gSQIpDK4JI6kBuHa102rrlnSLsT7CGiSFDuDKUTyTm2byDyuST
         rILatU9AwrehCV7Cl5k91iTTrP5q7PlN4oIqN4tA0YOUDyF8/WorTwTsiXE2dMhSb5Hn
         83hnRQEHGqRNIVsyfS7qRIY8cjVQKO3UG2+sne2lTWoTtLRE3u3rhMjvCGOK44uz0DMo
         YWWMJO6+AJxVBSUDGBh/Ggmc6lX++wSYrWQdRENZx/qwWD7oCi9AW3zzJSiyMvo/WuLe
         A2glNgjtuleXeGbLpWq3d0sMGpM17RPqq14DrxtBBh9MOWxsw+giDyUU6q3bMLtBGbLd
         HzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=efu4X3iWrS9CwdTFGkq3WRcR0Le41Qs8B4KVx/N2LLA=;
        b=ol5QxTpqGdZ0qhuSlCW/08gfKSCO/P6/i0qnwHXNWB5Eor6wUIz4FI21yX/+puYdRv
         MNNPVgRPmSojUmNNmy5rYFz3ao2mF/KeACma+C8dPTUrkE1BY6/Bfvd1v1StME23HPwB
         Vht1JNIdxx2TePdPdrViaXk830tZxGcjbV0LZ+u92x6TPbMobb4gAcwiZGVUohhWxexJ
         ekbUKUDlAdNWskx1CLUJJcJ/SR2MYHxGjpDO+Sd5B6M4Bvx/gsw0udY+Ovdh7uFXwcwK
         ul3+DB+hLY+RDBVbvcDw43zwAiwFbf6nwWSyJuk22hF2zHscONvytxQk6A4hwwfOWlQD
         JPGg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E9jXl2k/;
       dkim=pass header.i=@chromium.org header.s=google header.b=JIvh6IZp;
       spf=pass (google.com: domain of kernel-hardening-return-11879-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11879-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E9jXl2k/;
       dkim=pass header.i=@chromium.org header.s=google header.b=JIvh6IZp;
       spf=pass (google.com: domain of kernel-hardening-return-11879-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11879-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFxyvr-PVWaOe_PGjej4gGMdfF_Moq0a3A9xZ6gGWAQjbQ@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
 <CAGXu5j+gvH+X-XyqFbY+X0xtG2mQoL5bO7T2_QaeEyr3-Z5eLw@mail.gmail.com>
 <CA+55aFzsiVMFZVwm92N8L=E+YgOG+fpjwxt7rmz72=yMQGz8rg@mail.gmail.com>
 <CAGXu5jL5C1PHzVKwaQXuMm+jB=Wf0x-AN71_19RtzxvgYHHz3g@mail.gmail.com> <CA+55aFxyvr-PVWaOe_PGjej4gGMdfF_Moq0a3A9xZ6gGWAQjbQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 16:23:26 -0800
X-Google-Sender-Auth: dVCjxzYvTYPvmTUuaR-owPkuR9M
Message-ID: <CAGXu5jJRtiPNTZdA_RBUR=Xy6xcstqJUn_KoQtT4t=8jkucFQg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1593058553079261519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 4:22 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Feb 21, 2018 at 4:12 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Do you want me to send the patch for this, or do you already have it
>> prepared?
>
> I'd rather get something explicitly tested. I tried my earlier patch
> with "make allmodconfig" (and a fix to nfsd to make it compile), but
> now I'm back to testing hjl's gas updates so it would be better to get
> a tested commit with a good commit message.
>
>> The body-fields I had prepared for the nfs were:
>>
>> Reported-by: Patrick McLean <chutzpah@gentoo.org>
>> Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>
> Oh, I think Maciej needs to get more than a "Reported-by:". This was a
> really subtle thing that we didn't figure out in the original thread,
> so give him a gold star in the form of "Root-caused-by:" or something.

Oops, I just sent this out. I will adjust a re-send. I couldn't find a
documented field name for this...

> *Fixing* this ends up being a one-liner or so. Finding the cause was
> the painful part.

Yes indeed!

-Kees

-- 
Kees Cook
Pixel Security
