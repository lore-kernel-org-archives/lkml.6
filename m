Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF819ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684412075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A625t/zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684412075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbeGRDdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:33:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45402 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbeGRDdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:33:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id c4-v6so3038455wrs.12;
        Tue, 17 Jul 2018 19:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GdCtQMrcmLYUgr9/KpoVwb0TghP6vm51QhtqqEMNe8M=;
        b=A625t/zuTrRKtWLF+/0WuuwKWG0CM1PFuGoUrXKQyH/l+bheLZjCag+vdxTupHQFRN
         3B+IXzeTfDcaeSHZgZm4wi2F+/gnQjV4BsO2YUsq+UtOGIPxMh6dH7VbO3OTsMtz6ZnQ
         QEtnuJycx194ylhQg8+QKvFGrLkSC1EyHGnqka3UlaXKnmU6LBsRELTtHMDC29bWkRFq
         XNNeHgRy2dWaj343+0zGecspI+sfM9BNU/+PmCm04sBO+7LwTYLT0fiiLsSRhnEoDYeb
         dk++Ih/aiUMNv6I7cp3QoDSPZQ8SMY3dvFMQPoIN6RRpFB3Q2nZk+1zR7TZX+22duHWc
         Jdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GdCtQMrcmLYUgr9/KpoVwb0TghP6vm51QhtqqEMNe8M=;
        b=MPDVM2kxZiRuL35iKIe2enOG8/hZnb2AvM5nu/Xh6NwrT5IqvMhPEdrn1+ZAtWKe7k
         D2nV69rWhWVlQSjgukA3p8FU9IBqCRAv5B2EnnKKSwtdGI4Mc/HGjzTVjnavYTNHAHk9
         MspwYHChz4Ob3a3EtmvGxjmy4CKQnZ5BzX/3Trysg6gyGRZUehKfdO9AuYv7F2I8yP/T
         8OuCDE0sX/yo59rdYjnrIiJFFbovR7u4CS+UuRujQ4HLQSC8CqOLYFq1b4VKgPVN3lFv
         qxnCcggg8WgN7y+jsZDvgVEFslZfYhguQuw+4f3emva5AF+8oU4HfI5fECWD4k3mR4cm
         nHUA==
X-Gm-Message-State: AOUpUlF+XFoGTlOdyJkxOdm7JJiIRzh56eOyoinAYubT5JUHXi1Ak51H
        bUCxFUaTIhHVPJ0O79gBYDGesyiAQzdHk2CIw2k=
X-Google-Smtp-Source: AAOMgpcnGSySL1wsVjhjPIW6RtfdaEzStZjqJ5dxofSXDoYd+3qCsdrnMe0RRAJ1XtHHrPaxgx9U6/1RcSYZT35yM44=
X-Received: by 2002:adf:9183:: with SMTP id 3-v6mr2979830wri.122.1531882693866;
 Tue, 17 Jul 2018 19:58:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 19:57:33
 -0700 (PDT)
In-Reply-To: <4cd4429d-bca6-8b3d-1dd2-ef7f4cd102b7@gmail.com>
References: <20180718004639.30154-1-jmaxwell37@gmail.com> <5aafc511-15a1-da3c-19f8-cc8b658f9c3d@gmail.com>
 <CAGHK07D_XCpU6V6oJ2rhR1=rX5P6t8ZhTMT7GEAyrBXoc=hbcQ@mail.gmail.com> <4cd4429d-bca6-8b3d-1dd2-ef7f4cd102b7@gmail.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Wed, 18 Jul 2018 12:57:33 +1000
Message-ID: <CAGHK07DFJE2HFt4NpWR+6PPsiBY1v2tqMzL1tqJ91EXdA9wNbw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] tcp: improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        David Laight <David.Laight@aculab.com>,
        kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I see what you mean looking some examples on:

https://patchwork.ozlabs.org/project/netdev/list/

I'll resubmit with the correct patch series numbers but with
the same detailed description.

On Wed, Jul 18, 2018 at 12:40 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/17/2018 06:55 PM, Jonathan Maxwell wrote:
>> After committing the patches in my net-next git branch I used git send-mail:
>>
>> git send-email --identity=XXX --cover-letter --annotate origin
>> --compose --signoff
>>
>> and manually updated it based on an example of yours:
>>
>> https://lwn.net/Articles/706491/
>>
>> I can see the 3 patches that I just submitted on:
>>
>> https://patchwork.ozlabs.org/project/netdev/list/
>>
>> Flagged as under review by DaveM.
>>
>
> I dunno, each patch belongs to a separate patch series, this is not expected.
>
> Compare to what happens on https://patchwork.ozlabs.org/project/netdev/list/  for a proper submission.
>
> If you click on https://patchwork.ozlabs.org/project/netdev/list/?series=56100  for example,
> you can see 5 patch in a series.
>
> Standard workflow :
>
> git-format-patch ...
>
> <edit cover letter>
>
> git send-email --to "David S. Miller <davem@davemloft.net>" \
>         --cc "netdev <netdev@vger.kernel.org>" \
>         --cc "Eric Dumazet <edumazet@google.com>" \
>         00*
