Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64468C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8120827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWGpTO2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC8120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeJ3WZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:25:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33852 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbeJ3WZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:25:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id z2-v6so13441009qts.1;
        Tue, 30 Oct 2018 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=D3qfUGVdqJsH12NPHVgTWEAf8g+bRyIuusgonbKmn3g=;
        b=nWGpTO2T8dYctkH9d/F5E8CP0nB2FxpEIHrBRfXrIx0bmcKlEp+9Xl13IMdc6yyTMy
         hMAu1avw6S2PN1zszeFG2eKb6mKuYc0KPlQJIlbiB1K66szs6HfpAc12IgLhyCUAJrjM
         f1oODdjnU+9K0jOy4ZeCsgPZiHHw07R140G3Ulgu2jXTRrTm+KEPzEKXzEsHz6M16XNq
         5ZuMjSGU5Fbtf3DbZ9geEFSscVJkaFKah4GAs40DTZJ0EjpSE5fXwkAeZsb8TrXv2saz
         zpC/RPYqksdzhe6lzUdMk0+LCeaL11zpKK67CIzTtss9QQzsm67mCDAKp7AsANTHgiGp
         7vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=D3qfUGVdqJsH12NPHVgTWEAf8g+bRyIuusgonbKmn3g=;
        b=VTYruPOMPRJkDXb8UeaJRr5o6i999w85hL2ppSZCbcZcnhmjeurt1O6rlFge0gZgQl
         Yec+hkcpxO6/hjp1dmemZq+5faNHWDy8Q2mRrQEud6BN/VciR4rn3OBae17p1Osaaa1C
         C+XONY7k/ANuN9VAJav6mm8F33LUc5pi0KGqhZR8uPEABJyCnCq0I48y6DJHdFtOP3DN
         w8lWS3n0bh5/Gk257Wjlo0y2lfA6HnlOTtBuRsQVY7t1h4BlUNBn/MP01V67CexUqgnz
         p8gzjsh4KaO9YA8rZbrSmHR8VVSr8BrtDCc8ko3AMOKnczzE1PrGGRfYo9cw13uGpd2X
         mj9g==
X-Gm-Message-State: AGRZ1gKljmOh4eJ0BEpfWhezI/4lrlBqpV5zoau+ksHjumVcKFxKWrYO
        sf94+djXGHSXpLRjb8kv8ixUDTe94ETKqYHRlhw=
X-Google-Smtp-Source: AJdET5eKe1tYoIu78bhOYtXN4/esodyKbGGTSlpU6StoOjmTBZvNqD9caD0bKMwjj1q4WheijB6rtUL+5se2bjuwC1A=
X-Received: by 2002:ac8:2c16:: with SMTP id d22-v6mr2285299qta.152.1540906346734;
 Tue, 30 Oct 2018 06:32:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 06:32:25
 -0700 (PDT)
In-Reply-To: <871s87k607.wl-ysato@users.sourceforge.jp>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com> <871s87k607.wl-ysato@users.sourceforge.jp>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Oct 2018 14:32:25 +0100
X-Google-Sender-Auth: iT0YPTUsOg1rpwN6HAs2t2chtmE
Message-ID: <CAK8P3a2MGn6ugmex60Dj05aYHCjgbv9F38DRCLkGwZk2HfEFpw@mail.gmail.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18, Yoshinori Sato <ysato@users.sourceforge.jp> wrote:
> On Mon, 29 Oct 2018 18:44:59 +0900, Arnd Bergmann wrote:
>> just like ARM has mostly killed off the custom vendor-specific
>> instruction
>> sets already. If we add another architecture in the future, it may
>> instead
>> be something like the LLVM bitcode or WebAssembly, who knows?
>>
>
> I have one another port.
> Now we have a build environment so we can not merge right away,
> but I'd like to update it to the latest within a few months.

Ok, cool. Which one is that?

       Arnd
