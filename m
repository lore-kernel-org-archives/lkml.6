Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7282083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMk8FXWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7282083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeHaM6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:58:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32958 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeHaM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:58:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id z78-v6so929333qka.0;
        Fri, 31 Aug 2018 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnsiI0XNaW2EtnByt3SyBZucJueEHdYzMoXwR4C9a2Q=;
        b=bMk8FXWA820kw39+Ojx7gD1Ld2YqB3jcwf2EGW+JKa6tXz8kwWDKnmkJl7qboeG9gt
         PicbovgHWesyLH6uFomnXDa9yUqMgeciocesQ6vwlCPevJoZdNVr/TO8EoWdDsnuvg8c
         YNFssucAHUU0rkoLFliX4W2N1TLIkT1eTKJXS7wEuoHDuj5/kdNfsqUB1WFPYgfJoAua
         NTk/D+nC9LnPYfIcE4APSek0Ah1uHUIK8WUynbcjZkeiCBKRh/JfPO7qhkiGLL9oQiX9
         dPYn9oBdN/yz1Y3H5fzAfDEKoGQVWYbw0JM3zt6VpmhqrJ63VTFxV/NHHIssbx4DY4MZ
         5uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnsiI0XNaW2EtnByt3SyBZucJueEHdYzMoXwR4C9a2Q=;
        b=paX/jYO4PGDGYTNN5tpme1EhGZY4FSdGaD8wrXvxgwjf7yQ7YuEOoc3Kw6ntuVdmx1
         VzP3UvmXUTcdy1HacsEcyMLQTzhyiMgVrorfrneajMzDmRNATdEROx6w8KeUi6M9b8dV
         9mu8QL56dw/S1rx4RyNB9Q7kn/ZyBIphz17A+foKWxH6kC5qsD3ThiGS8JUvLeDIiMj1
         LDjjQAvsMuPw8J2+1hVe01x2pRi1spzoH52B3wHVpHyW/pKRloOgV/qWEwHZgbIGR3+o
         wnS6mj7FLMJGQqLA+jWbEGEP59yyJ5pdoYbDhgMU8ke74HLRa2gvkNYPXsk9VmLr0BmK
         KLng==
X-Gm-Message-State: APzg51ADb6vD1Z6yUjrvPKybNfpctEpmqWRM3eck/Rn6ZQZcrl/VfJ3m
        f+O9lT/N57cvqZoS1qwPduRXfTyPdSvetPyghzw=
X-Google-Smtp-Source: ANB0Vda1jEHfpmL0WND1ZgwxAeiQDOs+BpjcnlmrKb4J/m0aY2llhY/dJJraj3Pwov3y7hS9dfVBJWalmAtYb3bYDm8=
X-Received: by 2002:ae9:d885:: with SMTP id u127-v6mr14336139qkf.219.1535705532786;
 Fri, 31 Aug 2018 01:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180831083432.15872-1-andriy.shevchenko@linux.intel.com> <20180831083432.15872-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180831083432.15872-2-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Aug 2018 11:52:01 +0300
Message-ID: <CAHp75VcwdDA8OW5f2qsgCBXUJePuE-wULLfS-076eXfUBTb0zg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] platform/x86: intel_pmc_core: Get rid of custom
 ICPU() macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:50 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace custom grown macro with generic INTEL_CPU_FAM6() one.
>
> No functional change intended.

Actually there is one, that's why please drop this patch.

-- 
With Best Regards,
Andy Shevchenko
