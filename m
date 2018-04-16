Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3406967-1523888997-2-2875551061385582375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523888996; b=ARfxCQgQDj+qIwEGHAlQQAEo1VnvW2QDcn/sgAOAIv7XDUd383
    gJFseCSpLj3NiBHLgiUHecUlRgJhjFtUFfYQXtLJv5bIJ7imAm7m553MOsu17UnC
    r1uHfJVPIz4dpu1jmUofLzprQK6/x/9xdVMZuGEzwdzRt0ALj2EpsMPQSTJiaf7U
    mrtQfB6JGUNDMjeEL2p7eFlWgCDuOK+wAd0asiRMAGE3kqx6c+ucoMLgcFHYwMaD
    ezEcOcglRkrHAhr6oN2zczFggbxBo5TSbSyY12fRbDBuun9akS8tH3oWXjMoGBoz
    iTLg1ISKgLFOm1EhRftPgWIDk43OIMgtxZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523888996; bh=EzzOetBBtJFlCgKNLcfRPVoRCYWfIqk9W8JQlPMnWx
    A=; b=YWPj9ylgAiGXMd5TKh5Sr8so5j8QtQVT16mz6qlOoEnr+sG22MI52iUf+W
    8Ou/UKqV5txG7g3/XbKigNCUmFb32As96kYDWz68PH98ddGJjDaSb0Gyq+1LF4qX
    z1eYFNURsWk9p9r5cAh+LxwlmvaBNwoxkHggjfHRsWT7atH9F9UwHnmYmMd0RPq3
    Xl88PCzE4TWODC0XiTuuewdhF1H1RWHPDU/X7WtqJ2AiY99jcE5vexoj2WJuxWze
    /W+9Yn4AK9nvxbBPewxHfGK5DG1nguT+TUj0GpDa94AKzAMcGAJhazlYKQX9n5Gr
    f1URIY1azqTLU+h4Cdq+xusrCU6A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GOjHHR+j x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AghUw6A7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GOjHHR+j x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AghUw6A7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP4l3hZgJzpYTFAeb4YpfCfB7XrC3dpceoyDB1xeLRfas/d2fnRGCIOFo6gyTGBkFEOdWpPo1wxJgqqmwFw8DQf1TC4trJk4BQr+V7SHQzlgEeR+d2YR
    4Cknzd42Tdo35IaanpamtmJbkKWJ7zNH8FpUar1grRMlk9i8kRoJPW3sCTtyeIKouaViCb7+p2ifWXI+kmAJgzx820w4ILrzVb3Oy17KMbakSQgeqoV5EO0t
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=xIEnxEUKAAAA:8 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=gZgmVkEI4cvL1yREBBcA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=JpDqF-G6Ufas406PgLIE:22
    a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeDPO3y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 10:29:54 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43189 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeDPO3w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Apr 2018 10:29:52 -0400
X-Google-Smtp-Source: AIpwx48L1ytvLupY0YqO6ckq2KrnK6o6vaf8p8wOMwwzYhk7j8DmvDU/67J+UqDWHM88Y0AkEx69TY06SiVXcknHfaM=
MIME-Version: 1.0
In-Reply-To: <1523886928-14535-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523886928-14535-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Apr 2018 16:29:51 +0200
X-Google-Sender-Auth: 68OHbaR5sD-K9m7K7A-k_xc1xhc
Message-ID: <CAMuHMdWv0SbaPY3PgoEBKJ5zpC7pS5VYH7ESKV+H3D+zGnkbEA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 3:55 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add documentation for r8a77965 compatible string to Renesas sci-serial
> device tree bindings documentation.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v2 of the full r8a77965 series is still valid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
