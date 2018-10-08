Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005B1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9F920858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Leih5nMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9F920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJHWLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:11:06 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:51418 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeJHWLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:11:06 -0400
Received: by mail-it1-f180.google.com with SMTP id 74-v6so11861479itw.1;
        Mon, 08 Oct 2018 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XBIBBlLIEP0LVBuJe22LznfiNmuwu8XowiZyVHmp+w=;
        b=Leih5nMGuB/uXHWUkBU2sBPJaJ1+Q7Egxe6YdvQ1zn7z+SrO/0QdalZg1IB3/D0VR5
         crjycKxr4fyw1GtxMnd5s2U3ZIY7QJ4dlwcQdsw1x+jeJq6uAS8NW3zb0oiVJc5hv+dm
         RbjaS0NqFjSA6zV1J+alDht98XTMp42cbtTvCkO24e+9ztND/QZkgxlPn0cXhB5sKa4p
         j+LjS9lqDf9FWVsXhvEuVj1Yds32GQc65IGP4aghrhI0kk0YTCMGWLBPPx4g8+oKttay
         oDJ4wx3g52lnTIhKCaNEUyHqialZVkpPzN0PDfEhJOzJ8yLLW9uUIL+M0RrEQ1KKdB8E
         so2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XBIBBlLIEP0LVBuJe22LznfiNmuwu8XowiZyVHmp+w=;
        b=j78ius2ul/xG9Rt+pQstZFie/8zywdghoq23mTHQFsTrvYiEJKlw5pW3amwOD99YIM
         wuCZrzwoig2xHFAK9RbdqWN1aCUU4LXAhjIvLgUBAqSz8gO76l81m7yAf/hwBm76XtOm
         slHOK4+sX+WHX/3wBaKC12UyHyJos2EuG5UV8nBTlA/Uq/xzmDhSWsvGtMRKsE2iObqv
         mS6sBMnWhMG2ZB0D5fmvVYW2wMpiCUS6URt7XR7kYRfPHbq+rA7cfMvzvuRSnMTWwO33
         NsSvp/2lURVMCb45/qaG13s75LgUkhkiRR2xmupl7g30C8VqM8GnKVSVNqXdpFhqHhOB
         nY2Q==
X-Gm-Message-State: ABuFfoiM0Mn0iO1kXRK0rBLF03AemLZxgjgQU+D4NjJor9OxINJoc2bb
        T1cHS3psdDNPvlWIKl35W5LVBBLshUcIQlFz6kw=
X-Google-Smtp-Source: ACcGV60hYfX9dk1LQBPAP4rnnloogDW9UKTTej5qs4uf/SZUPr3bCiBjesQwop72rR8eiLukTA7D8TYdgtRa+YCiFhU=
X-Received: by 2002:a24:8789:: with SMTP id f131-v6mr6158565ite.27.1539010737793;
 Mon, 08 Oct 2018 07:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <1538919405-3093-1-git-send-email-laoar.shao@gmail.com>
 <0652963b-90ac-06a7-3a35-50a307465cf9@gmail.com> <CALOAHbAAwr1rsPhHT4R7wn3SYJ220C-i92qObSA3Cvp99M8i8w@mail.gmail.com>
 <CANn89iLUKmiP==WP=cf9KYwMaNDbsU2M=b07dPU+DspfBGSsAg@mail.gmail.com>
In-Reply-To: <CANn89iLUKmiP==WP=cf9KYwMaNDbsU2M=b07dPU+DspfBGSsAg@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 8 Oct 2018 22:58:21 +0800
Message-ID: <CALOAHbAov-uxMP8cmzdT0d9fPVi3VJ7=A8tQXjCyDDGXFG6x3w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] inet: do not set backlog if listen fails
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 10:48 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Oct 8, 2018 at 3:47 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> >
> > Pls. correct me if I missed something.
> >
>
> You missed that this variable must be set before listener is setup.
> Same feedback than prior version really (when you trived to move
> around sk_ack_backlog clearing)
>
> You are changing inet_csk_listen_start() but this is wrong...

Got it.
Thank you.
