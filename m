Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1DEC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9342133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9SCcPVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9342133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIMQQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:16:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38391 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:16:11 -0400
Received: by mail-io1-f65.google.com with SMTP id y3-v6so2777616ioc.5;
        Thu, 13 Sep 2018 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xmx6Vr/X6kjRiLxbx/TmokX3fiFzXQmLxoTCsGerCaU=;
        b=C9SCcPVB7Grsnjz9b5WSEfSGD1XqcdUFtTzhhuEyl7MXF1PmCY4bsf7VYxATDnE0hR
         OTJ0rslPA2XPTtczAVtGyIoSxbc6D8JjGBt95Wkkn+KsKHeu19m0YdraYmqTEniG3mw0
         kwpXdmoEvSsIDa9viIOPO6pPOwArY8uvU8nQkxisLpHSusj3IczOeg0EhHn2elXrhqSR
         P3BbX1gfqX+TT8QtpS8k5YM7maaXoCEZ6zIsno72uCFlsYYq9NY7+Aw3OPMUGG6Zuprc
         +SD8C3RXVUgm5Hf1crF2oFJ4tEmFsWckya3K8FMkWsjqyOIfc7F2LPnlWaGUI+8IWmkJ
         2BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xmx6Vr/X6kjRiLxbx/TmokX3fiFzXQmLxoTCsGerCaU=;
        b=fJzyODvFHkKdXpsy2rRiXKM9Nmtsxva+PGVlJNtAxanFkBSNqwSvKooIt9ds7Kdi90
         NftALzOrtNm/RLbynFpfl4CrvUErK27x9VY6/4xPPA2784cMEdSYcrE3WgaaNVnnU6h7
         B/wV95nXPKQOyhwMe8/5YQHUCUjwWnhjEL7pej9acHZV48RdUdSuJ9DLQNLtfdbWUprx
         h/alPSk1cuim8YAbUew2/FDrEjF6vOw2sQZ2rAqLsEbhSSeAncSoMMFY1bQifxdjoXIc
         pHguk6Jgi6afTmDk0JqUki2C+wNdxBqVYrebEPE3m4l17gNU5VZCcFkY1tV80q2wCvgX
         9+0A==
X-Gm-Message-State: APzg51DOqTzgBC3cLuVc0aB3N+b8hFrmx5KpppgZiuJiYJJpSHz1SGe8
        hJjZy+J/Ov0KmiB2zoaN5TeRlgeYS3mkfxqw1/o=
X-Google-Smtp-Source: ANB0VdYxy/u0ICDLlHZniv/ZAGA28sG2OcAIfr2B+sEgbD2nMSuhQxnIqkBxmMprjqSd9Ny0TJCYQjXdIW/Q22uZAYE=
X-Received: by 2002:a6b:dc3:: with SMTP id 186-v6mr5283638ion.231.1536836832682;
 Thu, 13 Sep 2018 04:07:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9157:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 04:07:12
 -0700 (PDT)
In-Reply-To: <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com> <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
From:   Oliver <oohall@gmail.com>
Date:   Thu, 13 Sep 2018 21:07:12 +1000
Message-ID: <CAOSf1CH39usAocrtuBnZaPdMBorO9GHrABrEgokxTo-pySUVEg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 6:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
>> > Add the generic PCI core error recovery files to the powerpc EEH
>> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
>> > generic PCI error handling strategy.
>>
>> I really want to make sure the powerpc folks are plugged into any PCI core
>> error handling discussions.  Please let me know if there's a better way
>> than this patch, or if there are other people who should be added.
>
> Sounds good. Oliver, you want to be looped in as well ?

Sure, putting all of EEH on Sam is probably not a nice thing to do.

> Cheers,
> Ben.
>
>
