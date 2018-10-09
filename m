Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C185AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8278020644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGKQ59fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8278020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeJIW4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:56:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38820 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIW4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:56:22 -0400
Received: by mail-io1-f65.google.com with SMTP id n5-v6so1505740ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3xFCs0HpqnRj6cRHEU+WDjgtDouMGc2T8zb7mAKlgo=;
        b=VGKQ59fo7mVoMwxz3l8ThApvzYx9QpARpbP7BZlsgadoEaeyVb/eJC9pImK4gZmcjF
         wuBTk0zlQQInL/aVPe+Y+AMbw42MY1aF0oqFZGTCMCoYnNOKvsxm5naFIHBao1awt64B
         dXLp/fm++yzCcOVZxKOIgC8nTupdiiHkD0fu1xKSOYT5PT/5H0gwBXhatPz0WeQ1W8Ex
         7y7q6yU7KaT1o1NTVLNGVL7EXM+iElz7JyhdDJBiNXlnxlhjDBQ/mqNnizVGAQwCBsXo
         25+LCyzBOC15J0FMi7I9g9giVSQqkCDtGq+JVoZwszOkCG1wB8Vr2J/HuqMUtUMsz5U9
         7iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3xFCs0HpqnRj6cRHEU+WDjgtDouMGc2T8zb7mAKlgo=;
        b=hheJ7voEqubzQygVPAB4sVaWaH1AN5lCxYSPQa0Me9iuHm8tU/LZlGlePh+WHyiElO
         /kTFw1zcKknEuDvfHZ6NcbwCN8xMqVrUHbVrqnIbLkcfvnp4cTkIiBoQtCZSbrVJYoQr
         EDrHgG9irrQdDWgr8QHV/NLrqTiGnTanPrOUOZ8eAsxxH3nPDy9ZjOAdZDmoOAUXCrEW
         owqjceq9o4GY4ro70E+WDU39c6pS4eIA8CvgqlTEYDptIYJ7p/KI/dDEn87fS1Tal0SP
         jJd9ZjPXy+7f5mEGLpiaOqmfBrwIVb7JHcnx7YgZkN6llDHoUccDoKodiJ1AiLRiRGSG
         R2KA==
X-Gm-Message-State: ABuFfoixQDqoLg/uowDWltNe4I1Pd310r4QiPD6Cyg6Et9F6Vi5oq9j6
        UGGv9hkecmPoB7+QbYIVkjuc1bkpoevbrJkhB81+hg==
X-Google-Smtp-Source: ACcGV62BJxb+XoVWcoSyTnKAfvWBmFE98/U6r7vHWafPiPZ4XwC+jFjRxxTIqkbdNFVsCDXv9dhUtfosIP4+gT609Ho=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr17831381iog.271.1539099531737;
 Tue, 09 Oct 2018 08:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
 <1539086718-4119-2-git-send-email-laoar.shao@gmail.com> <CANn89iL1BMCx3Mbsj3TijR3Srjji95q86px0k98r7JYJbwLzcw@mail.gmail.com>
 <CALOAHbBwGAqia_2xJSNkaX7TzSPN89bRz71qHRH43FtbwNTP6w@mail.gmail.com> <CANn89iKe4vETuo-FBZ8ZrovJGiimBbhbzBnbqawX_h0LA+8PoA@mail.gmail.com>
In-Reply-To: <CANn89iKe4vETuo-FBZ8ZrovJGiimBbhbzBnbqawX_h0LA+8PoA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 Oct 2018 08:38:39 -0700
Message-ID: <CANn89i+-g5DEnrv0DSCsMq3fXo35mAaOmXvf1Tr22Ybif1OV0Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: forbid direct reclaim if MSG_DONTWAIT is
 set in send path
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 7:58 AM Eric Dumazet <edumazet@google.com> wrote:
>

> We do not add bloat in the kernel if no application is ever going to
> use it, especially in the TCP fast path.
>

BTW, are you willing to change all memory allocations in the kernel as well ?

Let say an application is using a system call providing a pathname
(open(), stat(), ...), how this system call
is going to ask the kernel for no direct reclaim ?

Even allocating a socket with socket() or accept() has no ability to
avoid direct reclaim.

So tcp_sendmsg() is only the tip of the iceberg.
