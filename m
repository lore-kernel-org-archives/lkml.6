Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D7420837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="o99UDCuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D7420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeH3Vhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:37:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41862 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeH3Vhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:37:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so4149248plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o6QdlW5hbMszqdwMzI9jFkDmdlFLAzwzs4WCxhif6Qg=;
        b=o99UDCufXoVn48jbi6Z5ptGCA+kZMb6gAyJOFKyvcFTx51bP7EBXSepF48OyJWzlwE
         5GzKHuqUGvMNjW5ZJ4iM882+5ycQKgtloNP7sj+O1904I7GRBi8v2DFhg5erxL0xxUeY
         Ozj87Eyh4Nlj3xhFrfQy4a/E3vM/Uear2DnX8Ytk3bw9DCE4zEZD4MA7vUvsgeo8SBps
         CE3oVG6fMBUNhq+7VR6uBqlUtY9jWf4cFsDf0oovDj8RFaqBZWMh9Yc6TwPY3DyctTPR
         4JBEl6FZXb32HLdWhUdOw86XMufQZdO+2hzcs4d7kSLVnjCRDIV3TTWsPCcbdsCLXlo/
         sw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o6QdlW5hbMszqdwMzI9jFkDmdlFLAzwzs4WCxhif6Qg=;
        b=Ata5r99XwJyoZ5XFy6Yh2AbnBQgp1mmlRplYE8C8Lkj54A1lyN6H6y5uMCQSRfqWJM
         OCy1ZWgA5Uhzd2qg4f1hHIHjdKzfS4o3/L8WAijZS/l0ZcjcmkXYJOCoIIHF/abUuxlU
         1NNjKgr/5twB3n+gSAnxuH1nLwLfXI+uDGNRu24bHXBuGtmLns4vyrzV52iW4JcEnlpH
         y/srhnbtnOtz7bR2ioL9Tw0pNLG1fZ5Rglg5xyfadF5KEJ6gRHxpmqwd8L/aAZHl0dkQ
         L1UdXvLxq4VNRBBs8dO+tTU8PinaKK7ZlaqG33wIyC0o6LJb1XMOlF6mvtwcAuZCWhoD
         wujw==
X-Gm-Message-State: APzg51BuhOiRjpKRO5QOv7vI+T8QjORI58RTBkV8R01IQI7A0pAve/3h
        A5gNqRholttRCMoyxpvMVY1fXg==
X-Google-Smtp-Source: ANB0VdZf4F93D4oM0oyyea2UsL+45/ek5huX2rtJQEtVSOvLgIxjnyylaSZLVVutzOgdFW+5JT4oiA==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12-v6mr11403268plb.330.1535650480030;
        Thu, 30 Aug 2018 10:34:40 -0700 (PDT)
Received: from ?IPv6:2600:1010:b05a:7d28:c160:33fb:c0e2:e5ad? ([2600:1010:b05a:7d28:c160:33fb:c0e2:e5ad])
        by smtp.gmail.com with ESMTPSA id b21-v6sm21261248pfm.97.2018.08.30.10.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 10:34:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and pmdp_set_wrprotect for _PAGE_DIRTY_SW
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com>
Date:   Thu, 30 Aug 2018 10:34:37 -0700
Cc:     Jann Horn <jannh@google.com>, yu-cheng.yu@intel.com,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2222C69-337B-44F2-9DA6-69E685AA469B@amacapital.net>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com> <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com> <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com> <CAG48ez2gHOD9hH4+0wek5vUOv9upj79XWoug2SXjdwfXWoQqxw@mail.gmail.com> <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2018, at 10:19 AM, Dave Hansen <dave.hansen@linux.intel.com> wr=
ote:
>=20
>> On 08/30/2018 09:23 AM, Jann Horn wrote:
>> Three threads (A, B, C) run with the same CR3.
>>=20
>> 1. a dirty+writable PTE is placed directly in front of B's shadow stack.
>>   (this can happen, right? or is there a guard page?)
>> 2. C's TLB caches the dirty+writable PTE.
>> 3. A performs some syscall that triggers ptep_set_wrprotect().
>> 4. A's syscall calls clear_bit().
>> 5. B's TLB caches the transient shadow stack.
>> [now C has write access to B's transiently-extended shadow stack]
>> 6. B recurses into the transiently-extended shadow stack
>> 7. C overwrites the transiently-extended shadow stack area.
>> 8. B returns through the transiently-extended shadow stack, giving
>>    the attacker instruction pointer control in B.
>> 9. A's syscall broadcasts a TLB flush.
>=20
> Heh, that's a good point.  The shadow stack permissions are *not*
> strictly reduced because a page getting marked as shadow-stack has
> *increased* permissions when being used as a shadow stack.  Fun.
>=20
> For general hardening, it seems like we want to ensure that there's a
> guard page at the bottom of the shadow stack.  Yu-cheng, do we have a
> guard page?
>=20
> But, to keep B's TLB from picking up the entry, I think we can just make
> it !Present for a moment.  No TLB can cache it, and I believe the same
> "don't set Dirty on a !Writable entry" logic also holds for !Present
> (modulo a weird erratum or two).

Can we get documentation?  Pretty please?

