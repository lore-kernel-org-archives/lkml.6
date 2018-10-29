Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E058C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E84C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axiUYSjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E84C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeJ2RnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:43:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35823 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbeJ2RnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:43:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id q12-v6so4353774wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBxGQcGPRP0ykXDQYo3v2UheTzL3gJScMOFXPFIUvdw=;
        b=axiUYSjK05QQVbT6PcDWXOb1F7zqokHDuUsxdQm4Ko7dqCdmurH07LlYDWPxojSrXv
         9M3Yb11Sk8r5QjragnJ0V5H8MuC170+AZ7YCo6NKimb2jpeFWhFcjjCa1aTdZfo0yoD6
         lZby+pGTQ33bVUI/KT9vONZ1XMUDBXqjENb3ejMBe1noHtC3mREn2/bszgq9G84n7Bpf
         YgVpRZMrSJe30jSHXo23iDfflLYwJh5fHPoWLmw1joCtd/Fd/TxgFKRqBt+Tb+8m/vCq
         zakNEx/ZUuIAn9sIpEywBoBeXY5A+MwYrgP2VB/WY+JSndNdnD5fsPHuBgSRHhW8qv9P
         zZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBxGQcGPRP0ykXDQYo3v2UheTzL3gJScMOFXPFIUvdw=;
        b=QKbj8uYI0k+iQ9wwE5AmPVTfZwZnuLxOe71NGiUswI+HwJBot8Hwe8CLOt2XtFwiFR
         Z9q7ZXz6c+bI14xnqgzd+zrJQ/E8TJBI0uVnHz3KT7lzoWL8D6jWzHIkCu7w164Wx675
         gYG9g5kX0rAJDt7Z3vctkccqVJg7nZc8AXycnkDqb4q8baplsd1jTgS4OZB64C4cB5oL
         qj+v7MZPWlQWaZP6AxVwCjCWhYUsa9oCVqKbNToTIWc7jQ0YjgMtykxu7FMRLFouCrOz
         UjIL+sO+McpnCEad+KS+X8GptUIX3naxuKTDULPiblOzK1PjJXY1xyUjPPGUoMYubFqa
         S9hw==
X-Gm-Message-State: AGRZ1gIHHodbuHZm8Vwj9+giwXQWJTsEjkLBf9Hs/QXUi0uTI+vveUTB
        vssOMGxs0wGDZIQZkPrkZyWCz26PIfQyp0heoKM=
X-Google-Smtp-Source: AJdET5evFZ+0gPV4oLVUppIARA9wPD2IbrieSyvPFvxe9OFjcM1q0nQA5k0HbtdKK0/6RJQ82LuzyOmeBs/gBBMuAp8=
X-Received: by 2002:a1c:38c1:: with SMTP id f184-v6mr10373684wma.24.1540803334146;
 Mon, 29 Oct 2018 01:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181026195146.9C7C1136@viggo.jf.intel.com> <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com>
 <CA+DvKQLpizz2LJppOts1fB6ujQNqj0fii8mo-UfosoYpQWRb5g@mail.gmail.com>
 <FA6429E0-C480-47AA-AAF0-95E615D8265B@amacapital.net> <CA+DvKQJYmWm6uP6k4HYdkuTdMX7=rSu34W2j-Vk8YcnWZVA-3w@mail.gmail.com>
 <20181029063626.GD128403@gmail.com>
In-Reply-To: <20181029063626.GD128403@gmail.com>
From:   Daniel Micay <danielmicay@gmail.com>
Date:   Mon, 29 Oct 2018 04:55:07 -0400
Message-ID: <CA+DvKQKUCVN5OUxShwxhXUnx5Qx0EUZSCeKOAUYR2CWW+NkO_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>, jroedel@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, a no-op pkey_alloc flag tied to this patch to provide a way to
detect if pkey state is preserved on fork, since kernels without the
patch would report EINVAL. Something like
PKEY_ASSERT_FORK_INHERIT_STATE would make sense. Otherwise, it's
going to be quite painful to adopt this in userspace software without kernel
version checks. Most software can't accept causing a crash / abort
after forking in environments not applying all the stable kernel
patches, or in fresh OS installs that aren't fully updated + rebooted yet.
