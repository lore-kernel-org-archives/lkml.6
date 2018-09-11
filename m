Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C45C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60A02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apVho8hZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60A02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIKVKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:10:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37542 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKVKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:10:08 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so2232469itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kdQUiC7bpd5vbBlJ7GRQBgQSqfrL2yXOQL3N0xGBv3c=;
        b=apVho8hZVL3Lo4Mnu4IW1bcNTHZKUGbmiPLVuzlpFQxuePNX+W/SDgI3PtOjrEOeBE
         HhVFqNE0LDzXV8V3lhd9/ZPim9SnyK7yWRhJ2I2OLXeN2H/m1qRlFuEXhj5HUEVffoyz
         EfGreZt2adFuX/R6fPbGG7KYCcUJ6Cqg/PrkJSIcLEgKRN0Zk6xiwbAfBRVuIWP5KWw5
         JMIKjONJLIc2/7yyvk22IqCdNRqPcaIxcfYsvuFnwok9NK7IKnNbxFVnxNkWqt4dboRM
         x2I6GH1yU9CvUOk6At9v56b/UVlrVBCNroZhOhENHsL/pmQpPO1SX4KGJYGCMdH7CSsG
         u4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kdQUiC7bpd5vbBlJ7GRQBgQSqfrL2yXOQL3N0xGBv3c=;
        b=nbeKIf5lk40+nEjeLOFkYmEV+R76YmuRblPtqjOhppuYV1MyF0WIaXDRHTmnU0SkIN
         SNLo7MbbSBSMbMiTiWzvXbE90pR71+Kbyn1AR7VesITXNQe1g6y6yC+D/85YYaRJ+GSU
         c0uH7aABjllRdizreA7g3y4qtoG4qMTIR4IgGnpqHekqsKQjVLhN8efF582BX3vyoyuZ
         cAS/7Xx0EDYh+/anDecuSVZPO0UGfO2R246gXK0IypYSUiOvkVb0pen109YRUaALcYrY
         /4WTOw5Ez45I3cA1WYuG+YOKRISstjDq3wxWlhP8+Dg2x6MwJPRAH7VO6lR+FbuwkGyg
         UEBg==
X-Gm-Message-State: APzg51BegSBwV+UvKdPUl0iSwNgyrSjh+jSE6XdxI9C8EL9b25SruMQK
        YLMbpXrpSYGpFw2uMzavprMpG1iGo/PrzbFCU+t5IQ==
X-Google-Smtp-Source: ANB0VdYDVNsvGFN81cAwGLyRN4siawBXWI8SW3UdUufGfxA4dhYcMiwj/XL4k0wvmccjhJywwk1wy9Nh8GXmZ273EWo=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr2108193itb.95.1536682207651;
 Tue, 11 Sep 2018 09:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 09:10:07
 -0700 (PDT)
In-Reply-To: <3f2dee71-1615-4a34-d611-3ccaf407551e@virtuozzo.com>
References: <cover.1535462971.git.andreyknvl@google.com> <db103bdc2109396af0c6007f1669ebbbb63b872b.1535462971.git.andreyknvl@google.com>
 <3f2dee71-1615-4a34-d611-3ccaf407551e@virtuozzo.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 11 Sep 2018 18:10:07 +0200
Message-ID: <CAAeHK+wke5swBfwJUandKe=Oo643n7vHiwPGfUtarT3UmsHetg@mail.gmail.com>
Subject: Re: [PATCH v6 16/18] khwasan, mm, arm64: tag non slab memory
 allocated via pagealloc
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Alexander Potapenko <glider@google.com>,
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
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 6:06 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
> On 08/29/2018 02:35 PM, Andrey Konovalov wrote:
>
>>  void kasan_poison_slab(struct page *page)
>>  {
>> +     unsigned long i;
>> +
>> +     if (IS_ENABLED(CONFIG_SLAB))
>> +             page->s_mem = reset_tag(page->s_mem);
>
> Why reinitialize here, instead of single initialization in alloc_slabmgmt()?

Hm, don't see why I did it this way, looks odd to me as well. Will fix
in v7, thanks!
