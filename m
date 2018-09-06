Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CCCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29160206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3PXKowb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29160206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeIFLmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:42:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36501 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeIFLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:42:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id t5-v6so11142637qtn.3;
        Thu, 06 Sep 2018 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIrhOLwX+48sraw1dvPiPGC19YPahmb62sUBou1xt9s=;
        b=E3PXKowbak9wZoX2nHMu7iSjBAKDzfRuxoLI7ngzUli+JN54hNHFKW9n0x5BRN8Ta0
         99bAwJ/2HXQ9qfXeShUYnTrauIgpN8xpMIz4XeZuMwV7Ot3ViZ5GOpuCGVppQH61Umy/
         +Bvnc7pbmpiyc0S9YRSE7rwVN9OPj+xd0pvMWqQ2KQG1fwTPMemDSbsuVTRANnt+Bj0X
         FMFP/KnlJKJ7uliJ+RzXWoqjzBiQCON8Kub5DzE3RlCtJybi0Lme2hMzo1fPk7YeJldH
         9Spl3J/bfOyH9Onxe12BSqYlobGayPIW1zD+C/WM6qtb/HsMASJs5vK2zSKQXOFnBW4U
         j50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIrhOLwX+48sraw1dvPiPGC19YPahmb62sUBou1xt9s=;
        b=FbOZ8wgH91YxOYShmnrpsXRSo8LnQLA6Eor9b4nPAFsYOOpT85agLyeZhec7nKz6zV
         H9c/wuDL18AtjfikdaUwqyc++vsIVelPkNaoNaOn+H50/v/JrYautRHFYvt8DpEAsprq
         cf1Zhpvw/ug1dMnsDlmSY1EihKxN8qXGXkagae7fDXAMe3+pChhreOYP92cZJWouhYsv
         UQIBTYHd1n+t49EMwxOCqSAWM89dcErYbmkAk1w/smguoZeWPqTkvNSJHlvIKar/yI+k
         nCgdAoNXokleM5HtIKihPuChZxhNn61bD9ge//zHhHFvAJA/c15voXEPdtFWH9aRCfjk
         2liQ==
X-Gm-Message-State: APzg51ATr/ZxdVgZRhCGOBIGXrU417KGjL9qC3TqHSY2Eunoopecddrk
        /8Ao/WvStj06eOLlBU4gJRiiE+ki0v06cI2qGss=
X-Google-Smtp-Source: ANB0VdYAP2fohI0Pkj+1m9P8C/fCbWJ+mLFmiQdqVxPW2kzavM6WWwOms2X1S2BddqGHuCRe7473K35MbHFW5A02Q3M=
X-Received: by 2002:ac8:11b:: with SMTP id e27-v6mr919259qtg.221.1536217700316;
 Thu, 06 Sep 2018 00:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com> <20180904161114.GC5000@kunai>
In-Reply-To: <20180904161114.GC5000@kunai>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Thu, 6 Sep 2018 12:38:08 +0530
Message-ID: <CAKfKVtHrN2gGWxrOy5jhhQQ5pxU=XBSym72m8nDYUJvrPGfdiw@mail.gmail.com>
Subject: Re: [PATCH] i2c: xiic: Make the start and the byte count write atomic
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 4, 2018 at 9:41 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Sep 03, 2018 at 03:11:11PM +0530, shubhrajyoti.datta@gmail.com wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >
> > Disable interrupts while configuring the transfer and enable them back.
> >
> > We have below as the programming sequence
> > 1. start and slave address
> > 2. byte count and stop
> >
> > In some customer platform there was a lot of interrupts between 1 and 2
> > and after slave address (around 7 clock cyles) if 2 is not executed
> > then the transaction is nacked.
> >
> > To fix this case make the 2 writes atomic.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>
> I assume simply changing the order of the register writes won't fix it?
No that is not possible.
>
> I also assume this is stable material?
>
Yes let me know if you want me to resend with the stable tag?
