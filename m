Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57023C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE8120861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiHLlcMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE8120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeIGAt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:49:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36028 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeIGAt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:49:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so3628880wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ey41mNH9LAFsx9JkWO9N14Jix9PaIGdJKoz2RuJXAwI=;
        b=GiHLlcMhQzemXpla58Awqm0sm2nuAbWpNhMKy6SHTDjSRMXEUAY0j03vuSl+sg722l
         FevKD0ftRmAedhs/9JFgSywGJOK0QnGkNCwU26qdceab+dkzD2PBF8re23StdqcNzbkw
         TCU7+rIzgM7xMiItLmiWpe5aekFjUez/hvXXPKytCqX/FziW6c6ACBtyeSiudZl2pyM1
         AAO59BatU4yF0vDlLkyGfawvqU+b+F0aLEFf64tuRYi406Df0Pi58EwgET/s3Ve4RKYL
         GXbK9n4oXeGtCgyzZ59YUbTqdjtLf4NSq7Hss5/RdJvViUTEC2gf/vTKquaQQdfGq+zc
         ymLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ey41mNH9LAFsx9JkWO9N14Jix9PaIGdJKoz2RuJXAwI=;
        b=GWP+Iq23crEn8t6dBPXQk38kfLGvbBbNtS2iLkg7ioWwxoQZEMxWMQ2YokX9usxNnD
         5iAzbVONOmQ6e1uzuR/6KhcsaMYTmMOeVOmGCph2N98CEuOWxXpS0qLYXfVMLMxMVNVQ
         e7UDm2uSnN3qE+ejYjVYdnTZhJp+vmj7DbSD1S6sYcobwte8Aun3SrmJmyON9iAc4yPD
         uO5ssMIHar6PL/j277yDP4R56px/5jPxAARdo0LWmUAzjz+pLmW+NWtwzJgT76DDKKbC
         +EDxPxVSxz7Hg57MSRUusDxG+IcFFnMCW8zkGNgIsMkgU1XEb0DVwJSgg+XCVjGZ09XP
         UoLw==
X-Gm-Message-State: APzg51Bwbhce4RUXRyjEFUeXsDbutkvYaCuDRnyzV+dWQd5RXt4KXgoI
        gSOokkBR4gtsEporcn+gpg8=
X-Google-Smtp-Source: ANB0VdYkz8iBR9uPyk3WfgfsJQFkbKw2uwk+COwN/sh84Mmx99T6jxlIeqNQGX/D5hEuacRpEJmVnA==
X-Received: by 2002:adf:8385:: with SMTP id 5-v6mr3590590wre.13.1536264740716;
        Thu, 06 Sep 2018 13:12:20 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 144-v6sm9215345wma.45.2018.09.06.13.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:12:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] x86: use WRITE_ONCE() when setting PTEs
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180906195731.GE4816@worktop.programming.kicks-ass.net>
Date:   Thu, 6 Sep 2018 13:12:14 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10030BE1-FE29-4C60-9963-4BE932EF09BA@gmail.com>
References: <20180902181451.80520-1-namit@vmware.com>
 <20180906195731.GE4816@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:57 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 02, 2018 at 11:14:50AM -0700, Nadav Amit wrote:
>> When page-table entries are set, the compiler might optimize their
>> assignment by using multiple instructions to set the PTE. This might
>> turn into a security hazard if the user somehow manages to use the
>> interim PTE. L1TF does not make our lives easier, making even an =
interim
>> non-present PTE a security hazard.
>>=20
>> Using WRITE_ONCE() to set PTEs and friends should prevent this =
potential
>> security hazard.
>>=20
>> I skimmed the differences in the binary with and without this patch. =
The
>> differences are (obviously) greater when CONFIG_PARAVIRT=3Dn as more
>> code optimizations are possible. For better and worse, the impact on =
the
>> binary with this patch is pretty small. Skimming the code did not =
cause
>> anything to jump out as a security hazard, but it seems that at least
>> move_soft_dirty_pte() caused set_pte_at() to use multiple writes.
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>=20
> Also, its corollary would also make sense/be required, use READ_ONCE()
> when reading these.

I don=E2=80=99t know. This would obviously be much more intrusive. I can =
add a
get_pte() and write a Coccinelle script to use it instead of reading the
PTE, but in most cases, I presume, it would be an overkill.

The reason for that is that the PTEs are supposed to be accessed while
holding the page-table lock, and the hardware can only change dirty & =
access
bits. I think that any code that assumes that these bits do not change =
while
holding the lock is already broken in more ways.

