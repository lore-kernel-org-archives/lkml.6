Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3867D20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuuRFiqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3867D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIDS3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:29:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39694 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:29:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so3258447lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fTRmtd812OA45uCxLJlZKriqzNIRXpl+u5vgPLcj8JY=;
        b=OuuRFiqeKUrHOMoSGJ+l/UKr/GgzmbsP/cpxXI1rNfGizPQvOPMkzdRG2OzQUVrTJT
         n0z7G7vfRABYYebHPgxJL9BD5Cdauo2jnuAruDLiv7eT4V/nQkp6iKW2EV07uM4BKUP9
         YNY93lsQ5BOtbPcinsJDAvbTOf7QocT+6CcnlkGRBTXKTFZ6t+Z6npSPedusL+ISvr7i
         0JLh+uJnfN1Nssdp3XplxGQbZeu14uHdLlIZwGSgObxGSli2t8Jey/VoG9E6wbKukhsu
         kfV0pjr42g87cP8aYgJGjo+sN/rzBFL+LEmpf9DabgASQq3N1UdDO/WgB1u6YwzrScUV
         XFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fTRmtd812OA45uCxLJlZKriqzNIRXpl+u5vgPLcj8JY=;
        b=aON4YUJBrQAC1CkD89GjcKZSW/wqDSGp5hs+gBg0O4y5IPAmmq07qH1PnLGhIhWFQ5
         qDF0Pn6t2OFWdo3oU2Dxvkrbg5k8fafkq0yCH4BEMxiTDgmvAhUDx294CXMfK75thpAI
         PgYCO0oizae0VGj0svHTAJJfEKkEW/sQaeuOTmNuhO+D/av5HtWwlMe6cOx72BS9etUk
         oTMiCXZbQscI56UxrJ+5LwdES4R8GA0dM32CPlZpjXJwQIO7VWEAFHHUWba5Qw62D83B
         x0sVEol/Mex2VmqhDTxDgpSaY9yu0a8GP42nSEVPz4QDxkdiGVgCsd02UjBCpHVWyZZO
         YJfA==
X-Gm-Message-State: APzg51A4qsZ6AYU8vUvTU9q7BqL+95BDfKBTuXDXaTgBRUE7Mh7QDF3k
        puppk3CxwIiCAUBy9Wg58WTIczVttfYicjXJj/bLrvdo
X-Google-Smtp-Source: ANB0VdZAIGBum7ebLsUWn0FEJfwshRaL2scIp5FVXt+5jJRd92XupSLrBVuBcF8nn6q79NC4nbqfwMF/ZMnfSDQF1b8=
X-Received: by 2002:a2e:610a:: with SMTP id v10-v6mr20456721ljb.39.1536069866056;
 Tue, 04 Sep 2018 07:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Tue, 4 Sep 2018 16:04:09 +0200
Message-ID: <CAPybu_1Wb75fpQg61HC0Ja7eSgMobKAZfywRGKpWWfiLvhjODw@mail.gmail.com>
Subject: Re: [PATCH 0/8] gpio-addr-flash: Support for device-tree and cleanup
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

Hi!

Any  other comment before I resubmit v2 tomorrow from
https://github.com/ribalda/linux/tree/gpio-addr-flash-v2

So far the diff for v2 I have

From Boris Brezillon:
-Add Fixes and cc:stable

From kbuild:
- Fix warnings

- Rebase


Thanks!
On Tue, Aug 21, 2018 at 4:31 PM Ricardo Ribalda Delgado
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
>  drivers/mtd/maps/gpio-addr-flash.c            | 277 ++++++++++++------
>  2 files changed, 237 insertions(+), 86 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
>
> --
> 2.18.0
>


-- 
Ricardo Ribalda
