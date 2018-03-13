Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-9491-1520978720-2-34051750529990629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_NONE -0.0001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520978719; b=LpdesYBje9YbYsHGGKRoKjua4Q7hZnEjptT12EvdepCYfVN
    dcbTCiFpW1ddSIykth4MiUemZF9RMRj6+8vtvkefUrxhQWKP0i2TIo0Rb+Db2Yef
    ZZorRAg8HH2dup49UZZ9hZStWC3TSUBU1mWPz34HYBOiyK40SXSfSJuMsPvlLrUy
    NTfNGQK1LhtWbl8IKW5G83dNrM9uGyxW2FYG8AgFhE/hRirxEOXEiYYF9q4nM4qD
    iICTgaP7IE77Igbar1eeQPY2x+hU7pNfeOhj1nXhjqTW76nX5KWxXmW9sKfERh0V
    N0/UCK1LIXuOXVk3JcpQvRi4naVCMNu92l0W0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1520978719; bh=k4utSUTP
    IstZ8xQikxPCR/KxSmbhPzYL4CmJfAPWDxM=; b=O0pOmRBUhfiahKDz/fw3kIDh
    itANiltJ4iSoWTDvFCPlrXQDYDlRr0QTUXmJV1PgNayioxLNDuGXYYGY9jyf0WoZ
    hzFkeGoiP9Pai8KPAwFJDlc1PdYthby5xAsjTvCM8Zvp52hpROsYYmL7VIW+ta/E
    eGuxe28ezVJJYV8p5X/onlj6ZHebMrZV3A3xlQubNoj28cvJAzUia+KqXPh+FO7S
    26Q1EyC9a0dM9XZOJRtD+IK3OHsNp0xF4b+bva0Djpmqaa0/MyrKyvt5/lTHUcwy
    /3LJAulBAZApA1t34TIt/fDST8L9OxDn0r09936ewKl3HuvXNUE5RoPJ7ryW2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vXhab4UM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Co1XY+Zz;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vXhab4UM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Co1XY+Zz;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELsWxoHa2Hfe5NeXvJYCADGSPUxXpsA6K4+T8rMC1sQceXWWKmHFj4n8BV3wBGCdo20OOTg0tLMZEdP0PUf4aHo=
MIME-Version: 1.0
In-Reply-To: <20180313090540.GA4810@infradead.org>
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
 <20180312030834.GC8631@eros>
 <CA+55aFww=otC4Wv40enadF+9NAyWG4Hotzjvv2EKb+_wGFui-w@mail.gmail.com>
 <yq1y3iwem87.fsf@oracle.com> <20180313090540.GA4810@infradead.org>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Tue, 13 Mar 2018 23:04:21 +0100
Message-ID: <CAJHCu1+XPPmCcrP+89zc9Lg7k_t78LzfJbY7aC8Mt+ANeuVWdA@mail.gmail.com>
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
To: Christoph Hellwig <hch@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Linux SCSI List <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Tobin C. Harding" <tobin@apporbit.com>, kernelnewbies@kernelnewbies.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dario Ballabio <ballabio_dario@emc.com>,
 Arthur Marsh <arthur.marsh@internode.on.net>,
 Kees Cook <keescook@chromium.org>
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-13 10:05 GMT+01:00 Christoph Hellwig <hch@infradead.org>:
> On Mon, Mar 12, 2018 at 10:35:36PM -0400, Martin K. Petersen wrote:
>> No objections to Salvatore's patch but I have a slight affinity for
>> retiring unused code over patching it. So unless there are objections...
>
> Lets kill it.  And the not DMA capable eata_pio driver with it for
> good riddance.

Good, I'll send a patch to remove eata & friends.
Thank you for your time,

Salvatore

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
