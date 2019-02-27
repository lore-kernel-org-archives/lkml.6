Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C823AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C69A218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6fv3w/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfB0EgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:36:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46837 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfB0EgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 23:36:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id c17so4170085plz.13;
        Tue, 26 Feb 2019 20:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=UCvmrC0dUEZJyn2CDtaPiWbREFCNC3fnj+3eqopH4r8=;
        b=I6fv3w/YbbeT1FdxPHYxVEffiG1tpWidCSzadteeFRLPt/ugsM4BafoU2B/O8fRMqb
         UIh1eTWIpYCrR2/UT0J/OnxpnEvfbMIUJmuRiOg1m0xAbclOThVIYT1qTSoXvyiPOGFR
         YyxncDhkdNIBCAORHKDK7dTxdwvPERmLaZUtZwViwUy7x1XQFl0X5ECHFBCGTbNjujAy
         KPwJ12Jktu8tD6/Qa+9aKVubyFw5Z0gXpA5BVyfN7mNf6oiyPE9wuI70hJ2KeY41bTDG
         3ZxFRimv4NTs4A/s0Vxh86aKgEX70PTnM+OeFISH9UXX0yGslBqYxlggxsVpvUEhqBLK
         ZzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=UCvmrC0dUEZJyn2CDtaPiWbREFCNC3fnj+3eqopH4r8=;
        b=IEXOatqdUxDN6528d2C+bIznuPAuh18o69lcCt9wv9aHAJeBIamo764kwtFXCJQSdJ
         nJFxpG7ytzFKG4yJkrPN2KjxdkxLZUJqVcWoARoHN50jd4VABPlQlkdlhyWWFSQBsgF8
         r4Mhs3SSJyqYsxaOLORVcK+zVL8xfr9oYl54f+bn67A3X4ogbqI8FwQjBIH84nRwfdq2
         UID8HYpzg7Wynj9m/MIhDw0IuiMPv3qwT7clH6FKMbO40g4N5lP36AUh81fHS+HrZLI3
         tD/lGujEkszN1c8YoTPfWb9F9Ewy+2siZMpzMbqn9AweV+9nCtmg7QxiplnDtgKYg8Td
         oDXg==
X-Gm-Message-State: AHQUAuYMUwARzJXTj9m8aQ6UdEdWNEVIethJ8Vhdde2GPJpIK0qELq6S
        pXisE4IVLfHXrM1O6Ty+egnBV5xH
X-Google-Smtp-Source: AHgI3IZ1Ijhga1xYSFA5YuRFTBlKi0pxETeQj8Jqm4G6Aww4YrE/U8erpGclAtpLMzAVmxftX+cUVA==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr162453plp.0.1551242172174;
        Tue, 26 Feb 2019 20:36:12 -0800 (PST)
Received: from localhost (193-116-71-51.tpgi.com.au. [193.116.71.51])
        by smtp.gmail.com with ESMTPSA id e21sm34346002pfh.45.2019.02.26.20.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 20:36:11 -0800 (PST)
Date:   Wed, 27 Feb 2019 14:36:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 11/20] ia64: Add unconditional mmiowb() to
 arch_spin_unlock()
To:     linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190222185026.10973-1-will.deacon@arm.com>
        <20190222185026.10973-12-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-12-will.deacon@arm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551241306.u5r150hwwb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon's on February 23, 2019 4:50 am:
> The mmiowb() macro is horribly difficult to use and drivers will continue
> to work most of the time if they omit a call when it is required.
>=20
> Rather than rely on driver authors getting this right, push mmiowb() into
> arch_spin_unlock() for ia64. If this is deemed to be a performance issue,
> a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
> the barrier in cases where no I/O writes were performned inside the
> critical section.

mmiowb() was always the wrong approach. IIRC what happened is that an
ia64 platform found that real wmb() semantics were too expensive, so=20
they kind of "relaxed" it, breaking everything, and then said drivers
that wanted to unbreak themselves had to add these mmiowb() in.

The right way to go of course would have been to implement wmb()
the way existing drivers expected, and add a faster io_wmb() that
only ordered mmio stores from the CPU added to the few drivers that
the platform cared about.

I think it was argued the wmb() was still technically correct because
the reordering did not happen at the CPU, but somewhere else in the=20
interconnect or PCI controller. But that was just a crazy burden to
put on driver writers, and it was why the documentation was always
incomprehensible.

Not sure why Linus ever went along with it, but awesome you're removing
it. Thank you!

Thanks,
Nick
=
