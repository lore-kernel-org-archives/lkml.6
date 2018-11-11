Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1C620892
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="U4wjnbR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1C620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeKKKGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 05:06:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45925 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeKKKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 05:06:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id p17-v6so2562334pfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 16:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0cuXtaAxJ9YRgdBx1q2WJD4HHmDGmieV+OJEZ7rGfc4=;
        b=U4wjnbR7nPd6LO/VvZLyEp28uGr3JRC8XZMy+MqHtbCvzblHGMQk76JMVITIFcdHDv
         w8PZBWGuUVIb/7VbVQzfVOFplJjdCxgtSvuVgSQaeAtyEQBgtambgJXfqwqSQFnUGn/V
         zbenmSNkClXcMDIqqgiR/oqg1EtotXuhsSDmcDqFDz6VrLa5oe7Gu3nbzpF80+GUEC5i
         fbsf+V4nrGPHEHp6QLQ5KR6jOxk25DE4g5larVgmZGEr2s7fCto5pTmZyTAy5jaDKopv
         FRwjDMywV3+pYXNqcu/zh2p8KHCfl6Vsc+2nQhnMf3QkN7juqwsuLBohxxIYKgREp5wl
         /UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0cuXtaAxJ9YRgdBx1q2WJD4HHmDGmieV+OJEZ7rGfc4=;
        b=dKEc4SqeODV3faWWStT0UePB+9TzZRJCBLtr8CaSE0cHd+WvypdphYAjSZEoOLAsc7
         vZcwTC5CQ79P2pdQL5jupv45BsqbYE0SPG6kcMqVK8IaTgfBxWijsJTt0dO9WYRgjr8h
         WhdXxkMfAX1LB+b5RJKD0gX2ESXnzKwXi1yFcaEgyg7OVnC1PmoQl3Oyaio+CGWHNVpV
         Mg2bpStSJFQWDyRDH9mcTu4bqzLhAVvBMR9of73CG4p6+F168w7iRCeqUEjRxOxTxBeZ
         /h49YCypIK+MPDLNpj23KxzITTKj+x2oNlgmqPLf9ryY6pAAMPC1HQMXhCia8uJjacFA
         g6UQ==
X-Gm-Message-State: AGRZ1gKmMFN290j4Ov5KokvHoaXs7mYycvMEhW4OMhJ1IvykvH+KrSzk
        niHfq4iMqMBv4edb/YKMZqQ3WQ==
X-Google-Smtp-Source: AJdET5eZW3Kmo8zp0lf355dAUfBDjk8B7UuG9aQekuXbtt1Cip8JVFI4ZA5787pzGRR4i88AnSd0bw==
X-Received: by 2002:a65:5c81:: with SMTP id a1-v6mr12364489pgt.390.1541895555666;
        Sat, 10 Nov 2018 16:19:15 -0800 (PST)
Received: from ?IPv6:2600:1010:b00a:6291:7535:ae65:b517:1e1a? ([2600:1010:b00a:6291:7535:ae65:b517:1e1a])
        by smtp.gmail.com with ESMTPSA id r124-v6sm15702768pfr.151.2018.11.10.16.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 16:19:14 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/mm/pat: Fix missing preemption disable for __native_flush_tlb()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAPcyv4hXzBT1LkEdBYw_mkrKV+SK1LRE2PwJ5=T+e7GxWbXaNQ@mail.gmail.com>
Date:   Sat, 10 Nov 2018 16:19:08 -0800
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DFD717D-857D-493D-A606-B635D72BAC21@amacapital.net>
References: <154180834787.2060925.7738215365584115230.stgit@dwillia2-desk3.amr.corp.intel.com> <7590EF40-B0CF-40BD-9D29-FB731A2A2E3A@amacapital.net> <CAPcyv4hXzBT1LkEdBYw_mkrKV+SK1LRE2PwJ5=T+e7GxWbXaNQ@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 10, 2018, at 3:57 PM, Dan Williams <dan.j.williams@intel.com> wrote=
:
>=20
>> On Fri, Nov 9, 2018 at 4:22 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>>=20
>>=20
>>=20
>>> On Nov 9, 2018, at 4:05 PM, Dan Williams <dan.j.williams@intel.com> wrot=
e:
>>>=20
>>> Commit f77084d96355 "x86/mm/pat: Disable preemption around
>>> __flush_tlb_all()" addressed a case where __flush_tlb_all() is called
>>> without preemption being disabled. It also left a warning to catch other=

>>> cases where preemption is not disabled. That warning triggers for the
>>> memory hotplug path which is also used for persistent memory enabling:
>>=20
>> I don=E2=80=99t think I agree with the patch. If you call __flush_tlb_all=
() in a context where you might be *migrated*, then there=E2=80=99s a bug. W=
e could change the code to allow this particular use by checking that we hav=
en=E2=80=99t done SMP init yet, perhaps.
>=20
> Hmm, are saying the entire kernel_physical_mapping_init() sequence
> needs to run with pre-emption disabled?

If it indeed can run late in boot or after boot, then it sure looks buggy. E=
ither the __flush_tlb_all() should be removed or it should be replaced with f=
lush_tlb_kernel_range(). It=E2=80=99s unclear to me why a flush is needed at=
 all, but if it=E2=80=99s needed, surely all CPUs need flushing.=
