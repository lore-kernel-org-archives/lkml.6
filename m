Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5509BECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E876D214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3cdeu/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E876D214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIQA71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:59:27 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53896 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbeIQA71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:59:27 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so8555598itp.3;
        Sun, 16 Sep 2018 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsI5N8xgECQ9TitsTE6iRnzI8OU32xsrPI0hZGtsrgo=;
        b=L3cdeu/hpBrePAk0D2xnw2miE7RJuuQTD8w3nkFCnqTZvQeCUVNUcxMkio7wjMvZfv
         YWXEGCOdxdmaD6/0VY/RgKMTCpdyGMsfrpsG7mEqESusG9OwH/gajWJf5hjKFAq9AdAy
         gDUaufdGDhqhsOEUGZZrB+BtgpywwhanFbqI2CMfx46sT4X3PCdz1UXU7iRW2GybZrm8
         fXyYcgUOdTev1eHaj7Agv9usHBOX+UGo7sADQNXteD3jF7jEkGtHAc+jzcdWrIFByIfm
         rxjnkiD8SwgJWQll4qwAk3WF3asq2gFut7WZ1trjWiDukJztGZt04fPjClqrKMfDbOaa
         2ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsI5N8xgECQ9TitsTE6iRnzI8OU32xsrPI0hZGtsrgo=;
        b=aI50244Mb9EUt/RxsU6HUNFoq3POE3VTrlFRUnleXgzPE71X6q0Yyq5SLMY8obSQ2B
         eKNBDT27hKfAHOPQ5CHz1uY7r1RLQyRkC48oHnZVOZbzpMyp9LPXuBCR0bCznTDLvD6I
         jI296IJXUXlmdad8KvkzsxT2ctQ4wN82jlhi/E0DmgadbbR5xYjXctjDYYda+/vfRF7+
         QlKZNkzZY/BwKYXGgv0TJX/ErVgjbpvEhrjgGP3lVaC49gE/6mAO7mqXZMh60jbi8oPn
         AUP8Y8RSFZHvV9IgzW5YCGBbqr6I7HRlDmEx00zpJ4oD1BXCq0e1xWD6n2UDRnCoR7FS
         21gQ==
X-Gm-Message-State: APzg51AQdTDGfoKG/w8NOASYz8f/6+LoXSlhg0jLHY/MwXfDW22OFcZ6
        o/14nd+eeULugP+ztqpeDRdyYfrIkU1FmhUCkBF0hQ==
X-Google-Smtp-Source: ANB0VdaBs8dz0l7NGfiPEhXROqmMlMSaN1WSqFa+sQzaIVJp+ZUEv/0tOMQehfb/LHjeg4OuTctc4HK3pwD8356RvO0=
X-Received: by 2002:a24:6b0e:: with SMTP id v14-v6mr6981000itc.90.1537126527565;
 Sun, 16 Sep 2018 12:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180915133459.GA11537@pc-sasha.localdomain> <CAL_Jsq+Q3vRDmPRP+UB+eP3Qh=C3rknD7Q-4Np1gxCwCKSrtUQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Q3vRDmPRP+UB+eP3Qh=C3rknD7Q-4Np1gxCwCKSrtUQ@mail.gmail.com>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Sun, 16 Sep 2018 22:34:50 +0300
Message-ID: <CAJ1xhMWQx-XV_4Eh-Nj4yiP_tsX55z5A=if4PBT9NL2_Q-vt6w@mail.gmail.com>
Subject: Re: Inclusion of commit e54192b48da7 into stable tree?
To:     robh+dt@kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 10:11 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sat, Sep 15, 2018 at 8:35 AM Alexander Kapshuk
> <alexander.kapshuk@gmail.com> wrote:
> >
> > Is this commit queued up for inclusion into the stable tree?
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/of/base.c?h=next-20180913&id=e54192b48da75f025ae4b277925eaf6aca1d13bd
>
> It will be. It only landed in Linus' tree on Fri. Any commit with a
> stable tag gets picked up.
>
> Rob

Terrific.
Thanks for the info.
