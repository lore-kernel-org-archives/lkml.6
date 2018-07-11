Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD5DC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EDE20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RKpNEZ6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EDE20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbeGKXOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:14:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45906 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbeGKXOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:14:36 -0400
Received: by mail-pl0-f66.google.com with SMTP id a17-v6so3957092plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 16:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Qv0HkLAGzu3staRUmX6Rp1pvC+f8yKr2YsDxmf9WUI=;
        b=RKpNEZ6WuHNmPbADTjlt20oLkt2CdlfZfIts00DniMeLl0BszHbAq1GXSAs1Lgr7sB
         Pl55s0I3Y3v2rnUlInu3L3WGhZjYB1lgpMdVQTP0iygi9IE54HHEw8847VZx+HiYstPW
         o72PHEy6NX/mF71NHUYTTbGuCdyQdE0h30p5YM6nmS3EC1odAZ0zva7Z9QmYQ5JSuzfF
         itOViTJN2gfqxpJKUPTkJOhOHzV718/qWdM1H646HmgJYBvLQwhM3NqGfl3/DZfTBIqV
         kdZnq8s8HRS80XkhBUlxWugRin7JXbq6f+dl2qIfUEW8TNmzH0Q5LAdif8sS3KvBIioS
         H8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Qv0HkLAGzu3staRUmX6Rp1pvC+f8yKr2YsDxmf9WUI=;
        b=OoOde608r4SUQiEfGyKIUVPN7dOnyvqpy8l2U7U2aYw9e0646BcMJdf4AzMzFIWK95
         vxO+9MzWl3z8dvlSmip8z8nX9K6S8UHVmpuf30DEIfvlpdh6OeRRRPhmxLSvdb698OxQ
         FR5jv7jbkmpyDpJRRntrPaRcg+mfHCD5tBAeCQTHSqsNrj3Lvw49I9aEogFUuWdRXq5X
         +HatGRe2X9dNqBI+WckQosaoa/eO61okMTiY1KzYGj/iAIJ20ocibwS52j8xQDpqFHL0
         54i0KCv+z58m3CZ0WnYPLojSYQpZjyBita0rAehVKjfgmyy5XOvXjDrSkYJ7HyicU2mn
         ibAA==
X-Gm-Message-State: AOUpUlEgpweazqzIDAk8k8T4mI3Z8mEER3vdZ6gJQomKHhGtdiP/RiCg
        7+CXYFg3YbA58tZ4Gnd9PEk2NQ==
X-Google-Smtp-Source: AAOMgpfhSh3IW+IBrjGCeyCkdYBA1V+emLPilQaueEnALb4TJ09fO4BE8GP7OSIjNpCQl4xjm1V8AA==
X-Received: by 2002:a17:902:a581:: with SMTP id az1-v6mr503502plb.61.1531350479979;
        Wed, 11 Jul 2018 16:07:59 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:968:4f0:92ce:1385:5f3d? ([2600:1010:b052:968:4f0:92ce:1385:5f3d])
        by smtp.gmail.com with ESMTPSA id d188-v6sm37571186pfc.96.2018.07.11.16.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 16:07:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Kernel 4.17.4 lockup
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180711183126.yo7eyqpd4ggb5kcr@codemonkey.org.uk>
Date:   Wed, 11 Jul 2018 16:07:57 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A6C6EEB-85D8-4F59-95ED-EB4DA5947BCA@amacapital.net>
References: <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com> <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com> <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com> <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com> <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com> <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com> <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com> <067e2d5d-1abf-efd4-cb50-992ba5ca6748@intel.com> <20180711183126.yo7eyqpd4ggb5kcr@codemonkey.org.uk>
To:     Dave Jones <davej@codemonkey.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Jul 11, 2018, at 11:31 AM, Dave Jones <davej@codemonkey.org.uk> wrote:
>=20
>> On Wed, Jul 11, 2018 at 10:50:22AM -0700, Dave Hansen wrote:
>> On 07/11/2018 10:29 AM, H.J. Lu wrote:
>>>> I have seen it on machines with various amounts of cores and RAMs.
>>>> It triggers the fastest on 8 cores with 6GB RAM reliably.
>>> Here is the first kernel message.
>>=20
>> This looks like random corruption again.  It's probably a bogus 'struct
>> page' that fails the move_freepages() pfn_valid() checks.  I'm too lazy
>> to go reproduce the likely stack trace (not sure why it didn't show up
>> on your screen), but this could just be another symptom of the same
>> issue that caused the TLB batching oops.
>>=20
>> My money is on this being some kind of odd stack corruption, maybe
>> interrupt-induced, but that's a total guess at this point.
>=20
> So, maybe related.. I reported this to linux-mm a few days ago:
>=20
> When I ran an rsync on my machine I use for backups, it eventually
> hits this trace..
>=20
> kernel BUG at mm/page_alloc.c:2016!
> invalid opcode: 0000 [#1] SMP RIP: move_freepages_block+0x120/0x2d0
> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.18.0-rc4-backup+ #1
> Hardware name: ASUS All Series/Z97-DELUXE, BIOS 2602 08/18/2015
> RIP: 0010:move_freepages_block+0x120/0x2d0
> Code: 05 48 01 c8 74 3b f6 00 02 74 36 48 8b 03 48 c1 e8 3e 48 8d 0c 40 48=
 8b 86 c0 7f 00 00 48 c1 e8 3e 48 8d 04 40 48 39 c8 74 17 <0f> 0b 45 31 f6 4=
8 83 c4 28 44 89 f0 5b 5d 41
> 5c 41 5d 41 5e 41 5f
> RSP: 0018:ffff88043fac3af8 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffea0002e20000 RCX: 0000000000000003
> RDX: 0000000000000000 RSI: ffffea0002e20000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff88043fac3b5c R09: ffffffff9295e110
> R10: ffff88043fdf4000 R11: ffffea0002e20008 R12: ffffea0002e20000
> R13: ffffffff9295dd40 R14: 0000000000000008 R15: ffffea0002e27fc0
> FS:  0000000000000000(0000) GS:ffff88043fac0000(0000) knlGS:00000000000000=
00
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2a75f71fe8 CR3: 00000001e380f006 CR4: 00000000001606e0
> Call Trace:
> <IRQ>
> ? lock_acquire+0xe6/0x1dc
> steal_suitable_fallback+0x152/0x1a0
> get_page_from_freelist+0x1029/0x1650
> ? free_debug_processing+0x271/0x410
> __alloc_pages_nodemask+0x111/0x310
> page_frag_alloc+0x74/0x120
> __netdev_alloc_skb+0x95/0x110
> e1000_alloc_rx_buffers+0x225/0x2b0
> e1000_clean_rx_irq+0x2ee/0x450
> e1000e_poll+0x7c/0x2e0
> net_rx_action+0x273/0x4d0
> __do_softirq+0xc6/0x4d6
> irq_exit+0xbb/0xc0
> do_IRQ+0x60/0x110
> common_interrupt+0xf/0xf
> </IRQ>
> RIP: 0010:cpuidle_enter_state+0xb5/0x390
> Code: 89 04 24 0f 1f 44 00 00 31 ff e8 86 26 64 ff 80 7c 24 0f 00 0f 85 fb=
 01 00 00 e8 66 02 66 ff fb 48 ba cf f7 53 e3 a5 9b c4 20 <48> 8b 0c 24 4c 2=
9 f9 48 89 c8 48 c1 f9 3f 48
> f7 ea b8 ff ff ff 7f
> RSP: 0018:ffffc900000abe70 EFLAGS: 00000202
> ORIG_RAX: ffffffffffffffdc
> RAX: ffff880107fe8040 RBX: 0000000000000003 RCX: 0000000000000001
> RDX: 20c49ba5e353f7cf RSI: 0000000000000001 RDI: ffff880107fe8040
> RBP: ffff88043fae8c20 R08: 0000000000000001 R09: 0000000000000018
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff928fb7d8
> R13: 0000000000000003 R14: 0000000000000003 R15: 0000015e55aecf23
> do_idle+0x128/0x230
> cpu_startup_entry+0x6f/0x80
> start_secondary+0x192/0x1f0
> secondary_startup_64+0xa5/0xb0
> NMI watchdog: Watchdog detected hard LOCKUP on cpu 4
>=20
> Everything then locks up & rebooots.
>=20
> It's fairly reproduceable, though every time I run it my rsync gets furthe=
r, and eventually I suspect it
> won't create enough load to reproduce.
>=20
> 2006 #ifndef CONFIG_HOLES_IN_ZONE
> 2007         /*
> 2008          * page_zone is not safe to call in this context when
> 2009          * CONFIG_HOLES_IN_ZONE is set. This bug check is probably re=
dundant
> 2010          * anyway as we check zone boundaries in move_freepages_block=
().
> 2011          * Remove at a later date when no bug reports exist related t=
o
> 2012          * grouping pages by mobility
> 2013          */
> 2014         VM_BUG_ON(pfn_valid(page_to_pfn(start_page)) &&
> 2015                   pfn_valid(page_to_pfn(end_page)) &&
> 2016                   page_zone(start_page) !=3D page_zone(end_page));
> 2017 #endif
> 2018
>=20
>=20
> I could trigger it fairly quickly last week, but it seemed dependant on ju=
st how much
> rsync is actually transferring. (There are millions of files, and only a f=
ew thousand had changed)
>=20
> When there's nothing changed, the rsync was running to completion every ti=
me.
>=20
>=20

Could the cause be an overflow of the IRQ stack?  I=E2=80=99ve been meaning t=
o put guard pages on all the special stacks for a while. Let me see if I can=
 do that in the next couple days.=
