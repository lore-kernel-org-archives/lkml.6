Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-1629513-1520901915-2-2258983917361052739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520901914; b=PKcZQIhtivH9ZzyG2EkpBUT19JdzZZ1zzgna938s5UNrcTu
    NHMNRAeqiv954JYvnHnGEiZ0qQTYyLxDVE2+yZA+MTO16hfQGaPkcw8tXtbJn18u
    2uBGajR/Nu33do9xwQJKXZjBZ8Xx6gxkIuYkwA2jIEP2dgx/M9F87+tHgtoMLlbH
    Mm/wOBKVCLEbrwejzbgzqPZu0kW8TAjpnDzMqiVJMGhOLwJwKut+gmYgNIm66f6e
    /dRKjU1h4RGUhOIn0SbBJ+hCJ0qVJN4u4zTJfPJ2gfA1YGfMMW9mmxNW20wLP4T7
    TGO45DaAPOGktEr5NSUaCuVil93NJZtyqZuOrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe
    :content-transfer-encoding:content-type; s=arctest; t=
    1520901914; bh=p3Iz4ZFvXhV/u4YixeihhmOg1PneZVAyXawoHk4n7bs=; b=s
    OLvFh49I6oDqlpzOZ1sf1s2yooVVKkCh+i0KB4iqtrFCS73S1wwPhsIIC6+r81Ad
    TcDfEXGHXhKsBWaJdaLvGH7GhyzZFnSy6cd9EPWPZ9FPF+daiXp09BGZWLxF/mic
    JMdIWCm8KYk7rSymxA3IpBphlzZVJ+7KYfhHlL6fimFN2Y+HDCssrPPj7Xiophpm
    WKdvqdz7bO3n5QWOYWrtRYa2v+tqMbtWgag3wnm9r95CB9QWn8F8ygXRus8ppvHE
    1UJOzlv2oj5dMhq5eoHnj4MyW2LU7zpVvmcv5wdtp9tQS1G8sfzBWmZ+Ac0UEJ/L
    HZBIVDcuP6sHS/g9LDd2g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=internode.on.net;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=internode.on.net header.result=pass header_org.domain=on.net header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=internode.on.net;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=internode.on.net header.result=pass header_org.domain=on.net header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Tobin C. Harding" <tobin@apporbit.com>
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
 <20180312030834.GC8631@eros>
 <CA+55aFww=otC4Wv40enadF+9NAyWG4Hotzjvv2EKb+_wGFui-w@mail.gmail.com>
From: Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <52aee09d-ba14-666b-8482-a4e7b6ef8889@internode.on.net>
Date: Tue, 13 Mar 2018 11:14:52 +1030
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFww=otC4Wv40enadF+9NAyWG4Hotzjvv2EKb+_wGFui-w@mail.gmail.com>
Content-Language: en-AU
Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Linux SCSI List <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 kernelnewbies@kernelnewbies.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dario Ballabio <ballabio_dario@emc.com>, Kees Cook <keescook@chromium.org>
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Linus Torvalds wrote on 13/03/18 05:15:
> On Sun, Mar 11, 2018 at 8:08 PM, Tobin C. Harding <tobin@apporbit.com> wrote:
>>
>> I think we are going to see a recurring theme here.  MAX_MAILBOXES==64
>> so this patch adds 1536 bytes to the stack on a 64 bit machine or 768
>> bytes on a 32 bit machine.
> 
> Yeah, that's a bit excessive. It probably works, but one or two of
> those allocations will make the kernel stack really tight, so in
> general I really would suggest using kmalloc() instead, or figuring
> out some way to simply shrink the data structures.
> 
> That said, I wonder if the solution to this particular driver is
> "delete it". Because the hardware is truly ancient and nobody sane
> would use it any more.
> 
> The last patch that seemed to come from an actual _user_ finding a
> problem was in 2008 (commit 20c09df7eb9c: "[SCSI] eata: fix the data
> buffer accessors conversion regression"). And even then it apparently
> took a year for people to have noticed the breakage.
> 
> But because the person who reported that problem is still around, I'll
> just add him to the cc, just in case.
> 
> Arthur Marsh, you have the dubious honor and distinction of being the
> only person to have apparently used that driver in the last ten years.
> Do you still have hardware using that? Because maybe it's really time
> to retire that driver.
> 
>                     Linus
> 

Hi Linus and maintainers, thanks for the courtesy email and all the help 
with the driver.

I am unable to make use of the driver any more due to failed hardware.

The DPT2044W SCSI controller and the IBM disk from May 1998 last 
officially ran on 7 August 2017. I was had previously been able to get 
the data off it and disconnected the controller and disk following 
recurring problems with booting.

Aug  7 16:40:24 localhost kernel: [  105.098705] sd 0:0:6:0: [sda] 
Synchronizing SCSI cache
Aug  7 16:40:24 localhost kernel: [  105.233166] EATA0: IRQ 11 mapped to 
IO-APIC IRQ 18.
Aug  7 16:40:24 localhost kernel: [  105.233475] EATA/DMA 2.0x: 
Copyright (C) 1994-2003 Dario Ballabio.
Aug  7 16:40:24 localhost kernel: [  105.233485] EATA config options -> 
tm:1, lc:y, mq:16, rs:y, et:n, ip:n, ep:n, pp:y.
Aug  7 16:40:24 localhost kernel: [  105.233492] EATA0: 2.0C, PCI 
0x9010, IRQ 18, BMST, SG 122, MB 64.
Aug  7 16:40:24 localhost kernel: [  105.233499] EATA0: wide SCSI 
support enabled, max_id 16, max_lun 8.
Aug  7 16:40:24 localhost kernel: [  105.233505] EATA0: SCSI channel 0 
enabled, host target ID 7.
Aug  7 16:40:24 localhost kernel: [  105.233521] scsi host0: EATA/DMA 
2.0x rev. 8.10.00

Arthur Marsh.

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
