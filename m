Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C8FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C27620C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxFRMVYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C27620C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbeGKNvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:51:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46858 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbeGKNvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:51:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so49320092oie.13;
        Wed, 11 Jul 2018 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b6znGufrlpNhwDbATgq1XndSrOlJ0sUd9fskYtLr6s0=;
        b=NxFRMVYi90bGHgVc69MHzR/KQ4gvkDdiMFjwP0hX0G6+3QOg7xYYgG5rjzW52CFeLg
         8r3bGy0rLWCJGx3AncadzL9b4e3zi/fUdLZOutg7TjbYc3Hoo/gyv4/HSTOmaCzvq87w
         wJ0oGNT4R6Kkqsv6EyF+3M9VM9x0tYw79HO5jxElJ6uGaVZozl6XtguQbA3doHN/UM79
         ACDBdKhLry+7EBTh9J+zqo2xBMn+NPAANpa1Hai2oatGfAjgLlz60rCwqV9VP+pD2DQO
         8HMq70o9i5qJy28EHNVFaRy+lgVj5HwdvACx83wMJncpcn0F8HXC9R2Pj8iOdDP13/Nk
         4U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b6znGufrlpNhwDbATgq1XndSrOlJ0sUd9fskYtLr6s0=;
        b=iCPHNvDZ6pSWmfa4dQTQQesVlNQEfHoOQ2k8x0iA9io1b61Io+9g+EwdHssLcVPLYf
         IFJBmt+ZUw8H5l++th9FqXrNdTTJh9MSR3eRa6AD4XwPA27CTVFA8p9tvjgRdb03DZ+j
         +xor4tAmZTwY9Jud13WF4BWAb6C3bHHFR23eZxWmItAhN/2mk+x4DjRm8HzCeQnwn8d3
         DeHbh/Trrh4jiXk2nzZYb0ZpW6fxHkby95nBJfHBOCNv9kZtb6XB3fgjrYMrcYfv+Os8
         KC7He5ZBooJe93iWE+levLtkPIx6EeiKSaaurTFoAVeZpkEkeC2y6DoRFXYkZJbnZqct
         h1Lw==
X-Gm-Message-State: APt69E1N7Lixs7NsXlSOcqa67iHquOkbgytAJgc9CBQi+073dVKZSquM
        SQ4kb2VfS4K9kB2l5ROe3+aEmY7gR9tlhH2XzHA=
X-Google-Smtp-Source: AAOMgpdEMgWcSmXq/Qd4HqqeThMVOjNe1gNIIrPuOUXR9Tv2cJf0+NLuKFw6iCzJp1g+6DQwoYfQrwhiR7p1R+BtiAw=
X-Received: by 2002:aca:b857:: with SMTP id i84-v6mr34396047oif.279.1531316826729;
 Wed, 11 Jul 2018 06:47:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 06:47:06
 -0700 (PDT)
In-Reply-To: <ae3e2013-9c90-af39-f9da-278bf7af6f73@redhat.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-6-yu-cheng.yu@intel.com>
 <ae3e2013-9c90-af39-f9da-278bf7af6f73@redhat.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 11 Jul 2018 06:47:06 -0700
Message-ID: <CAMe9rOqo3ZSMuwNZf8HbrL72OY1aQ0S0Huwqj7rsVY9_ZOfF_A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/27] Documentation/x86: Add CET description
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 2:57 AM, Florian Weimer <fweimer@redhat.com> wrote:
> On 07/11/2018 12:26 AM, Yu-cheng Yu wrote:
>
>> +To build a CET-enabled kernel, Binutils v2.30 and GCC v8.1 or later
>> +are required.  To build a CET-enabled application, GLIBC v2.29 or
>> +later is also requried.
>
>
> Have you given up on getting the required changes into glibc 2.28?
>

This is a typo.  We are still targeting for 2.28.  All pieces are there.

-- 
H.J.
