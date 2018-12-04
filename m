Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F592081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypaps6pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F592081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeLDS7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDS7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:59:38 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3AA20850
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543949977;
        bh=KQ4UA8nbuN6DnQl2/Ec3Mt925vyosNzRvFYzre32GEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ypaps6pq1O2b+QJzW41IUFR8PiyDVsf9mYdnAHuymMQLCbfXK26VymzmHjYgEy9Lo
         PagfGjli9HNE1wDKObgD/MdfLut2CpPYfljoAO5QBgMDRB+LreDTUVCHqbvzUYeOdg
         CWEb1WgM0wKPzL0Il4QHdMKXopOV0VHaTAH4pUCg=
Received: by mail-wr1-f54.google.com with SMTP id j10so17102982wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:59:37 -0800 (PST)
X-Gm-Message-State: AA+aEWZLa8knLHYdVZHBwKjDn5GQz5XnuVUTwxxrbMp9RrH7NF7s7Sa9
        HhEGjr6jlFNm/a6Quf4rjMzqCTs36Lz6EkCy876WPA==
X-Google-Smtp-Source: AFSGD/W/DuSRAWyC5WNlogZaJpDhISr/LntWDBSQRwa94Y4WPojYtqMJpiDIJFbbz8pmZvuqo0TsFX0IK/fFdAqdJfQ=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr18689303wrm.309.1543949975684;
 Tue, 04 Dec 2018 10:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20181204161741.12292-1-sean.j.christopherson@intel.com> <20181204161741.12292-3-sean.j.christopherson@intel.com>
In-Reply-To: <20181204161741.12292-3-sean.j.christopherson@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 10:59:24 -0800
X-Gmail-Original-Message-ID: <CALCETrXMEdbcq_fXe6CEeU+Mi_G54KexCMasmhz7GKk4iDjerw@mail.gmail.com>
Message-ID: <CALCETrXMEdbcq_fXe6CEeU+Mi_G54KexCMasmhz7GKk4iDjerw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/vdso: Remove a stale/misleading comment from the
 linker script
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 8:17 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Once upon a time, vdso2c aggressively stripped data from the vDSO
> image when generating the final userspace image.  This included
> stripping the .altinstructions and .altinstr_replacement sections.
> Eventually, the stripping process reverted to "objdump -S" and no
> longer removed the aforementioned sections, but the comment remained.
>
> Keeping the .alt* sections at the end of the PT_LOAD segment is no
> longer necessary, but there's no harm in doing so and it's a helpful
> reminder that they don't need to be included in the final vDSO image,
> i.e. someone may want to take another stab at zapping/stripping the
> unneeded sections.

Acked-by: Andy Lutomirski <luto@kernel.org>
