Return-Path: <kernel-hardening-return-12961-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/zp78XQUmYwbvRsawemvlXVdoW9bYVlIyPmAnhlZwxM5C2XcPuJQalwfCztvLDhzvhroSu
ARC-Seal: i=1; a=rsa-sha256; t=1523395418; cv=none;
        d=google.com; s=arc-20160816;
        b=G+xQMQ3jAwVKMvd1N2AdTPbveipC3EO5a84aU+cQwFQsjq+e111A/qo8+j9ECuzkxP
         tCFYQUGEz/JSJSSM4QO/C2Xoabg8Wsm5EaJwo7HUi4YkaT1sIItWoh8DjZdwPLVQWoxj
         EDdhHxIsTGMlf7Tdg8d4ezj81xJ4l61IffMcYr9WGhKaOljBk7fvCFiuJOoWpSLaI5G9
         lGJo7+OodDWiuscJiHLsTbZtdrXb0my+vZryFv7oJEwmfANbf7qLV1SWDJVtvslXU/ww
         GnUak+1vUIYrHzIxuFAfkQCxy0kNPG8quIYeVzbR2FYB1S2uOWEzJKdq5QOvvbwlKCde
         piDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=jQlUz9Tv3bkkUQkjq+zhW4LAd7rqZV0Oljw5aRgTPR4=;
        b=HBehIyLP3e531FIg26beMS+BSL6clGU2v/MOd0S72VJfREXwsFMrirJuRRE8LeYHGf
         pwVlhcctARPZ1vWNBQ2XpX9uNgb37G61sEvdR82LbqfqF0yVJthYybrWkDb6j3hDhHVj
         9T6QbrXG6/RDCscEGb82jOvAYZcBbPMQuApb3Xqx9F8SqPS1HXjEiIMtv6pl7gD1JxWA
         +N23bk12ZVg3E5uvSrlwLWId34WxUfNrmm3r6sqCK2cBFtG+FrX3lHuu3ajhZE6jwQEK
         Vuq7vuCpEdyu93xbVQqsNK9gwnOIc/ZeVa61khF2OyLRL/g1wMFgXwLdYrzQl+4KaFGF
         x5bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=uRA9TAds;
       dkim=pass header.i=@chromium.org header.s=google header.b=dA8u2NJQ;
       spf=pass (google.com: domain of kernel-hardening-return-12961-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12961-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=uRA9TAds;
       dkim=pass header.i=@chromium.org header.s=google header.b=dA8u2NJQ;
       spf=pass (google.com: domain of kernel-hardening-return-12961-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12961-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAJHCu1LAvw5N8cXr-L8goEXUN5+jAdC4aUv3jNW0FxO9W_VH1w@mail.gmail.com>
References: <1519729200-16056-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5jKYSRqsHo8rqvyR1ZLQ2MT+UnG=F4_RTEp7Sq9q9qsPtw@mail.gmail.com>
 <CAGXu5j+RELwBqkLrpQ0zHdHM3u2FxgcKokumtSS8KpkCeUgT2g@mail.gmail.com> <CAJHCu1LAvw5N8cXr-L8goEXUN5+jAdC4aUv3jNW0FxO9W_VH1w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 10 Apr 2018 14:23:17 -0700
X-Google-Sender-Auth: B4mZrW1dbiUDR2NvfFlgK3-8TvU
Message-ID: <CAGXu5jKXMx1hzQX6g=Y51mdTgHoYp4vuVUvri3=s7Fn9NgmZmA@mail.gmail.com>
Subject: Re: [PATCH v4] Protected FIFOs and regular files
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, David Laight <David.Laight@aculab.com>,
	Ian Campbell <ijc@hellion.org.uk>, Jann Horn <jannh@google.com>,
	Matthew Wilcox <willy@infradead.org>, Pavel Vasilyev <dixlor@gmail.com>,
	Solar Designer <solar@openwall.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
	"Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593551596949260408?=
X-GMAIL-MSGID: =?utf-8?q?1597395874088586363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 1:22 AM, Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> 2018-02-27 21:22 GMT+01:00 Kees Cook <keescook@chromium.org>:
>> On Tue, Feb 27, 2018 at 11:47 AM, Kees Cook <keescook@chromium.org> wrote:
>>> On Tue, Feb 27, 2018 at 3:00 AM, Salvatore Mesoraca
>>> <s.mesoraca16@gmail.com> wrote:
>>>> Disallows open of FIFOs or regular files not owned by the user in world
>>>> writable sticky directories, unless the owner is the same as that of
>>>> the directory or the file is opened without the O_CREAT flag.
>>>> The purpose is to make data spoofing attacks harder.
>>>> This protection can be turned on and off separately for FIFOs and regular
>>>> files via sysctl, just like the symlinks/hardlinks protection.
>>>> This patch is based on Openwall's "HARDEN_FIFO" feature by Solar
>>>> Designer.
>>>>
>>>> This is a brief list of old vulnerabilities that could have been prevented
>>>> by this feature, some of them even allow for privilege escalation:
>>>> CVE-2000-1134
>>>> CVE-2007-3852
>>>> CVE-2008-0525
>>>> CVE-2009-0416
>>>> CVE-2011-4834
>>>> CVE-2015-1838
>>>> CVE-2015-7442
>>>> CVE-2016-7489
>>>>
>>>> This list is not meant to be complete. It's difficult to track down
>>>> all vulnerabilities of this kind because they were often reported
>>>> without any mention of this particular attack vector.
>>>> In fact, before hardlinks/symlinks restrictions, fifos/regular
>>>> files weren't the favorite vehicle to exploit them.
>>>>
>>>> Suggested-by: Solar Designer <solar@openwall.com>
>>>> Suggested-by: Kees Cook <keescook@chromium.org>
>>>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>>>> [...]
>>>
>>> I think this looks great.
>>>
>>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> Tested-by: Kees Cook <keescook@chromium.org>
>
> Awesome! Thank you very much for your help!

Salvatore, do you want to send this again as a v5 with my two
follow-up patches, as I have them here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/userspace/protected-creat

or would you like me to send those? I would expect this series to land
via the -mm tree, since that tends to be the catch-all. (In which
case, the series should be To: akpm with everyone else in Cc.)

-Kees

-- 
Kees Cook
Pixel Security
