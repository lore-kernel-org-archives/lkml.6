Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CCFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0723920C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5zmrpYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0723920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeGQKzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:55:47 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:39118 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbeGQKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:55:47 -0400
Received: by mail-oi0-f45.google.com with SMTP id d189-v6so1021577oib.6;
        Tue, 17 Jul 2018 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9LvtM9vBWUmjZKWE2Ji4MQjdGC7SdL4mvtTtqv6dHGY=;
        b=R5zmrpYBEl/WnYd1NFn1ypIF5r5WzV1nsTGRCF1ShbD6iztjUPRAx1vD3tl1N0UKGu
         5F6A0xjmvJYNhABYBjGQzt8tdigUzBACNz4VZK76NXc11jP7T8RMAFWIrTAVGFqUm1/x
         eKsnY0FNOJGzYj5PFZOVO5g+ISts1r2N7Jw9FGRP6pwzzadHasOe0orbVFhL1ZpK785j
         3YHf1ShysmCqTSwqBrWZLXc7AmJ0iEMAddG9pKTssXcNJ7FJQLsVNGgb/cGEJb0MZPDn
         VsxbC4xWseBSYIVUlTp3mVT3L1/mf14sjB0diWtxIdrgjUQ0mmy5/iU7T8FrS7ThAAw+
         hV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9LvtM9vBWUmjZKWE2Ji4MQjdGC7SdL4mvtTtqv6dHGY=;
        b=FE6R/pUxU74WtEyKkMyH7lCzZFH62yJBBGjytn50OCwIZxQvABA5UBpZsoXJuMYKKs
         imWTOQYOdj2CyZEu5SZsvcNUqB/iwshxOFurDto2eDAIa2qiNhVx357M6K/TTdwONuMq
         6UmorDD5FPGLBqY/mUGciIfw/my4EOkZ3NGD+Yj5tXP5aA3ftpBOUzpxlR/5E2pEUhjZ
         JOzCwOrsAD1vs3Hy3dNYxuCtuPGCkugeY6FbBr4tLM75OXZ/lAp1JY3ttzh5WMYzYNI3
         nPNwphFH4hcqYilfzDIkKzsLnuSJONaCfDX2CgWPQYyc/L5wUniB9+Boa0+uROiA1V1C
         D7Mw==
X-Gm-Message-State: AOUpUlEEIzbIVnxXIH/f1Xv4f8TvDWVn4f/p609ack3f3eNarZtcJh4m
        JEwf3fay3YOR3hShZ7cNB1GFmFmKsDAD7vkaIKw=
X-Google-Smtp-Source: AAOMgpdj1aaJ+/BADQOoXXo9uPKoswHKo6unVUcSMNDATTGyK7ua7es+7RdP9KFVCi0j4B5IuubtA+K2lR1TAyhcpZ4=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr1033893oie.233.1531823031542;
 Tue, 17 Jul 2018 03:23:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 03:23:51
 -0700 (PDT)
In-Reply-To: <20180717102136.snayvzmv2h3dcwiq@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717092721.onkaf3qsu7te6syi@suselix>
 <20180717093620.ym6phfmr3rfvsxyo@suselix> <3724084.DyflrVPzDS@aspire.rjw.lan> <20180717102136.snayvzmv2h3dcwiq@suselix>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 12:23:51 +0200
X-Google-Sender-Auth: IDyg2PMHEiEFVq8KPiT5TWWP-4o
Message-ID: <CAJZ5v0gdbopHE5Kbhw3h7Hj7bqmDKeoReNoRXJ2gYxQROQQ6iw@mail.gmail.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:21 PM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 12:09:21PM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, July 17, 2018 11:36:20 AM CEST Andreas Herrmann wrote:
>> > On Tue, Jul 17, 2018 at 11:27:21AM +0200, Andreas Herrmann wrote:
>> > > On Tue, Jul 17, 2018 at 11:23:25AM +0200, Rafael J. Wysocki wrote:
>> > > > On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>> > > > > On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
>> > > > >> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>> > > > >>
>> > > > >> [cut]
>> > > > >>
>> > > > >> >
>> > > > >> > On balance before this commit users could use pcc-cpufreq but had
>> > > > >> > already suboptimal performance (compared to say intel_pstate driver
>> > > > >> > which can be used changing BIOS options).
>> > > > >>
>> > > > >> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
>> > > > >
>> > > > > I think this is because of (in intel_pstate_init()):
>> > > > >
>> > > > >         /*
>> > > > >          * The Intel pstate driver will be ignored if the platform
>> > > > >          * firmware has its own power management modes.
>> > > > >          */
>> > > > >         if (intel_pstate_platform_pwr_mgmt_exists())
>> > > > >                 return -ENODEV;
>> > > > >
>> > > >
>> > > > OK, because of the "Proliant" entry, right?
>> > > >
>> > > > So it looks like we have an issue there.  We find the entry and we
>> > > > look for _PSS.  It is not there, so we assume that the firmware is
>> > > > expected to control performance, which is not the case.
>> >
>> > FYI, there is another BIOS setting on those systems. It's called
>> > "Collaborative Power Control" (AFAIK enabled by default).
>> >
>> > Only if this is disabled, firmware is (alone) in control of
>> > performance. (And of course in this case neither pcc-cpufreq nor
>> > intel_pstate will be loaded).
>>
>> OK, the patch is below.
>>
>> First, I hope that if "Collaborative Power Control" is disabled, it will
>> simply hide the PCCH object and so intel_pstate will still not load then.
>
> PCCH is hidden in that case.

OK

>> The main question basically is what the OS is expected to do if
>> "Dynamic Power Savings Mode" is set.  If we are *expected* to use
>> the PCC interface then, intel_pstate may not work in that case, but
>> I suspect that the PCC interface allows extra energy to be saved
>> over what is possible without it.
>
> I'll test it and see what happens.

Thanks!
