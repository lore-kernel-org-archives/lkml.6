Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66363ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128922150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpfC5YF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128922150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeISAQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:16:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36740 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbeISAQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:16:55 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so4393036iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4d36XmtxBW5NFyXdurff1rHNSewgLeeQvwdnKIbecc0=;
        b=dpfC5YF8D4Eyb/jgB8z9LJJb7npv0hinuVPaY7/zuloofzBIfb4ihj0G3iopVdCYUv
         2ybQTIkNExxXDJbyihrMZbqq/bhkMg9eYncAerKmgc7GFWXQvNrG/18q/3Kns3kQKFB/
         015ITZ6xbbs54B8zqSLOU+NVDUtTh/BITt0R5FI9icsrPueY12xsfIhTnMRSTfM4UP8r
         sX7c/eIp9okOCVZfZaDkoFZK7yRgbw5ijHBi1/tEH3kWcYfBoblqgkw7KJ2B+W3+tmcf
         7lBxCTDl09bxUuIV0qw6lMXWv48JE+gxubVMeeAE7rJJGW2p/Z7VCFmUOF4W/8kNgCzs
         a2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4d36XmtxBW5NFyXdurff1rHNSewgLeeQvwdnKIbecc0=;
        b=t14odGCwJ/qj1OKYgL+i9IU8fZBOsL1T8zhFDKuGuBOhZ7vFlGghDIbkF4+EER2aCc
         eTM/DN9OLxYjomCDQ+zfMCNZkzJx2Lh04iUyOURzZ4RWxpSn/PIstv7gM8sl1qesjsAy
         rXL8JQFd84Bs0A6Aw5WbS/4/6cS+vhJgz5m33LzFDmYzr4RPAewbOq6nwkkLTQ4efnoZ
         kcj1OG0TkT7376XdBczwGi02udomYxpd0dn3Mf0lFWNTx06YvVH8dJxkF9R0KWdFA92i
         2hP2uQjkzlPHAsLZppvJZbO9AbnACQ9X1phCtr5AafEr/yNH7WjctcC1c0oytSRMQLp2
         mFTw==
X-Gm-Message-State: APzg51Bx0nObTuL9Rp5A1TsrDn+jYzg9dFdjnR1CfSTqAxgOKdcENi7o
        Uxv8cVHe7Km/IcjGjHzqrTQtpc3HGuDrhHhO/pQx0w==
X-Google-Smtp-Source: ANB0VdYdcTxqpzntHjnCUJ1d3zVspY4qpnFDX1LOIND654hhtFQOMVr480zjb+rTk2Eoty/k+X6m+unvHyWRYDr3oZg=
X-Received: by 2002:a24:9f07:: with SMTP id c7-v6mr15535988ite.53.1537296177299;
 Tue, 18 Sep 2018 11:42:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 11:42:56
 -0700 (PDT)
In-Reply-To: <CACT4Y+a0A1n+FjbiQSEh4UMUPkq4KnqEOEXkfo-X+EwsVFZxMg@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <1a3b3030b6ee01931b397583b69f3af94e2a2308.1535462971.git.andreyknvl@google.com>
 <CACT4Y+a0A1n+FjbiQSEh4UMUPkq4KnqEOEXkfo-X+EwsVFZxMg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 18 Sep 2018 20:42:56 +0200
Message-ID: <CAAeHK+wDhpX_E7cL8D4-BnM4WCT_Bb2Gp6wfqk7+P-4XAoiMOg@mail.gmail.com>
Subject: Re: [PATCH v6 17/18] khwasan: update kasan documentation
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
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

On Wed, Sep 12, 2018 at 8:39 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> This patch updates KASAN documentation to reflect the addition of KHWASAN.

>> -Currently KASAN is supported only for the x86_64 and arm64 architectures.
>> +KASAN uses compile-time instrumentation to insert validity checks before every
>> +memory access, and therefore requires a compiler version that supports that.
>> +For classic KASAN you need GCC version 4.9.2 or later. GCC 5.0 or later is
>> +required for detection of out-of-bounds accesses on stack and global variables.
>> +KHWASAN in turns is only supported in clang and requires revision 330044 or
>
> in turn?
>

>> -and choose between CONFIG_KASAN_OUTLINE and CONFIG_KASAN_INLINE. Outline and
>> -inline are compiler instrumentation types. The former produces smaller binary
>> -the latter is 1.1 - 2 times faster. Inline instrumentation requires a GCC
>> +and choose between CONFIG_KASAN_GENERIC (to enable classic KASAN) and
>> +CONFIG_KASAN_HW (to enabled KHWASAN). You also need to choose choose between
>
> to enable
>

>> +     print_address_description+0x73/0x280 mm/kasan/report.c:254
>
>
> KASAN does not print line numbers per se.
> I think we need to show unmodified output to not confuse readers
> (probably remove the useless ? lines).

Will fix all in v7.
