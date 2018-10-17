Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F8ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680B3204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKF9/X57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680B3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeJRAbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:31:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41027 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJRAbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:31:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id q7-v6so2594407wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiuDuLVqVz80vf52xfUzQ48F2hNVPZ/+3rI2seL09AI=;
        b=GKF9/X57DSr6mj3X/l91TKCEt2s4UUmzFoY0iG1Jc9Gjq8AZCSS6I3K1REoc+nR5GH
         zlIbl8sZYK7F8WXD06EZpUVd6BeiGMXqT5EZa9sXgiHalMPQ+zjInvbseq+Xf/ShYgoj
         y9f6fMqxkjfjU1jA+fVHScJl8GwdN4D04vsNQTS18Rgt1M8Xr5p1Am4h1EYcidNazBrN
         I/i48pNmBwr/PaZ7/lxDNsuZNtcy5ydc9w1tT3zIG323kABRrUPdVA6x2yDatJGz3mUc
         dN20qk6fw5i+5hNAyGYF6WPUpYqVgAlNqV/9TPQLJFjZ3vVRn4FyaYdFv+oFkNwwO39x
         YkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiuDuLVqVz80vf52xfUzQ48F2hNVPZ/+3rI2seL09AI=;
        b=luPJJS+arbXPCM5WTYZ4okQbu+l3abCtD0WZc44qMyrITixx/QGjopZZj+iz5DuIAt
         Tzf+wYa9RXlHNYDVdrW+H3AI3JdRJr/OnFIubr45XJgS9pNV1Ur7qO2gAax/Qp/h/mMD
         Upid0rX/vV/Sfc+utZXCXjS4XNil3mmB53w86SbaaCFhrn3Aog/nVDj2zEGAuhksQYjI
         mctxMW80iW8hNWT2i57cUO+wTGjB7/lddDE0Tleno3XCcGT84kTi2c853MUV4GZdsIxi
         yW9L+Ivly50IrDBtg2YlIYe3ZsNAa0QD6iN+xBJtQFRPLqT0iupbdryQII3FwkJonUyd
         pspw==
X-Gm-Message-State: ABuFfogF7kTai5wpzxUI0QcORK01atByQohyfeD3xEscM16f4P08HEmk
        ReGsdX/0+5Tl/ZtrurAaXgBtf6LUTqoBdsdNHVw=
X-Google-Smtp-Source: ACcGV63311QGCdFR6vaWFHrfpI4sFIRv4HLvuIZEX980E2NLFsq9Rkyx5jUsAGU7pm6q8piMlO1duaKOKZUFbjv3gPo=
X-Received: by 2002:adf:f4c3:: with SMTP id h3-v6mr23258022wrp.259.1539794107115;
 Wed, 17 Oct 2018 09:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQ1cqGzq5k5xVzngJo03eKn03hg43AMQ6r2p129dic9wbm=jw@mail.gmail.com>
 <20181017074328.GB25537@kroah.com>
In-Reply-To: <20181017074328.GB25537@kroah.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 17 Oct 2018 09:34:55 -0700
Message-ID: <CAHQ1cqF5Z2T6na9rGbXCbLtWoi6CHWq0SSBrAdMRpUSvUUQWcA@mail.gmail.com>
Subject: Re: Fate of ihex2fw tool
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <mmarek@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 16, 2018 at 10:36:15PM -0700, Andrey Smirnov wrote:
> > Everyone:
> >
> > Since commit 5620a0d1aacd554ebebcff373e31107bb1ef7769 ("firmware:
> > delete in-kernel firmware"):
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.19-rc7&id=5620a0d1aacd554ebebcff373e31107bb1ef7769
> >
> > firmware/ihex2fw.c is gone from the source tree and with it ihex2fw
> > tool used to generate sruct ihxed_binrec {} filled images (.ihex ->
> > .fw) consumed by request_ihex_frimware().
> >
> > I tried looking for that too in
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> > but couldn't find it there.
> >
> > Is there a  new/different source tree it can be found nowadays?
> > Or is there another established tool that can do .ihex -> .fw
> > conversion that is expected to be used instead of ihex2bin?
>
> We've all had to write this utility over and over again over the years,
> so why not just submit a patch to add this tool back under tools/ ?
>

Sure, more that happy to do that. Just wanted to make sure that I
wasn't missing some big picture.

Thanks,
Andrey Smirnov
