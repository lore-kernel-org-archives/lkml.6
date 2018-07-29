Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0648C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B79520873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="njxCHMKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B79520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeG2RAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 13:00:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44655 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeG2RAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 13:00:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so5842452pgp.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z9s052X3Y/4DSY7S3yWI6aVARuUoXuKMXkn7jAF6rQA=;
        b=njxCHMKvWKey9xXbKB/HSjz6mph8OdV+xiGTaBzzA3fw6MG4GUPtx2SQCWPaflt6JV
         59yxigQrIwIjsHJZNTVKU5zdx0ueA4jU+Px+UMhx1UaJTRTnqEBBdDO8sWEEMallanzB
         baHG0Zrwb0tx4Y65snKxHNJMzHM9d3coxcpDXCvyzbVwW/X9GXLJnCygH6nNYFVXV8p9
         fmtzSj9R39MHpumAVcU8QDMyjhIzwhMnWUk8iY2BSK6Zj4IxROqwfJwqZ8lRWPKoiwD8
         JrQ/ntr9p6S/AA6uRFmgbdR8B3EMr52o6DBkNc61HxeqKKk7SxGgjlkVu8K4BvzbZgbT
         KTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z9s052X3Y/4DSY7S3yWI6aVARuUoXuKMXkn7jAF6rQA=;
        b=c+QsAYhrYnEHsujdmU/mVgyRe99rLZLhY4GWa0Wk3SfYZ8sDo6IXrSAtRnJk4pd4in
         FR6HO7bYgNsVUnvqRDGiqMV2THj0lqs0tO3+TfN7WCChPhXycRI0WOSkUZN2brmutHfR
         WQ/6Qm2FyT4uOR4/tAcoqc/tUw8hxblhF5OWti5zXRTolhWbJjUyJ5tzoON35Jca/znv
         v5VCmzRfJIVulYgF+Mp0As9biXkcngHpKMJHmXweMQjhFBYg12LEFMajLtGeFOpWyOPZ
         3FoVMYbKmXem24qLqiDRaCx+h71v/+ZT06YHVF9B3q3VDAviIwextB/VGq7zywDqWVkc
         pYSQ==
X-Gm-Message-State: AOUpUlHqdgos33FE9U6Lvi0YNin0p58GeNsp9Ej7YDMhvm5WZmPe/fnF
        Cs27bAC4ubDlVR389bCjGqNyeA==
X-Google-Smtp-Source: AAOMgpcTyIgWwuEEhgQzglxvfsX8UilI0p2X94V7WS9BDC/sF16ecWQVGYGvxFiZi4Sa7dxaBHeTuA==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr13156675pgs.350.1532878170604;
        Sun, 29 Jul 2018 08:29:30 -0700 (PDT)
Received: from ?IPv6:2600:1010:b066:ba1f:d10d:1ec8:df2a:b975? ([2600:1010:b066:ba1f:d10d:1ec8:df2a:b975])
        by smtp.gmail.com with ESMTPSA id s20-v6sm11413696pga.37.2018.07.29.08.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 08:29:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/10] mm,sched: conditionally skip lazy TLB mm refcounting
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <1532866319.28585.12.camel@surriel.com>
Date:   Sun, 29 Jul 2018 08:29:27 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC4DF151-463C-4CED-8962-9056648BFEDC@amacapital.net>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-11-riel@surriel.com> <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com> <1532866319.28585.12.camel@surriel.com>
To:     Rik van Riel <riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 29, 2018, at 5:11 AM, Rik van Riel <riel@surriel.com> wrote:
>=20
>> On Sat, 2018-07-28 at 21:21 -0700, Andy Lutomirski wrote:
>> On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com>
>> wrote:
>>> Conditionally skip lazy TLB mm refcounting. When an architecture
>>> has
>>> CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
>>> lazy TLB mode anywhere will get shot down from exit_mmap, and there
>>> in no need to incur the cache line bouncing overhead of refcounting
>>> a lazy TLB mm.
>>=20
>> Unless I've misunderstood something, this patch results in idle tasks
>> whose active_mm has been freed still having active_mm pointing at
>> freed memory.=20
>=20
> Patch 9/10 is supposed to ensure that the lazy TLB CPUs get
> switched to init_mm before an mm is freed. No CPU should ever
> have its active_mm pointing at a freed mm.
>=20
> Your message made me re-read the code, and now I realize that
> leave_mm does not actually do that.
>=20
> Looking at the other callers of leave_mm, I might not be the
> only one surprised by that; xen_drop_mm_ref comes to mind.
>=20
> I guess I should some code to leave_mm to have it actually
> clear active_mm and call the conditional refcount drop helper
> function.
>=20
> Does that clear up the confusion?
>=20

Kind of. But what=E2=80=99s the point of keeping active_mm?  On architecture=
s that opt in to the new mode, there won=E2=80=99t be any code that cares ab=
out it=E2=80=99s value.  What=E2=80=99s the benefit of keeping it around?  I=
f you ifdef it out, then it can=E2=80=99t possibly point to freed memory, an=
d there=E2=80=99s nothing to worry about.=
