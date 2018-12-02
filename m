Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1403CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E32082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6CyQi8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5E32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbeLBLvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:51:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46014 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLBLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:51:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so9106032ota.12;
        Sun, 02 Dec 2018 03:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+cN52WtnMWFGaLz7ycKc6LyEsjMu573ypUH75h/9Go=;
        b=N6CyQi8GEBN8oIdLQ9IEaHOkm6cDNoYMuT4iVyFN8ME6u49YP78L0u7S0pUH3Oj+sI
         /XrJiT/804GVe7FmbUBPQ7xIyrx4HKpiqcQXV/pUROlWePX31L301CJEi3RftwHRp6KO
         2liVaIjnKt58Sq1M0lb+7qsMts2mAexYpaPSV1SKLtQpP873xdgElf9ksCj/76igxRKY
         DIE2HwaxCRJM28SE/iXKtsKtG3SAtH8KDPjTGogd8xX/OfioD+SGdYBisp21iF0B7NIS
         0dbR6X1rN9AJhJUG3BryCoz2uQEflEX4GnBkCAfCXY8EdkHkCrvYv65xAEgcKZwmNZdr
         RPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+cN52WtnMWFGaLz7ycKc6LyEsjMu573ypUH75h/9Go=;
        b=WdD1XTPq+Fbxdr7uZjQcu9yFHWrXDhZWzDUg3JmAyZenffi/MVNmJ3I6Y01E9jIP/6
         O6bsTex3c42KOpN10JHZH2AHiwZL2kq/pIDuWvXix6XfUuswNuFC61jYy6PbmFeE3wyi
         fzoqyekVQCUIeOWVOhnwAzDyfSqjD73AsnXCiE271T2Ok41aXk5iChS7T9Pngn1dYncV
         YeX8LQ/XjmQlBkQh/aCZbL5k8j5YtPOUg9bXX/7hLxxpl4fQluAq4wqtxvfXKUfOfEOS
         ComhgwsjStZQJ/taQaRrkvnzxwDQvDTGxlJdCOSTBVBku65YONJqlaY8fT3pJmVJr1kY
         W7KQ==
X-Gm-Message-State: AA+aEWa6VnrtARi5V3WYYrFTrwhkDNkoIBczlmC0k7fQbqOImTKHvndY
        nEoS8dTjh0oF4Jy5tZ3mFCigMU3Kn0b9Fpym9DY=
X-Google-Smtp-Source: AFSGD/X+kDQdUSj/mdMEVrLioIUKa0Ign7lz4e540RopbXGJhA4N9mPbP5EcvvWNQ/rgqOlnb9cTeOuokjkWQT/OM3E=
X-Received: by 2002:a9d:5249:: with SMTP id q9mr7519138otg.160.1543751468803;
 Sun, 02 Dec 2018 03:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
 <20181129080923.GE13859@kroah.com> <1676802.TThbbZSlzy@blindfold>
In-Reply-To: <1676802.TThbbZSlzy@blindfold>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 2 Dec 2018 11:50:33 +0000
Message-ID: <CADVatmP1h7GJJRVURkinwSM44Y4iooMP-U_7zew4V+zsMva4Vw@mail.gmail.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
To:     Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     martin.kepplinger@ginzinger.com, Stable <stable@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Juergen <juergen.lachmann@harman.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Dec 2, 2018 at 8:51 AM Richard Weinberger <richard@nod.at> wrote:
>
> Greg,
>
> Am Donnerstag, 29. November 2018, 09:09:23 CET schrieb Greg KH:
> > On Mon, Nov 26, 2018 at 11:38:42AM +0100, Martin Kepplinger wrote:
> > > From: Richard Weinberger <richard@nod.at>
> > >
> > > [ Upstream commit 34653fd8c46e771585fce5975e4243f8fd401914 ]
> > >
<snip>
> >
> > Now queued up for 4.14.y, thanks.
>
> can you *please* slow a little down?

True. It will really help if you can have some sort of fixed schedule
for stable release, like maybe stablerc is ready on Thursday or Friday
and release the stable on Monday. Having a weekend in stablerc will be
helpful for people like me who only get the time in weekends for
upstream or stable kernel.

-- 
Regards
Sudip
