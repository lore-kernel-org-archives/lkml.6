Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA22C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F134920693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lff/JcFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F134920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeFSD7V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:59:21 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54612 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937251AbeFSD7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:59:19 -0400
Received: by mail-wm0-f47.google.com with SMTP id o13-v6so17366045wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsLPc0NEdj9ycXq7pqz+S6+rblFo7q4JQO6pC6mHmFc=;
        b=Lff/JcFMg6RCC5p3WpBQcVPGPC4RwhqE5PRcxoC44o3TFWOvQR+dujisrGShi7+Q47
         YfWa+tzaNx9G6VGIUiZnnfCajvX1D9T9oqJsqtvIhI5dd+Kg/KGSIvIma7Xd+sVNw1hr
         g1Fd/UkWfNeXBGTgNn/FbtGRYZ1uV+rHQanWrpCm6PEYlHM495XWqlwyOHStScexMIV6
         MUVjaEmM200blWa4c2ZhCPmOhzUN4fva9lad4WoWS9x9/18IC12uRwg1LJ61gkbqb1BI
         9d1syIEu469+R8GfXy4Nw4l1/6c3GOMVBonZWxZAEoGO6cW27lUuHZKq2HohhoV0iDM1
         kT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsLPc0NEdj9ycXq7pqz+S6+rblFo7q4JQO6pC6mHmFc=;
        b=PSOIpqgtWXPgdAlwX137XQknn9c0UcZlKGsW0pJoC0w0XyPOtmdiyk8wz1pmHHDUEP
         5kXxODKM7+H5yBh/H/btotlgY5NmGNulC3O+yivPlLsob+rZZeRzdqXKXNqLd/AMX4wc
         ED7nhP9E/EGLQkBowlf/4d3zt6vCDCmb3sXmXij86P/0y7x2kj2xDEZZ9HArodHHWhlp
         9R6/KUfTF3ZfmUdYuXZ0OMPqXcpLt8MVmTciyI0ajzMTfzImAT7vvKC7MjOkLaiwAnYz
         wVUpgVoOJEvPYoof0kCEVNwiwhjA/AtgmGZrbLPgfKKVpAh0CiwbQtj+01rUfSdh6BJ+
         QYow==
X-Gm-Message-State: APt69E0ZkjT/NRguY/2rSXQSR4/bCALDqHFr+jaGNeCR8ONa6b2mqE1J
        Y1q/FWARk5wZrc1dEmafLhfdm2IvYStpJXyNiJnQiQ==
X-Google-Smtp-Source: ADUXVKIoIzX6nb4wqAki4pugw5vBXBFyJO3R8fCy227RL0T4n0++3I/SmPFdqFePle62KaH6hSkp7NjWJqPW863prQI=
X-Received: by 2002:a1c:20c7:: with SMTP id g190-v6mr10981462wmg.2.1529380758125;
 Mon, 18 Jun 2018 20:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
In-Reply-To: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 Jun 2018 20:59:01 -0700
Message-ID: <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Jason@zx2c4.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 7:51 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hello Shakeel,
>
> It may be the case that f9e13c0a5a33d1eaec374d6d4dab53a4f72756a0 has
> introduced a regression. I've bisected a failing test to this commit,
> and after staring at the my code for a long time, I'm unable to find a
> bug that this commit might have unearthed. Rather, it looks like this
> commit introduces a performance optimization, rather than a
> correctness fix, so it seems that whatever test case is failing is
> likely an incorrect failure. Does that seem like an accurate
> possibility to you?
>
> Below is a stack trace when things go south. Let me know if you'd like
> to run my test suite, and I can send additional information.
>
> Regards,
> Jason
>

Hi Jason, yes please do send me the test suite with the kernel config.

Shakeel
