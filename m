Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B039BC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6620A20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVKRNa1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6620A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeFTTl7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:41:59 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46404 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbeFTTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:41:48 -0400
Received: by mail-io0-f194.google.com with SMTP id d22-v6so796753iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zFkkPYA2JYdxQPsfsZNZmw2WT34MpHd7e3Y+OlnJD+I=;
        b=XVKRNa1aWKuAKlVuqCsgcsiqs0EOs3vtm8A7qpsUaSNSlnU5as5A69xg3vF/qhlBhZ
         XZOUic0dYPRJs/Zvod0191xnXi9iBRpt6cW1WNsIhHVtS7xLa3HiHSashG/RRJ9+CZ7+
         qLdUIoPwY/U1L7ZwfDSkvvpeQGVsKjwfJIymte370lOBoipZEquS/+ixghcuWWsFdqXz
         AWf5sqrmaAkpWxD7vWJjyYfTjIj04i64AElDWejIQasz7QOKn/VzPGmxng9PhlvLUqsC
         9EZzsGRzHSVi7bjsZb3R5kyMdpa+97RF8UkLPWFZsKa9KHxqa8Xi+OY8KUrgdCDYHTmm
         +t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zFkkPYA2JYdxQPsfsZNZmw2WT34MpHd7e3Y+OlnJD+I=;
        b=XVy4napC9AcEsoSlDJe9tYas7+5HOcGiDY9IEaiFcZ6cYoCgRDWqUjIMboqftwQqq9
         Gzh3hj/JzsIjua2dAz+lPEa6Uy7aabdR9DBhsaDJgHZ9fmmX3CRK5DV+s4RGWKmO8LD6
         2OlPvV94cgMOo2ZI7+tFUl7snXBtO2qLnjr1FSvq56nlqUgPxsqhEHiYRl3cMWTmGYcQ
         J0Ma2wvlhSsJ2ZGSzJQvbK0y4yWWgM3un2VlWMgJkWInvOw+eolauSCO1VBLNUi971wj
         piFMwwtwwoXfa3+P2ZHlV3HZxzwGC0zogKzTlwbYYYjCrjdZYTJ4hlrQh4xRmlIPj/NP
         Qsmg==
X-Gm-Message-State: APt69E0rt5OAZgR1gPA0P8vJmILRtUzWBLB3qUIWXaNEQe1xzXDBJvjq
        pS3pAJP447MaLO4JO++G8zwZv5ytAEXyGwZDtYy5KQ==
X-Google-Smtp-Source: ADUXVKJB++igNKKy4kMzyYt/RPBMBzF9BKhOMkmz1fT9H2LFrUm0uS4YVbTAqkN50QRQ9Kti7Ob/zr54prsiL3UMvoQ=
X-Received: by 2002:a6b:84e1:: with SMTP id o94-v6mr17990721ioi.119.1529523707600;
 Wed, 20 Jun 2018 12:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:9082:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:41:46
 -0700 (PDT)
In-Reply-To: <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com>
References: <cover.1529515183.git.andreyknvl@google.com> <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
 <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 20 Jun 2018 21:41:46 +0200
Message-ID: <CAAeHK+zJgSAxiHHfzhrm7N7iey7CbW42WfWvUN+FnZMPP3FXrA@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] kasan: add SPDX-License-Identifier mark to
 source files
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
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

On Wed, Jun 20, 2018 at 9:15 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 2:40 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index 6f4f2ebf5f57..3feacd889e24 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +// SPDX-License-Identifier: GPL-2.0
>
> The original notation is correct: /* */ style is used for header files.

I used mm/slub.c as a reference, which uses //. Bu I can change it to
/* */ in the next version, no problem.
