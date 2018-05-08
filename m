Return-Path: <jmforbes@linuxtx.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525814765; cv=none;
        d=google.com; s=arc-20160816;
        b=f/uUvGLQe2Jf0iHymKBryHslFc7zOCFOZr6qH/wMqBsKshRih5tp3xilyfo3ijuBJI
         WxVRcF8RjMKx5v3yUDUo/M30+yEOYuYTLVuOfAqkMN0nu16W7oevC098GOn1b3sFt8Xk
         BuXo9cLFc7bBCkjgJmmOMKcBudeKah0mAXag6uU8mD1HYmvFy/28lou8lYO9YvrEPaSq
         MJFEF3RmnCf0vke3eGY9Z2p0eToPCUn8ORZfWk0eh5LYrg7KjBa0muPbtC9ghhcWFgog
         KT9d6Je/gAUpMful9QZZSjucR4m0+L92iNVQ6iY5CaKiM03j5OI8rnWKYTigFFw8GnUr
         XgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=P4bac4MI3sVOGdaZv4QLIuetfffcA0k5+deXXnGrvlo=;
        b=O2KHuGjgYGFFKOe32GKEeoYKX86VWSAZVj1X6RKG+goUdPy4FHt1NC2t35pmvpzQIU
         7BdAEiHYEXKv9mrCCtslIYVtznM9Kxh0A1CQ6IT3MEkphyGbk1BnNRmXdfv/HUYEOWqJ
         M0eHnmoFssf5Qh+MZqfmwQjXy3sDVIpCHkzuOI9ev8uZ6Be4+5v3HVkFNUPhBjgud86d
         WbVxkbNbOR1Unz6m6IXvTrjGBGcrjy7slxIDJJmhivfiAIquIcNl40HLdVFkCfot/VR9
         Km62FnqT0j9lhOB260u0SOqZE0h7FFCc0zwlsO8TvGkV/774vycYCNde63SW1afp9+S+
         j/9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxtx.org header.s=google header.b=cHQZSmGB;
       spf=pass (google.com: domain of jmforbes@linuxtx.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmforbes@linuxtx.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxtx.org header.s=google header.b=cHQZSmGB;
       spf=pass (google.com: domain of jmforbes@linuxtx.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=jmforbes@linuxtx.org
X-Google-Smtp-Source: AB8JxZpIyC1l1P9vT5mWrDxePF3KWr3zl1jgXIJ9MnfVHgEJebe7PkzGt81VD3DybSsCEPySCmxES5zgOj2e9CuzLrs=
MIME-Version: 1.0
In-Reply-To: <20180508205505.GD8514@sasha-vm>
References: <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org> <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
 <20180508202912.GC8514@sasha-vm> <CAFhKne-aDcMKD8FjfROGZ-=ffmq3Xa+7n0dm8uvzKJ_7WO-qCQ@mail.gmail.com>
 <20180508205505.GD8514@sasha-vm>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 8 May 2018 16:26:04 -0500
Message-ID: <CAFxkdAow8=tK86c=AtkWhhzy_iE_sNX0uUGY+xjLC=njvBynBQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Matthew Wilcox <willy6545@gmail.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599932743441773001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 3:55 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Tue, May 08, 2018 at 08:40:02PM +0000, Matthew Wilcox wrote:
>>I think your sample size omits some people. I run Debian Testing on my
>>laptop. That gets something akin to a Linus release pretty soon after he
>>releases it, and while it gets some amount of -stable patches, it
>>progresses to the next release fairly rapidly.
>
> Debian testing is pretty much a -stable tree, see the git log history:
>
> https://salsa.debian.org/kernel-team/linux/commits/sid
>
> It follows a current stable tree, and moves on to the next one once it's
> available (about a week after Linus releases a new kernel).
>
>>Added Ben to the cc for more updates.
>>
>>I think Fedora does something similar.
>
> Fedora's rawhide is just (daily?) builds of Linus's tree, they don't
> care what stage the tree is in at any point.

It is, but there is a branch point when Linus releases. If we are
working on a new Fedora release, such as F28, all testing stayed on
4.16.0 until stable updates were released. If there is no release
deadline nearing, we have a "stabilization" repository where people
are using and testing the .0 release until stable updates happen. In
either case, the Linus release is really only tested until the stable
.1 happens, but there are users and testers of .0.

>
> My point is that no one picks a release and sticks with it more than a
> week. If someone plans to use a release for longer term they use a
> -stable tree, and if they are interested in testing, they move on to the
> next release once it's available.
>
> There's no one, for example, who picked up vanilla v4.16 and plans to
> keep using it for a year.
>
> This leads to my point about rushing fixes: -stable releases for v4.16 are
> done weekly, there's no need to rush them in during v4.16-rc8 just to
> make some imaginary release no one will pick up.
