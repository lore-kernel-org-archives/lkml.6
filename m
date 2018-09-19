Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE76CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB5320858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJL4E6V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB5320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbeITAgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:36:20 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:50253 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeITAgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:36:19 -0400
Received: by mail-it0-f54.google.com with SMTP id j81-v6so9814760ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NGUGCTwr/PNEC9+Nt6leY0kWT1OlxqT/it/bimgN2ds=;
        b=XJL4E6V6ryycU+Jd/TA3pHRkyxhKTqugF5o19OOt6lGsNnZi6TmdKVwL033r5mMcNP
         O4CaCUyTaoy3Ns7Mi+8Qjxpq8XwvbItO0S7BdOMioCDhOG8MzpDhHNlHlDQPl4aSNF8U
         CxI5SxElmle940pmEhs5z1VpA+UzrRvdu1pi7okCVsaUezs/pN4Pm+Dec7OSNsoXbdSV
         TH5YzGViAv/wVahuFZzF6o3JZ1NsXVO9SrsqngBVHti9wsmaZ4QOmeP1L7lrqpcd+aEV
         gIAQhxKfxKj3TpYQqcE1anj9eoRhA2g3zmWj9hjuRm3FNE4qDHerpbxl7JBllElR/S5y
         0lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NGUGCTwr/PNEC9+Nt6leY0kWT1OlxqT/it/bimgN2ds=;
        b=Eu0aqGWSvWrg7i5PduB8pvckXgKBOLQNyB9areayoDtoxoIsTIwrHkS1CV9Dt/EsbN
         RYXWDx6kst1vGhtPK+TnyVa2QgH3xUVj4iHwB6MwK4lN0TMWTeU9xQbx3HTtbmD8bnZ/
         bAKWKBUB5TGcP+X2iG4Qb9QEculPriZwle0gUIi1WErnnFGTBPNGxQsvBfSqC8sGfKdl
         aUzQ36xy2pDt5dJeGOulka+Fs9po8vl0lzSh5vd37Mr++jkQIyistgN3gDUu/4LrvbZD
         QuRhe7y4ZQ1sO3d2AsokUkHNUwyg6PP6U18vZ7lWA6351R+Ot9GUK4rNktZZl/wq9BAO
         uA0w==
X-Gm-Message-State: APzg51CWT2bNGs9oHioPmvNaB7+6ZjNox7AJBeqFrc9Qgy5vX1ceVpO7
        pQYZUXhQ5kHoDzQgGILTfvMtVi8tg/+VJe9Pm+hw5g==
X-Google-Smtp-Source: ANB0VdbDJD+tvPc/h5OVpUgKj7hIWdWtUH4yMYmSuUqNcYWVDivEYDr3FI5crm0skpK5IdMD7IzaxN8qNj9AzMZ4RUo=
X-Received: by 2002:a02:ad14:: with SMTP id s20-v6mr33804961jan.132.1537383423773;
 Wed, 19 Sep 2018 11:57:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 11:57:03
 -0700 (PDT)
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 19 Sep 2018 20:57:03 +0200
Message-ID: <CAAeHK+xB-4vzQSt-Wznjof7yq-at2PsQNMA9qR0U=H0Uhdan+A@mail.gmail.com>
Subject: Re: [PATCH v8 00/20] kasan: add software tag-based mode for arm64
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accidentally marked the series as v8 instead of v7, I hope that is not an issue.
