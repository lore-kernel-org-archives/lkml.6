Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6679EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297E62084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3Q2NMC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297E62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeJ3JU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:20:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38769 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJ3JU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:20:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id f24so3725142otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IJFDquwh4P6+AVm2OH5/2e/UIHeSIJZiW/M3XbaDV3s=;
        b=q3Q2NMC6GefBHio46GP4O6F+p1Hh/pKh+WAhOIt2Brh49dVDtkgT/4rJqhYhdzm0x/
         mtAL6UF6gfDGnf5isE3vh0UXHuDSA4AKFhuWLmqkhoFd5J3Hqr4kPbwx8MYTaROEpsWL
         E24MXrAURiJHbYjkbUsTtYVczDvBrzJHTAWI2bePjUa1NZqfFc/ssKnmTIMsxKV4XqEw
         9ksCCn6ufR4ZKpndEhPJdxRO25Tut1VlfWpdGibGgL+XQ/Em6rtBw4lyfWCh3hQvHYYU
         97bMWpsP+Dc2VNVp7ilRTgwDQzGKyua8flymgzG4K0Ufslqiaa49nKVoHVLX69wE0QpZ
         SaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IJFDquwh4P6+AVm2OH5/2e/UIHeSIJZiW/M3XbaDV3s=;
        b=HX6TUjIe3O2t1xOpuk+s4nQ8ry/unrnr5WAc9mtJaDnfOgYntwUX7pyLWp+KUolUdz
         xf4sWB+zclr2KZwMyxj5iKD5B5GiZBM0VTKgnkQ6DV8PCHpzmbcHgGpGQ0VILZexLhzf
         EzFA3u1FMpyPaczRMfU+v0VmZr7M6ahRNhqU+5U+3E+k0mmy9aDCF0aNdfLsYr/GmH41
         kdkELj/EIlrU6YJSZP58UbhoWp81nSU1+M4vwf7PGKOufCodopt/hG22YNzKCKvZ4uZK
         En9ObiYw+N/1QNAJjPSYN3NFCUWuEmSlU46tvAI2/hGQAktcNRoIe2kGrBWQFt5p4hm+
         DKqQ==
X-Gm-Message-State: AGRZ1gKDirsxorp4VTdDz/rNprGG5/OTrKaBkTBKQOd9pPSRiN4qQLq9
        YpTlmJcB7VAJm75/DMpVMu3VuzgmSIScMyxLV0Jfhw==
X-Google-Smtp-Source: AJdET5d/3zMfHcMMrTR01WhHFra/0AiZPEqrdcW30xOJ3K4hl2YDDxv93d/PdPfmg+1toFFD22uvwG/KAn6MWV4PYro=
X-Received: by 2002:a9d:2e53:: with SMTP id c19mr4948060otd.67.1540859386434;
 Mon, 29 Oct 2018 17:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F6B4F6@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F6B4F6@EXMBX-SZMAIL022.tencent.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 29 Oct 2018 17:29:34 -0700
Message-ID: <CAHRSSExHFhwQ_J3X+adyCUkwg6usBRQN6Wz_YshjTOfx4C33eg@mail.gmail.com>
Subject: Re: [PATCH] binder: ipc namespace support for android binder
To:     chouryzhou@tencent.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        dave@stgolabs.net, LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+christian@brauner.io

On Sun, Oct 28, 2018 at 7:29 PM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzhou@=
tencent.com> wrote:
...
>
> > It's not obvious from this patch where this dependency comes
> > from...why is SYSVIPC required? I'd like to not have to require IPC_NS
> > either for devices.
>
> Yes, the patch is not highly dependent on SYSVIPC, but it will be conveni=
ent
> if require it. I will update it to drop dependency of it in V2 patch. Thi=
s patch
> doesn't need IPC_NS set at present.

Actually it is dependent on IPC_NS since it makes changes to
ipc/namespace.c which is
compiled only if CONFIG_IPC_NS.

There are a couple more implementations similar to this one.
https://lwn.net/Articles/577957/ and some submissions to AOSP derived
from that one
that introduce a generic registration function for namespace support [1], a=
nd
changes to binder to implement namespaces [2].

If this is really needed, then we should have a solution that works
for devices without
requiring IPC_NS or SYSVIPC. Also, we should not add binder-specific code t=
o
ipc/namespace.c or include/linux/ipc_namespace.h.

-Todd

[1] https://android-review.googlesource.com/c/kernel/common/+/471961
[2] https://android-review.googlesource.com/c/kernel/common/+/471825
