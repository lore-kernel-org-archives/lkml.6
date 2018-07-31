Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB600C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9090A208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noBTi9HZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9090A208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeGaRC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:02:26 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43061 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732358AbeGaRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:02:26 -0400
Received: by mail-io0-f195.google.com with SMTP id y10-v6so13332409ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xWE2aF0pajdZAOP+uUcDJNx6SJt58NICxf0URo6mRNg=;
        b=noBTi9HZ7q5dUt0wE4QBXNbrQbnss3heBqyxzdpzF+TPVi2rwXsilLdvg20pfrCav3
         as8rNbf241vy4nhYz3sKea22yqKLdgt7pu9yymGgzsfE9W/wNLWugGsAZ5OqtDzTLgvo
         zO8qphr3l98wjq8DGe0yV6URA6escglDwkPp5QlYvGseOszIWmYKumgyi9CwZQTLdDbK
         SURuaGZPOoJJmpDaRmuu1g4cBL3h4eETEVG62NMzZdY7TW3mOuWU3sbkhW02jzCkSLW4
         2pJ2i3ZEiUD5B5c2MlDLSWVhPn7ujiYzHoOx+pd1N3KNLQWlydLmb5uQCpRS+MXbU779
         C+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xWE2aF0pajdZAOP+uUcDJNx6SJt58NICxf0URo6mRNg=;
        b=hEJoR0pi5swIhtcPhCipjYvukDOzO2upohEDYOmdBsNZAA9HCl6hzS/PDctQUxu1/q
         VzrLHHfA4G6ezHL2l/mPUCfrWCBrMPGnCdOE6J0t4axX8meBNrc+dIInM0hzHeONZBQn
         VC4bTuRA5KtiqMP6F5zy1AMlj4U0mXDWGQTHcLprFZW9nzRcDFC3R82D2qWdF3X7WMGD
         ufGe5+c9XOaek2fkY1+cntJb0pMXjdlK1Mbqe+7EBY15D6092KrS3ilunwN0Q4N8QI9V
         +BpmE0wt3nec7joTCmY/Dp4//a4TNaiWz1FdpuC1cv/kPa9p731/ExWZbBR6W7kVSkFs
         +WMg==
X-Gm-Message-State: AOUpUlGj++wCAPZeCSW054MQybGao6vlnRHff9F9jZdvA22dhHSF7YWk
        N39rKPr0Qw8HgSrP3uk8CkbVDvhGU3QLxvNiMcaKzQ==
X-Google-Smtp-Source: AAOMgpcpZrFsOVvbBmMU629/+ZWRiXxRhNc5nasNiD1kICxgjwP2EwDTeKPb8szTpcTCj+BtgR6TDley9hDPrpD0KZA=
X-Received: by 2002:a6b:84c6:: with SMTP id o67-v6mr135135ioi.119.1533050496587;
 Tue, 31 Jul 2018 08:21:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:918c:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 08:21:35
 -0700 (PDT)
In-Reply-To: <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com>
References: <cover.1530018818.git.andreyknvl@google.com> <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
 <09cb5553-d84a-0e62-5174-315c14b88833@arm.com> <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
 <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 31 Jul 2018 17:21:35 +0200
Message-ID: <CAAeHK+wUu4c5MwknrJkw=22y5cWuZNsyd+-QJ3v0Z48Xj-Hqng@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     vincenzo.frascino@arm.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 4:50 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> On 07/31/2018 04:05 PM, Andrey Konovalov wrote:
>> We can assign tags to objects with constructors when a slab is
>> allocated and call constructors once as usual. The downside is that
>> such object would always have the same tag when it is reallocated, so
>> we won't catch use-after-frees.
>
> Actually you should do this for SLAB_TYPESAFE_BY_RCU slabs. Usually they are with ->ctors but there
> are few without constructors.
> We can't reinitialize or even retag them. The latter will definitely cause false-positive use-after-free reports.
>
> As for non-SLAB_TYPESAFE_BY_RCU caches with constructors, it's probably ok to reinitialize and retag such objects.
> I don't see how could any code rely on the current ->ctor() behavior in non-SLAB_TYPESAFE_BY_RCU case,
> unless it does something extremely stupid or weird.
> But let's not do it now. If you care, you cand do it later, with a separate patch, so we could just revert
> it if anything goes wrong.

OK, will do it then when there's either a constructor or the slab is
SLAB_TYPESAFE_BY_RCU.
