Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E5DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1631D20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjHdpT3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1631D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeLDRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:39:51 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34579 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLDRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:39:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so10148511qkg.1;
        Tue, 04 Dec 2018 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i17EbTCXoD4SgC269iODZLS8/qCs7g6XwMptOF77oMY=;
        b=OjHdpT3ozm6ocDWq0dQbBdIEJkP++KN6tBbMObWD0HgJhrkvZFP2SFv5HmBoj6hMEI
         WCPnjV4OUhwPl/Z+rpcmyjeCG9t2qRsmHvhptzzcdvYTeNsaCx0M3QXzTxSx7GcnSm7H
         dmDHpfrfcxl4SpDvet0f1vbMMysoP7VI9MzwmcHMc6fBLnkNK0Q5wTWzZxepCCBDoC6K
         59azg+7sSPRKrqbYbSeY0kl2mjO7P0gaBPKpEjLPDhnTmhtUIotzJ4Qckgei5wlF/fqb
         uNZhqrGE1lHQUu5RhIsV6klfkOM9Jv3g6VXqPkJud04E7vnpGxNE+URj3fbAofum3jUP
         n0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i17EbTCXoD4SgC269iODZLS8/qCs7g6XwMptOF77oMY=;
        b=TCHkbFwWilpML9q3lUCxceNQVz1AeMlFymXzPcT74sOj8b/DfLuFKybC8X6W6wJj3h
         95wCWQN7G1juK2M6Sdcj96XtavO3caiLGreqOZk1anP/ITOjzgnF2Nbr6ythti4WROS3
         XzeClRWYEdU3PlcYdVhN/Pva3rkS8kzmLugcJFaGd6DX10zV9n90QjLaOgLhDZB8cLt8
         ov31YlDaFKVSF/QlNLL8O57rxqpiFxkBIPMnmwHrVDzyHC7Oee2VSt6cVK9lVKjw+O8R
         nV91Yj7UKhPhLx4vP/ELqe/FCWRQOPg8F/LoFXZWhoNNBuBsMiS27jA2PAtxhgbEVO8h
         bekA==
X-Gm-Message-State: AA+aEWYtp+OAGJ6p3QWg/NQEe36gFyKeQBmIUZgO13hiO2XUusbaUb3A
        CVoiKo3naAozbMOkm7u+4jySZMlvB8Q4TjP/bqc=
X-Google-Smtp-Source: AFSGD/VcA0JcnRIh5fL1PE24i0cOj7XE54Oduc6sNHuqjhr+WFhofwPvcCVS4eeSeP6DNh/Eca/6knStjWqqLgpPnCk=
X-Received: by 2002:a37:6005:: with SMTP id u5mr18524956qkb.219.1543945189141;
 Tue, 04 Dec 2018 09:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
 <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
 <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
 <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com> <CAEExFWso=uBKj4geVTr2zWOd74V1p5EWq=7r6AATSPh63MQ=mg@mail.gmail.com>
In-Reply-To: <CAEExFWso=uBKj4geVTr2zWOd74V1p5EWq=7r6AATSPh63MQ=mg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Dec 2018 19:39:37 +0200
Message-ID: <CAHp75VcXO0YNd32PVfk+BE68+OUCy=THNi9buU2Wu=PUZhPt8g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 6:58 PM Frank Lee <tiny.windzz@gmail.com> wrote:

> $ git br -r
>   origin/HEAD -> origin/master
>   origin/fixes
>   origin/for-next
>   origin/master
>   origin/review-andy
> $ git remote set-branches --add origin for-next
> $ git br -vv
> * for-next 651022382c7f [origin/for-next] Linux 4.20-rc1

Here is the problem,

For a few days at least we have
4ecd94b8e13b (HEAD -> for-next) platform/x86: dell-laptop: Mark
expected switch fall-throughs

> $ git apply ../../0001-platform-x86-convert-to-DEFINE_SHOW_ATTRIBUTE.patch
> $ git st
> On branch for-next
> Your branch is up to date with 'origin/for-next'.
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
>
>         modified:   drivers/platform/x86/intel_pmc_core.c
>         modified:   drivers/platform/x86/intel_telemetry_debugfs.c
>
> no changes added to commit (use "git add" and/or "git commit -a")

> Andy,I don't know why.
> Is there a problem with my operation?

Definitely.

-- 
With Best Regards,
Andy Shevchenko
