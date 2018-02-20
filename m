Return-Path: <Steffen.Klassert@secunet.com>
X-Google-Smtp-Source: AH8x226qujUr2XNn/awynMOjNGnrn+3eCNmR7DeeiIYi15z1DEig2o9xG16P4vH2HrYGXTW+HPCe
ARC-Seal: i=1; a=rsa-sha256; t=1519120390; cv=none;
        d=google.com; s=arc-20160816;
        b=U60jCevDxjTwPj5lJbvRUFb9HNMQ7MrItgS7M072GMvO/mVdwbbOl1CZdWz8e/0+M9
         1RXHusR0MLA1otYcxhd/wdolO1wglCXGWzWWPrKq1u7Sd69+VONTCJVdnySmTkcvbATl
         W3mEH6cntArPBcmsHjHKN2DubV5yKphb9Rg7/RiU3bgh+UyNVKmdhSMHBvFuIH/mSpLS
         XJhrvgpeQPCtcqSo5q/VFJZmlPCULrXZHrN/K7jK6oZ7NT5ZQGvqz7qWa9KvUa+zALb3
         w4lNkpT73rDJ4mXXGkWr0JxQLSQNSzSnObl6w4mQ6Cf91DuQgpNHFTQCFBMwt8Vj4FAQ
         8IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0PelpJtVQPt7sfYjk8bF7CvQc5I5K1WQmU5nXfxX6Ms=;
        b=hJ4q3zDT9s7s3SYpwt2VkvPrIql/LD6UPQzWmqV1q1IULbYopkw9VM0VZL+cy/HYUB
         mQIvZ7HATjNTjBQXoHRXuwDL8gsd34iA9fXhZ8pGNji0t5ngTncfQ6I5beAuxNGToemX
         KPwHpbr+mGiZawnTL2PZ24al+6cKmYltSb0IrhByoSwHDyulJ51WUBXTrxJB0JuiMpsn
         tuPAxbEgahNJ4dXM0yCp2DWS6uwSzIceK8G03lJwra04VR9hUDcCLItgM4kbVP8Q9aC+
         eXRyDtQqZWPDtuof6uiWu5kcl/vF2TTiGfSy3ZeMaZkVHgnGOuJE8qW/fiWatI6qMAKw
         nAWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of steffen.klassert@secunet.com designates 62.96.220.36 as permitted sender) smtp.mailfrom=Steffen.Klassert@secunet.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of steffen.klassert@secunet.com designates 62.96.220.36 as permitted sender) smtp.mailfrom=Steffen.Klassert@secunet.com
Date: Tue, 20 Feb 2018 10:53:07 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dmitry Vyukov <dvyukov@google.com>
CC: syzbot <syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com>,
	<dzickus@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	<npiggin@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>,
	<syzkaller-bugs@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>,
	"the arch/x86 maintainers" <x86@kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, netdev
	<netdev@vger.kernel.org>
Subject: Re: INFO: rcu detected stall in xfrm_confirm_neigh
Message-ID: <20180220095307.lh4m6m43354i7cal@gauss3.secunet.de>
References: <001a1141ba9ea381f70565057687@google.com>
 <CACT4Y+Z-iMWQccvthBAb2Ze4GjkVAm-B7m=b+KYg8AqEn4gw1Q@mail.gmail.com>
 <CACT4Y+aHScQyOybzx22irqKE+B=xU79+zfgSnjCHZT6gqF89Hw@mail.gmail.com>
 <20180219072243.vk7ow4gdpqhz5gbp@gauss3.secunet.de>
 <CACT4Y+ZNFC0sBUd+ikf64N6vv26v-GcqD+M2p7q=gDDw-LkBQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZNFC0sBUd+ikf64N6vv26v-GcqD+M2p7q=gDDw-LkBQQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: C0D6CA9D-99E1-4956-818A-5E094A0E0A00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592209203961806699?=
X-GMAIL-MSGID: =?utf-8?q?1592913182599756640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 11:05:38AM +0100, Dmitry Vyukov wrote:
> On Mon, Feb 19, 2018 at 8:22 AM, Steffen Klassert
> <steffen.klassert@secunet.com> wrote:
> >> > <syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com> wrote:
> >> >> Hello,
> >> >>
> >> >> syzbot hit the following crash on net-next commit
> >> >> 9515a2e082f91457db0ecff4b65371d0fb5d9aad (Thu Jan 25 03:37:38 2018 +0000)
> >> >> net/ipv4: Allow send to local broadcast from a socket bound to a VRF
> >> >>
> >> >> So far this crash happened 6 times on net-next.
> >> >> Unfortunately, I don't have any reproducer for this crash yet.
> >> >> Raw console output is attached.
> >> >> compiler: gcc (GCC) 7.1.1 20170620
> >> >> .config is attached.
> >> >
> >> >
> >> > +xfrm maintainers
> >>
> >> Here is a C repro:
> >> https://gist.githubusercontent.com/dvyukov/92c67ba9afaaa960bcfbdc6ef549ac10/raw/786f9221c1d707c7f4a15effcb1d5997dd4f8638/gistfile1.txt
> >
> > Seems like syzbot does not know about this reproducer.
> >
> > I've send a patch to test and got this as the reply:
> >
> > This crash does not have a reproducer. I cannot test it.
> 
> Yes, it does not know about the reproducer. I've extracted it
> manually, these hangs are sometimes hard to reproduce. For syzbot this
> bug does not have a reproducer.
> Have you tried to run the reproducer? For me it reproduced the bug
> quite reliably.

I've tried the reproducer, it does not trigger with my kernel
config and with your config my machine does not boot. So it
was just easy to ask syzbot for a test.

Anyway, Florian Westphal did a test and confirmed that
the patch fixes the issue. I've just applied the fix
below to the ipsec tree.


Subject: [PATCH] xfrm: Fix infinite loop in xfrm_get_dst_nexthop with transport mode.

On transport mode we forget to fetch the child dst_entry
before we continue the while loop, this leads to an infinite
loop. Fix this by fetching the child dst_entry before we
continue the while loop.

Fixes: 0f6c480f23f4 ("xfrm: Move dst->path into struct xfrm_dst")
Reported-by: syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com
Tested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 150d46633ce6..625b3fca5704 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2732,14 +2732,14 @@ static const void *xfrm_get_dst_nexthop(const struct dst_entry *dst,
 	while (dst->xfrm) {
 		const struct xfrm_state *xfrm = dst->xfrm;
 
+		dst = xfrm_dst_child(dst);
+
 		if (xfrm->props.mode == XFRM_MODE_TRANSPORT)
 			continue;
 		if (xfrm->type->flags & XFRM_TYPE_REMOTE_COADDR)
 			daddr = xfrm->coaddr;
 		else if (!(xfrm->type->flags & XFRM_TYPE_LOCAL_COADDR))
 			daddr = &xfrm->id.daddr;
-
-		dst = xfrm_dst_child(dst);
 	}
 	return daddr;
 }
-- 
2.14.1
