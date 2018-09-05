Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C601AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838252077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ifS9yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838252077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIEVqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:46:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42869 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:46:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id z11-v6so6633654lff.9;
        Wed, 05 Sep 2018 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFodOkxJoIRBUK0avb++T5XRDW3E3h+YFVH4SKC74UA=;
        b=X4ifS9yfpuU4EFCJAyxv//ZMhdL4dvSamSDDQcwX+IP/ycQ0atyenXyPZ+DY5ojsos
         3XXX/g+3K8s9GtbGtK93C1F1+8a13e4Zwo1upUXGHesBz49c+2tTO/XkqUFzd4mnW4Xz
         tSD2JyhX8LK0Z7WY1UJptbgBF7hmVRkMD/tytJtzXYgbkRVN11b8tpQxVh0+/rSRlaO2
         slTOgffGzsK8Frx3VullsZVlRqOQYNYsumfNitid9pOEu79XTGTHzkUhEE/GzIdV2+v5
         CqnKcR5j6ZGvd5mSd871oHUxTlp367P1uMC3bRXBef1MhNCcYyfKXCOxus7MRc7ND+eP
         cLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFodOkxJoIRBUK0avb++T5XRDW3E3h+YFVH4SKC74UA=;
        b=cVOG/odlh8apwf/pwfOQomiWFLnChQbogHFYqZ27RXT+gZgJiClkBYm//WUIhE+K1s
         eIXoafstUgF+K2i9Gxa+23Cb8nMeMCEp6NbFg+MzHwvjulJp7RNg1dPg/K0gSqDz0ert
         RaIkciCDVGvr/Q395PBeKvBSiD9dkOobCnxqkvgTd4xhTPPrtAoW5QzQM7f4z82Zt7bH
         YIofENl/swzSl+Bt6L49i4RrA7iVv+w31OdlnpVPrfWYieosHMbWRwFr499agAAd7Ao0
         1jtU0iSjjcPj7WLlDXbe0/geeK0er5F/+Jost5KiUErYU6XkfDpG24b94ItHUFSyFnqt
         H7BA==
X-Gm-Message-State: APzg51BP3BVhaXPQykKSaEPX9Hu/IFIo1/W7H7GtTp+HaeRMOQTNVY2Y
        V5D1BV6q80g4RnGIEJPWQaZszXikXYTKqM/t8SY=
X-Google-Smtp-Source: ANB0VdY++CMvVzDhQyyMRUeBAUXUCCDcEuuH3T+ze4o8V9JIsFiZsOZadeFdnq0PvffWqf6KMSmKFC+lFWBrEbkFQK4=
X-Received: by 2002:a19:2a91:: with SMTP id q17-v6mr25208373lfq.74.1536167710790;
 Wed, 05 Sep 2018 10:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180902064601.183036-1-alexander.levin@microsoft.com> <20180902064601.183036-94-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-94-alexander.levin@microsoft.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 5 Sep 2018 10:14:59 -0700
Message-ID: <CAKdAkRRERue28yO1VKVx0sjpkv-ZUTpS-JkcDzct3cvWxOu17A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 094/131] Input: atmel_mxt_ts - only use first
 T9 instance
To:     Alexander.Levin@microsoft.com
Cc:     "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 6:05 AM Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
>
> From: Nick Dyer <nick.dyer@itdev.co.uk>
>
> [ Upstream commit 36f5d9ef26e52edff046b4b097855db89bf0cd4a ]
>
> The driver only registers one input device, which uses the screen
> parameters from the first T9 instance. The first T63 instance also uses
> those parameters.
>
> It is incorrect to send input reports from the second instances of these
> objects if they are enabled: the input scaling will be wrong and the
> positions will be mashed together.
>
> This also causes problems on Android if the number of slots exceeds 32.
>
> In the future, this could be handled by looking for enabled touch object
> instances and creating an input device for each one.

So if this is proposed for stable, how many devices are actually
affected by this? Why does this need to be in stable?

Thanks.

-- 
Dmitry
