Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D401C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD9D2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="R3Ed13o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD9D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeKUGCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:02:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42949 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeKUGCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:02:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so2483044oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPuUQEYBbdmX9YQZXgJmtyhYqecyke5vkd8efhvPyoM=;
        b=R3Ed13o9+qhHqJKuYPjwcP/GA4os95QPcbLWfpGIUHGr6jcfVPlCdok9IF6AhGtXUF
         sr7ntx20T57rAZ+XvCmu/EnKcvEn5jbp12AtGNibp/uxF0q9S4xQhzya9VhpcvAH1Bei
         Wpzh8VfnMOmvrneG7c2l/qQgpALIhCbKsWOiYULC64FpIG/0y0gRZ9UQ7eAQg1kEKzT1
         Kka7BtL7ltx1qWyoD283CIvqodoAY7iJoXbkW2tRBBujJ4smUAiGpN97apLvef0m2/OV
         ZRgYI4dEoPTsg9zXurK/aufIp/Zczlyqh/vBTpNZZtzvIOgIhFch5YYVBl7SmEp+pAUV
         MFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPuUQEYBbdmX9YQZXgJmtyhYqecyke5vkd8efhvPyoM=;
        b=OfcUoNWlzwG2vcrEJlCCmMU1zZgX4YRH/5n9JeycJbVH0pWovvU0uX2Pz+G8FCAM32
         AkqFLbUanJ0r4OtsTfmwNvxkxBu+9jvdIffOis1260UAY0gWLIcH+bd9ddQQoalfW7p0
         NPe0czYrnpAIFtTEE9I4ir6Z1PPMnW+QG42QiGbEt4K7SD7Wpja3h9EZB8qsze0ViIuF
         eqsl1/xhZw0STOkJVKWgY+4LDirlNI+DougLIxrMu0ci7Lu+6TRG3pgYT6h7ag8gnH1Z
         O5dOZf70JqPjSIQgqY3wuCCbpEBcRTClq6v93je+vMItOI8DI3hNDUmo/cpwYyc8dvYO
         DhbA==
X-Gm-Message-State: AGRZ1gJkl3qrDWhuph55mrhR8BNFlvSS/N9g9XMqqmO1ZsnXWqNfqmRV
        UWnqCvZ6yW+ugVCYHOueQa6z6x+KElF53IXUoB8ipA==
X-Google-Smtp-Source: AJdET5dTJy/QRMKjzMqw195J8A89p8VCFRJyL9j8vfh1pXulfqIQ+3nD27XUI9aIfKFnd6ouVisqEDhz9HqJ0E6dDcA=
X-Received: by 2002:aca:e691:: with SMTP id d139-v6mr1739289oih.232.1542742279302;
 Tue, 20 Nov 2018 11:31:19 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
 <20181115061036.1575223d@silica.lan> <20181115162008.GO3759@mtr-leonro.mtl.com>
 <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com>
 <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
 <20181118110324.543edbd8@coco.lan> <8736rwgoem.fsf@intel.com>
In-Reply-To: <8736rwgoem.fsf@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Nov 2018 11:31:08 -0800
Message-ID: <CAPcyv4j9UmWpufJpniGJgk48=smq_cQZyBGSCEdj2o5v4CdYLg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
To:     jani.nikula@intel.com
Cc:     mchehab+samsung@kernel.org, zwisler@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:09 AM Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Sun, 18 Nov 2018, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > Hmm.. Perhaps the subsystem profile should point to IRC channels if any?
> > Several subsystems use them in order to provide newbies some directions
> > and to discuss other development issues.
>
> MAINTAINERS:
>
>         C: URI for chat protocol, server and channel where developers
>            usually hang out, for example irc://server/channel.
>
> Alas very few subsystems have added that.
>
> I actually fear very few subsystems will add a subsystem profile for
> that matter.

I'm not too worried about the adoption rate of the Subsystem Profile.
If a few subsystems pick it up and contributors find it useful then it
will naturally proliferate, if not then perhaps the initial concern
about contributor pain stumbling through the discovery of these local
policy details was misplaced.
