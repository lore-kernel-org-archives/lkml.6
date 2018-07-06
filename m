Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D943C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2278E24088
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plEYnjoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2278E24088
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeGFHoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:44:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45708 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbeGFHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:44:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id y24-v6so7705484pfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YkrBq/b2EuBF5uuZ3JGh+95AdBLkDNUUwCS5RydHeuY=;
        b=plEYnjoj4FuoPjvrfoJIV6CKrBxmdsNnBllY3DBgWpl3CIzr+H1LxLbjU5BOZlS3sh
         M6zLUc3/hER08eRExtm+wAqMrUDe13gYHqCaYSKDtf9JsBQXAPI1xazMai+v5na/MW6W
         8fy34aIz27rZpg7ZqrGrt0CAN1bfZHhP5I63dBvLNmBJ/qh+hRxgQ4iymYPfOgnpY/rE
         T6Ho9SsD63s27xzP8oz8ofxhl/v1L3OjREqiZOB+vyx53Tsyk5HbFJOKd+94y3AFlIiS
         n/6JNbus/CBHxVUtsgH7i2gOXagxklE0TMAUYfmuG+YUkBrXqg8w1QVWhjBcarLL7tBc
         o3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YkrBq/b2EuBF5uuZ3JGh+95AdBLkDNUUwCS5RydHeuY=;
        b=tH5sKPA3iJGU7WyYOy4Z5WBJuqbmsrBfB7doGH5+wJE8morZzFcDQYW6UvWDrGv+b1
         tUvY5efdGdy4frSO0PdQ2BbC66mkoMOzFh7ADqrCTu6RI8ZAPAfqeENpRloskwDPBPde
         fl9/sx7oEWz9GmbT+yk+LRCsGjD9DgqsZE/56752mskDrgZbG3mTtBj/V0VAmm6C4NCW
         tdVex/6jVdzjNWNWcMas09EAgqhxkS3/XR6k3EBtLuMEDddNzcSk2Yp6Zj3t/U/TvsiE
         B7CgZn/GoO5BRHFJmsnz6uH8Hg/8uT8Wt5Oxapuzl8LF8RbwW5M1UanWreBS7Hl6xWXX
         IZKQ==
X-Gm-Message-State: APt69E3YYSS6on2y4CIe21Y3o3W9DA5RWFHRWmS9TKZ1r0XKnYePRAWw
        kkBWp7lQxFGW84VqqOj6PuA7T+AESV4SSz06A7x2Og==
X-Google-Smtp-Source: AAOMgpdep5EbLidS2A2YHu03WYow8kFdtOA+QybNMRT+VKtNDSh7FpHGlBif85q9QVyAu1tzD4N3U9UMIoDUrOd+AQo=
X-Received: by 2002:a62:3f44:: with SMTP id m65-v6mr9514705pfa.98.1530863084239;
 Fri, 06 Jul 2018 00:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Fri, 6 Jul 2018 00:44:23
 -0700 (PDT)
In-Reply-To: <2049675.lBcD2vaCCs@tauon.chronox.de>
References: <000000000000846e9e0570438176@google.com> <1626520.Rx0128ICKU@positron.chronox.de>
 <CACT4Y+YJUVJnFt2bn7rhV+ET6dVhwWrym8DK+LgV3rJGVUuCFA@mail.gmail.com> <2049675.lBcD2vaCCs@tauon.chronox.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 6 Jul 2018 09:44:23 +0200
Message-ID: <CACT4Y+b5JS5BboDz4Z92KoHpp6HEp-SByzWDAXARrLJtyR0Aug@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
To:     Stephan Mueller <smueller@chronox.de>
Cc:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 9:41 AM, Stephan Mueller <smueller@chronox.de> wrote=
:
> Am Freitag, 6. Juli 2018, 09:38:41 CEST schrieb Dmitry Vyukov:
>
> Hi Dmitry,
>
>> On Thu, Jul 5, 2018 at 8:45 PM, Stephan M=C3=BCller <smueller@chronox.de=
> wrote:
>> > Am Donnerstag, 5. Juli 2018, 19:02:01 CEST schrieb syzbot:
>> >
>> > Hi Dimitry,
>> >
>> > does the syzkaller somehow uses the "---" separator as part of the URL=
?
>>
>> It used it as branch. Please see:
>>
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-p=
atch
>> es
>>
>> for formats. In all formats a git tree is not enough. And it is not
>> enough to identify code state in any other context too, it's always
>> git repo + branch or commit hash.
>
> And which branch should I use for the kmsan.git repo?

master, as specified in the original syzbot report. I will add this to
the doc too.
