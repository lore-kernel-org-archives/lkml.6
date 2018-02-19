Return-Path: <Steffen.Klassert@secunet.com>
X-Google-Smtp-Source: AH8x226hSt7SfI+2ZLqcV+8CBPCK+SSfIBYfZfdcb9A1iZzJE+k6V5mtgCJ9kuMsBXT5GC2UKtlZ
ARC-Seal: i=1; a=rsa-sha256; t=1519024964; cv=none;
        d=google.com; s=arc-20160816;
        b=z52u0tsRAerGs32rcAffmMIEHZOM1xhSyExDBEvZ5pq09PnecM0+dhV3MkHghXeZBH
         sUfNtLyAIu0/XXJIs0dXhlxFrwbJwvBcHhIjEnRQw82g709Q3UpbWy6HR2W195GauKOJ
         5nwhJMV8sxmFiWezlo1loQs6N1f+p3jzMxYsnEhvgt2oGCysDlT6tS+xXmp7fr4Y2JRK
         uQ2LIP1Yhxftk8NPYUiIm66V0rDSzzruUVHFQFKSWMltvhW4wzP4piOVFzQx2dUJ91KT
         vfvXFU1RT9RZqv70SpKWMoosOXVn2P3hvXmx+Eyd6N4zQZJMnQIWjio5Pm9s6gV7ddaw
         hdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NrjnHKMlu1HU+6ByONXY7Zb/NzXMNoWR3PhWcmjrDyQ=;
        b=RXfrPqiIv6/KcqcaV8zYP2EOvg6HGMUqapdEwWLJItoMLNDgLDbNZUtt5wRsS53bQB
         2ksW12VNtRfnN7o/ySYSvxVOkLzWCwYFxuy0yOf70r4V9Uk3tZDRnsJA2WhLokw2HrUD
         3fyoUC1WPBBhFT2oUihejWGsg2SLO0uYBxYOi2PiJb6HEUNcedqsktJ0YcOslk8Cncwo
         O60QK3alFLqTFbXfkLmZJqTaXUaBOdgQVimu7a5F84/clmYgVF4cn+UDls0Ln2aN9gM7
         vye6c5bf5gUUSZw17JUYGVxEYEkcm0idJHZxSWaN77sjwmY/J4F4khVvjTFaYCYu3GBn
         vwLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of steffen.klassert@secunet.com designates 62.96.220.36 as permitted sender) smtp.mailfrom=Steffen.Klassert@secunet.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of steffen.klassert@secunet.com designates 62.96.220.36 as permitted sender) smtp.mailfrom=Steffen.Klassert@secunet.com
Date: Mon, 19 Feb 2018 08:22:43 +0100
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
Message-ID: <20180219072243.vk7ow4gdpqhz5gbp@gauss3.secunet.de>
References: <001a1141ba9ea381f70565057687@google.com>
 <CACT4Y+Z-iMWQccvthBAb2Ze4GjkVAm-B7m=b+KYg8AqEn4gw1Q@mail.gmail.com>
 <CACT4Y+aHScQyOybzx22irqKE+B=xU79+zfgSnjCHZT6gqF89Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+aHScQyOybzx22irqKE+B=xU79+zfgSnjCHZT6gqF89Hw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: B1880CED-33C0-49D3-BD27-EC43E8272BDD
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592209203961806699?=
X-GMAIL-MSGID: =?utf-8?q?1592813121344111320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 10:19:17AM +0100, Dmitry Vyukov wrote:
> On Mon, Feb 12, 2018 at 4:26 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Feb 12, 2018 at 4:23 PM, syzbot
> > <syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot hit the following crash on net-next commit
> >> 9515a2e082f91457db0ecff4b65371d0fb5d9aad (Thu Jan 25 03:37:38 2018 +0000)
> >> net/ipv4: Allow send to local broadcast from a socket bound to a VRF
> >>
> >> So far this crash happened 6 times on net-next.
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >> Raw console output is attached.
> >> compiler: gcc (GCC) 7.1.1 20170620
> >> .config is attached.
> >
> >
> > +xfrm maintainers
> 
> Here is a C repro:
> https://gist.githubusercontent.com/dvyukov/92c67ba9afaaa960bcfbdc6ef549ac10/raw/786f9221c1d707c7f4a15effcb1d5997dd4f8638/gistfile1.txt

Seems like syzbot does not know about this reproducer.

I've send a patch to test and got this as the reply:

This crash does not have a reproducer. I cannot test it.
