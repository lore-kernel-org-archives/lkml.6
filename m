Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B33C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE222086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dP3F4u8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE222086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeIDLkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:40:00 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42780 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIDLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:39:59 -0400
Received: by mail-lj1-f180.google.com with SMTP id f1-v6so2214549ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QIwZCtROatCmNKpkEhtjP2HqY0FksC9XnF7GpB0+O9k=;
        b=dP3F4u8cZP4kgT1fBmIepszFegEESgRM4nxxVoWRzIeG8mEoDlqHiLb24yhXRSecMO
         ubVZnNZszx+pxZtv5KQ2dMBWHZAocko0nUTetD/tF6p6my2b51omyFztCqG+N1N0/vmb
         PMQ8hB6g71UW9ig5WSfM6l0Ge23J0BBe6vLjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QIwZCtROatCmNKpkEhtjP2HqY0FksC9XnF7GpB0+O9k=;
        b=njGQRRDXYAhxcCLGzsc0GoiUL+bVSMw41ltJ8+Ksquohb+qYEFKl388JoWv6PfwYOK
         MgJOPFoipq/xHYuRYl3fMKXlTxBjwsgMsZScbmYR15q6D2N1UK2UpyspGaSWVz5nMx3e
         A3mNoatODoRwunu8878UTQrh9umwYILRD+l3DvIfYjPrc9GO+Q74By4DJfilylc65FbG
         We8oOMbSDhMwT/Xj59sROoErFlkElPCC7RJEG8F6N9y30dxwPC1tiCo/oMbjXuxUwo2c
         astIAJmpxz7TH+DiauYK7kHjwQekx6vKUcG6fOjqZdVReVgMci4kEFoh5OVJ+E8THgei
         dyew==
X-Gm-Message-State: APzg51Bpgwn99WTeDk4jY4uF+DHa8wl1wnUjITP4coHXs55WILFBtIao
        xIzFg47x5c0bzV7WfR9iv3QaydFA66cQxUqc+rfBjw==
X-Google-Smtp-Source: ANB0VdYg+LgU6CLLjmdCHSgsroLa2CKk2RQ7E4KBuNUFaBdU4t5y+6d2/U8ooPmsT7fdbhUrtlp15lTjevfjCG2xXAQ=
X-Received: by 2002:a2e:5296:: with SMTP id n22-v6mr20522464lje.54.1536045369398;
 Tue, 04 Sep 2018 00:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:180c:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 00:16:08 -0700 (PDT)
In-Reply-To: <20180904052428.GA26045@kroah.com>
References: <20180903165719.499675257@linuxfoundation.org> <20180903165721.576888426@linuxfoundation.org>
 <CA+G9fYsyr_AxbmuWfD6svin4Cq_5QJOYvOW_ohnS7fUobRU7ZA@mail.gmail.com> <20180904052428.GA26045@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Sep 2018 12:46:08 +0530
Message-ID: <CA+G9fYukBEWqEj_gFZsMatZ+4Qs7VxMpsrL35jDDKY_ChhukqA@mail.gmail.com>
Subject: Re: [PATCH 4.18 050/123] mm/tlb, x86/mm: Support invalidating TLB
 caches for RCU_TABLE_FREE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will.deacon@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Full test log link,
>> https://lkft.validation.linaro.org/scheduler/job/404027#L4051
>
> Does Linus's tree also crash with this patch applied?  Being "bug
> compatible" is good :)

No.
It did not crash on mainline kernel.

- Naresh

>
> thanks,
>
> greg k-h
