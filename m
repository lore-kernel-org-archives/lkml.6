Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032A4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB965208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL/gp2T6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB965208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeGaTdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:33:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42407 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbeGaTc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:32:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so6467516pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PKElp04UgMwElXRd3OjLixeXgrBPSMQRVTAjbusprc4=;
        b=TL/gp2T6VKOIkzJj9VM14lnHYFStQ53Ahj63pcN028SKRr+GSIzVeEOLKFhm1IEgOF
         6/lSYSl5AER5sUYxJApEJJu5UWss9U01WwzTcbJFX9S5lL12NVg+psgx9bBHq36TQ3dF
         QDEgrl3nzZxx4AdRDBhyZ/uU6d7JZTNT9PPUdhF7H/cIwFF+n3hLUo8XUIMZ9tT38Gem
         KL6EIOjPwmZPJeaAcBxK7bPTmOgrBZa41oy/X/n5e9gyVQlH+n7MB92ieUpmrEfSFKa6
         Cm0Cgshqf1sN+YVvzRIx9FDfXggLjPLDnW+Ua/ZfoCnQ5kyiQMSHZ4icGxBzfypQtQJY
         jz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PKElp04UgMwElXRd3OjLixeXgrBPSMQRVTAjbusprc4=;
        b=fo+QXUxS/kBMqo6ia8Uqwy+KNvMxG/nKy5xynjLBfTc87tf3ZLM3lWae/b/pUDIVTf
         myY4/usu2/BFFqliNsJBNdGPsuwXjIrszmqG2XG/DJis4SH6kz+C7DInnpJh6kbqSSt1
         +Es9gjYx3XLZz4DWg+ETQVaZDEBeMzuonc6ahsPvJ7kBMxOBHJXj4EeB175OnSfBS8VB
         ippgCnLnwIpZ740IjOEiRNuMOVGcYuBF5P9+EQrO3PtDtunIVTFcqTpzyI+kB22/U4NA
         mNjp5CLHDzngl96Li6SnIWj+KaU4TTUQWzR/DgrekzfMEzqhbTaFg+JAIHHFE9GrhVLP
         q6zA==
X-Gm-Message-State: AOUpUlERgj0eIh3a3XNxUnLEATVJP9/N1G3zetS2frF0BJU/OM9/BrbN
        Bjw1NEP0F/B9Iwjb7T1E6YzDsElZBTZ9aMyprY04Bg==
X-Google-Smtp-Source: AAOMgpcDsxkw4nLkGIa2b36NXG8RAZf/8f/LjeFacSA2sqboQ7wmJa02765iwV4qjTbXnV0W79M8EzFf718e6qRetnk=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr21820229pgp.334.1533059490212;
 Tue, 31 Jul 2018 10:51:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 31 Jul 2018 10:51:09
 -0700 (PDT)
In-Reply-To: <CANn89iLLQP2vA+2J-zxL3Fa75zNw=yRmv3Jg6vcEc=fYeEZ2ow@mail.gmail.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CANn89iLLQP2vA+2J-zxL3Fa75zNw=yRmv3Jg6vcEc=fYeEZ2ow@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 31 Jul 2018 19:51:09 +0200
Message-ID: <CACT4Y+Y6dhNgisDM9hdP-M-Rnk66DxZWcX7v39ESGJR8RY3asQ@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Eric Dumazet <edumazet@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 7:41 PM, Eric Dumazet <edumazet@google.com> wrote:
> On Tue, Jul 31, 2018 at 10:36 AM Christopher Lameter <cl@linux.com> wrote:
>
>>
>> If there is refcounting going on then why use SLAB_TYPESAFE_BY_RCU?
>
> To allow fast reuse of objects, without going through call_rcu() and
> reducing cache efficiency.
>
> I believe this is mentioned in Documentation/RCU/rculist_nulls.txt


Is it OK to overwrite ct->status? It seems that are some read and
writes to it right after atomic_inc_not_zero.
