Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E8620825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFCsLs7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E8620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeKHWcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:32:53 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44753 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeKHWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:32:53 -0500
Received: by mail-lj1-f180.google.com with SMTP id k19-v6so17868586lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dXgw/9fNedfxWHe/AZOfyHek9BfS91z8Nq/WDBm4x+s=;
        b=UFCsLs7b8gCMFkkJDqX1o+cHSOIdzMXf9drY56cPWTcMi9USqU/61Hly3uxZ7b1ALG
         r/VCDwTCTgK0majX6NlU1facFhUNWvvjfOf+BkQdfGBvNvneVNwqBvzF6xbkU0tWHzim
         gWRQzyQnNVWY04pr3Y9FVAXPr02N9h6qFKFiIbV4m122BfYIDZsgdNdnJWfW5b6BzvV8
         ChosPHSxhZqTHhEjDI7tiDDwVMeSSiuZHqjSnXKiX9+FH5I14CTvMWKML7YVac2fucmh
         1Q/ZYeCWr0m+i0jylETASwp4ICFfjxxawrz1rJJ3SNCn+1pkFJc27WCAT6Tv5yPaCpWE
         4IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dXgw/9fNedfxWHe/AZOfyHek9BfS91z8Nq/WDBm4x+s=;
        b=j79sirw/LkHoG39Yqr7f+bI1aYXd0YQqrLbM0G7BDcYKYCjcIQHMf3scsByNenLj00
         OYbPdMHZlksjmD9rjX6sWXeTFfajj9B98rcGHxP0edh2vkXIRL+wHHvVYph28ZjWq3Ns
         6VFZWYsdRCtGDchbNFix0WSZhQoxe2bnV9/HJqwx8+liNp97AQ5NbtSVhsdvjOzCjYwq
         gZdcxmuZtPpR6mBP2zh7xbA2W6mSLGrmF1vesrT0amajtX9yFuH0IU1E9zH4lZSd1/iL
         eNAIZzcawW6fLGeCvlmfu0+b0YPFZtSCmtNay+5YTgzMtEn9knF5hwYre16TaSaeswSq
         58LA==
X-Gm-Message-State: AGRZ1gJi5WWe16OAm4s7fsazNaRixCS9KFzQYoWFrugx6F9aU4gO1YX/
        ogL5voRi9n7jNSe6eCjWOwsT/f+mFowriSWtCCA=
X-Google-Smtp-Source: AJdET5cjVusNkuKDrfKsZcXT3ynTpsvJzuvxxoilM3XYRYKgYTbGmzpEOgodkAvuwySNpMiXiCScanOw+1tTkG1scQ4=
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr2381146ljg.71.1541681848466;
 Thu, 08 Nov 2018 04:57:28 -0800 (PST)
MIME-Version: 1.0
References: <1530853846-30215-1-git-send-email-ks77sj@gmail.com>
 <CAMJBoFPGZ_pYFQTXb06U4QxM1ibUhmdxr6efwZigXdUo=4S=Vw@mail.gmail.com> <CALbL15bGHL_M=ofWy_VrDZU_7b2DOC7BnpqJ63gfQ_1gNcG_9A@mail.gmail.com>
In-Reply-To: <CALbL15bGHL_M=ofWy_VrDZU_7b2DOC7BnpqJ63gfQ_1gNcG_9A@mail.gmail.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Thu, 8 Nov 2018 13:57:17 +0100
Message-ID: <CAMJBoFP3C5NffHf2bPaY-W2qXPLs6z+Ker+Z+Sq_3MHV5xekHQ@mail.gmail.com>
Subject: Re: [PATCH] z3fold: fix wrong handling of headless pages
To:     =?UTF-8?B?6rmA7KKF7ISd?= <ks77sj@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tors 8 nov. 2018 kl 13:34 skrev =EA=B9=80=EC=A2=85=EC=84=9D <ks77sj@gma=
il.com>:
>
> Hi Vitaly,
> thank you for the reply.
>
> I agree your a new solution is more comprehensive and drop my patch is si=
mple way.
> But, I think it's not fair.
> If my previous patch was not wrong, is (my patch -> your patch) the right=
 way?

I could apply the new patch on top of yours but that would effectively
revert most of your changes.
Would it be ok for you if I add you to Signed-off-by for the new patch inst=
ead?

~Vitaly

> I'm sorry I sent reply twice.
>
> Best regards,
> Jongseok
>
>
> > On 6/11/2018 4:48 PM, Vitaly Wool wrote:
> > Hi Jongseok,
>
> > thank you for your work, we've now got a more comprehensive solution:
> > https://lkml.org/lkml/2018/11/5/726
>
> > Would you please confirm that it works for you? Also, would you be
> >okay with dropping your patch in favor of the new one?
>
> > ~Vitaly
