Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB2220841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKclMVW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB2220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbeGaTX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:23:29 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43560 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbeGaTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:23:29 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so13732706ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZPiLSVij48Ml7RyMFdOOkoCd/1f7/lix5KTpWVZDok=;
        b=YKclMVW54MIH2TrUVfJUGUOKzcLzesXUTCHwt6/wl+qTNoR4eOj+j0zfkMIjX42iEk
         m9zhb1l3yKW08YXn6kJnYsFzL0vcSDyK/+YSmYQ2KyepPQxglVzdYc7qvjv8gwyWkCtR
         shdXLVVrycSvOZBGEf/cYcrGVkGoTQPTF4JnvLFb6y05xSoDrQv7bRYiN7vI/TdSWD+u
         AhwE5hKo+k9NxJhlDfybxjEKsjviA4pNL075f5wFi+JTUuip6oMMUt2wukGrnidLjSDt
         IKI8STY2PZRBfZUgKzxRCAHrfVVnDAEAxuOZ2ohIRfuzFcDy2cePi/qs5w1HJ5qXlAlF
         pIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZPiLSVij48Ml7RyMFdOOkoCd/1f7/lix5KTpWVZDok=;
        b=Y+1BXT84VrNKC5JbuJrbjrOrUoztjgwl8dV9ytbBPyxhgJcoowHn7I6KbkQtr2tVeS
         Zu6tL1fEZj86DIDCMDivP2Ji9alN3zWeH/Kiehmm1un5syykE4UQR7VMGj0FncwMyv/Y
         b9IkmifECMuY5XG//lcw5eq4Ann0XYTk56KMJ/kMIUcpC3zYMBQuSyBMgFgA1sDOM3Dt
         W19TIwubMDuChdO30CRAJnpTkNfI/3lGkwIQjZHeEmEKl3s78BGCxJ62QiZnuCozP/U4
         XxGaNaoQY5dx4OZ0arHdJkNvjYKzsr5cQ+CKwDDh6xY9NAI7uJySVI0zG1ao/KjjEl7G
         Aptg==
X-Gm-Message-State: AOUpUlFcM4X+TJotv24EWFtUOz26a8B99dO1OqvQbIoI50xLuILiAh5n
        M4X3bknV+kkA8R3dt3fYE+BecYgzQAqmKXFfq951IQ==
X-Google-Smtp-Source: AAOMgpdYt/HTWx2J1qu7l91noLsrW/v+rrHTl1YFYDF0Io1IOeb+pJx+ZQtBSDpt2dpDgN+CwS57MsiWKs5e70uxghE=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr532662iog.271.1533058925770;
 Tue, 31 Jul 2018 10:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com> <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
In-Reply-To: <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 31 Jul 2018 10:41:54 -0700
Message-ID: <CANn89iLLQP2vA+2J-zxL3Fa75zNw=yRmv3Jg6vcEc=fYeEZ2ow@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Christoph Lameter <cl@linux.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, jack@suse.com,
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
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:36 AM Christopher Lameter <cl@linux.com> wrote:

>
> If there is refcounting going on then why use SLAB_TYPESAFE_BY_RCU?

To allow fast reuse of objects, without going through call_rcu() and
reducing cache efficiency.

I believe this is mentioned in Documentation/RCU/rculist_nulls.txt
