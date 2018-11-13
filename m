Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7894C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A49D2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="bLVPwgiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A49D2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbeKMW5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:57:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37780 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732986AbeKMW5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:57:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so1059774oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B40sURHNTLb8+tSXCx26itaj23HZO710UGG5DEoOj08=;
        b=bLVPwgiO53EG+aleK7QFI/5sTZp9lz0ORpJ9ny7Icn0z0mEIiYmH44vUAMJlaxwSla
         wobNtOeOHMfSE4h5YUhapo6OKKPuFJYWJuXQD6+i4/qKchDe4ShfvECy2DwfkB5h3jKM
         A29zhdXrnHhPkqXM171n4LkNngrVqKKFAwMSE260gUhvQTW/vepuAJ4K7GJWN8VaAIJA
         w1XedZCHqSL+yoWnKMnAcv9KA0VO6UdlWzMGvF0tWZX3JJilSSofkF+HgFOvXbWNmyX/
         vr0yplXwBfuYIVyjfmKAOF5Fs2bWV9JDk0echJ+irjRZojdBGpCwtP9vuOdqcH8ceQPt
         1BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B40sURHNTLb8+tSXCx26itaj23HZO710UGG5DEoOj08=;
        b=A3f4Ugj+pOUC/YTHJ1bBlLYov1LMihXFHWDp31SfUQjZRCz1mFZr+9rp3YVtvlFUf5
         Ase+XGR6B67Fu/felrqisZ3fXmaHM9F1UBdcCzoZO2zij8iku/aqdCBO2OlvZA2dfhmW
         SEsRZz+3NPXFjzYjxU69FLRErABqJM+Xaug+PcmTqaxVG4dgcAu38pjtE3OWmX0uKKNQ
         iZdJbZ7L+6sEaaymDAsUd+GIt9KckC8jW1puejqUPvnnZMMyHYE5C8F/3ltEs67Z95Oc
         /1jiydOMOJB0CTmUXrXlmx0szG+54U3nB2pJIDkI3Uqbk1DwedX6Kg7KuIwkgo+BAVy0
         JMhg==
X-Gm-Message-State: AGRZ1gIuWNdTIVhOHcS31BiiQ9h6Ovrhbh0tvze9ah7E+3PqT+RPU1HV
        YDA6oH+admjZ/kP18lnGwMdUt9dvYd0dKaBb
X-Google-Smtp-Source: AJdET5cthyQJ/pA78A64r+z77wT218oEQ+pAWxIsFnn/g+oL7ih8TOWivZtVUAqqBaXgFCbdSLwBNQ==
X-Received: by 2002:aca:d694:: with SMTP id n142-v6mr2760097oig.32.1542113939152;
        Tue, 13 Nov 2018 04:58:59 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id e42sm22037270oth.36.2018.11.13.04.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:58:57 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id c206so4628053oib.0;
        Tue, 13 Nov 2018 04:58:57 -0800 (PST)
X-Received: by 2002:aca:f40d:: with SMTP id s13-v6mr3069528oih.102.1542113937120;
 Tue, 13 Nov 2018 04:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20181112231344.7161-1-timofey.titovets@synesis.ru> <CAG48ez0VRmRQckOjQhOeaf6bLYkfi45ksdnzuCKPwBYTM+As1g@mail.gmail.com>
In-Reply-To: <CAG48ez0VRmRQckOjQhOeaf6bLYkfi45ksdnzuCKPwBYTM+As1g@mail.gmail.com>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Tue, 13 Nov 2018 15:58:20 +0300
X-Gmail-Original-Message-ID: <CAGqmi75MShkwHTiSLPiOoQuYORmYTBJVqMKXm7pKhoNg9PT3yw@mail.gmail.com>
Message-ID: <CAGqmi75MShkwHTiSLPiOoQuYORmYTBJVqMKXm7pKhoNg9PT3yw@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     jannh@google.com
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 14:57, Jann =
Horn <jannh@google.com>:
>
> On Tue, Nov 13, 2018 at 12:40 PM Timofey Titovets
> <timofey.titovets@synesis.ru> wrote:
> > ksm by default working only on memory that added by
> > madvise().
> >
> > And only way get that work on other applications:
> >   * Use LD_PRELOAD and libraries
> >   * Patch kernel
> >
> > Lets use kernel task list and add logic to import VMAs from tasks.
> >
> > That behaviour controlled by new attributes:
> >   * mode:
> >     I try mimic hugepages attribute, so mode have two states:
> >       * madvise      - old default behaviour
> >       * always [new] - allow ksm to get tasks vma and
> >                        try working on that.
>
> Please don't. And if you really have to for some reason, put some big
> warnings on this, advising people that it's a security risk.
>
> KSM is one of the favorite punching bags of side-channel and hardware
> security researchers:
>
> As a gigantic, problematic side channel:
> http://staff.aist.go.jp/k.suzaki/EuroSec2011-suzaki.pdf
> https://www.usenix.org/system/files/conference/woot15/woot15-paper-barres=
i.pdf
> https://access.redhat.com/blogs/766093/posts/1976303
> https://gruss.cc/files/dedup.pdf
>
> In particular https://gruss.cc/files/dedup.pdf ("Practical Memory
> Deduplication Attacks in Sandboxed JavaScript") shows that KSM makes
> it possible to use malicious JavaScript to determine whether a given
> page of memory exists elsewhere on your system.
>
> And also as a way to target rowhammer-based faults:
> https://www.usenix.org/system/files/conference/usenixsecurity16/sec16_pap=
er_razavi.pdf
> https://thisissecurity.stormshield.com/2017/10/19/attacking-co-hosted-vm-=
hacker-hammer-two-memory-modules/

I'm very sorry, i'm not a security specialist.
But if i understood correctly, ksm have that security issues _without_
my patch set.
Even more, not only KSM have that type of issue, any memory
deduplication have that problems.
Any guy who care about security must decide on it self. Which things
him use and how he will
defend from others.
Even more on it self he must learn tools, what he use and make some
decision right?

So, if you really care about that problem in general, or only on KSM side,
that your initiative and your duty to warn people about that.

KSM already exists for 10+ years. You know about security implication
of use memory deduplication.
That your duty to send a patches to documentation, and add appropriate warn=
ings.

Sorry for my passive aggressive,
i don't try hurt someone, or humiliate.

That's just my IMHO and i'm just to restricted in my english knowledge,
to write that more gentle.

Thanks!
