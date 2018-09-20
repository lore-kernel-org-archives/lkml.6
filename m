Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB6DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1BC2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3syRlhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1BC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbeIUBba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:31:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37831 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUBb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:31:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id b12-v6so2114244lfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hkDyska//tbySqweBQUFOmIQk3RBC3BaeiclO8EPrko=;
        b=S3syRlhhKIO3RrGLC4qZR1GtrMFvLDOdS0JnO6aeLXfE376XuWjtenpx3cwJMghBIB
         FQwsKXRcYvBBA83peexarqsx5th8AZPMmKOhYNnTnve7mDRVrX7Qz32PhMMZdO99Fnur
         ZxB72d3sXimpI+cmT4LZxOLb9h2t5rhPTQEnDi/5zNnUFsm+4lVlH9KzdyKaRHIpkq+d
         OUHkeegBeQmSydB7iOF1gyhIT3x2i+oqOr9vyNNAT26lVrVtStmC5wwJa42b4Re8MuUE
         bA+yHmVrrJ7JgIQmD8nxAAUzgcVioAlehdiEtL3ndC3js0JUYB9K5onKrmTNUr2JdStg
         ha0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hkDyska//tbySqweBQUFOmIQk3RBC3BaeiclO8EPrko=;
        b=J+IcjkaJt+EvmVpaotW8Jqjx8rHeEATZEcE8txR4p2beBjJ93EMZec/mRKpiBUxZKI
         Ygt+WwwWn7Ieng75buITVUyv5naVrWtoBZZ0LDtLgTwQ8q1yS1E3TIxrX9/FqxVzod4C
         oEhm39aH2UVSxI88zaylW8NokrSE9oB+7mmF3a4aHzKCTwQqc+aZDITz0//woyi4tu6Y
         mGqWOuA43CVk7H8PuldFPlJ/w1LH6LCBe8Sm6RLethjwuEBl6HAfHNslp/Zxj9Oek6Oj
         nrZWC6xouOC5LkwQlIJNkRlYrWHc8LgBwGUR5wLHeBDjaRoCpbd7DiZdxvXxyPctoQ/W
         tE6A==
X-Gm-Message-State: APzg51DLHq8knAaiXnMSdApKyejjcJSpGLMuXATav9nO4T9o6nesWlqS
        spgUE3wvHgRDlUlqbg6LqzIzZ+PbcCNxgpIB3OWDUg==
X-Google-Smtp-Source: ANB0VdYnFVH8ELQa+jmiQnbskpx2ro6Tcl63N5MIPMgVXXWL1Txnf/sHA36ziE1HU7vOIIXBPmyzDOPxDWozoIfO2bg=
X-Received: by 2002:a19:d189:: with SMTP id i131-v6mr59691lfg.20.1537472782892;
 Thu, 20 Sep 2018 12:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 20 Sep 2018 21:46:06 +0200
Message-ID: <CAPybu_3oa14VZBCH2ndU9AYNGVj0Pvb7sR6Q=Sb6GdH-J8sLxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] gpio-addr-flash: Support for device-tree and cleanup
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

No comments?

Thanks!
On Wed, Sep 5, 2018 at 4:36 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> This patch series does the following:
>
> 1) Fix bug regarding ioremap size
> 2) Cleanup code to use new APIs
> 3) Simplify numerical operations
> 4) Add support for device-tree devices
>
> Thanks!
>
> Changelog v2:
>
> From Boris Brezillon:
> -Add Fixes and cc:stable
>
> From kbuild:
> - Fix warnings
>
> - Rebase
>
> Ricardo Ribalda Delgado (8):
>   mtd: maps: gpio-addr-flash: Replace custom printk
>   mtd: maps: gpio-addr-flash: Fix ioremapped size
>   mtd: maps: gpio-addr-flash: Use devm_* functions
>   mtd: maps: gpio-addr-flash: Use order insted of size
>   mtd: maps: gpio-addr-flash: Replace array with an integer
>   mtd: maps: gpio-addr-flash: Split allocation in two
>   mtd: maps: gpio-addr-flash: Add support for device-tree devices
>   dt-binding: mtd: Document gpio-addr-flash
>
>  .../bindings/mtd/gpio-addr-flash.txt          |  46 +++
>  drivers/mtd/maps/gpio-addr-flash.c            | 276 ++++++++++++------
>  2 files changed, 236 insertions(+), 86 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
>
> --
> 2.18.0
>


-- 
Ricardo Ribalda
